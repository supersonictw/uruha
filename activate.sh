#!/bin/bash

set -e

SUDO=''
if [ "$EUID" != 0 ]; then
    SUDO='sudo'
fi

export URUHA_WORK_DIRECTORY=$(pwd)

for name in tmp proc sys dev dev/pts etc/resolv.conf
do
    $SUDO mount --bind /$name $URUHA_WORK_DIRECTORY/rootfs/$name
done

$SUDO chroot rootfs /root/.uruha_python/bin/ipython

for name in tmp proc sys dev/pts dev etc/resolv.conf
do
    $SUDO umount $URUHA_WORK_DIRECTORY/rootfs/$name
done
