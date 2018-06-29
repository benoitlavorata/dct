#!/bin/bash
#"default-runtime": "nvidia"

_section "Download docker-compose file"
_download $APP_COMPOSE_URL
_success "OK, script downloaded at $APP_NAME/docker-compose.yml"

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