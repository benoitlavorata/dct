#!/bin/bash

_log "Get files"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/gpu.sh"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/mgpu.sh"

chmod +x *.sh
mkdir ~/scripts
mv gpu.sh ~/scripts
mv mgpu.sh ~/

_log "Check if it is working"
cd ~/scripts
./gpu.sh

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"