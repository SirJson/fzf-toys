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

SELECT=$(df -h --output="source" | grep -E "/dev/sd" | fzf --preview="lsblk -x NAME -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT {+}" --prompt='<ESC>=Exit <RETURN>=Accept | Unmount device: ')

[ -z "$SELECT" ] && exit 0

POINT=$(lsblk "$SELECT" -n -o MOUNTPOINT)

echo "Unmounting $SELECT from $POINT..."

if sudo umount "$POINT"; then
  echo "$SELECT successfully unmounted! You can now safely eject the device."
else
  echo "Failed to unmount $SELECT"
fi
