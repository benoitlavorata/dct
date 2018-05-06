
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
__COLOR_INTRO=$__BLUE
__COLOR_SUB_INTRO=$__YELLOW
__COLOR_INFO=$__BLUE
__COLOR_DEBUG=$__GREY
__COLOR_ERROR=$__RED
__COLOR_SUCCESS=$__GREEN
__COLOR_SECTION=$__WHITE
__COLOR_LOG=$__LIGHTGRAY
__COLOR_PROMPT=$__YELLOW
__COLOR_PROMPT_ANSWER=$__LCYAN

# DEFINE LOG FUNCTION
__DATE='date +%Y%m%d-%H%M%S'
__YEAR=`date +%Y`
__PREFIX=$(echo -en $__COLOR_DATE`$__DATE`" | "$__NC)
__INDENT="   "
__LINE="--------------------------------"

function _intro {
    echo -e "${__COLOR_INTRO}${__LINE}"
    echo -e "INSTALL APPS: $1"
    echo -e "INTO: $2"
    echo -e "By Benoit Lavorata, ${__YEAR}"
    echo -e "${__LINE}${NC}"
}
function _sub_intro {
    echo -e "${__COLOR_SUB_INTRO}"
    echo -e "APP: $1"
    echo -e "INTO: $2/$1"
    echo -e "${__LINE}${NC}"
}

function _exit {
    echo -e "${__COLOR_INTRO}"
    echo -e ${__LINE}
    echo -e "Thank you for using the compose script !"
    echo -e "Cheers, Benoit Lavorata."
    echo -e " "
    echo -e "Buy me a coffee ?"
    echo -e  "ETH: 0xdAFd17d20DcBdB24A29A073c350B7e719f45ce3D"
    echo -e  "AION: a0f0886adb7ea587db2283f902efc504304277802cb1d75dffddfc0979667e40"
    echo -e ${__LINE}
    echo -e "${__NC}"
}

function _quit {
    exit 1
}

function _log {
    echo -e ${__PREFIX}${__COLOR_LOG}"$1"${NC}
}
function _log1 {
    _log "${__INDENT}$1"
}
function _log2 {
    _log1 "${__INDENT}$1"
}
function _log3 {
    _log2 "${__INDENT}$1"
}

function _debug {
    echo -e ${__PREFIX}${__COLOR_DEBUG}"${__INDENT}[DEBUG] $1"${NC}
}
function _info {
    echo -e ${__PREFIX}${__COLOR_INFO}"${__INDENT}[INFO] $1"${NC}
}
function _error {
    echo -e ${__PREFIX}${__COLOR_ERROR}"${__INDENT}[ERROR] $1"${NC}
}
function _success {
    echo -e ${__PREFIX}${__COLOR_SUCCESS}"${__INDENT}[SUCCESS] $1"${NC}
}

function _section {
    echo -e " "
    echo -e $__PREFIX"${__COLOR_SECTION}--- $1 ---${__NC}"
}

function _source {
    echo -e " "
    echo -e $__PREFIX"${__COLOR_INFO}--- CUSTOM SCRIPT FOR $1 ---${__NC}"
    source $2
    echo -e " "
    echo -e $__PREFIX"${__COLOR_INFO}--- END OF CUSTOM SCRIPT ---${__NC}"
}

function _quit_if_not_root {
    #CHECK THAT WE ARE ROOT
    _log "Log in as root"
    if [[ $EUID -ne 0 ]]; then
        _error $1
        exit 1
    fi
    _success "Log in as root"
}


function _file_exists {
    local  __resultvar=$1
    local  __inputvar=$2
    local  __result=0

    _log "Does file $__inputvar exist ?"
    if [ -f "$__inputvar" ]; then
        _log1 "Yes, the file exists"
        __result=1
    else
        _log1 "No, the file does not exist"
        __result=0
    fi

    eval $__resultvar="'$__result'"
}


function _folder_exists {
    local  __resultvar=$1
    local  __inputvar=$2
    local  __result=0

    _log "Does folder $__inputvar exist ?"
    if [ -d "$__inputvar" ]; then
        _log1 "Yes, the folder exists"
        __result=1
    else
        _log1 "No, the folder does not exist"
        __result=0
    fi

    eval $__resultvar="'$__result'"
}


function _url_file_exists
{
    local  __resultvar=$1
    local  __inputvar=$2
    local  __result=0

    _log "Does URL $__inputvar exist ?"
    if curl --output /dev/null --silent --head --fail "$__inputvar"; then
        _log1 "Yes, the URL exists"
        __result=1
    else
        _log1 "No, the URL does not exist"
        __result=0
    fi
    
    eval $__resultvar="'$__result'"
}

function TODO_url_exists
{
    local  __resultvar=$1
    local  __inputvar=$2
    local  __result=0

    _log "Does URL $__inputvar exist ?"
    __result = curl -s --head http://myurl/ | head -n 1 | grep "HTTP/1.[01] [23].."

    echo $__result
    _exit

    if curl --output /dev/null --silent --head --fail "$__inputvar"; then
        _log1 "Yes, the URL exists"
        __result=1
    else
        _log1 "No, the URL does not exist"
        __result=0
    fi
    
    eval $__resultvar="'$__result'"
}

function _shortcuts_summary {
    _section "How to start your application ?"
    _info "You can now start your app by executing these commands:"
    _log " "
    _log "Start:$__INDENT./up.sh"
    _log "Stop :$__INDENT./down.sh"
    _log "Logs :$__INDENT./logs.sh"
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
    _log "Download file: $1"
    curl --silent --remote-name $1
    _log1 "Downloaded file"
}

function _add_custom_config {
    local __resultvar=$1
    local __defaultval=$2

    # Set var to value
    #eval $__resultvar="'$__result'"

    # Append to CUSTOM_CONFIG
    eval CUSTOM_CONFIG_NAMES+=("$__resultvar")
    eval CUSTOM_CONFIG_VALUES+=("$__defaultval")
}

function _display_custom_config {
    for index in ${!CUSTOM_CONFIG_NAMES[*]} 
    do
       _log1 "${index}. ${CUSTOM_CONFIG_NAMES[$index]}  =  ${CUSTOM_CONFIG_VALUES[$index]}"
    done
}

function _prompt_custom_config {
    local __question=$1

    _log "$1"
    _break_line

    for index in ${!CUSTOM_CONFIG_NAMES[*]} 
    do
        # Prompt user
        local _var_name="CUSTOM_CONFIG_${CUSTOM_CONFIG_NAMES[$index]}"
        _prompt "${__COLOR_PROMPT}${index}. ${CUSTOM_CONFIG_NAMES[$index]} (default ${CUSTOM_CONFIG_VALUES[$index]}) ? ${__COLOR_PROMPT_ANSWER}" "$_var_name"

        if [ "${!_var_name}" != "" ]; then
            # KEEP USER INPUT
            CUSTOM_CONFIG_VALUES[$index]=${!_var_name}
        fi
    done
    _log "${__NC}"
}

function _prompt {
    local __question=$1
    local __resultvar=$2
    read -p "$__PREFIX$__INDENT$__question" __result
    eval $__resultvar="'$__result'"
}

function TODO_prompt {
    local __question=$1
    local __resultvar=$2
    local __summary_var=$3
    local __sumary_names_var="$3_NAMES"
    
    read -p "$__PREFIX$__INDENT$__question" __result

    if [ "$__summary_var" == "NONE" ]; then
        eval $__resultvar="'$__result'"
    else
        eval $__resultvar="'$__result'"
        eval "$__summary_var+=($__result)"
        eval "$__sumary_names_var+=($__resultvar)"
    fi
}

function _break_line {
    echo ""
}

function _install {
    #CHECK IF WE HAVE ARG
    if [ -z ${1+x} ]; 
    then 
        _sub_intro "NO APPS NAME"
        _error "You did not set any app name in argument. Try again."
        return 0
    else 
        APP_NAME=$1
        _sub_intro $APP_NAME $SCRIPT_WORKING_DIR_PATH
    fi

    # VARIABLES
    APP_COMPOSE_URL="https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/docker-compose.yml"
    APP_CUSTOM_URL="https://raw.githubusercontent.com/sbglive/compose/master/$APP_NAME/install.sh"
    APP_CAN_INSTALL=0

    # CHECK COMPOSE URL
    _section "Check if app has a docker-compose.yml: $APP_NAME"
    _url_file_exists APP_HAS_COMPOSE_URL $APP_COMPOSE_URL
    if [ "$APP_HAS_COMPOSE_URL" == 1 ]; then
        _success "I found the app $APP_NAME on github"
        APP_CAN_INSTALL=1
    else
        _info "The app $APP_NAME does not have a docker-compose.yml"
    fi


    # Check if there is an installation script with it, if yes, run it
    _section "Check if the app $APP_NAME has a custom install script on github"
    _url_file_exists APP_HAS_CUSTOM_URL $APP_CUSTOM_URL
    if [ "$APP_HAS_CUSTOM_URL" == 1 ]; then
        _success "I found a custom script for $APP_NAME on github"
        APP_CAN_INSTALL=1
    else
        _info "No custom install script for $APP_NAME"
    fi

    # Can we install ?
    _section "Check if we can install"
    if [ "$APP_CAN_INSTALL" == 1 ]; then
        _success "Yes, we can."
    else
        _error "No, we cannot. The app is missing a docker-compose.yml or install.sh file."
        return 0
    fi


    # CREATE LOCAL FOLDER
    _section "Create local folder: $APP_NAME"
    _folder_exists APP_HAS_APP_FOLDER $APP_NAME
    if [ "$APP_HAS_APP_FOLDER" == 1 ]; then
        _error "The folder $APP_NAME already exists. You need to rename it or remove it before installing this app here"
        return 0
    else
        _log "Creating the folder $APP_NAME"
        mkdir $APP_NAME
        cd $APP_NAME
        _success "Folder $APP_NAME created"
    fi


    # DOWLOAD SCRIPTS/COMPOSE FILE
    if [ "$APP_HAS_CUSTOM_URL" == 1 ]; then
        # DOWNLOAD CUSTOM SCRIPT
        _section "Download install script"
        _download $APP_CUSTOM_URL
        _success "OK, script downloaded here: $APP_NAME/install.sh"
        chmod +x install.sh
        _source $APP_NAME install.sh
    else
        # DOWNLOAD COMPOSE
        _section "Download docker-compose file"
        _download $APP_COMPOSE_URL
        _success "OK, script downloaded at $APP_NAME/docker-compose.yml"
        _create_compose_scripts
        _shortcuts_summary
    fi
}

function _clear {
    #clear
    _break_line
    _break_line
    _break_line
}

function _working_dir {
    local  __resultvar=$1
    eval $__resultvar="'$PWD'"
}
function _script_dir {
    local  __resultvar=$1
    eval $__resultvar="'${BASH_SOURCE[0]}'"
}