#!/usr/bin/env bash

# set -o errexit

function updateVersionOfGithubProject() {
    local githubRepo=$1
    local roleFolder=$2
    local keyToUpdate=$3

    local actualVersion=$(yq e ".${keyToUpdate}" "${roleFolder}/defaults/main.yml")
    local lastVersion=$(curl -s "https://api.github.com/repos/${githubRepo}/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" --header "X-GitHub-Api-Version: 2022-11-28" | jq .tag_name | sed 's/"//g' | sed 's/v//g')

    if [ "${lastVersion}" == "null" ]; then
        echo "No release found for ${githubRepo}"
        echo "github api limit reached"
        exit 1
    fi
    if [ "${actualVersion}" == "${lastVersion}" ]; then
        echo "No update needed for ${githubRepo}"
        return 1
    fi
    echo "Updating ${githubRepo} from ${actualVersion} to ${lastVersion}"
    yq -i e ".${keyToUpdate} = \"${lastVersion}\"" "${roleFolder}/defaults/main.yml"
    sleep 2
    return 0
}

function seekUpdateAndUpdate
{
    local githubRepo=$1
    local roleFolder=$2
    local keyToUpdate=$3

    updateVersionOfGithubProject "$githubRepo" "$roleFolder" "$keyToUpdate"
    rc=$?

    # if [ "$rc" != "0" ]; then
    #     return $rc
    # fi

    diff=$(git status -s "$roleFolder" | wc -l)
    # check if there is a modification in folder $githubRepo with git
    if [ "$diff" == "0" ]; then
        echo "No modifications in $roleFolder folder"
        return 1
    fi
    echo "Modifications detected in $githubRepo folder"
    # Tests role
    echo "  Test role $roleFolder with molecule"
    ./test-role-with-molecule.sh "$roleFolder"
    rc="$?"
    if [ "$rc" = "0" ];then
        echo "  Test OK => will commit changes and push them"
        local newVersion
        newVersion=$(yq e ".${keyToUpdate}" "${roleFolder}/defaults/main.yml")
        git add "$roleFolder"
        git commit -m "bump $(basename "$roleFolder") version $newVersion"
        git push
    else
        echo "  Test KO => TO FIX"
    fi
}

if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN is not set. EXIT 1"
    exit 1
fi

seekUpdateAndUpdate nektos/act     src/roles/act  act_version
seekUpdateAndUpdate imsnif/bandwhich     src/roles/bandwhich  bandwhich_version
seekUpdateAndUpdate sharkdp/bat          src/roles/bat        bat_version
seekUpdateAndUpdate docker/buildx        src/roles/buildx     buildx_version  # No way
seekUpdateAndUpdate sgaunet/calcdate     src/roles/calcdate   calcdate_version
seekUpdateAndUpdate goreleaser/chglog    src/roles/chglog     chglog_version
seekUpdateAndUpdate concourse/concourse  src/roles/concourse  concourse_version
seekUpdateAndUpdate terrastruct/d2       src/roles/d2         d2_version
seekUpdateAndUpdate TomWright/dasel      src/roles/dasel      dasel_version
seekUpdateAndUpdate dandavison/delta       src/roles/delta      delta_version
seekUpdateAndUpdate wagoodman/dive src/roles/dive dive_version
seekUpdateAndUpdate eksctl-io/eksctl src/roles/eksctl  eksctl_version
seekUpdateAndUpdate sgaunet/ekspodlogs src/roles/ekspodlogs  ekspodlogs_version
seekUpdateAndUpdate sgaunet/envtemplate src/roles/envtemplate  envtemplate_version
seekUpdateAndUpdate sharkdp/fd src/roles/fd  fd_version
seekUpdateAndUpdate antonmedv/fx src/roles/fx  fx_version
seekUpdateAndUpdate wtetsu/gaze src/roles/gaze  gaze_version
seekUpdateAndUpdate dundee/gdu src/roles/gdu gdu_version
seekUpdateAndUpdate sgaunet/gini src/roles/gini gini_version
seekUpdateAndUpdate sgaunet/gitlab-issue-report src/roles/gitlab_issue_report/ gitlab_issue_report_version
seekUpdateAndUpdate sgaunet/gitlab-stats src/roles/gitlab_stats/ gitlab_stats_version
seekUpdateAndUpdate gitleaks/gitleaks src/roles/gitleaks gitleaks_version
seekUpdateAndUpdate charmbracelet/glow src/roles/glow glow_version
seekUpdateAndUpdate google/go-containerregistry src/roles/gocontainerregistry gocontainerregistry_version
seekUpdateAndUpdate sgaunet/gocrypt src/roles/gocrypt gocrypt_version
seekUpdateAndUpdate rfjakob/gocryptfs src/roles/gocryptfs gocryptfs_version
seekUpdateAndUpdate golangci/golangci-lint src/roles/golangcilint golangcilint_version
seekUpdateAndUpdate goreleaser/goreleaser src/roles/goreleaser goreleaser_version
seekUpdateAndUpdate hadolint/hadolint        src/roles/hadolint       hadolint_version
seekUpdateAndUpdate helm/helm        src/roles/helm       helm_version
seekUpdateAndUpdate sgaunet/helmchart-helper src/roles/helmchart_helper helmchart_helper_version
seekUpdateAndUpdate norwoodj/helm-docs        src/roles/helmdocs       helmdocs_version
seekUpdateAndUpdate helmfile/helmfile src/roles/helmfile helmfile_version
seekUpdateAndUpdate sgaunet/httping-go src/roles/httping httping_version
seekUpdateAndUpdate sharkdp/hyperfine src/roles/hyperfine hyperfine_version
seekUpdateAndUpdate ankitpokhrel/jira-cli src/roles/jiracli jiracli_version
seekUpdateAndUpdate grafana/k6 src/roles/k6 k6_version
seekUpdateAndUpdate derailed/k9s src/roles/k9s k9s_version
# # seekUpdateAndUpdate szkiba/xk6-dashboard src/roles/xk6-dashboard xk6-dashboard_version
seekUpdateAndUpdate particledecay/kconf src/roles/kconf kconf_version
seekUpdateAndUpdate ryane/kfilt src/roles/kfilt kfilt_version
seekUpdateAndUpdate kubernetes-sigs/kind src/roles/kind kind_version
seekUpdateAndUpdate kluctl/kluctl src/roles/kluctl kluctl_version
seekUpdateAndUpdate yonahd/kor src/roles/kor kor_version
seekUpdateAndUpdate kubernetes-sigs/krew src/roles/krew krew_version
seekUpdateAndUpdate robscott/kube-capacity src/roles/kubecapacity kubecapacity_version
seekUpdateAndUpdate NimbleArchitect/kubectl-ice src/roles/kubectl_ice kubectl_ice_version
seekUpdateAndUpdate stackrox/kube-linter src/roles/kube_linter kube_linter_version
seekUpdateAndUpdate ahmetb/kubectx src/roles/kubectx kubectx_version
seekUpdateAndUpdate ahmetb/kubectx src/roles/kubectx kubens_version
seekUpdateAndUpdate kubescape/kubescape src/roles/kubescape kubescape_version
seekUpdateAndUpdate kubeshark/kubeshark src/roles/kubeshark kubeshark_version
seekUpdateAndUpdate txn2/kubefwd src/roles/kubefwd kubefwd_version
seekUpdateAndUpdate doitintl/kube-no-trouble src/roles/kubent kubent_version
seekUpdateAndUpdate sgaunet/mdtohtml src/roles/mdtohtml mdtohtml_version
seekUpdateAndUpdate matryer/moq src/roles/moq moq_version
seekUpdateAndUpdate raviqqe/muffet src/roles/muffet muffet_version
seekUpdateAndUpdate goreleaser/nfpm src/roles/nfpm nfpm_version
seekUpdateAndUpdate google/osv-scanner src/roles/osv_scanner osv_scanner_version
seekUpdateAndUpdate sharkdp/pastel src/roles/pastel pastel_version
seekUpdateAndUpdate knqyf263/pet src/roles/pet pet_version
seekUpdateAndUpdate sosedoff/pgweb src/roles/pgweb pgweb_version
seekUpdateAndUpdate pre-commit/pre-commit src/roles/pre_commit pre_commit_version
seekUpdateAndUpdate derailed/popeye src/roles/popeye popeye_version
seekUpdateAndUpdate natesales/q src/roles/qqq qqq_version
seekUpdateAndUpdate sgaunet/retry src/roles/retry retry_version
seekUpdateAndUpdate peak/s5cmd src/roles/s5cmd s5cmd_version
seekUpdateAndUpdate boyter/scc src/roles/scc scc_version
seekUpdateAndUpdate sqlc-dev/sqlc src/roles/sqlc sqlc_version
seekUpdateAndUpdate starship/starship src/roles/starship starship_version
seekUpdateAndUpdate stern/stern src/roles/stern stern_version
seekUpdateAndUpdate k1LoW/tbls src/roles/tbls tbls_version
seekUpdateAndUpdate dbrgn/tealdeer src/roles/tealdeer tealdeer_version
seekUpdateAndUpdate aquasecurity/trivy src/roles/trivy trivy_version
seekUpdateAndUpdate trufflesecurity/trufflehog src/roles/trufflehog trufflehog_version
seekUpdateAndUpdate bensadeh/tailspin src/roles/tspin tspin_version
seekUpdateAndUpdate tsl0922/ttyd src/roles/ttyd ttyd_version
seekUpdateAndUpdate xo/usql src/roles/usql usql_version
seekUpdateAndUpdate charmbracelet/vhs src/roles/vhs vhs_version
seekUpdateAndUpdate ovh/venom src/roles/venom venom_version
seekUpdateAndUpdate sachaos/viddy src/roles/viddy viddy_version
seekUpdateAndUpdate helmfile/vals src/roles/vals vals_version
seekUpdateAndUpdate mikefarah/yq src/roles/yq yq_version
seekUpdateAndUpdate bvaisvil/zenith src/roles/zenith zenith_version

# TODO
# # seekUpdateAndUpdate anchore/grype src/roles/grype grype_version   always latest
