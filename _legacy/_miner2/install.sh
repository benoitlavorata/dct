#!/bin/bash
_log "Check the running driver: should not show nouveau if everything is ok"
lsmod | grep video

_log1 "The command below should show nvidia... if everything is ok"
lsmod | grep nvidia

_log1 "The command below should show nothing if everything ok"
lsmod | grep nouveau

#_log "Disable Nouveau driver"
#lsmod | grep nouveau
#/etc/modprobe.d/nvidia-installer-disable-nouveau.conf

_log "Continue install !"
app _nvidia_docker

_section "Add default runtime as nvidia for docker"
#sudo su
#cp "/etc/docker/daemon.json" "/etc/docker/daemon.json.backup"
#sed -i '$ d' "/etc/docker/daemon.json"
#sed -i '${s/$/,/}' /etc/docker/daemon.json
#echo '"default-runtime": "nvidia"' >> "/etc/docker/daemon.json"
#echo '}' >> "/etc/docker/daemon.json"
#exit
#sudo service docker restart
cat "/etc/docker/daemon.json"
_success "nvidia as default runtime"

_log "Install the miner !"
cd ~/
app aion_smartminer

_log "Install the miner monitor!"
cd ~/
app _miner_monitor

_log "Install portainer!"
cd ~/
app portainer


cd "$SCRIPT_WORKING_DIR_PATH/_miner2"
_section "Remove $APP_NAME files"
cd .. 
rm -r $APP_NAME
_success "Removed files"