#!/usr/bin/env bash
set -ex

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')

if [ "${ARCH}" == "arm64" ] ; then
    echo "Grass for arm64 currently not supported, skipping install"
    exit 0
fi

# Install grass
echo "Installing Grass"
apt-get update
apt-get install -y /dockerstartup/install/ubuntu/install/grass/grass_4.26.6_amd64.deb
echo "DONE Grass"

# Cleanup
chown -R 1000:0 $HOME
find /usr/share/ -name "icon-theme.cache" -exec rm -f {} \;
if [ -z ${SKIP_CLEAN+x} ]; then
  apt-get autoclean
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
fi
