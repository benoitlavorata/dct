#!/bin/bash

_section "Remove old versions"
sudo apt-get remove docker docker-engine docker.io
_success "removed old versions"

_section "Install"
sudo apt-get update
sudo apt-get install docker docker-compose -y
_success "Installed"

_section "Remove install files"
cd .. 
rm -r _docker
_success "removed files"

