#!/bin/bash
cd /entrypoint
source "helpers.sh"

_section "Create or clean log file"
echo " " > ~/runtime.log

_section "Execute all apps"
for filename in apps/*.sh; do
    file=$(basename "$filename" .sh)
    _log "Booting ${file}"
    cd apps
    _source "${file}" "$file.sh"
done

cd /
tail -f ~/runtime.log