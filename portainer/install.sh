#!/bin/bash
#"default-runtime": "nvidia"

_section "Download docker-compose file"
_download $APP_COMPOSE_URL
_success "OK, script downloaded at $APP_NAME/docker-compose.yml"

#VARIABLES
_section "Read Default config (default login/pass is: admin // password"
CUSTOM_ADMIN_PASSWORD_CLEAR='password'
CUSTOM_ADMIN_PASSWORD_CRYPT='$$2y$$05$$tv5/3s.O.w0UW08zU6CpO.U.Z9xlchoOetGO91N4z9ZoZjwY/4VOi'
#_add_custom_config "" "$CUSTOM_ADMIN_PASSWORD_CLEAR"
_add_custom_config "PORT" "9000"
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

    sed -i -e "s/CUSTOM_ADMIN_PASSWORD_CRYPT/$CUSTOM_ADMIN_PASSWORD_CRYPT/g" "docker-compose.yml"
    

    _success "OK, configuration is done"
    _create_compose_scripts
    _shortcuts_summary
else
   _error "OK, I cancel the installation. Remember to remove the files if not needed"
   _exit
   _quit
fi