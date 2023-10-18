#!/usr/bin/env bash

set -o errexit

function updateVersionOfGithubProject() {
    local githubRepo=$1
    local fileToUpdate=$2
    local keyToUpdate=$3

    local actualVersion=$(yq e ".${keyToUpdate}" "${fileToUpdate}")
    local lastVersion=$(curl -s "https://api.github.com/repos/${githubRepo}/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" --header "X-GitHub-Api-Version: 2022-11-28" | jq .tag_name | sed 's/"//g' | sed 's/v//g')

    if [ "${lastVersion}" == "null" ]; then
        echo "No release found for ${githubRepo}"
        echo "github api limit reached"
        exit 1
    fi
    if [ "${actualVersion}" == "${lastVersion}" ]; then
        echo "No update needed for ${githubRepo}"
        return
    fi
    echo "Updating ${githubRepo} from ${actualVersion} to ${lastVersion}"
    yq -i e ".${keyToUpdate} = \"${lastVersion}\"" "${fileToUpdate}"
    sleep 2
}

if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN is not set. EXIT 1"
    exit 1
fi

updateVersionOfGithubProject norwoodj/helm-docs        src/roles/helmdocs/defaults/main.yml       helmdocs_version
updateVersionOfGithubProject imsnif/bandwhich src/roles/bandwhich/defaults/main.yml bandwhich_version
updateVersionOfGithubProject sharkdp/bat      src/roles/bat/defaults/main.yml       bat_version
updateVersionOfGithubProject ClementTsang/bottom src/roles/bottom/defaults/main.yml bottom_version
updateVersionOfGithubProject docker/buildx src/roles/buildx/defaults/main.yml buildx_version
updateVersionOfGithubProject sgaunet/calcdate src/roles/calcdate/defaults/main.yml calcdate_version
updateVersionOfGithubProject goreleaser/chglog src/roles/chglog/defaults/main.yml chglog_version
updateVersionOfGithubProject concourse/concourse src/roles/concourse/defaults/main.yml concourse_version
updateVersionOfGithubProject bcicen/ctop src/roles/ctop/defaults/main.yml ctop_version
updateVersionOfGithubProject terrastruct/d2 src/roles/d2/defaults/main.yml d2_version
updateVersionOfGithubProject particledecay/kconf src/roles/kconf/defaults/main.yml kconf_version
updateVersionOfGithubProject peak/s5cmd src/roles/s5cmd/defaults/main.yml s5cmd_version
updateVersionOfGithubProject derailed/k9s src/roles/k9s/defaults/main.yml k9s_version
updateVersionOfGithubProject zellij-org/zellij src/roles/zellij/defaults/main.yml zellij_version
updateVersionOfGithubProject trufflesecurity/trufflehog src/roles/trufflehog/defaults/main.yml trufflehog_version
updateVersionOfGithubProject dundee/gdu src/roles/gdu/defaults/main.yml gdu_version
updateVersionOfGithubProject NimbleArchitect/kubectl-ice src/roles/kubectl_ice/defaults/main.yml kubectlice_version
updateVersionOfGithubProject knqyf263/pet src/roles/pet/defaults/main.yml pet_version
updateVersionOfGithubProject txn2/kubefwd src/roles/kubefwd/defaults/main.yml kubefwd_version
updateVersionOfGithubProject sharkdp/bat src/roles/bat/defaults/main.yml bat_version
updateVersionOfGithubProject robscott/kube-capacity src/roles/kubecapacity/defaults/main.yml kubecapacity_version
updateVersionOfGithubProject wagoodman/dive src/roles/dive/defaults/main.yml dive_version
updateVersionOfGithubProject raviqqe/muffet src/roles/muffet/defaults/main.yml muffet_version
updateVersionOfGithubProject doitintl/kube-no-trouble src/roles/kubent/defaults/main.yml kubent_version
updateVersionOfGithubProject terrastruct/d2 src/roles/d2/defaults/main.yml d2_version
updateVersionOfGithubProject ogham/exa src/roles/exa/defaults/main.yml exa_version
# updateVersionOfGithubProject szkiba/xk6-dashboard src/roles/xk6-dashboard/defaults/main.yml xk6-dashboard_version
updateVersionOfGithubProject sgaunet/gitlab-issue-report src/roles/gitlab_issue_report/defaults/main.yml gitlabissuereport_version
updateVersionOfGithubProject sharkdp/pastel src/roles/pastel/defaults/main.yml pastel_version
updateVersionOfGithubProject charmbracelet/vhs src/roles/vhs/defaults/main.yml vhs_version
updateVersionOfGithubProject wtetsu/gaze src/roles/gaze/defaults/main.yml gaze_version
updateVersionOfGithubProject starship/starship src/roles/starship/defaults/main.yml starship_version
updateVersionOfGithubProject goreleaser/goreleaser src/roles/goreleaser/defaults/main.yml goreleaser_version
updateVersionOfGithubProject imsnif/bandwhich src/roles/bandwhich/defaults/main.yml bandwhich_version
updateVersionOfGithubProject sachaos/viddy src/roles/viddy/defaults/main.yml viddy_version
updateVersionOfGithubProject sgaunet/httping-go src/roles/httping/defaults/main.yml httping_version
updateVersionOfGithubProject derailed/popeye src/roles/popeye/defaults/main.yml popeye_version
updateVersionOfGithubProject golangci/golangci-lint src/roles/golangcilint/defaults/main.yml golangcilint_version
updateVersionOfGithubProject matryer/moq src/roles/moq/defaults/main.yml moq_version
updateVersionOfGithubProject concourse/concourse src/roles/concourse/defaults/main.yml concourse_version
updateVersionOfGithubProject bootandy/dust src/roles/dust/defaults/main.yml dust_version
# updateVersionOfGithubProject weaveworks/eksctl src/roles/eksctl/defaults/main.yml eksctl_version
updateVersionOfGithubProject goreleaser/nfpm src/roles/nfpm/defaults/main.yml nfpm_version
updateVersionOfGithubProject grafana/k6 src/roles/k6/defaults/main.yml k6_version
updateVersionOfGithubProject ClementTsang/bottom src/roles/bottom/defaults/main.yml bottom_version
updateVersionOfGithubProject sgaunet/mdtohtml src/roles/mdtohtml/defaults/main.yml mdtohtml_version
updateVersionOfGithubProject sgaunet/gocrypt src/roles/gocrypt/defaults/main.yml gocrypt_version
updateVersionOfGithubProject charmbracelet/gum src/roles/gum/defaults/main.yml gum_version
updateVersionOfGithubProject sqlc-dev/sqlc src/roles/sqlc/defaults/main.yml sqlc_version
updateVersionOfGithubProject boyter/scc src/roles/scc/defaults/main.yml scc_version
updateVersionOfGithubProject go-task/task src/roles/task/defaults/main.yml task_version
updateVersionOfGithubProject stern/stern src/roles/stern/defaults/main.yml stern_version
updateVersionOfGithubProject sharkdp/hyperfine src/roles/hyperfine/defaults/main.yml hyperfine_version
updateVersionOfGithubProject kluctl/kluctl src/roles/kluctl/defaults/main.yml kluctl_version
updateVersionOfGithubProject rfjakob/gocryptfs src/roles/gocryptfs/defaults/main.yml gocryptfs_version
updateVersionOfGithubProject sharkdp/fd src/roles/fd/defaults/main.yml fd_version
updateVersionOfGithubProject goreleaser/chglog src/roles/chglog/defaults/main.yml chglog_version
# updateVersionOfGithubProject anchore/grype src/roles/grype/defaults/main.yml grype_version   always latest
# updateVersionOfGithubProject zricethezav/gitleaks src/roles/gitleaks/defaults/main.yml gitleaks_version
updateVersionOfGithubProject xo/usql src/roles/usql/defaults/main.yml usql_version
updateVersionOfGithubProject google/go-containerregistry src/roles/gocontainerregistry/defaults/main.yml gocontainerregistry_version
updateVersionOfGithubProject ahmetb/kubectx src/roles/kubectx/defaults/main.yml kubectx_version
updateVersionOfGithubProject ahmetb/kubectx src/roles/kubectx/defaults/main.yml kubens_version
updateVersionOfGithubProject helmfile/helmfile src/roles/helmfile/defaults/main.yml helmfile_version
updateVersionOfGithubProject yonahd/kor src/roles/kor/defaults/main.yml kor_version
updateVersionOfGithubProject sosedoff/pgweb src/roles/pgweb/defaults/main.yml pgweb_version
updateVersionOfGithubProject k1LoW/tbls src/roles/tbls/defaults/main.yml tbls_version