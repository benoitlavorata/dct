FROM nvidia/cuda:9.1-base-ubuntu16.04

# 
# Initial code from https://hub.docker.com/r/sh39sxn/aion-miner-gpu/
# Thank you for the great work !
#

ENV DEVICE=0
ENV CUDA_SOLVER=1
ENV MINING_POOL_ADDRESS=localhost
ENV MINING_POOL_PORT=3333
ENV MINING_ADDRESS=xvin3t_smartminer

# replaceholder for downloading specific version
#ARG MINER_VERSION=v0.1.10  # use v as prefix for this version
ARG MINER_VERSION=v3.1
ARG MINER_GIT="smartbitcoin/SmartMiner"

RUN rm /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list && apt-get update && apt-get install -y \
        jq \
        curl \
        wget \
        bzip2

WORKDIR /opt

# example: https://api.github.com/repos/smartbitcoin/SmartMiner/releases/tags/v3.1
RUN curl -s https://api.github.com/repos/${MINER_GIT}/releases/tags/${MINER_VERSION} | jq --raw-output '.assets[0] | .browser_download_url' | xargs wget -O aion_smartminer.tar.bz2
RUN tar -xvjf ./aion_smartminer.tar.bz2

# start GPU Miner
CMD ./SmartMiner.$MINER_VERSION -cd $DEVICE -cv $CUDA_SOLVER -l $MINING_POOL_ADDRESS:$MINING_POOL_PORT -u $MINING_ADDRESS


#   docker build -f aion_smartminer.Dockerfile -t aion_smartminer .
#   docker run -it -e MINING_POOL_ADDRESS=pool.sbg-live.com -e MINING_POOL_PORT=3333 -e MINING_ADDRESS=brice_gpus -e CUDA_SOLVER=1 -e DEVICE=0 --net=aion_mining --runtime=nvidia --rm --name blavorata/aion_smartminer:latest bash
