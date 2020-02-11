#!/bin/bash

# Create useful gitignore files. Based on gi from fzf examples
# Usage: ignoreman [param]
# param is a comma separated list of ignore profiles.
# If param is ommited choose interactively.
# This version will modify or create a .gitignore file and provide a preview in interactive mode

# I also switched from sh to bash because I couldn't execute this script with sh.

function __gi() {
  curl -L -s https://www.gitignore.io/api/"$*"
}

function __writeresult() {
  __gi "$1" >>.gitignore
}

if [ "$#" -eq 0 ]; then
  IFS+=","
  for item in $(__gi list); do
    echo "$item"
  done | fzf --multi --ansi --exact --header='Select the templates you want to add to your .gitignore file' --preview="curl -L -s https://www.gitignore.io/api/{}" | paste -s -d "," - |
    { read -r result && __writeresult "$result"; }
else
  __gi "$@"
fi
