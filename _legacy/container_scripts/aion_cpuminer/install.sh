#!/bin/bash
#ENV NUMBER_CPU_THREADS=1
#ENV MINING_POOL_ADDRESS=localhost
#ENV MINING_POOL_PORT=3333
#ENV MINING_ADDRESS=0xa002b257cdc41ec76cbc9e30e1f1d93d0fe702201a45ab588ccabaadd5606e22

_section "Install Aion CPU Miner"

# replaceholder for downloading specific version
#ARG MINER_VERSION=v0.1.10  # use v as prefix for this version
MINER_VERSION=v0.2.2

_log "get packages (be patient)"
apt-get install -y -qq bzip2 curl jq wget > /dev/null

_log "get miner version $MINER_VERSION(be patient)"
cd /opt
https://api.github.com/repos/aionnetwork/aion_miner/releases/tags/v0.2.2
curl -s "https://api.github.com/repos/aionnetwork/aion_miner/releases/tags/$MINER_VERSION" | jq --raw-output '.assets[0] | .browser_download_url' | xargs wget -O aionminer_CPU.tar.bz2

v0.2.2
_log "Extract"
tar -xvjf ./aionminer_CPU.tar.bz2 >/dev/null

_log "Show results"
ls 

_log "Install boot files"
cp boot.sh /entrypoint/apps/$APP_NAME

_success "Installed $APP_NAME"