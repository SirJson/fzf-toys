#!/bin/bash

SELECT=$(df -h --output="source" | grep -E "/dev/sd" | fzf --preview="lsblk -x NAME -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT {+}" --prompt='<ESC>=Exit <RETURN>=Accept | Unmount device: ')

[ -z "$SELECT" ] && exit 0

POINT=$(lsblk "$SELECT" -n -o MOUNTPOINT)

echo "Unmounting $SELECT from $POINT..."

if sudo umount "$POINT"; then
  echo "$SELECT successfully unmounted! You can now safely eject the device."
else
  echo "Failed to unmount $SELECT"
fi
