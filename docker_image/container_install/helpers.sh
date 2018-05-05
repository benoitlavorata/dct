#!/bin/bash
# DEFINE LOG FUNCTION
DATE='date +%Y/%m/%d-%H:%M:%S'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function _intro {
    echo " "
    echo "================================"
    echo "SBG > ODOO UBUNTU $1"
    echo "--------------------------------"
    echo "Benoit Lavorata, December 2017"
    echo "================================"
    echo " "
}

function _info {
    echo `$DATE`"| $1"
}

function _log1 {
    echo `$DATE`"| ... $1"
}

function _log2 {
    echo `$DATE`"| ...... $1"
}

function _skip {
    echo `$DATE`"|     [SKIP] $1"
}

function _error {
    printf ${RED}`$DATE`"|     [ERROR] $1 ${NC}"
    #echo `$DATE`"|     [ERROR] $1"
    echo " "
}

function _success {
    printf ${GREEN}`$DATE`"|     [SUCCESS] $1 ${NC}"
    #echo `$DATE`"|     [SUCCESS] $1"
    echo " "
}

function _section {
    echo " "
    echo `$DATE`"| --- $1 ---"
#    echo "-------------------|"
}
function _quit_if_not_root {
    echo " "
    #CHECK THAT WE ARE ROOT
    _info "Log in as root"
    if [[ $EUID -ne 0 ]]; then
        _error $1
        exit 1
    fi
    _success "Log in as root"
}

