FROM ubuntu:16.04

ENV REDIS_HOST=aion_redis
ENV KERNEL_HOST=aion_kernel

# replaceholder for downloading specific version
#ARG MINER_VERSION=v0.1.10  # use v as prefix for this version and for 0.1.11
ARG MINER_VERSION=v0.2.2

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        build-essential \
        libboost-all-dev \
        git \
        moreutils \
        jq \
        make \
        gcc

WORKDIR /opt

# install NodeJs 9.x (https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs


# install node-gyp v3.6.2+
RUN npm install -g node-gyp

# install libsodium v1.0.16+
RUN wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
RUN tar -xvzf LATEST.tar.gz
RUN cd libsodium-stable && ./configure && make && make check && make install

# install more prerequisites
RUN npm install --save nan
RUN npm install bindings


RUN curl -s https://api.github.com/repos/aionnetwork/aion_miner/releases/tags/$MINER_VERSION | jq --raw-output '.assets[0] | .browser_download_url' | xargs wget -O aion-solo-pool.tar.gz
RUN tar -xvzf ./aion-solo-pool.tar.gz
RUN ls -la

RUN cd ./local_modules/equihashverify && node-gyp configure && node-gyp build && ldconfig -v && node-gyp rebuild && node test.js  
#(should print a table, if not try: sudo ldconfig -v --> node-gyp rebuild --> node test.js)

WORKDIR /opt
RUN chown -R root:root . && npm install
#(needed because npm install fails because of missing permissions)

RUN npm install --unsafe-perm bignum && npm rebuild --unsafe-perm

COPY ./start-solo-mining-pool.sh ./start-solo-mining-pool.sh

CMD ./start-solo-mining-pool.sh $REDIS_HOST $KERNEL_HOST
#CMD ./run.sh

#   docker build -f aion_pool.Dockerfile -t aion:pool .
#   docker run -p 3333:3333 --restart always --net=aion_mining --rm --name aion_pool aion:pool bash