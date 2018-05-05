#!/bin/bash

_section "AION BASE NEEDS"

_log "Install deps"
apt-get install -y -qq bzip2 curl jq wget vim > /dev/null


_success "Installed AION BASE"