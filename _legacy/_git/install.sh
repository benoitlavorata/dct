#!/bin/bash

_section "Install git"
sudo apt-get install -y git

_log "Set git"
_prompt "Input your email (for git actions) ?" CUSTOM_USER_GIT_MAIL
_prompt "Input your email (for git actions) ?" CUSTOM_USER_GIT_NAME
git config --global user.email "$CUSTOM_USER_GIT_MAIL"
git config --global user.name "$CUSTOM_USER_GIT_NAME"

_log "Start SSH and gen custom keys"
sudo service ssh restart
ssh-keygen -t rsa -b 4096 
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
_break_line

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"