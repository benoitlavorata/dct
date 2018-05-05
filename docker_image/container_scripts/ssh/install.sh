#!/bin/bash

_section "SSH"

_log "Install openssh"
apt-get install -y openssh-server 
#-qq> /dev/null
mkdir /var/run/sshd

_log "Install boot files"
cp boot.sh /entrypoint/apps/$APP_NAME

_success "Installed SSH"