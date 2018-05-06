#!/bin/bash
DRIVER_VERSION="380.48"
DRIVER_ARCH="Linux-x86_64"

_section "Install drivers $DRIVER_VERSION for $DRIVER_ARCH"

_log "Download drivers"
_download "http://us.download.nvidia.com/XFree86/$DRIVER_ARCH/$DRIVER_VERSION/NVIDIA-$DRIVER_ARCH-$DRIVER_VERSION.run"
chmod +x NVIDIA-$DRIVER_ARCH-$DRIVER_VERSION.run
_success "Downloaded drivers"

_log "Install drivers"
sudo sh ./NVIDIA-$DRIVER_ARCH-$DRIVER_VERSION.run
_success "Installed drivers"

_log "Reboot"
_prompt "You need to reboot your computer, do it now (y/n) ?" APP_REBOOT
 if [ "$APP_REBOOT" == 1 ]; then
    _success "OK, will reboot in 5s"
    sleep 5
    sudo reboot
else
    _info "OK, I do not reboot now, remember to do it !"
fi