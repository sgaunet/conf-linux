#!/usr/bin/env bash

function wait_after_gitlab_pipeline() {
  status_file="/tmp/pipeline_status.$$"
  echo "Checking pipeline status..."
  while true; do
    glab pipeline list -F json | jq '.[].status' > "$status_file"
    grep -qE 'running|pending|created' "$status_file"
    rc="$?"
    if [ "$rc" -ne "0" ]; then
      break
    fi
    echo "Pipeline is still running..."
    sleep 5
  done
  rm -f "$status_file"
}

function get_last_pipeline_status() {
  glab pipeline list -F json | jq -r '.[].status' | head -n 1
}

function wait_after_github_pipeline() {
  status_file="/tmp/action_status.$$"
  echo "Checking action status..."
  while true; do
    gh run list --json status | jq '.[].status' > "$status_file"
    grep -qE 'in_progress|queued' "$status_file"
    rc="$?"
    if [ "$rc" -ne "0" ]; then
      break
    fi
    echo "Action is still running..."
    sleep 5
  done
  rm -f "$status_file"
}

function get_last_action_status() {
  gh run list --limit 1 --json conclusion --jq '.[0].conclusion'
}

which glab > /dev/null 2>&1
rc="$?"
if [ "$rc" -ne 0 ]; then
  echo "glab not found. Please install glab."
  exit 1
fi

which gh > /dev/null 2>&1
rc="$?"
if [ "$rc" -ne 0 ]; then
  echo "gh not found. Please install gh."
  exit 1
fi

which gum > /dev/null 2>&1
rc="$?"
if [ "$rc" -ne 0 ]; then
  echo "gum not found. Please install gum."
  exit 1
fi

which git > /dev/null 2>&1
rc="$?"
if [ "$rc" -ne 0 ]; then
  echo "git not found. Please install git."
  exit 1
fi

which yq > /dev/null 2>&1
rc="$?"
if [ "$rc" -ne 0 ]; then
  echo "yq not found. Please install yq."
  exit 1
fi

# Get configuration from file $HOME/.config/auto-mr/config.yml
# This file has the following format:
# gitlab:
#   assignee: 
#   reviewer:
# github:
#   assignee: 
#   reviewer:

config_file="$HOME/.config/auto-mr/config.yml"
if [ ! -f "$config_file" ]; then
  echo "Config file not found: $config_file"
  echo "Please create the config file with the following format:"
  echo "gitlab:"
  echo "  assignee: "
  echo "  reviewer:"
  echo "github:"
  echo "  assignee: "
  echo "  reviewer:"
  exit 1
fi

# Get the assignee and reviewer from the config file
assignee_gitlab=$(yq e '.gitlab.assignee' "$config_file")
reviewer_gitlab=$(yq e '.gitlab.reviewer' "$config_file")
assignee_github=$(yq e '.github.assignee' "$config_file")
reviewer_github=$(yq e '.github.reviewer' "$config_file")

# Check if the assignee and reviewer are set
if [ -z "$assignee_gitlab" ] || [ -z "$reviewer_gitlab" ]; then
  echo "The assignee or reviewer is not set for gitlab."
  exit 1
fi

if [ -z "$assignee_github" ] || [ -z "$reviewer_github" ]; then
  echo "The assignee or reviewer is not set for github."
  exit 1
fi

# Get the main branch name
main_branch_name=$(git remote show origin | grep HEAD | awk -F ':' '{ print $2 }' | sed 's# *##g')
echo "main_branch_name: $main_branch_name"

# Get the current branch name
current_branch_name=$(git branch --show-current)

if [ "$current_branch_name" = "$main_branch_name" ]; then
  echo "You are on the main branch. Please checkout to a feature branch."
  exit 1
fi

# Check that there is some changes in the staged area
git diff --cached --exit-code
rc="$?"
if [ "$rc" -ne 0 ]; then
  echo "There are some changes in the staged area. Please commit them."
  exit 1
fi

# Check if repo is on gitlab
git remote show origin | grep push | grep -q gitlab.com
rc=$?
if [ "$rc" = "0" ]; then
  on_gitlab="true"
fi

# Check if repo is on github
git remote show origin | grep push | grep -q github.com
rc=$?
if [ "$rc" = "0" ]; then
  on_github="true"
fi

if [ -z "$on_gitlab" ] && [ -z "$on_github" ]; then
  echo "The repo is not on gitlab or github. Please push it to gitlab or github."
  exit 1
fi

# push the changes to the current branch
git push --set-upstream origin "$current_branch_name"
rc="$?"
if [ "$rc" -ne 0 ]; then
  echo "Failed to push the changes to the current branch."
  exit 1
fi

# Choose labels for the MR
# labels=$(gum choose --header "Choose labels:" --limit=3 "BUG" "DOC" "FEAT" "INFRA" "MONITORING" "Migration" "SUPPORT" "TEST")


if [ -n "$on_gitlab" ]; then
  # convert labels to a string with comma separated values
  # lst_labels=$(echo "$labels" | tr '\n' ',' | sed 's/,$//')
  # echo "lst_labels: $lst_labels"

  # Create a merge request on gitlab (Link mr with an issue: --related-issue)
  glab mr create --fill --fill-commit-body --yes --squash-before-merge --remove-source-branch --assignee "${assignee_gitlab}" --reviewer "${reviewer_gitlab}" #-l "${lst_labels}"
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to create a merge request on gitlab."
    exit 1
  fi

  # Let the time to the pipeline to be launched
  sleep 2

  # Wait after the gitlab pipeline
  wait_after_gitlab_pipeline
  # Get the last pipeline status
  last_pipeline_status=$(get_last_pipeline_status)
  echo "last_pipeline_status: $last_pipeline_status"
  if [ "$last_pipeline_status" != "success" ] && [ "$last_pipeline_status" != "" ]; then
    echo "The pipeline failed."
    exit 1
  fi

  # Retrieve the id of the merge request
  glab mr list -F json | jq '.[].iid' > /tmp/mr_id
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to retrieve the id of the merge request."
    exit 1
  fi

  # Check there is only one MR
  mr_count=$(wc -l /tmp/mr_id | awk '{ print $1 }')
  if [ "$mr_count" -ne 1 ]; then
    echo "There is more than one MR."
    exit 1
  fi

  # Get the id of the merge request
  mr_id=$(cat /tmp/mr_id)
  echo "mr_id: $mr_id"

  # Auto approve mr
  glab mr approve "$mr_id"
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to approve the merge request. (can depend of the gitlab configuration)"
  fi

  # Auto merge mr
  glab mr merge --squash --remove-source-branch --yes "$mr_id"
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to merge the merge request."
    exit 1
  fi

  # Let the time to the pipeline to be launched
  sleep 2
  # Wait after the gitlab pipeline
  wait_after_gitlab_pipeline
  # Get the last pipeline status
  last_pipeline_status=$(get_last_pipeline_status)
  echo "last_pipeline_status: $last_pipeline_status"
  if [ "$last_pipeline_status" != "success" ]; then
    echo "The pipeline failed."
    exit 1
  fi

  git switch "$main_branch_name"
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to switch to the main branch."
    exit 1
  fi

  git pull
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to pull the changes from the main branch."
    exit 1
  fi

  git fetch --prune
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to prune the remote branches."
    exit 1
  fi

  git branch -D "$current_branch_name"
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to delete the feature branch."
    exit 1
  fi

fi


if [ -n "$on_github" ]; then
  # convert labels to options for gh pr create command
  # for label in $labels; do
  #   lst_labels="${lst_labels} --label ${label}"
  # done
  # echo "lst_labels: $lst_labels"

  # Create a merge request on github
  gh pr create  --assignee "${assignee_github}" --fill-verbose --reviewer "${reviewer_github}" $lst_labels
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    # check if the PR already exists
    gh pr list --json number | jq .[].number | grep -qE '^[0-9]+$'
    rc="$?"
    if [ "$rc" -ne 0 ]; then
      echo "Failed to create a merge request on github."
      exit 1
    fi
  fi

  # Let the time to the pipeline to be launched
  sleep 2

  # Wait after the github pipeline
  wait_after_github_pipeline
  # Get the last pipeline status
  last_action_status=$(get_last_action_status)
  echo "last_action_status: $last_action_status"
  if [ "$last_action_status" != "success" ] && [ "$last_action_status" != "" ]; then
    echo "The pipeline failed."
    exit 1
  fi

  # Retrieve the id of the PR
  gh pr ls -s open --author "${assignee_github}" --json number | jq .[].number > /tmp/pr_id
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to retrieve the id of the PR."
    exit 1
  fi

  # Check there is only one PR
  pr_count=$(wc -l /tmp/pr_id | awk '{ print $1 }')
  if [ "$pr_count" -ne 1 ]; then
    echo "There is more than one PR."
    exit 1
  fi

  # Get the id of the PR
  pr_id=$(cat /tmp/pr_id)
  echo "pr_id: $pr_id"

  # Auto merge mr
  gh pr merge --squash --delete-branch "$pr_id"
  rc="$?"
  if [ "$rc" -ne 0 ]; then
    echo "Failed to merge the merge request."
    exit 1
  fi

  sleep 2

  # Wait after the github pipeline
  wait_after_github_pipeline
  # Get the last pipeline status
  last_action_status=$(get_last_action_status)
  echo "last_action_status: $last_action_status"
  if [ "$last_action_status" != "success" ] && [ "$last_action_status" != "" ]; then
    echo "The pipeline failed."
    exit 1
  fi
fi

