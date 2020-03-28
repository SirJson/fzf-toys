#!/bin/bash

pip3 list --process-dependency-links --pre  --user | fzf --nth=1 --with-nth=1 --preview='pip3 show --files {1}' --prompt="Python package >" --header-lines=2 --sort --layout=reverse | xargs pip3 show --files
