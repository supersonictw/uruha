#!/bin/bash

apt-get update
apt-get install -y --no-install-recommends \
    gpg wget ca-certificates

mkdir --parents --mode=0755 /etc/apt/keyrings
wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | gpg --dearmor | tee /etc/apt/keyrings/rocm.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/debian focal main' | tee /etc/apt/sources.list.d/rocm.list
echo 'Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600' | tee /etc/apt/preferences.d/rocm-pin-600

apt update

apt install -y --no-install-recommends \
    python3 python3-pip python3-venv python-is-python3 \
    rocm-hip-libraries rocm-libs miopen-hip-dev hipfft-dev rocrand-dev hipsparse-dev hipsolver-dev \
    rccl-dev rccl hip-dev rocfft-dev roctracer-dev hipblas-dev rocm-device-libs \
    rocsolver-dev rocblas-dev

python -m venv /root/.uruha_python
/root/.uruha_python/bin/pip install ipython

tee -a /root/.bashrc <<'EOF'
export HSA_OVERRIDE_GFX_VERSION="10.3.0"
if [ -d /opt/rocm ]; then
    ROCM_PATH=/opt/rocm
    PATH=$ROCM_PATH/bin:$PATH
fi
if [ -f /root/.uruha_python/bin/activate ]; then
    . /root/.uruha_python/bin/activate
fi
EOF
