#!/bin/bash

# DOWNLOAD COMPOSE
_section "Download docker-compose file"
_download $APP_COMPOSE_URL
_success "OK, script downloaded at $APP_NAME/docker-compose.yml"

_section "Configure your application"
_break_line
_log "1. About Odoo: "
_prompt "Odoo Admin Password: " CUSTOM_ODOO_ADMIN_PASSWD CUSTOM_CONF_SUMMARY
_prompt "Odoo port: " CUSTOM_ODOO_PORT CUSTOM_CONF_SUMMARY

_break_line
_log "2. About Postgresql"
_prompt "DB user: " CUSTOM_ODOO_DB_USER CUSTOM_CONF_SUMMARY
_prompt "DB password: " CUSTOM_ODOO_DB_PASSWORD CUSTOM_CONF_SUMMARY
_prompt "DB port: " CUSTOM_DB_PORT CUSTOM_CONF_SUMMARY


_section "Confirm your inputs"
_log "Your settings:"
for index in ${!CUSTOM_CONF_SUMMARY[*]}
do
    _log1 "${CUSTOM_CONF_SUMMARY_NAMES[$index]}: ${!CUSTOM_CONF_SUMMARY_NAMES[$index]}"
done

_break_line
_prompt 'Are you sure (y/n) ? ' CUSTOM_CONFIG_CONFIRM NONE

if [ "$CUSTOM_CONFIG_CONFIRM" == "y" ]; then
    _section "Building configuration"
    _log "Will now update the docker-compose.yml"
    for index in ${!CUSTOM_CONF_SUMMARY[*]}
    do
         sed -i -e "s/${CUSTOM_CONF_SUMMARY_NAMES[$index]}/${!CUSTOM_CONF_SUMMARY_NAMES[$index]}/g" docker-compose.yml
    done
    _success "OK, configuration is done"

    _create_compose_scripts
    _shortcuts_summary


    _prompt 'Do you want me to start it now ?' CUSTOM_START_CONFIRM
    if [ "$CUSTOM_START_CONFIRM" == "y" ]; then
        _log "OK, starting it now. ** It will automatically restart it if you reboot your computer **"
        cd $APP_NAME
        ./up.sh
        _log1 "$APP_NAME Started"

        _log "You can check the logs with ./logs.sh"
    else
        _log "I will not start it for you, then."
    fi
else
   _error "OK, I cancel the installation. Remember to remove the files if not needed"
   _exit
fi