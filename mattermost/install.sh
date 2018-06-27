#!/bin/bash
#"default-runtime": "nvidia"

_section "Download docker-compose file"
_download $APP_COMPOSE_URL
_success "OK, script downloaded at $APP_NAME/docker-compose.yml"

#VARIABLES
_section "Read Default config"
_add_custom_config "PORT" "8065"
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

    _log "Replace config into docker-compose.yml"
    for index in ${!CUSTOM_CONFIG_NAMES[*]} 
    do
       sed -i -e "s/CUSTOM_${CUSTOM_CONFIG_NAMES[$index]}/${CUSTOM_CONFIG_VALUES[$index]}/g" "docker-compose.yml"
    done

    _success "OK, configuration is done"
    _create_compose_scripts
    _shortcuts_summary

    _break_line
    _prompt 'Do you want me to start it now (y/n) ?' CUSTOM_START_CONFIRM
    _break_line
    
    if [ "$CUSTOM_START_CONFIRM" == "y" ]; then
        _log "OK, starting it now. ** It will automatically restart it if you reboot your computer **"
        
        ./up.sh
        _log1 "$APP_NAME Started"

        cd ..
    else
        _log "I will not start it for you, then."
    fi
else
   _error "OK, I cancel the installation. Remember to remove the files if not needed"
   _exit
   _quit
fi