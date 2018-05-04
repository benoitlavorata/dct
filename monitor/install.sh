#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="dockprom"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
git clone https://github.com/sbglive/dockprom.git .
_success "Cloned repository"

_section "Configure your application"
_log "Please answer the questions below"
read -p "Admin login: " CUSTOM_ADMIN_USER
read -p "Admin password: " CUSTOM_ADMIN_PASSWORD

_section "Confirm your inputs"
_log "Admin login: $CUSTOM_ADMIN_USER"
_log "Admin password: $CUSTOM_ADMIN_PASSWORD"
echo ""
read -p 'Are you sure ? (y/n)' CUSTOM_CONFIG_CONFIRM

_section "Building configuration"
_log "Will now update the docker-compose.yml"
sed -i -e "s/ADMIN_USER/$CUSTOM_ADMIN_USER/g" docker-compose.yml
sed -i -e "s/ADMIN_PASSWORD/$CUSTOM_ADMIN_PASSWORD/g" docker-compose.yml
_success "OK, configuration is done"

_create_compose_scripts
_shortcuts_summary