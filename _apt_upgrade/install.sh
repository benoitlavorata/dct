#!/bin/bash
_section "APT Upgrade"
_log "Execute upgrade (be patient)"
 apt-get upgrade -y
_success "Upgraded APT"


_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"