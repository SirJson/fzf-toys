#!/bin/bash
if [[ ! -r ~/.ssh/config ]]; then
    echo "No readable SSH host config found for this user"
    exit 1
fi

echo ~/.ssh/config | awk '{ if($1 =="Host" && $2 !="*") print $2 }' | fzf | xargs -o ssh
