#!/bin/bash

#MAKE SURE TO DEFINE VARIABLES
SERVICE_NAME="pos_monitor"
SERVICE_USER="plspos"
NODE_SCRIPT_FOLDER="/home/plspos/Documents/pos_monitor/"
NODE_BOOT_COMMAND="node index.js"



### HELPERS V1
# DEFINE LOG FUNCTION
DATE='date +%Y/%m/%d-%H:%M:%S'

function _intro {
    echo " "
    echo "================================"
    echo "SBG > ODOO UBUNTU $1"
    echo "--------------------------------"
    echo "Benoit Lavorata, December 2017"
    echo "================================"
    echo " "
}

function _info {
    echo `$DATE`"| $1"
}

function _error {
    echo `$DATE`"| [ERROR] $1"
    echo " "
}

function _success {
    echo `$DATE`"| [SUCCESS] $1"
    echo " "
}

function _section {
    echo " "
    echo `$DATE`"| --- $1 ---"
#    echo "-------------------|"
}
function _quit_if_not_root {
    echo " "
    #CHECK THAT WE ARE ROOT
    _info "Log in as root"
    if [[ $EUID -ne 0 ]]; then
        _error $1
        exit 1
    fi
    _success "Log in as root"
}
#### END OF HELPERS

_intro "Install a nodejs script as a startup service"
_quit_if_not_root "You cannot start this script without being root"

#VARIABLES
_section "Defined variables"

SERVICE_FOLDER="/etc/systemd/system/"
SERVICE_USERGROUP="$SERVICE_USER"
SERVICE_STARTUP_SCRIPT="startup.sh"
SERVICE_SCRIPT="$SERVICE_NAME.service"
SERVICE_DISABLE_SCRIPT="disable-service.sh"
SERVICE_ENABLE_SCRIPT="enable-service.sh"
SERVICE_RESTART_SCRIPT="restart-service.sh"
SERVICE_STOP_SCRIPT="stop-service.sh"
SERVICE_STATUS_SCRIPT="status-service.sh"
SERVICE_REMOVE_SCRIPT="remove-service.sh"

_section "Create service startup script = node boot"
cd $NODE_SCRIPT_FOLDER
touch $SERVICE_STARTUP_SCRIPT
echo "#!/bin/bash" > $SERVICE_STARTUP_SCRIPT
echo "echo Will now execute $NODE_BOOT_COMMAND ..." >> $SERVICE_STARTUP_SCRIPT
echo "cd $NODE_SCRIPT_FOLDER" >> $SERVICE_STARTUP_SCRIPT
echo "$NODE_BOOT_COMMAND" >> $SERVICE_STARTUP_SCRIPT
chmod +x $SERVICE_STARTUP_SCRIPT
_success "Create service startup script = node boot"

_section "Create startup script"
touch $SERVICE_SCRIPT
echo "[Unit]" > $SERVICE_SCRIPT
echo " " >> $SERVICE_SCRIPT
echo "After=network.target" >> $SERVICE_SCRIPT
echo " " >> $SERVICE_SCRIPT
echo "[Service]" >> $SERVICE_SCRIPT
echo "User=$SERVICE_USER" >> $SERVICE_SCRIPT
echo "Group=$SERVICE_USERGROUP" >> $SERVICE_SCRIPT
echo "ExecStart=$NODE_SCRIPT_FOLDER/$SERVICE_STARTUP_SCRIPT" >> $SERVICE_SCRIPT
echo " " >> $SERVICE_SCRIPT
echo "[Install]" >> $SERVICE_SCRIPT
echo "WantedBy=default.target" >> $SERVICE_SCRIPT
_success "Created startup script at $SERVICE_SCRIPT"


_section "Copy service script to $SERVICE_FOLDER/$SERVICE_SCRIPT and activate"
sudo cp $SERVICE_SCRIPT $SERVICE_FOLDER/$SERVICE_SCRIPT
sudo chmod 664 $SERVICE_FOLDER/$SERVICE_SCRIPT
sudo rm $SERVICE_SCRIPT
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_SCRIPT
_success "Activated service"


_section "Create quick service scripts"
echo "#!/bin/bash" > $SERVICE_DISABLE_SCRIPT
echo "echo Will now disable: $SERVICE_NAME ..." >> $SERVICE_DISABLE_SCRIPT
echo "sudo systemctl disable $SERVICE_SCRIPT" >> $SERVICE_DISABLE_SCRIPT
chmod +x $SERVICE_DISABLE_SCRIPT
echo "#!/bin/bash" > $SERVICE_ENABLE_SCRIPT
echo "echo Will now enable: $SERVICE_NAME ..." >> $SERVICE_ENABLE_SCRIPT
echo "sudo systemctl enable $SERVICE_SCRIPT" >> $SERVICE_ENABLE_SCRIPT
chmod +x $SERVICE_ENABLE_SCRIPT
echo "#!/bin/bash" > $SERVICE_RESTART_SCRIPT
echo "echo Will now restart: $SERVICE_NAME ..." >> $SERVICE_RESTART_SCRIPT
echo "sudo systemctl restart $SERVICE_SCRIPT" >> $SERVICE_RESTART_SCRIPT
chmod +x $SERVICE_RESTART_SCRIPT
echo "#!/bin/bash" > $SERVICE_STOP_SCRIPT
echo "echo Will now stop: $SERVICE_NAME ..." >> $SERVICE_STOP_SCRIPT
echo "sudo systemctl stop $SERVICE_SCRIPT" >> $SERVICE_STOP_SCRIPT
chmod +x $SERVICE_STOP_SCRIPT
echo "#!/bin/bash" > $SERVICE_STATUS_SCRIPT
echo "echo Will now check status: $SERVICE_NAME ..." >> $SERVICE_STATUS_SCRIPT
echo "sudo systemctl status $SERVICE_SCRIPT" >> $SERVICE_STATUS_SCRIPT
chmod +x $SERVICE_STATUS_SCRIPT

echo "#!/bin/bash" > $SERVICE_REMOVE_SCRIPT
echo "echo Will now remove these bash scripts for $SERVICE_NAME ..." >> $SERVICE_REMOVE_SCRIPT
echo "cd $NODE_SCRIPT_FOLDER" >> $SERVICE_REMOVE_SCRIPT
echo "sudo systemctl stop $SERVICE_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "sudo systemctl disable $SERVICE_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "sudo rm $SERVICE_FOLDER/$SERVICE_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "sudo systemctl daemon-reload" >> $SERVICE_REMOVE_SCRIPT
echo "sudo rm $SERVICE_STATUS_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "sudo rm $SERVICE_STOP_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "sudo rm $SERVICE_RESTART_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "sudo rm $SERVICE_ENABLE_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "sudo rm $SERVICE_DISABLE_SCRIPT" >> $SERVICE_REMOVE_SCRIPT
echo "OK all done, only need to remove $NODE_SCRIPT_FOLDER/$SERVICE_REMOVE_SCRIPT and you are done !" >> $SERVICE_REMOVE_SCRIPT
chmod +x $SERVICE_REMOVE_SCRIPT
_success "Create quick scripts"

_section "Change permissions"
sudo chown $SERVICE_USER:$SERVICE_USERGROUP *.sh
_success "Changed permissions"

_section "Thank you for using this script !"
_info "You can now use these commands:"
_info " "
_info "Stop the service:    ./$SERVICE_STOP_SCRIPT.sh"
_info "Restart the service:    ./$SERVICE_RESTART_SCRIPT.sh"
_info "Check the status of the service:    ./$SERVICE_STATUS_SCRIPT.sh"
_info "Disable the service:    ./$SERVICE_DISABLE_SCRIPT.sh"
_info "Enable the service:    ./$SERVICE_ENABLE_SCRIPT.sh"
_info "Clean/Remove the service and these bash scripts:    ./$SERVICE_REMOVE_SCRIPT.sh"
_info " "
_success "Cheers, Benoit Lavorata (2018)."