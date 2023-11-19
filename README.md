# Uruha

The chroot machine learning environment for amdgpu with ROCm.

## Installation

Choose the directory you prefer to storage your rootfs.

For me, I chosen a drive mounted directory, because ROCm will cost more than 16GB, it's so large.

```sh
git clone https://github.com/supersonictw/uruha.git . # Checkout the repository
bash init_rootfs.sh # Play the magic
```

Yep, only two commands, the script will download the rootfs and install ROCm suites automatically.

## Usage

```sh
bash activate.sh
```

The script will mount/chroot/umount the rootfs automatically, the default shell is `ipython` with `python 3.8`, you can use ["pyenv"](https://github.com/pyenv/pyenv) or something like to switch your python version.
