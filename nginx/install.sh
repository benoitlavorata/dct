#!/bin/bash

_section "Clone repo"
git clone https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion.git
_success "Clone repo"

cd docker-compose-letsencrypt-nginx-proxy-companion
cp .env.sample .env

_section "Rest of installation is manual:"
_log "1. Edit the file .env to your needs"
_log "2. Start the app with : ./start.sh"

_success "OK, all done."
_exit
_quit