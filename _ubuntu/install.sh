#!/bin/bash

PACKAGE_LIST="vim docker docker-compose gcc build-essential nodejs npm wget curl"
NPM_LIST="forever n"

_section "Install usual packages (personal use)"
_log "Ubuntu packages: ${PACKAGE_LIST}"
_log "NPM packages: ${NPM_LIST}"
_break_line

_log "Update"
sudo apt-get update

_log "Upgrade"
sudo apt-get upgrade -y

_log "Install ubuntu packages"
sudo apt-get install $PACKAGE_LIST

_log "Install npm packages (global)"
sudo npm install -g $NPM_LIST

_success "Installed"

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"