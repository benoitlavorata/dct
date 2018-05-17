#!/bin/bash
PACKAGE_LIST="vim wget curl jq autossh"

_section "Install usual ubuntu packages"
_log "Ubuntu packages: ${PACKAGE_LIST}"

_log "Install ubuntu packages"
sudo apt-get install -y $PACKAGE_LIST

_success "Installed packages"

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"