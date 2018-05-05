#!/bin/bash
echo $DOCKER_ENTRYPOINT_DIR

echo "${DOCKER_ENTRYPOINT_DIR}/helpers.sh"
source "${DOCKER_ENTRYPOINT_DIR}/helpers.sh"

_intro "${DOCKER_IMAGE_NAME}"
_section "DOCKER CONTAINER BOOTED"
_info "This script will start the environment"
_quit_if_not_root "You cannot start this script without being root"

#_section "Start openssh"

if [ "${SSH_ENABLED}" = "YES" ]; then
    echo "start ssh"
    set -e
    /usr/sbin/sshd -D
else
    echo "do not start ssh"
fi