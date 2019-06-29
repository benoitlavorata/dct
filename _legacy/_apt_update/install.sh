#!/bin/bash
_section "APT Update"
_log "Execute update (be patient)"
 apt-get update
 # -qq > /dev/null
_success "Updated APT"


_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"