#!/bin/sh
# Uruha
# The chroot machine learning environment for amdgpu with ROCm.
# (c) 2022 SuperSonic (https://github.com/supersonictw)

. "$PWD/.trait.sh"

if [ -d "$URUHA_WORK_DIRECTORY/rootfs" ]; then
    echo "rootfs already exists, exits for preventing from unexpected initiating."
    exit 1
fi

URUHA_LOCK

$SUDO wget -O "$URUHA_WORK_DIRECTORY/rootfs.tar.gz" -- \
    "http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.3-base-amd64.tar.gz"

$SUDO mkdir -- "$URUHA_WORK_DIRECTORY/rootfs"

$SUDO tar -zxvf "$URUHA_WORK_DIRECTORY/rootfs.tar.gz" -C "$URUHA_WORK_DIRECTORY/rootfs"
$SUDO rm -- "$URUHA_WORK_DIRECTORY/rootfs.tar.gz"

$SUDO cp -- "$URUHA_WORK_DIRECTORY/.rootfs_setup.sh" "$URUHA_WORK_DIRECTORY/rootfs/setup.sh"
$SUDO chmod +x -- "$URUHA_WORK_DIRECTORY/rootfs/setup.sh"

URUHA_MOUNT
URUHA_CHROOT "/bin/bash" "/setup.sh"
URUHA_UMOUNT

$SUDO rm -- "$URUHA_WORK_DIRECTORY/rootfs/setup.sh"

URUHA_UNLOCK
