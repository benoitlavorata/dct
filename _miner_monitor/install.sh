#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="miner"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
cd ~/
git clone $CUSTOM_GIT_URL
cd miner

_success "Cloned repository"



_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"