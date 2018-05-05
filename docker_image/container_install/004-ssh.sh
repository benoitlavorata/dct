#!/bin/bash

#INCLUDE HELPERS AND PRINT SECTION TITLE
source "${DOCKER_INSTALL_DIR}/helpers.sh"
_section "SSH enabled: $SSH_ENABLED"


# LOCAL VARIABLES
_SSH_DONE="NO"

if [ "${SSH_ENABLED}" = "YES" ]; then
    _info "Install SSH"
    
    _log1 "Install openssh-server"
    apt-get install -y -qq openssh-server > /dev/null

    _log1 "configure openssh-server, access with ${SSH_LOGIN}:${SSH_PASS}"
    mkdir /var/run/sshd
    echo "${SSH_LOGIN}:${SSH_PASS}" | chpasswd
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

    _SSH_DONE="YES"
    _success "SSH: ok, I installed SSH"
else
    _skip "Install SSH"
fi