#!/bin/bash
PACKAGE_LIST="vim wget curl jq tmux autossh openssh-server"

_section "Install usual packages (personal use)"
_log "Ubuntu packages: ${PACKAGE_LIST}"
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

_log "Install node and npm"
cd ~/
app _nodejs
_break_line

_log "Install git"
cd ~/
app _git
_break_line

_log "Install docker, portainer, cloud9, monitor"
cd ~/
app _docker
cd ~/
app portainer 
cd ~/ 
app cloud9 
cd ~/
app monitor

cd ~/

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


_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"