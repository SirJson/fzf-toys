#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
    exit 1
fi

echo "Symlink all scripts"
for f in ./*.sh; do
    real=$(realpath "$f")
    base=$(basename "$f" .sh)
    if [[ "$base" != "linkall" ]]; then
        echo "$real -> /usr/local/bin/$base"
        ln -s "$real" "/usr/local/bin/$base"
    fi
done