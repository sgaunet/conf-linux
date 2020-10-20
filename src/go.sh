#!/usr/bin/env bash

ansible-playbook -i hosts installation.yml -l portable --ask-become-pass
