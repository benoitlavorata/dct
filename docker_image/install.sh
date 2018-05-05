#!/bin/bash

#VARIABLES
CUSTOM_GIT_FOLDER="compose"
CUSTOM_GIT_ACCOUNT="sbglive"
CUSTOM_GIT_URL="https://github.com/$CUSTOM_GIT_ACCOUNT/$CUSTOM_GIT_FOLDER.git"
CUSTOM_KEEP_GIT_FOLDER="docker_image"

_section "Clone $CUSTOM_GIT_URL"
git clone https://github.com/$CUSTOM_GIT_ACCOUNT/$CUSTOM_GIT_FOLDER.git
eval "mv $CUSTOM_GIT_FOLDER/$CUSTOM_KEEP_GIT_FOLDER/container_scripts/ ."
eval "mv $CUSTOM_GIT_FOLDER/$CUSTOM_KEEP_GIT_FOLDER/Dockerfile ."
eval "sudo rm -r $CUSTOM_GIT_FOLDER/"
_success "Cloned repository"

_section "Read Default config"
CUSTOM_IMAGE_NAME="DOCKER_BOILERPLATE"
_add_custom_config "IMAGE_NAME" "$CUSTOM_IMAGE_NAME"
#_add_custom_config "IMAGE_INSTALL_SCRIPTS" "NONE"
#_add_custom_config "MIRRORS_LOCATION" "CHINA"
#_add_custom_config "MIRRORS_APT_CHINA" "DEFAULT"
#_add_custom_config "UBUNTU_ADDITIONAL_DEP" "NONE"
#_add_custom_config "APT_UPGRADE" "YES"
#_add_custom_config "SSH_ENABLED" "YES"
#_add_custom_config "SSH_LOGIN" "root"
#_add_custom_config "SSH_PASS" "1234"
_add_custom_config "EXPOSED_PORTS" "22"
_success "Got the defaults values"

_section "Configure your application"
_prompt_custom_config "Please answer the questions below, just press Enter if you want to keep the default value"
_success "Got all your inputs"

_section "Confirm your config"
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
       
        if [ "${CUSTOM_CONFIG_NAMES[$index]}" == "IMAGE_NAME" ]; then
            CUSTOM_IMAGE_NAME="${CUSTOM_CONFIG_VALUES[$index]}"
        fi
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
echo -e "docker build -f $CUSTOM_IMAGE_NAME.Dockerfile -t $CUSTOM_IMAGE_NAME ." >> build.sh
chmod +x build.sh

_log "Create run.sh script"
echo -e "#!/bin/bash" > run.sh
echo -e "echo -e Will now run $CUSTOM_IMAGE_NAME ..." >> run.sh
echo -e "docker run -it --rm --name=$CUSTOM_IMAGE_NAME $CUSTOM_IMAGE_NAME" >> run.sh
chmod +x run.sh