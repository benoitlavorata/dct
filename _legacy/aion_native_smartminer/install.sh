#!/bin/bash

_section "Install Aion Miner in Docker"
mkdir boot_container
cd boot_container
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/boot.sh"
cd ..
_success "Got boot file"

rm /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list && apt-get install -y bzip2
cd /opt

# example: https://api.github.com/repos/smartbitcoin/SmartMiner/releases/tags/v3.1
curl -s https://api.github.com/repos/${MINER_GIT}/releases/tags/${MINER_VERSION} | jq --raw-output '.assets[0] | .browser_download_url' | xargs wget -O aion_smartminer.tar.bz2
tar -xvjf ./aion_smartminer.tar.bz2



_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"