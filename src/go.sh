#!/usr/bin/env bash

tag="$1"

if [ -z "$tag" ]
then
    ansible-playbook -i hosts installation.yml -l portable --ask-become-pass
else
    ansible-playbook -i hosts installation.yml -l portable --ask-become-pass -t $tag
fi
