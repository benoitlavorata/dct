#!/bin/bash

_section "Install usual packages (personal use)"
sudo apt-get install -y gcc build-essential

NPM_LIST="forever n"
_log "NPM packages: ${NPM_LIST}"
_break_line

_section "Install nodejs"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
_break_line

_log "Install npm packages (global)"
sudo npm install -g $NPM_LIST
_break_line

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"