#!/bin/bash

set -e

export URUHA_WORK_DIRECTORY=$(pwd)

if [ ! -f "/tmp/uruha.lock" ]; then
    touch /tmp/uruha.lock
else
    echo "/tmp/uruha.lock already exists, exits for preventing from unexpected mounting."
    exit 1
fi

SUDO=''
if [ "$EUID" != 0 ]; then
    SUDO='sudo'
fi

for name in tmp proc sys dev dev/pts etc/resolv.conf
do
    $SUDO mount --bind /$name $URUHA_WORK_DIRECTORY/rootfs/$name
done

$SUDO chroot rootfs /bin/sh -c "cd /root && bash"

for name in tmp proc sys dev/pts dev etc/resolv.conf
do
    $SUDO umount $URUHA_WORK_DIRECTORY/rootfs/$name
done

rm /tmp/uruha.lock
