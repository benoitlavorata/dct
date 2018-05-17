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

_intro "APP INSTALLER" "~/bin"

_section "Create folder ~/bin and add to PATH"

_log "Create ~/bin"
cd ~/ && mkdir bin

_log "Backup ~/.bash_profile to ~/.bash_profile.compose.backup"
cp ~/.bash_profile ~/.bash_profile.compose.backup
touch ~/.bash_profile

_log "Add ~/bin to PATH"
echo 'PATH=$PATH:$HOME/bin' >> ~/.bash_profile 

_log "Reload ~/.bash_profile"
source ~/.bash_profile

_log "Download & Install app compose (SBG)"
cd ~/bin
rm compose.sh
rm helpers.sh
wget https://raw.githubusercontent.com/sbglive/compose/master/helpers.sh && chmod +x helpers.sh
wget https://raw.githubusercontent.com/sbglive/compose/master/compose.sh && chmod +x compose.sh
mv compose.sh app
_success "Installed the app !"

_info "You can now use the command: app <APP_NAME>"
_outro