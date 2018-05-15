#!/bin/bash
source ~/bin/helpers.sh

# CLEAN THE STDOUT
_clear

# GET CURRENT DIR PATH
_working_dir SCRIPT_WORKING_DIR_PATH
_script_dir SCRIPT_DIR_PATH

# CHECK IF WE HAVE ARGS
if [ -z ${1+x} ]; 
then 
    _intro "NO APPS NAME" "$SCRIPT_WORKING_DIR_PATH"
    _error "You did not set any app name in argument. Try again with: app <APP_NAME1> <APP_NAME2> ..."
    _exit
fi

# GET PROVIDED ARGS INTO ARRAY
__ARGS=()
for var in "$@" 
do
    __ARGS+=("$var")
done

# GIVE INTRODUCTION
_intro "${__ARGS[*]}" "$SCRIPT_WORKING_DIR_PATH"

# LAUNCH THE SCRIPT AS MANY TIME AS NECESSARY
for index in ${!__ARGS[*]} 
do
    #_log1 "$index: ${__ARGS[$index]}"
    cd $SCRIPT_WORKING_DIR_PATH
    _install "${__ARGS[$index]}"
done

# EXIT
_exit
