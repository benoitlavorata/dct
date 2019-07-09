#!/bin/bash
SCRIPT_NAME="DCT install script"
SCRIPT_DESCRIPTION="Installs docker-compose production ready apps"
SCRIPT_AUTHOR="Benoit Lavorata"

SERVICE_NAME=$1
DESTINATION=$2
DCT_USER="benoit.lavorata"
GIT_URL="https://gitlab.com/${DCT_USER}/${SERVICE_NAME}.service.git"

###############
### HELPERS ###
###############
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
__COLOR_DATE=$__BLUE
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
__INDENT="  "
__LINE="-------------------------------------------------"

function _intro {
    echo -e "${__COLOR_INTRO}${__LINE}"
    echo -e "SCRIPT:${__COLOR_LOG} ${SCRIPT_NAME} ${__COLOR_INTRO}"
    echo -e "INFO:${__COLOR_LOG} ${SCRIPT_DESCRIPTION}${__COLOR_INTRO}"
    echo -e "AUTHOR:${__COLOR_LOG} ${SCRIPT_AUTHOR}, ${__YEAR} ${__COLOR_INTRO}"
    echo -e "${__LINE}${__NC}"
}

function _outro {
    echo -e "${__COLOR_INTRO}"
    echo -e ${__LINE}
    echo -e "Have a good day,"
    echo -e "$SCRIPT_AUTHOR."
    echo -e ${__LINE}
    echo -e "${__NC}"
}

function _br {
    echo " "
}

function _log {
    echo -e ${__PREFIX}${__COLOR_LOG}"$1"${__NC}
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
function _log4 {
    _log3 "${__INDENT}$1"
}

##########################
### BUSINESS FUNCTIONS ###
##########################

function _list_all_services {
    API_ENDPOINT="https://gitlab.com/api/v4"
    TARGET="$API_ENDPOINT/users/$DCT_USER/projects"
    SHORT=$1

    #_log "Fetching all services from: $TARGET"
    _log "DCT Services list:"
    for row in $(curl -s $TARGET | jq -r '.[] | @base64'); do
        _jq() {
            echo ${row} | base64 --decode | jq -r ${1}
        }

        REPO_NAME=$(_jq '.name')
        if [[ $REPO_NAME == *".service"* ]]; then
        
            SERVICE=${REPO_NAME%".service"}
            REPO_URL=$(_jq '.http_url_to_repo')
            
            if [ -z "$SHORT" ]
            then
                _log1 "${__YELLOW}${SERVICE}${__COLOR_LOG} $REPO_URL"
            else
                REPO_DESCRIPTION=$(_jq '.description')
                _log1 "${__YELLOW}${SERVICE}${__COLOR_LOG}"
                _log1 "$REPO_DESCRIPTION"
                _log1 "Link: $REPO_URL"
                _br
            fi
        fi
    done
}

function _exit {
    _outro
    exit 0
}


### START

_intro

if [ -z "$SERVICE_NAME" ]
then
    _log "[FAIL] You should provide a service name as first argument"
    _br
    _list_all_services
    _exit
fi
if [ -z "$DESTINATION" ]
then
    _log "Default destination set to $PWD"
    DESTINATION=$PWD
fi

_log "Check if jq and curl are installed..."
if [ $(dpkg-query -W -f='${Status}' jq 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  _log1 "install jq"
  sudo apt-get install jq -y
fi

if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  _log1 "install curl"
  sudo apt-get install curl -y
fi
  _log1 "OK, packages installed"

_log "Attempt to install ${SERVICE_NAME} in ${DESTINATION}, from ${GIT_URL}"

_log "Check if service exists"
if curl --head --silent --fail "${GIT_URL}" 2>&1 > /dev/null;
then
    _log "${SERVICE_NAME} exists, continue"
else
    _log "[FAIL] ${SERVICE_NAME} does not exist in dct services."
    _br
    _list_all_services
    _exit
fi

_log "git clone ${GIT_URL}"
git clone ${GIT_URL} "${DESTINATION}/${SERVICE_NAME}.service"

_log "initialize the service"
cd "${DESTINATION}/${SERVICE_NAME}.service"
./up.sh

_exit
