#!/bin/bash
_log "Set nvidia-xconfig"
_log1 "You may need to modify your /etc/X11/xorg.conf after"
sudo nvidia-xconfig ---enable-all-gpus --separate-x-screens --cool-bits=28 --allow-empty-initial-configuration

# sudo vim /etc/X11/xorg.conf
_log "Set make xorg.conf non editable"
sudo chmod 444 /etc/X11/xorg.conf && sudo chattr +i /etc/X11/xorg.conf

_log "Get OC scripts for quick use"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/default-oc.sh"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/high-oc.sh"

chmod +x *.sh
mv default-oc.sh ~/
mv high-oc.sh ~/

_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"