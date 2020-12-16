#!/bin/ksh
# 
# Wrapper for "build_sgml.ksh". The difference between
#  invoking the latter through this script and doing so
#  directly is that if you do the former, you will auto-
#  matically get a log generated. Any old log of the same
#  name (i.e., generated earlier the same day) will be
#  saved under a unique name; the user is responsible for
#  saving any earlier same-day build, by running
#  copy_build.ksh.
# 
# Following is path to which log will be written...
LOG_PATH=/u1/BOOKS/BUILD/LOGS

# Check command line, and generate full log name if
#  the command is valid...
if [[ ${1} = "" ]]; then

  build_sgml.ksh ${1}
  exit

elif [[ ${1} = "all" ]]; then

  LOG_NAME=`date '+ALL_BOOKS_LOG_%m-%d-%y'`

else

  LOG_NAME=${1}_`date '+LOG_%m-%d-%y'`

fi

TIME=`date '+_%H:%M:%S'`
trap "" ERR
umask 1

# Rename any previous log of the same name...
if [[ -f ${LOG_PATH}/${LOG_NAME} ]]; then
  mv ${LOG_PATH}/${LOG_NAME} ${LOG_PATH}/${LOG_NAME}_old${TIME}
fi

touch ${LOG_PATH}/${LOG_NAME}
chmod 666 ${LOG_PATH}/${LOG_NAME}

# Invoke the build and direct the output as appropriate...
build_sgml.ksh ${1} 2>&1 << '\n\n\n\n\n' | tee ${LOG_PATH}/${LOG_NAME}

# Rename any previous error log of the same name...
# if [[ -f ${LOG_PATH}/ERRORS_FROM_${LOG_NAME} ]]; then
#   mv ${LOG_PATH}/ERRORS_FROM_${LOG_NAME} ${LOG_PATH}/ERRORS_FROM_${LOG_NAME}_old${TIME}
# fi
# 
# Derive the new error log...
# /u1/BOOKS/BUILD/exec/cgrep -1 "Error on" ${LOG_PATH}/${LOG_NAME} > ${LOG_PATH}/ERRORS_FROM_${LOG_NAME}
# 
# Make the log manipulable for others...
# chmod 666 ${LOG_PATH}/ERRORS_FROM_${LOG_NAME}
