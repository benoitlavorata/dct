#!/bin/bash

_section "Boot SSH"
SSH_ENABLED="NO"
SSH_LOGIN="root"
SSH_PASS="1234"

_log "Set login/password = ${SSH_LOGIN}:${SSH_PASS}"
echo "${SSH_LOGIN}:${SSH_PASS}" | chpasswd

_log "Set config"
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

_log "Start service..."
if [ "${SSH_ENABLED}" = "YES" ]; then
    _info "Starting SSH"
    set -e
    /usr/sbin/sshd -D 2>&1 >> ~/runtime.log
else
    _info "SSH not enabled, skip"
fi