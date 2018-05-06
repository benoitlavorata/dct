#!/bin/bash
_log "Check the running driver"
lsmod | grep video

#_log "Disable Nouveau driver"
#lsmod | grep nouveau
#/etc/modprobe.d/nvidia-installer-disable-nouveau.conf

_log "Continue install !"
app _nvidia_monitor _nvidia_docker _nvidia_oc

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"