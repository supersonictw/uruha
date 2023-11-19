#!/bin/bash

set -e

export URUHA_WORK_DIRECTORY=$(pwd)

if [ -d "$URUHA_WORK_DIRECTORY/rootfs" ]; then
    echo "rootfs already exists, exits for preventing from unexpected initiating."
    exit 1
fi

SUDO=''
if [ "$EUID" != 0 ]; then
    SUDO='sudo'
fi

$SUDO wget -O $URUHA_WORK_DIRECTORY/rootfs.tar.gz http://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.1-base-amd64.tar.gz

$SUDO mkdir $URUHA_WORK_DIRECTORY/rootfs

$SUDO tar -zxvf $URUHA_WORK_DIRECTORY/rootfs.tar.gz -C $URUHA_WORK_DIRECTORY/rootfs
$SUDO rm $URUHA_WORK_DIRECTORY/rootfs.tar.gz

$SUDO cp $URUHA_WORK_DIRECTORY/.rootfs_setup.sh $URUHA_WORK_DIRECTORY/rootfs/setup.sh
chmod +x $URUHA_WORK_DIRECTORY/rootfs/setup.sh

$SUDO mount --bind /etc/resolv.conf $URUHA_WORK_DIRECTORY/rootfs/etc/resolv.conf
$SUDO chroot $URUHA_WORK_DIRECTORY/rootfs /bin/bash /setup.sh

$SUDO rm $URUHA_WORK_DIRECTORY/rootfs/setup.sh
