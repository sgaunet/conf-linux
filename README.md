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
* [awscli v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

For kubernetes:

* [krew](https://krew.sigs.k8s.io/)
* [helm v3](https://helm.sh/docs/intro/install/)
* [kubectl-dashboard](https://github.com/bouk/kubectl-dashboard)
* [k3s](https://k3s.io/)
* [k9s](https://k9scli.io/)
* [kubectl](https://kubernetes.io/releases/download/)
* alias for kubectl (k=kubectl + bash completion/zsh completion)
* [kubectx/kubens](https://github.com/ahmetb/kubectx/)
* [stern](https://github.com/wercker/stern)
* [popeye](https://github.com/derailed/popeye)
* [skaffold](https://skaffold.dev/)

For markdown :

* [marp](https://marp.app/)
* [typora](https://typora.io/)
* [mdtohtml](https://github.com/sgaunet/mdtohtml)

For Docker :

* [dockle](https://github.com/goodwithtech/dockle)
* [hadolint](https://github.com/hadolint/hadolint)

For GOLANG :

* [gvm](https://github.com/moovweb/gvm)
* [goreleaser](https://github.com/goreleaser/goreleaser/)
* [task](https://taskfile.dev/)


VM :

* [packer](https://www.packer.io/)
* [vagrant](https://www.vagrantup.com/downloads)


Misceleaneous :

* [peek](https://github.com/phw/peek)
* [vegeta](https://github.com/tsenart/vegeta)
* [vscode](https://code.visualstudio.com/docs/setup/linux)
* zsh
* [dust](https://github.com/bootandy/dust)
* [bottom](https://github.com/ClementTsang/bottom/)
