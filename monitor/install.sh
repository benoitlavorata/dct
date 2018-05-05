#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="dockprom"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
git clone https://github.com/sbglive/dockprom.git
eval "mv $CUSTOM_GIT_FOLDER/* ."
_success "Cloned repository"

_section "Configure your application"
_log "Please answer the questions below"
_prompt "Admin login: " ADMIN_USER CUSTOM_CONF_SUMMARY
_prompt "Admin password: " ADMIN_PASSWORD CUSTOM_CONF_SUMMARY

_section "Confirm your inputs"
_log "Your settings:"
for index in ${!CUSTOM_CONF_SUMMARY[*]}
do
    _log1 "${CUSTOM_CONF_SUMMARY_NAMES[$index]}: ${!CUSTOM_CONF_SUMMARY_NAMES[$index]}"
done

_break_line
_prompt 'Are you sure (y/n) ? ' CUSTOM_CONFIG_CONFIRM NONE

if [ "$CUSTOM_CONFIG_CONFIRM" == "y" ]; then
    _section "Building configuration"
    _log "Will now update the docker-compose.yml"
    for index in ${!CUSTOM_CONF_SUMMARY[*]}
    do
         sed -i -e "s/${CUSTOM_CONF_SUMMARY_NAMES[$index]}/${!CUSTOM_CONF_SUMMARY_NAMES[$index]}/g" docker-compose.yml
    done
    _success "OK, configuration is done"

    _create_compose_scripts
    _shortcuts_summary
else
   _error "OK, I cancel the installation. Remember to remove the files if not needed"
   _exit
fi