#!/bin/bash

PACKAGE_LIST="vim docker docker-compose gcc build-essential nodejs npm wget curl"
NPM_LIST="forever n"

_section "Install usual packages (personal use)"
_log "Ubuntu packages: ${PACKAGE_LIST}"
_log "NPM packages: ${NPM_LIST}"
_break_line

_log "Update"
sudo apt-get update
_break_line

_log "Upgrade"
sudo apt-get upgrade -y
_break_line

_log "Install ubuntu packages"
sudo apt-get install $PACKAGE_LIST
_break_line

_log "Install npm packages (global)"
sudo npm install -g $NPM_LIST
_break_line
_success "Installed"

_log "Install compose.sh as bin in path"
cd ~/ 
mkdir bin
cp ~/.bash_profile ~/.bash_profile.compose.backup
echo 'PATH=$PATH:$HOME/bin' >> ~/.bash_profile 
cd ~/bin
rm compose.sh
wget https://raw.githubusercontent.com/sbglive/compose/master/compose.sh
chmod +x compose.sh
mv compose.sh app
cd "$SCRIPT_WORKING_DIR_PATH/$APP_NAME"


_log "Install docker"
app _docker
# /etc/docker/daemon.json
# {
#  "registry-mirrors": ["https://registry.docker-cn.com"]
# }


_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"