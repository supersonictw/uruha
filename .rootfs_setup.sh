#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    build-essential ca-certificates curl git-core gpg wget python3 tk-dev dropbear \
    libncurses5-dev libsqlite3-dev libbz2-dev \
    libffi-dev liblzma-dev libreadline-dev \
    libtk8.6 libgdm-dev libdb4o-cil-dev libpcap-dev libssl-dev 

wget -O /tmp/amdgpu-install.deb https://repo.radeon.com/amdgpu-install/6.1.2/ubuntu/jammy/amdgpu-install_6.1.60102-1_all.deb

apt-get install -y -f \
    /tmp/amdgpu-install.deb &&
    amdgpu-install -y --no-dkms --no-32

wget -O - https://pyenv.run | bash

tee -a /root/.bashrc <<'EOF'
alias sudo=""
alias run-sshd="dropbear -REFp 2024"
alias amdgpu-install="amdgpu-install --no-dkms --no-32"

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u [uruha_chroot]\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export HSA_OVERRIDE_GFX_VERSION="10.3.0"
export ROCM_PATH="/opt/rocm"
export PATH="$ROCM_PATH/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF
