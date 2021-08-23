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
* marp
* stern
* popeye
* awscli
* dockle
* gvm
* hadolint
* helm
* krew (for kubectl + some plugins)
* packer
* peek
* skaffold
* typora
* vagrant
* vegeta
* vscode
* zsh
* [dust](https://github.com/bootandy/dust)
* [bottom](https://github.com/ClementTsang/bottom/)