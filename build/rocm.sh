#!/bin/sh

set -e

source rocm_env.sh

# Install script dependencies
apt-get -qq install build-essential cmake repo git git-lfs python3-pip sudo

# Repo sync
mkdir -p /build/rocm
cd /build/rocm
repo init -u https://github.com/RadeonOpenCompute/ROCm.git -b roc-$ROCM_MAJOR_VERSION.$ROCM_MINOR_VERSION.x
repo sync

# Prepare rocm-build
cd /build
git clone https://github.com/xuhuisheng/rocm-build.git

cd /build/rocm-build
git checkout 59b87dc62972c1ad32a8862e9ea6b5921c1f33a0

# Load build environment
sh ./install-dependency.sh

# Array of script names matching the pattern [0-9][0-9].?????.sh
scripts=($(ls -1v [0-9][0-9].*.sh))

# Loop through scripts and execute them
for script in "${scripts[@]}"; do
  echo "Running script: $script"
  bash "./$script"
  echo "----------------------------------------"
done
