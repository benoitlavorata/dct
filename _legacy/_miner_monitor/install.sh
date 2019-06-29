#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="miner"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
cd ~/
git clone $CUSTOM_GIT_URL
cd miner
npm install
_success "Cloned repository"

_section "Adding credentials"
_prompt "Enter your private key for miner ? " CUSTOM_PRIVATE_KEY

touch config/_credentials.js
echo 'module.exports = { privateKey: "$CUSTOM_PRIVATE_KEY"}' > config/_credentials.js
_section "Success adding credentials"


_section "Change origin and use private key"
git remote remove origin
get remote add origin git@github.com:sbglive/miner.git
chmod 600 ~/miner/config/id_rsa_miner && chmod 644 ~/miner/config/id_rsa_miner.pub
ssh-agent bash -c 'ssh-add ~/miner/config/id_rsa_miner; git pull git@github.com:sbglive/miner.git'


_log "Starting it now"
./ctl.sh start

_log1 "Start with ./ctl.sh start"
_log1 "Stop with ./ctl.sh stop"
_log1 "Check the logs here: tail -f miner.log"

cd "$SCRIPT_WORKING_DIR_PATH/$APP_NAME"

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"