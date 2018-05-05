#!/bin/bash

_section "Installing Chinese mirrors for APT"

_log "Backup original sources.list"
#cat /etc/apt/sources.list
mv /etc/apt/sources.list /etc/apt/sources.list.backup

_log "Copy new sources.list"
mv sources.list /etc/apt/sources.list

_log "Update APT (be patient)"
apt-get update
#-y -qq > /dev/null
 
_success "Installed Chinese mirrors"