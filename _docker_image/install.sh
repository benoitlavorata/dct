#!/bin/bash

_section "Get Base DockerFile"
_download "https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/Dockerfile"
_success "Got docker file"


_section "Read Default config"
CUSTOM_IMAGE_NAME=""
CUSTOM_
CUSTOM_IMAGE_NAME
CUSTOM_IMAGE_INSTALL_SCRIPTS


_add_custom_config "IMAGE_SOURCE" "ubuntu:16.04"
_add_custom_config "IMAGE_NAME" "DOCKER_BOILERPLATE"
_add_custom_config "IMAGE_MAINTAINER" "BenoitLavorata"
_add_custom_config "IMAGE_INSTALL_SCRIPTS" "test"
_add_custom_config "IMAGE_EXPOSED_PORTS" "22"
_success "Got the defaults values"

_section "Configure your application"
_prompt_custom_config "Please answer the questions below, just press Enter if you want to keep the default value."
_success "Got all your inputs"

_section "Confirm your configuration"
_display_custom_config

_break_line
_prompt 'Are you sure (y/n) ? ' CUSTOM_CONFIG_CONFIRM

if [ "$CUSTOM_CONFIG_CONFIRM" == "y" ]; then
    _section "Building configuration"

    # GET IMAGE NAME
    _log "Get image name..."
    for index in ${!CUSTOM_CONFIG_NAMES[*]} 
    do
        if [ "${CUSTOM_CONFIG_NAMES[$index]}" == "IMAGE_NAME" ]; then
            CUSTOM_IMAGE_NAME="${CUSTOM_CONFIG_VALUES[$index]}"
        fi
    done

    _log "Will now create the Dockerfile for $CUSTOM_IMAGE_NAME"
    cp "Dockerfile" "$CUSTOM_IMAGE_NAME.Dockerfile"

    _log "Replace config into Dockerfile"
    for index in ${!CUSTOM_CONFIG_NAMES[*]} 
    do
       sed -i -e "s/CUSTOM_${CUSTOM_CONFIG_NAMES[$index]}/${CUSTOM_CONFIG_VALUES[$index]}/g" "$CUSTOM_IMAGE_NAME.Dockerfile"
    done
    _success "OK, configuration is done"

else
   _error "OK, I cancel the installation. Remember to remove the files if not needed"
   _exit
   _quit
fi

#    _create_compose_scripts
#    _shortcuts_summary
_section "Create shortcut scripts for building your image $CUSTOM_IMAGE_NAME"

_log "Create build.sh script"
echo -e "#!/bin/bash" > build.sh
echo -e "echo -e Will now build $CUSTOM_IMAGE_NAME ..." >> build.sh
echo -e "docker build -f $CUSTOM_IMAGE_NAME.Dockerfile -t $CUSTOM_IMAGE_NAME:latest ." >> build.sh
chmod +x build.sh

_log "Create run.sh script"
echo -e "#!/bin/bash" > run.sh
echo -e "echo -e Will now run $CUSTOM_IMAGE_NAME ..." >> run.sh
echo -e "docker run -it --rm --name=$CUSTOM_IMAGE_NAME $CUSTOM_IMAGE_NAME:latest" >> run.sh
chmod +x run.sh


_section "Rename folder"
cd .. 
mv "$APP_NAME" "$CUSTOM_IMAGE_NAME"
_success "Rename folder"