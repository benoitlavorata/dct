#!/bin/bash
source "${DOCKER_INSTALL_DIR}/helpers.sh"

# START SCRIPT INSTALL
_intro "${DOCKER_IMAGE_NAME}"
_section "SCRIPT BOOTED"
_info "This script will set up the environment"
_quit_if_not_root "You cannot start this script without being root"


# UBUNTU CONFIG
.${DOCKER_INSTALL_DIR}/install-001-mirrors.sh
.${DOCKER_INSTALL_DIR}/install-002-locales.sh
.${DOCKER_INSTALL_DIR}/install-003-tools.sh
.${DOCKER_INSTALL_DIR}/install-004-ssh.sh

# SET UP ENTRY POINT
.${DOCKER_INSTALL_DIR}/install-100-entrypoint.sh

_section "FINISHED INSTALLATION"