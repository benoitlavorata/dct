#!/bin/bash

#################################################################
### HELPERS V2 ### THE MAGIC PART IS AFTER THE END OF HELPERS ###
#################################################################
# COPY PASTE AT FRONT OF BASH SCRIPTS, KEEP THEM DEPENCY FREE

# DEFINE LOG FUNCTION
__DATE='date +%Y%m%d-%H%M%S'
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




#Title
if [ -z ${1+x} ]; 
then 
    _error "You did not set any app name in argument. Try again."
    exit 0
else 
    _intro "Get app $1"
fi

#Check if url exists
URL="https://raw.githubusercontent.com/sbglive/compose/master/$1/docker-compose.yml"
_info "Check if app exists on repository: $1"
if curl --output /dev/null --silent --head --fail "$URL"; then
    _success "OK, the app exists"
else
    _error "The app $1 does not exist on the repository (did you spell it properly ?)"
    exit 1
fi

#Create folder
_info "Create folder: $1"
mkdir $1
cd $1
_success "OK, folder $1 created"

#Download script
_info "Download script: $URL"
wget $URL
_success "OK, script downloaded at $1/docker-compose.yml"


#Create up, down scripts
_info "Create up.sh, down.sh scripts in $1"

echo "#!/bin/bash" > up.sh
echo "echo Will now start: $1 ..." >> up.sh
echo "docker-compose up -d" >> up.sh
chmod +x up.sh

echo "#!/bin/bash" > down.sh
echo "echo Will now stop: $1 ..." >> down.sh
echo "docker-compose down" >> down.sh
chmod +x down.sh

echo "#!/bin/bash" > logs.sh
echo "echo Will now tail logs of $1 ..." >> logs.sh
echo "docker-compose logs -f" >> logs.sh
chmod +x logs.sh

_success "OK, start/stop scripts created"

_section "Thank you for using the composeapps script !"
_info "You can now start your app by executing these commands:"
_info " "
_info "Start the app $1:    ./up.sh"
_info "Stop the app $1:     ./down.sh"
_info "Follow logs of $1:   ./logs.sh"
_info " "
_success "Cheers, Benoit Lavorata."
