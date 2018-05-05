#!/bin/bash

_section "APT Update"

_log "Execute update (be patient)"
 apt-get update
 # -qq > /dev/null

_success "Updated APT"