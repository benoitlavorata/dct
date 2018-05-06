#!/bin/bash

_log "Install compose.sh as bin in path"
cd ~/ 
mkdir bin
cp ~/.bash_profile ~/.bash_profile.compose.backup
echo 'PATH=$PATH:$HOME/bin' >> ~/.bash_profile 
source ~/.bash_profile 
cd ~/bin
rm compose.sh
_download https://raw.githubusercontent.com/sbglive/compose/master/compose.sh
chmod +x compose.sh
mv compose.sh app
cd "$SCRIPT_WORKING_DIR_PATH/$APP_NAME"

_log "Start install !"
app _ubuntu _nvidia_driver

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"