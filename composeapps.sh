#!/bin/bash

#################################################################
### HELPERS V2 ### THE MAGIC PART IS AFTER THE END OF HELPERS ###
#################################################################
# COPY PASTE AT FRONT OF BASH SCRIPTS, KEEP THEM DEPENCY FREE

# COLORS
__NC=$(echo -en '\033[0m')
__RED=$(echo -en '\033[00;31m')
__GREEN=$(echo -en '\033[00;32m')
__YELLOW=$(echo -en '\033[00;33m')
__BLUE=$(echo -en '\033[00;34m')
__MAGENTA=$(echo -en '\033[00;35m')
__PURPLE=$(echo -en '\033[00;35m')
__CYAN=$(echo -en '\033[00;36m')
__LIGHTGRAY=$(echo -en '\033[00;37m')
__LRED=$(echo -en '\033[01;31m')
__LGREEN=$(echo -en '\033[01;32m')
__LYELLOW=$(echo -en '\033[01;33m')
__LBLUE=$(echo -en '\033[01;34m')
__LMAGENTA=$(echo -en '\033[01;35m')
__LPURPLE=$(echo -en '\033[01;35m')
__LCYAN=$(echo -en '\033[01;36m')
__WHITE=$(echo -en '\033[01;37m')
__GREY=$(echo -en '\033[01;30m')


# SET FORMATS
__COLOR_DATE=$__GREY
__COLOR_INTRO=$__YELLOW
__COLOR_INFO=$__BLUE
__COLOR_ERROR=$__RED
__COLOR_SUCCESS=$__GREEN
__COLOR_SECTION=$__WHITE

# DEFINE LOG FUNCTION
__DATE='date +%Y%m%d-%H%M%S'
__YEAR=`date +%Y`
__PREFIX=$(echo -en $__COLOR_DATE`$__DATE`" | "$__NC)

function _intro {
    clear
    echo -e "$__COLOR_INTRO"
    echo -e "GET SCRIPTS FOR: $1"
    echo -e "By Benoit Lavorata, $__YEAR"
    echo -e "--------------------------------"
    #echo -e "================================"
    echo -e "$__NC"
}

function _exit {
    echo -e "$__COLOR_INTRO"
    echo -e "--------------------------------"
    echo -e "Thank you for using the compose script !"
    echo -e "Cheers, Benoit Lavorata."
    echo -e " "
    echo -e "Buy me a coffee ?"
    echo -e  "ETH: 0xdAFd17d20DcBdB24A29A073c350B7e719f45ce3D"
    echo -e  "AION: a0f0886adb7ea587db2283f902efc504304277802cb1d75dffddfc0979667e40"
    echo -e "$__NC"
    exit 1
}

function _log {
    echo -e $__PREFIX"$1"
}

function _log1 {
    echo -e $__PREFIX"    $1"
}

function _info {
    echo -e $__PREFIX"$__COLOR_INFO[INFO]$__NC $1"
}

function _error {
    echo -e $__PREFIX"$__COLOR_ERROR[ERROR]$__NC $1"
    echo -e " "
}

function _success {
    echo -e $__PREFIX"$__COLOR_SUCCESS[SUCCESS]$__NC $1"
    echo -e " "
}

function _section {
    echo -e " "
    echo -e $__PREFIX"$__COLOR_SECTION--- $1 ---$__NC"
#    echo -e "-------------------|"
}

function _quit_if_not_root {
    echo -e " "
    #CHECK THAT WE ARE ROOT
    _info "Log in as root"
    if [[ $EUID -ne 0 ]]; then
        _error $1
        exit 1
    fi
    _success "Log in as root"
}

function _check_url()
{
    local  __resultvar=$1
    local  __inputvar=$2
    local  __result=0

    _log "Checking URL: $__inputvar"
    if curl --output /dev/null --silent --head --fail "$__inputvar"; then
        _log1 "Yes ! the URL exists"
        __result=1
    else
        _log1 "Oh oh, the URL does not exist"
        __result=0
    fi
    
    eval $__resultvar="'$__result'"
}

function _shortcuts_summary {
    _log "You can now start your app by executing these commands:"
    _log " "
    _log "Start app:    ./up.sh"
    _log "Stop app:     ./down.sh"
    _log "Display logs:   ./logs.sh"
}


function _create_compose_scripts {
    #Create up, down scripts
    _section "Create shortcut scripts for the app"
    _log "Create up.sh, down.sh scripts"
    echo -e "#!/bin/bash" > up.sh
    echo -e "echo -e Will now start: ..." >> up.sh
    echo -e "docker-compose up -d" >> up.sh
    chmod +x up.sh

    echo -e "#!/bin/bash" > down.sh
    echo -e "echo -e Will now stop: ..." >> down.sh
    echo -e "docker-compose down" >> down.sh
    chmod +x down.sh

    echo -e "#!/bin/bash" > logs.sh
    echo -e "echo -e Will now tail logs..." >> logs.sh
    echo -e "docker-compose logs -f" >> logs.sh
    chmod +x logs.sh

    _success "Created shortcuts"
}

function _download {
    log "Will now attempt to download $1"
    curl --remote-name $1
    _success "Downloaded file"
}

#################################################################
### END OF HELPERS ### THE MAGIC PART GOES BELOW (HOPEFULLY)  ###
#################################################################


#CHECK IF WE HAVE ARG
if [ -z ${1+x} ]; 
then 
    _error "You did not set any app name in argument. Try again."
    _exit
else 
    APP_NAME=$1
    _intro $APP_NAME
fi

# VARIABLES
APP_COMPOSE_URL="https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/docker-compose.yml"
APP_CUSTOM_URL="https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/install.sh"


# CHECK COMPOSE URL
_section "Check if app exists on repository: $APP_NAME"
_check_url HAS_COMPOSE_URL $APP_COMPOSE_URL
if [ "$HAS_COMPOSE_URL" == 1 ]; then
    _success "I found the app $APP_NAME on github"
else
    _error "The app $APP_NAME does not exist on the repository (did you spell it properly ?)"
    _exit
fi


# Check if there is an installation script with it, if yes, run it
_section "Check if the app $APP_NAME has a custom install script on github"
_check_url HAS_CUSTOM_URL $APP_CUSTOM_URL
if [ "$HAS_CUSTOM_URL" == 1 ] then
    _success "I found a custom script for $APP_NAME on github"
else
    _log "No custom install script for $APP_NAME"
fi


# CREATE LOCAL FOLDER
_section "Create folder: $APP_NAME"
mkdir $APP_NAME
cd $APP_NAME
_success "OK, folder $APP_NAME created"


# DOWLOAD SCRIPTS/COMPOSE FILE
if [ "$HAS_CUSTOM_URL" == 1 ] then
    # DOWNLOAD CUSTOM SCRIPT
    _section "Download script: $APP_CUSTOM_URL"
    _download $APP_CUSTOM_URL
    _success "OK, script downloaded here: $APP_NAME/install.sh"
    chmod +x install.sh
    ./install.sh
else
    # DOWNLOAD COMPOSE
    _section "Download script: $APP_COMPOSE_URL"
    _download $APP_COMPOSE_URL
    _success "OK, script downloaded at $APP_NAME/docker-compose.yml"
    _create_compose_scripts
    _shortcuts_summary
fi

# EXIT
_exit
