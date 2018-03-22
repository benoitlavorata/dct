#!/bin/bash

#################################################################
### HELPERS V2 ### THE MAGIC PART IS AFTER THE END OF HELPERS ###
#################################################################
# COPY PASTE AT FRONT OF BASH SCRIPTS, KEEP THEM DEPENCY FREE

# DEFINE LOG FUNCTION
__DATE='date +%Y/%m/%d %H:%M:%S'
__YEAR=`date +%Y`

function _intro {
    echo " "
    echo "================================"
    echo "SBG > BASH SCRIPT: $1"
    echo "--------------------------------"
    echo "Benoit Lavorata, $__YEAR"
    echo "================================"
    echo " "
}

function _info {
    echo `$__DATE`"| $1"
}

function _error {
    echo `$__DATE`"| [ERROR] $1"
    echo " "
}

function _success {
    echo `$__DATE`"| [SUCCESS] $1"
    echo " "
}

function _section {
    echo " "
    echo `$__DATE`"| --- $1 ---"
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
#################################################################
### END OF HELPERS ### THE MAGIC PART GOES BELOW (HOPEFULLY)  ###
#################################################################


_intro "Install docker on ubuntu"
_quit_if_not_root "You cannot start this script without being root"

# Install docker on ubuntu
_section "Uninstall old versions"
sudo apt-get remove -y docker docker-engine docker.io
_success "Uninstall old versions"

_section "Install using the repository"
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce
_success "INSTALLED"

