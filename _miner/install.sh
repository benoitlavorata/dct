#!/bin/bash
_section "Install miner in ~/"
cd ~/

_section "Set APT mirrors"
sudo sed -i -e 's/http:\/\/us.archive/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list
 
_log "Update"
sudo apt-get update
_break_line

_log "Upgrade"
sudo apt-get upgrade -y
_break_line

_log "Install ubuntu packages"
PACKAGE_LIST="vim wget curl git"
_log "Ubuntu packages: ${PACKAGE_LIST}"
sudo apt-get install -y $PACKAGE_LIST
_break_line

_log "Install node and npm"
app _nodejs
_break_line

_log "Install docker"
app _docker
_break_line

_log "Install nvidia drivers"
app _nvidia_driver
_break_line

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"