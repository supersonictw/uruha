#!/bin/bash

set -e

export URUHA_WORK_DIRECTORY=$PWD

if [ -d "$URUHA_WORK_DIRECTORY/rootfs" ]; then
    echo "rootfs already exists, exits for preventing from unexpected initiating."
    exit 1
fi

if [ ! -f "/tmp/uruha.lock" ]; then
    touch /tmp/uruha.lock
else
    echo "/tmp/uruha.lock already exists, exits for preventing from unexpected mounting."
    exit 1
fi

SUDO=""
if [ "$EUID" != 0 ]; then
    SUDO="sudo"
fi

$SUDO wget -O "$URUHA_WORK_DIRECTORY/rootfs.tar.gz" http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.4-base-amd64.tar.gz

$SUDO mkdir "$URUHA_WORK_DIRECTORY/rootfs"

$SUDO tar -zxvf "$URUHA_WORK_DIRECTORY/rootfs.tar.gz" -C "$URUHA_WORK_DIRECTORY/rootfs"
$SUDO rm "$URUHA_WORK_DIRECTORY/rootfs.tar.gz"

$SUDO cp "$URUHA_WORK_DIRECTORY/.rootfs_setup.sh" "$URUHA_WORK_DIRECTORY/rootfs/setup.sh"
$SUDO chmod +x "$URUHA_WORK_DIRECTORY/rootfs/setup.sh"

for name in tmp proc sys dev dev/pts etc/resolv.conf
do
    $SUDO mount --bind /$name "$URUHA_WORK_DIRECTORY/rootfs/$name"
done

$SUDO chroot "$URUHA_WORK_DIRECTORY/rootfs" /bin/bash /setup.sh

for name in etc/resolv.conf dev/pts dev sys proc tmp
do
    $SUDO umount "$URUHA_WORK_DIRECTORY/rootfs/$name"
done

$SUDO rm "$URUHA_WORK_DIRECTORY/rootfs/setup.sh"
rm /tmp/uruha.lock
