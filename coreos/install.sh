#!/bin/sh

grubdisk='/dev/disk/by-label/OEM'

if [ ! -e "$1" ]; then
	printf 'Target "%s" not found.\nPlease specify a block device to install to as a parameter, e.g:\n    %s /dev/sda\n\nAvailable block devices:\n%s\n' \
		"$1" "$0" "$(lsblk)" >&2
	exit 1
fi

set -e

sudo coreos-install -d "$1"

printf 'Waiting for partitions to appear ...'
for i in 1 2 3 4 5 6 7 8 9 10; do
	if [ -e "$grubdisk" ]; then
		break
	fi
	sleep 1
done
printf '\n'

sudo mount "$grubdisk" /mnt
printf 'set linux_append="cloud-config-url=https://raw.githubusercontent.com/scy/devbox/master/coreos/cloud-config.yml"\n' \
	| sudo tee /mnt/grub.cfg >/dev/null
sudo umount /mnt

sudo reboot
