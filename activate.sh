#!/bin/sh
# Uruha
# The chroot machine learning environment for amdgpu with ROCm.
# (c) 2022 SuperSonic (https://github.com/supersonictw)

. "$PWD/.trait.sh"

case "$1" in
"")
    URUHA_LOCK &&
        URUHA_MOUNT &&
        URUHA_CHROOT "/bin/sh" "-c" "cd /root && bash" &&
        URUHA_UMOUNT &&
        URUHA_UNLOCK
    ;;
umount)
    URUHA_UMOUNT &&
        URUHA_UNLOCK
    ;;
*) echo "$1: unknown task." ;;
esac
