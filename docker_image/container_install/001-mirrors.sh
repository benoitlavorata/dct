#!/bin/bash

#INCLUDE HELPERS AND PRINT SECTION TITLE
source "${DOCKER_INSTALL_DIR}/helpers.sh"
_section "APT Mirrors: MIRRORS_ENABLED=$MIRRORS_ENABLED, MIRRORS_LOCATION=$MIRRORS_LOCATION"


# LOCAL VARIABLES
_MIRRORS_DONE="NO"
_MIRRORS_SRC_PATH="${DOCKER_INSTALL_DIR}/resources/mirrors"


# MIRRORS CONFIGURATION GOES HERE
## CHINESE MIRRORS
if [ "$MIRRORS_ENABLED" = "YES" ] && [ "$MIRRORS_LOCATION" = "CHINA" ]; then 

    _info "Will set mirrors to location $MIRRORS_LOCATION"

    _log1 "backup original sources.list"
    mv /etc/apt/sources.list /etc/apt/sources.list.backup

    _log1 "copy ${_MIRRORS_SRC_PATH}/CHINA/${MIRRORS_APT_CHINA}-sources.list to /etc/apt/sources.list"
    mv ${_MIRRORS_SRC_PATH}/CHINA/${MIRRORS_APT_CHINA}-sources.list /etc/apt/sources.list
    
    _MIRRORS_DONE="YES"
fi


# PRINT RESULTS
## SOMETHING WENT WRONG
if [ "$MIRRORS_ENABLED" = "YES" ] && [ "$_MIRRORS_DONE" = "NO" ]; then 
    _error "APT Mirrors: something went wrong, could not set the mirrors properly"
    exit 1
fi

## ALL GOOD
if [ "$MIRRORS_ENABLED" = "YES" ] && [ "$_MIRRORS_DONE" = "YES" ]; then 

    _log1 "Update APT Repository"
    apt-get update -y -qq > /dev/null

    _success "APT Mirrors: ok, mirrors are configured"
fi

## SKIP
if [ "$MIRRORS_ENABLED" = "NO" ]; then 
    _skip "APT Mirrors"
fi

## CHECK IF NEED UPGRADE DISTRO
_info "Upgrade distribution"
if [ "$APT_UPGRADE" = "YES" ]; then 
    apt-get upgrade -y -qq > /dev/null
    _success "Upgrade distribution: done"
else
    _skip "Upgrade distribution"
fi