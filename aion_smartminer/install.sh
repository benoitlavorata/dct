#!/bin/bash
#"default-runtime": "nvidia"

#VARIABLES
CUSTOM_GIT_FOLDER="dockprom"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
git clone https://github.com/sbglive/dockprom.git
eval "mv $CUSTOM_GIT_FOLDER/* ."
_success "Cloned repository"


_section "Read Default config"
_add_custom_config "ADMIN_USER" "admin"
_add_custom_config "ADMIN_PASSWORD" "1234"
_success "Got the defaults values"

_section "Configure your application"
_prompt_custom_config "Please answer the questions below, just press Enter if you want to keep the default value"
_success "Got all your inputs"

_section "Confirm your config"
_display_custom_config

_break_line
_prompt 'Are you sure (y/n) ? ' CUSTOM_CONFIG_CONFIRM

if [ "$CUSTOM_CONFIG_CONFIRM" == "y" ]; then
    _section "Building configuration"

    _log "Replace config into docker-compose.yml"
    for index in ${!CUSTOM_CONFIG_NAMES[*]} 
    do
       sed -i -e "s/CUSTOM_${CUSTOM_CONFIG_NAMES[$index]}/${CUSTOM_CONFIG_VALUES[$index]}/g" "docker-compose.yml"
    done
    _success "OK, configuration is done"
    _create_compose_scripts
    _shortcuts_summary
else
   _error "OK, I cancel the installation. Remember to remove the files if not needed"
   _exit
   _quit
fi