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

* k9s
* kubectl
* alias for kubectl (k=kubectl + bash completion/zsh completion)
* kubectx/kubens
* [marp](https://marp.app/)
* [stern](https://github.com/wercker/stern)
* [popeye](https://github.com/derailed/popeye)
* [awscli v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* [dockle](https://github.com/goodwithtech/dockle)
* [gvm](https://github.com/moovweb/gvm)
* [hadolint](https://github.com/hadolint/hadolint)
* [helm v3](https://helm.sh/docs/intro/install/)
* [krew (for kubectl + some plugins)](https://github.com/kubernetes-sigs/krew)
* [packer](https://www.packer.io/)
* [peek](https://github.com/phw/peek)
* [skaffold](https://skaffold.dev/)
* [typora](https://typora.io/)
* [vagrant](https://www.vagrantup.com/downloads)
* [vegeta](https://github.com/tsenart/vegeta)
* [vscode](https://code.visualstudio.com/docs/setup/linux)
* zsh
* [dust](https://github.com/bootandy/dust)
* [bottom](https://github.com/ClementTsang/bottom/)