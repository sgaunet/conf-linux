# conf-linux

That's a collection of ansible role to configure my Linux account for a new PC (debian based). That's far away from perfection but that's a start.

# Execution 

```
git clone git@github.com:sgaunet/conf-linux.git
sudo apt install -y ansible
cd conf-linux/src
<edit> installation.yml
./go.sh
```

# Roles

## kube-ps1

To get a beautiful prompt (for bash or zsh)

![prompt](img/prompt.png)

## And

* common 
    * Install common softwares cifs-utils tmux git git-crypt gpg docker jq unzip
    * Install software-properties-common apt-transport-https wget

For AWS :

* [eksctl](https://eksctl.io/)
* [awscli v2](https://github.com/aws/aws-cli/)
* [ekspodlogs](https://github.com/sgaunet/ekspodlogs)

For kubernetes:

* [krew](https://krew.sigs.k8s.io/)
* [helm v3](https://helm.sh/docs/intro/install/)
* [kubectl-dashboard](https://github.com/bouk/kubectl-dashboard)
* [k9s](https://k9scli.io/)
* [kubectl](https://kubernetes.io/releases/download/)
* alias for kubectl (k=kubectl + bash completion/zsh completion)
* [kubectx/kubens](https://github.com/ahmetb/kubectx/)
* [stern](https://github.com/wercker/stern)
* [popeye](https://github.com/derailed/popeye)
* [kfilt](https://github.com/ryane/kfilt)
* [kube-capacity](https://github.com/robscott/kube-capacity)
* [tilt](https://tilt.dev/)
* [kconf](https://github.com/particledecay/kconf)
* [kubectl-ice](https://github.com/NimbleArchitect/kubectl-ice)
* [kubefwd](https://github.com/txn2/kubefwd)
* [silver-surfer](https://github.com/devtron-labs/silver-surfer)
* [kluctl](https://github.com/kluctl/kluctl)
* [kubescape](https://github.com/kubescape/kubescape)
* [kubeval](https://github.com/instrumenta/kubeval)

For markdown :

* [marp](https://marp.app/)
* [mdtohtml](https://github.com/sgaunet/mdtohtml)

For Docker :

* [dockle](https://github.com/goodwithtech/dockle)
* [hadolint](https://github.com/hadolint/hadolint)
* [docker buildx](https://github.com/docker/buildx)
* [grype](https://github.com/anchore/grype)
* [dive](https://github.com/wagoodman/dive)

For GOLANG :

* [gvm](https://github.com/moovweb/gvm)
* [goreleaser](https://github.com/goreleaser/goreleaser/)
* [task](https://taskfile.dev/)
* [sqlc](https://sqlc.dev/)
* [golang-ci-lint](https://github.com/golangci/golangci-lint)
* [pre-commit](https://github.com/pre-commit/pre-commit)


VM :

* [packer](https://www.packer.io/)
* [vagrant](https://www.vagrantup.com/downloads)

Load tests :

* [plow](https://github.com/six-ddc/plow)
* [vegeta](https://github.com/tsenart/vegeta)

Development:

* [vscode](https://code.visualstudio.com/docs/setup/linux)
* vscode extensions
* [gtmpl](https://github.com/sgaunet/gtmpl)
* [gitleaks](https://github.com/zricethezav/gitleaks)
* [glab](https://github.com/profclems/glab/)
* [gitlab-issue-report](https://github.com/sgaunet/gitlab-issue-report)
* [gitlab-stats](https://github.com/sgaunet/gitlab-stats)
* [gum](https://github.com/charmbracelet/gum)
* [nfpm](https://nfpm.goreleaser.com/)
* [chglog](https://github.com/goreleaser/chglog)
* [scc](https://github.com/boyter/scc)
* [gaze](https://github.com/wtetsu/gaze)
* [trufflehog](https://github.com/trufflesecurity/trufflehog)
* [fx](https://github.com/antonmedv/fx)

Linux tools :

* [dust](https://github.com/bootandy/dust)
* [bottom](https://github.com/ClementTsang/bottom/)
* [zellij](https://github.com/zellij-org/zellij)
* [gdu](https://github.com/dundee/gdu)
* [yq](https://github.com/mikefarah/yq)
* [bandwhich](https://github.com/imsnif/bandwhich)
* [hyperfine](https://github.com/sharkdp/hyperfine)
* [gocrypt](https://github.com/sgaunet/gocrypt)
* [pet](https://github.com/knqyf263/pet)
* [usql](https://github.com/xo/usql)
* [sshs](https://github.com/quantumsheep/sshs)
* [exa](https://github.com/ogham/exa)
* [bat](https://github.com/sharkdp/bat)
* [vivid](https://github.com/sharkdp/vivid)
* [viddy](https://github.com/sachaos/viddy)
* [fd](https://github.com/sharkdp/fd)
* [tealdeer](https://github.com/dbrgn/tealdeer)
* [s5cmd](https://github.com/peak/s5cmd)
* [ctop](https://github.com/bcicen/ctop)
* [vhs](https://github.com/charmbracelet/vhs)
* [ttyd](https://github.com/tsl0922/ttyd) - dependency for vhs
* [gini](https://github.com/sgaunet/gini)

Tests:

* [venom](https://github.com/ovh/venom)
* [muffet](https://github.com/raviqqe/muffet/)

Misceleaneous :

* [peek](https://github.com/phw/peek)
* zsh
* [startship](https://starship.rs/)
* [pastel](https://github.com/sharkdp/pastel)

Bash formatter:

* [shellcheck](https://www.shellcheck.net/)
* [shfmt](https://github.com/mvdan/sh)

