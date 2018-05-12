#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="miner"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
cd ~/
git clone $CUSTOM_GIT_URL
cd miner
npm install
touch config/_credentials.js
_log1 "Make sure to edit the file config/_credentials.js"
_success "Cloned repository"


cd "$SCRIPT_WORKING_DIR_PATH/$APP_NAME"

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"