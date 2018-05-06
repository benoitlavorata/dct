#!/bin/bash
_log "Continue install !"
_nvidia_docker

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"