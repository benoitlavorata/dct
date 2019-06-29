#!/bin/bash
git submodule add https://gitlab.com/benoit.lavorata/$1.service.git
./push.sh "Added submodule $1.service"