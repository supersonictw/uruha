#!/bin/sh

URUHA_WORK_DIRECTORY="$PWD"
URUHA_LOCK_FILE="/tmp/uruha.lock"

SUDO=""
if [ "$EUID" != 0 ]; then
    SUDO="sudo"
fi

URUHA_LOCK() {
    if [ ! -f "$URUHA_LOCK_FILE" ]; then
        touch -- "$URUHA_LOCK_FILE"
    else
        echo "$URUHA_LOCK_FILE already exists, exits for preventing from unexpected mounting."
        exit 1
    fi
}

URUHA_UNLOCK() {
    if [ -f "$URUHA_LOCK_FILE" ]; then
        rm -- "$URUHA_LOCK_FILE"
    else
        echo "$URUHA_LOCK_FILE not exists."
        exit 1
    fi
}

URUHA_MOUNT() {
    for name in tmp proc sys dev dev/pts etc/resolv.conf; do
        $SUDO mount --bind -- /$name "$URUHA_WORK_DIRECTORY/rootfs/$name"
    done
}

URUHA_UMOUNT() {
    for name in etc/resolv.conf dev/pts dev sys proc tmp; do
        $SUDO umount -- "$URUHA_WORK_DIRECTORY/rootfs/$name"
    done
}

URUHA_CHROOT() {
    $SUDO chroot -- "$URUHA_WORK_DIRECTORY/rootfs" $* || true
    sleep 1
}
