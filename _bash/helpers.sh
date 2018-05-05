
#################################################################
### HELPERS V2 ### THE MAGIC PART IS AFTER THE END OF HELPERS ###
#################################################################
# COPY PASTE AT FRONT OF BASH SCRIPTS, KEEP THEM DEPENCY FREE

# DEFINE LOG FUNCTION
__DATE='date +%Y/%m/%d %H:%M:%S'
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
