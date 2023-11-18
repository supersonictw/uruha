#!/bin/sh

set -e

apt-get -qq update
apt-get -qq install -y --no-install-recommends wget ca-certificates

wget -qO /etc/apt/sources.list https://gist.githubusercontent.com/supersonictw/46f2da8114d620168c674fa8e104d1f0/raw/e4736ca846a1ebbc22ee47bc1d0676ced3604e0c/sources.debian.list
apt-get -qq update
apt-get -qq upgrade
