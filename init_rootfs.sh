#!/bin/sh

set -e

SUDO=''
if [ "$EUID" != 0 ]; then
    SUDO='sudo'
fi

$SUDO wget -O rootfs.tar.gz http://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.1-base-amd64.tar.gz

$SUDO mkdir rootfs && cd rootfs
$SUDO tar -zxvf ../rootfs.tar.gz && rm ../rootfs.tar.gz

$SUDO cp ../.rootfs_setup.sh . && chmod +x .rootfs_setup.sh
$SUDO chroot . /bin/bash ./.rootfs_setup.sh

$SUDO rm .rootfs_setup.sh
