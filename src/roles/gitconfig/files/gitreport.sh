#!/usr/bin/env bash

folder="$1"
exprBeginDate="$2"
exprEndDate="$3"

if [ -z "$folder" ]
then
	echo "Usage: $0 <folder> [begin date] [end date]"
	echo "  folder: the folder of a git repository"
	echo "  begin date: the begin date of the range. Default: /-1 ::   meaning start of the last month. See calcdate for more information"
	echo "  end date: the end date of the range. Default: /-1 ::   meaning end of the last month. See calcdate for more information"
	exit 1
fi

# Check prerequisites
if ! command -v calcdate > /dev/null 2>&1
then
	echo "calcdate is not installed"
	exit 1
fi

if ! command -v git > /dev/null 2>&1
then
	echo "git is not installed"
	exit 1
fi

if [ -z "$exprBeginDate" ]
then
	exprBeginDate="/-1/ ::"
fi

if [ -z "$exprEndDate" ]
then
	exprEndDate="/-1/ ::"
fi

rangedate=$(calcdate -b "$exprBeginDate" -ofmt "%YYYY-%MM-%DD" -e "$exprEndDate")
begindate=$(echo "$rangedate" | awk '{ print $1 }')
enddate=$(echo "$rangedate" | awk '{ print $2 }')

echo "List of commits from $begindate to $enddate"

find "${folder}" -name .git -type d | while read -r GITDIR
do
	workingDir=$(dirname "$GITDIR")
	cd "$workingDir" || exit 1
		output=$(git --no-pager log --since="$begindate" --until="$enddate"  --oneline --format="%ci %s - %an - %ce")
		if [ -n "$output" ]
		then
			pwd
			echo "$output"
			echo ""
		fi
	cd - > /dev/null 2>&1 || exit 1
done
