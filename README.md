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

The script will mount/chroot/umount the rootfs automatically.

The default shell is `bash`, and ["pyenv"](https://github.com/pyenv/pyenv) pre-installed, you can use "pyenv" to download/activate python version on your prefer.

The script default behavior will define `HSA_OVERRIDE_GFX_VERSION=10.3.0` in `/root/.bashrc` to support RX6XXX series RDNA2 GPUs, you can change the variable for supporting your device.
