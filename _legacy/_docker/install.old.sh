#!/bin/bash

_section "Remove old versions"
sudo apt-get remove docker docker-engine docker.io
_success "removed old versions"

_section "Install deps"
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
_success "Installed deps"

_section "Add rep"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   sudo apt-get update
_success "Add rep"

_section "Install docker-ce and compose"
sudo apt-get install docker
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
_success "installed"

_section "Remove install files"
cd .. 
rm -r _docker
_success "removed files"

