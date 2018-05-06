#!/bin/bash

_section "Remove old versions"
sudo apt-get remove -y docker docker-engine docker.io docker-compose
_success "removed old versions"

_section "Install"
#sudo apt-get install docker docker-compose -y
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   sudo apt-get update
   sudo apt-get install -y docker-ce
_success "Installed"


_section "Use docker with chinese mirrors"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/daemon.json"
sudo mkdir /etc/docker/
sudo mv daemon.json /etc/docker/daemon.json
_success "Docker chinese mirrors"


_section "Use docker without sudo"
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart
_success "Changed permissions"

_section "Test docker"
docker run hello-world
_success "Tested docker"

_section "Remove install files"
cd .. 
rm -r $APP_NAME
_success "removed files"

