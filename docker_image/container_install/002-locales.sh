#!/bin/bash

#INCLUDE HELPERS AND PRINT SECTION TITLE
source "${DOCKER_INSTALL_DIR}/helpers.sh"
_section "Locales: TO RE-CHECK"


# LOCAL VARIABLES
_LOCALES_DONE="NO"


# LOCALES CONFIGURATION GOES HERE
_info "Configure locales"
_log1 "Install package"
apt-get install -y -qq locales > /dev/null

_log1 "Remove old apt list"
rm -rf /var/lib/apt/lists/*

_log1 "Set locale"
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
export LANG="en_US.utf8"
#locale

_log1 "Update apt list"
apt-get update -y -qq > /dev/null

_LOCALES_DONE="YES"

_success "Locales: ok, locales are configured"