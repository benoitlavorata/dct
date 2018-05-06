#!/bin/bash

_log "Install compose.sh as bin in path"
cd "$SCRIPT_WORKING_DIR_PATH/$APP_NAME"

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"