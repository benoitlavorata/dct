#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="dockprom"
CUSTOM_GIT_URL="https://github.com/sbglive/$CUSTOM_GIT_FOLDER.git"

_section "Clone $CUSTOM_GIT_URL"
git clone https://github.com/sbglive/dockprom.git
_success "Cloned repository"


_section "Build start scripts"
# ADMIN_USER=admin ADMIN_PASSWORD=admin docker-compose up -d

