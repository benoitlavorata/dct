#!/bin/bash

_section "APT Upgrade"

_log "Execute upgrade (be patient)"
 apt-get upgrade -y -qq > /dev/null

_success "Upgraded APT"