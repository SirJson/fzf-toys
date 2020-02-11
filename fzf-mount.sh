#!/bin/bash

_set_fzf_default_opts() {
  local color00='#232c31'
  local color01='#1c3657'
  local color04='#84898c'
  local color06='#a7cfa3'
  local color0A='#a03b1e'
  local color0C='#b02f30'
  local color0D='#484d79'

  export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
}

_set_fzf_default_opts

DEVICES=$(ls -GAB /dev | grep -P 'sd[a-z]|mmc\w+|nvme\w+')

SELECT=$($DEVICES | xargs -I % sh -c "echo /dev/%" | fzf --preview="lsblk -x NAME -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT {+}" --margin 4% --preview-window=right:70%:wrap --prompt='<ESC>=Exit <RETURN>=Accept | Device to mount: ')

[ -z "$SELECT" ] && exit 0

DEVNAME=$(lsblk "$SELECT" -n -o NAME)
MNTDIR="/mnt/$DEVNAME"

echo "Mounting $SELECT to $MNTDIR..."

sudo mkdir -p "$MNTDIR"
sudo mount "$SELECT" "$MNTDIR"

if sudo mount "$SELECT" "$MNTDIR"; then
  echo "$SELECT successfully mounted!"
else
  echo "Failed to mount $SELECT"
fi
