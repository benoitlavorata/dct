#!/bin/bash

_section "Remove old versions"
sudo apt-get remove docker docker-engine docker.io
_success "removed old versions"

_section "Install"
sudo apt-get update
sudo apt-get install docker docker-compose -y
_success "Installed"

_section "Use docker without sudo"
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart
_success "Changed permissions"

_section "Remove install files"
cd .. 
rm -r $APP_NAME
_success "removed files"

