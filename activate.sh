#!/bin/bash

set -e

export URUHA_WORK_DIRECTORY=$(pwd)

SUDO=''
if [ "$EUID" != 0 ]; then
    SUDO='sudo'
fi

URUHA_MOUNT() {
    if [ ! -f "/tmp/uruha.lock" ]; then
        touch /tmp/uruha.lock
    else
        echo "/tmp/uruha.lock already exists, exits for preventing from unexpected mounting."
        exit 1
    fi

    for name in tmp proc sys dev dev/pts etc/resolv.conf
    do
        $SUDO mount --bind /$name $URUHA_WORK_DIRECTORY/rootfs/$name
    done
}

URUHA_UMOUNT() {
    for name in etc/resolv.conf dev/pts dev sys proc tmp
    do
        $SUDO umount $URUHA_WORK_DIRECTORY/rootfs/$name
    done

    rm /tmp/uruha.lock
}

URUHA_CHROOT() {
    $SUDO chroot rootfs /bin/sh -c "cd /root && bash" || true
}

case "$1" in
    "") 
        URUHA_MOUNT
        URUHA_CHROOT
        URUHA_UMOUNT
        ;;
    umount)
        URUHA_UMOUNT
        ;;
    *) echo "$1: unknown task."
esac
