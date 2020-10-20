# conf-linux

That's a collection of ansible role to configure my Linux account for a new PC (debian based). That's far away from perfection but that's a start and I will try to update it to be indepotent (actually, it's not).

# Execution 

```
git clone git@github.com:sgaunet/conf-linux.git
sudo apt install -y ansible
cd conf-linux/src
<edit> installation.yml
./go.sh
```

# Roles

##  common

Install : cifs-utils','tmux','firefox','git','git-crypt','gpg','docker','jq'

##  awscli

Install the awscli to play with Amazon Web Service API.

##  packer

Install packer.

##  typora

Install Typora.

##  vagrant

Install vagrant.

##  vscode

Install vscode from official repository.

##  zsh

Install zsh, ohmyzsh and configure the ~/.zshrc with agnoster theme. 

## kubectl

Install kubectl command

## kubectx-ns

Install :

* kubens
* kubectx


## helm

Install helm v3

## kube-ps1

To get a beautiful prompt (for bash or zsh)

![prompt](img/prompt.png)
      