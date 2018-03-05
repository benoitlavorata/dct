#!/bin/bash
#
# DEFINE SOME HELPERS FUNCTIONS TO MAKE OUR SCRIPT PRETTY
#
# DEFINE LOG FUNCTION
DATE='date +%Y/%m/%d-%H:%M:%S'

function _intro {
    echo " "
    echo "================================"
    echo "SBG COMPOSE APPS > $1"
    echo "--------------------------------"
    echo "Benoit Lavorata, 2018"
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
}
function _quit_if_not_root {
    echo " "
    #CHECK THAT WE ARE ROOT
    _info "Log in as root"
    if [[ $EUID -ne 0 ]]; then
        _error "You must be root user (try sudo)"
        exit 1
    fi
    _success "Log in as root"
}
function _url_exists {
     echo " "
}

#
# WHERE IT ALL HAPPENS
#

#Title
_intro "Get app $1"

#Check if url exists
URL="https://raw.githubusercontent.com/sbglive/compose/master/$1/docker-compose.yml"
_info "Check if app exists on repository: $1"
if curl --output /dev/null --silent --head --fail "$URL"; then
    _success "OK, the app exists"
else
    _fail "The app $1 does not exist on the repository (did you spell it properly ?)"
    exit 1
fi

#Create folder
_info "Create folder: $1"
mkdir $1
cd $1
_success "OK, folder $1 created"

#Download script
_info "Download script: $URL"
wget -O - $URL
_success "OK, script downloaded at $1/docker-compose.yml"

_section "Thank you for using the composeapps script ! See you soon"
