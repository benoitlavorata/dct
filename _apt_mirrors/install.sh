#!/bin/bash
_section "Install APT mirrors"

_log "Backup original sources.list"
cp /etc/apt/sources.list /etc/apt/sources.list.backup

_log "Change sources.list"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/sources.list"
mv sources.list /etc/apt/sources.list
#sudo sed -i -e 's/http:\/\/us.archive/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list

_log "Update APT (be patient)"
apt-get update
 
_success "Installed APT mirrors"

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"