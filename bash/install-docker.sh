#!/bin/bash

### HELPERS V1
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
#### END OF HELPERS

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

