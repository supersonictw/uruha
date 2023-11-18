#!/bin/sh

set -e

alias sudo=""

# Install script dependencies
apt-get -qq install build-essential cmake repo git git-lfs python3-pip

# Repo sync
repo init -u https://github.com/RadeonOpenCompute/ROCm.git -b roc-5.7.x
repo sync

# Prepare rocm-build
git clone https://github.com/xuhuisheng/rocm-build.git
cd rocm-build
git checkout 59b87dc62972c1ad32a8862e9ea6b5921c1f33a0

# Load build environment
source env.sh
sh install-dependency.sh

# Array of script names matching the pattern [0-9][0-9].?????.sh
scripts=($(ls -1v [0-9][0-9].*.sh))

# Loop through scripts and execute them
for script in "${scripts[@]}"; do
  echo "Running script: $script"
  bash "$script"
  echo "----------------------------------------"
done
