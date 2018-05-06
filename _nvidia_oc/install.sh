#!/bin/bash

_log "Get files"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/default-oc.sh"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/high-oc.sh"

chmod +x default-oc.sh
chmod +x high-oc.sh
mv default-oc.sh ~/
mv high-oc.sh ~/

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"