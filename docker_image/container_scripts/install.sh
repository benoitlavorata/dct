#!/bin/bash
source "${IMAGE_INSTALL_DIR}/helpers.sh"

# START SCRIPT
_intro "${IMAGE_NAME}" "Docker container"

_section "Check access rights"
_quit_if_not_root "You cannot start this script without being root"


_section "Create entrypoint file and folder"
_log "Create folder ${ENTRYPOINT_FOLDER}"
mkdir ${ENTRYPOINT_FOLDER}
mkdir ${ENTRYPOINT_FOLDER}/apps
_log "Copy entrypoint files"
cp "${IMAGE_INSTALL_DIR}/boot.sh" "${ENTRYPOINT_FOLDER}"
cp "${IMAGE_INSTALL_DIR}/helpers.sh" "${ENTRYPOINT_FOLDER}"


_section "Will install custom apps"
IFS=', ' read -r -a SCRIPTS_ARRAY <<< "${IMAGE_INSTALL_SCRIPTS}"
_log "To install: ${SCRIPTS_ARRAY[*]}"

for index in ${!SCRIPTS_ARRAY[*]}
do
    APP_NAME=${SCRIPTS_ARRAY[$index]}
    APP_FOLDER="${IMAGE_INSTALL_DIR}/${APP_NAME}"
    APP_FILE="${APP_FOLDER}/install.sh"

    _section "Install: ${APP_NAME} from ${APP_FOLDER}"

    _log "Check if folder exists"
    _file_exists APP_HAS_FILE ${APP_FILE}
    if [ "$APP_HAS_FILE" == 1 ]; then
        _success "The file $APP_FILE exists."
    else
       _error "The file ${APP_FILE} does not exist, quit the install"
       _exit
       _quit
    fi

    _log "Start install script"
    cd ${APP_FOLDER}
    _source "$APP_NAME" "$APP_FILE" 
done

_section "Make all boot files executable"
chmod +x ${ENTRYPOINT_FOLDER}/*.sh
chmod +x ${ENTRYPOINT_FOLDER}/apps/*.sh

_success "All has been installed !"
_exit