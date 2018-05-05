#!/bin/bash

#INCLUDE HELPERS AND PRINT SECTION TITLE
source "${DOCKER_INSTALL_DIR}/helpers.sh"
_section "Tools: additional packages which are useful !"


# LOCAL VARIABLES
_TOOLS_DONE="NO"
_TOOLS_BASIC="unzip vim nano"

# LOCALES CONFIGURATION GOES HERE
_info "Configure tools"
_log1 "Install packages:"
_log2 "Basic: $_TOOLS_BASIC"
_log2 "Additional: $UBUNTU_ADDITIONAL_DEP"
apt-get install -y -qq $_TOOLS_BASIC $UBUNTU_ADDITIONAL_DEP > /dev/null

_TOOLS_DONE="YES"
_success "Tools: ok, packages have been installed"