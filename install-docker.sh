#!/bin/bash
source "helpers.sh"
_intro "Install docker on ubuntu"
_quit_if_not_root "You cannot start this script without being root"

# Install docker on ubuntu
_section "Uninstall old versions"
sudo apt-get remove -y docker docker-engine docker.io
_success "Uninstall old versions"

_section "Install using the repository"
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce
_success "INSTALLED"

