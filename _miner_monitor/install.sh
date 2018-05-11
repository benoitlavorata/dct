#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="dockprom"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
git clone $CUSTOM_GIT_URL
eval "mv $CUSTOM_GIT_FOLDER/* ."
_success "Cloned repository"


_section "Add default runtime as nvidia for docker"
sudo su
cp "/etc/docker/daemon.json" "/etc/docker/daemon.json.backup"
sed -i '$ d' "/etc/docker/daemon.json"
sed -i '${s/$/,/}' /etc/docker/daemon.json
echo '"default-runtime": "nvidia"' >> "/etc/docker/daemon.json"
echo '}' >> "/etc/docker/daemon.json"
exit
sudo service docker restart
cat "/etc/docker/daemon.json"
_success "nvidia as default runtime"

_log "Install the miner !"
cd ~/
app aion_smartminer
cd "$SCRIPT_WORKING_DIR_PATH/$APP_NAME"

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"