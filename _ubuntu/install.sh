#!/bin/bash

PACKAGE_LIST="vim docker docker-compose gcc build-essential nodejs npm wget curl jq"
NPM_LIST="forever n"

_section "Install usual packages (personal use)"
_log "Ubuntu packages: ${PACKAGE_LIST}"
_log "NPM packages: ${NPM_LIST}"
_break_line

_section "Set APT mirrors"
sudo sed -i -e 's/http:\/\/us.archive/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list

_log "Update"
sudo apt-get update
_break_line

_log "Upgrade"
sudo apt-get upgrade -y
_break_line

_log "Install ubuntu packages"
sudo apt-get install -y $PACKAGE_LIST
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
_download https://raw.githubusercontent.com/sbglive/compose/master/compose.sh
chmod +x compose.sh
mv compose.sh app
cd "$SCRIPT_WORKING_DIR_PATH/$APP_NAME"


_log "Install docker, portainer, cloud9, monitor"
app _docker portainer cloud9 monitor

_log "Start portainer, cloud9, monitor"
cd portainer
./up.sh
cd ..
cd cloud9
./up.sh
cd ..
cd monitor
./up.sh
cd ..

_log1 "Portainer should be running here: http://127.0.0.1:9000/"
_log1 "Cloud9 should be running here: http://127.0.0.1:8181/"
_log1 "Monitor should be running here: http://127.0.0.1:3000/"
_break_line

_log "Start SSH and gen custom keys"
sudo service ssh restart
ssh-keygen -t rsa -b 4096 
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"