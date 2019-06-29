#!/bin/bash

#INCLUDE HELPERS AND PRINT SECTION TITLE
source "${INSTALL_DIR}/helpers.sh"
_section "Entrypoint config"


# LOCAL VARIABLES
_ENTRYPOINT_DONE="NO"
_ENTRYPOINT_SRC_PATH="${INSTALL_DIR}/resources/entrypoint"

_info "Will setup boot files on the vm"

_log1 "move entrypoint folder to root: mv ${_ENTRYPOINT_SRC_PATH} ${DOCKER_ENTRYPOINT_DIR}"
mv ${_ENTRYPOINT_SRC_PATH} ${DOCKER_ENTRYPOINT_DIR}

_log1 "copy helpers to entrypoint folder: cp ${INSTALL_DIR}/helpers.sh ${DOCKER_ENTRYPOINT_DIR}/helpers.sh"
cp ${INSTALL_DIR}/helpers.sh ${DOCKER_ENTRYPOINT_DIR}/helpers.sh

_log1 "make executable: chmod +x ${DOCKER_ENTRYPOINT_DIR}/*.sh"
chmod +x ${DOCKER_ENTRYPOINT_DIR}/*.sh

_log1 "move entrypoint at root: mv ${DOCKER_ENTRYPOINT_DIR}/entrypoint.sh /entrypoint.sh"
mv ${DOCKER_ENTRYPOINT_DIR}/entrypoint.sh /entrypoint.sh

_log1 "set additional ENV variables"
export DOCKER_ENTRYPOINT_DIR=${DOCKER_ENTRYPOINT_DIR}
export DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME}

_ENTRYPOINT_DONE="YES"
_success "Entrypoint config"