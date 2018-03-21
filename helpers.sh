#!/bin/bash
# DEFINE LOG FUNCTION
DATE='date +%Y/%m/%d-%H:%M:%S'

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

function _error {
    echo `$DATE`"| [ERROR] $1"
    echo " "
}

function _success {
    echo `$DATE`"| [SUCCESS] $1"
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
