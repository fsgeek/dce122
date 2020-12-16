#!/bin/ksh
# 
# SGML automated DCE 1.2.2 book build (into publish format) script.
# 
# To run, type the following (on mazeppa!):
# 
#     % cd /u1/BOOKS/BUILD/exec
#     % build_sgml.ksh
# 
# If you want a log, type:
# 
#     % build_sgml.ksh > LOG
# 
# --or do the build by invoking "do_build.ksh".
# 
# 
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# Here are the paths we depend on...
# 
# A. Remote:
TREE_PATH=/project/dce/build/dcedoc1.2.2/src/dce_books_sgml
#  (The place from which we copy the sources to build, as well as
#   DocBook-da, entities, etc.)
# 
# B. Local:
ADEPT_PATH=/u1/adept/bin
#  (Path to installed Adept binaries.)
# 
BUILD_PATH=/u1/BOOKS/BUILD
#  (The top-level directory under which our build is locally
#   organized.)
# 
SRC_PATH=${BUILD_PATH}/dce_books_sgml
#  (The location to which the contents of dce_books_sgml will
#   be copied.)
# 
OUT_PATH=${BUILD_PATH}/built_books
#  (The location at which the PostScript output will be finally
#   deposited.)
# 
# 
# ...And here is a graphic representation of the paths in B above:
# 
# 
#                               mazeppa:/u1
#                                    |
#                                    |
#                        -------------------------
#                        |                       |
#                 /u1/BOOKS/BUILD         /u1/adept/bin
#                        |
#                        |
#                        |
#       ------------------------------------------
#       |                    |                   |
# dce_books_sgml ($SRC_PATH) |                   |
#                            |                   |
#                       built_books ($OUT_PATH)  |
#                                                |
#                                               exec
#                                                |
#                                                |
#                                                |
#                                          build_sgml.ksh
#                                            (this file)
# 

# -------------------------------------------------------------------------
BOOKS="admin_gd_intro dfs_admin_gdref gds_admin_gdref command_ref app_gd_dir dfa_admin_gdref dfa_users_gd intro admin_gd_core app_gd_style app_ref app_gd_core prob_gd"
# 
# 
# 

# -------------------------------------------------------------------------
function build_book {

  BOOK_TO_BUILD=${1}
  case ${1} in
        dfa_users_gd) BOOK_NAME="DFA User's Guide" PARTS=3;;
        admin_gd_core) BOOK_NAME="Admin Guide Core" PARTS=26;;
        admin_gd_intro) BOOK_NAME="Admin Guide Intro" PARTS=10;;
        app_gd_dir) BOOK_NAME="Application Guide Directory Services" PARTS=22;;
        dfa_admin_gdref) BOOK_NAME="DFA Admin Guide and Reference" PARTS=4;;
        dfs_admin_gdref) BOOK_NAME="DFS Admin Guide and Reference" PARTS=38;;
        gds_admin_gdref) BOOK_NAME="GDS Admin Guide and Reference" PARTS=24;;
        intro) BOOK_NAME="Introduction to OSF DCE" PARTS=9;;
        command_ref) BOOK_NAME="Command Reference" PARTS=30;;
        app_gd_style) BOOK_NAME="Application Guide Style Guide" PARTS=15;;
        app_ref) BOOK_NAME="Application Reference" PARTS=77;;
        app_gd_core) BOOK_NAME="Application Guide Core" PARTS=34;;
        prob_gd) BOOK_NAME="Problem Determination Guide" PARTS=47;;

  esac

  cd ${SRC_PATH}
  echo "\n\n\n-------------------------------------------------------------------------\n"
  echo ${BOOK_NAME}" START\n"
  DATE=`date '+DATE: %m/%d/%y%nTIME: %H:%M:%S%n'`
  echo ${DATE}
  ${ADEPT_PATH}/pubformat -p ${BOOK_TO_BUILD}
  echo ${BOOK_NAME}" DONE\n"
  DATE=`date '+DATE: %m/%d/%y%nTIME: %H:%M:%S%n'`
  echo ${DATE}
  echo "\n-------------------------------------------------------------------------\n"
  echo "Cleanup...\n"
  cd ${SRC_PATH}/${BOOK_TO_BUILD}
  rm -f ${BOOK_TO_BUILD}".chk" ${BOOK_TO_BUILD}".dvi" ${BOOK_TO_BUILD}".dvx"
  rm -f ${BOOK_TO_BUILD}".in0" ${BOOK_TO_BUILD} ${BOOK_TO_BUILD}".in1" ${BOOK_TO_BUILD}".mac"
  rm -f ${BOOK_TO_BUILD}".st0" ${BOOK_TO_BUILD}".st1" ${BOOK_TO_BUILD}".sty"
  rm -f ${BOOK_TO_BUILD}".tex"
  rm -f *.ftx idx.* *.st[0-9]
  mv ${BOOK_TO_BUILD}".ps" ${OUT_PATH}/${BOOK_TO_BUILD}/${BOOK_TO_BUILD}"_publish.ps"
  echo "...Cleanup finished.\n"

# Now cut it up...
  cd ${OUT_PATH}/${BOOK_TO_BUILD}
  echo "Splitting up PostScript files...\n"

  let part_count=1
  let first=1
  let last=30
  while ((part_count <= ${PARTS} )); do
     if (( part_count < 10 )); then
         psselect -p${first}-${last} ${BOOK_TO_BUILD}"_publish.ps" ${BOOK_TO_BUILD}"_publish-0"${part_count}".ps"
     else
         psselect -p${first}-${last} ${BOOK_TO_BUILD}"_publish.ps" ${BOOK_TO_BUILD}"_publish-${part_count}.ps"
     fi
     let first=first+30
     let last=last+30
     let part_count=part_count+1
  done

  mv ${BOOK_TO_BUILD}"_publish.ps" ${BOOK_TO_BUILD}"_publish_WHOLE_BOOK.ps"
  echo "\n-------------------------------------------------------------------------\n\n\n"

}

# -------------------------------------------------------------------------
# Step 1: Startup: Print out messages, then copy current state of tree
#                  for all books if all are to be built, or for the single
#                  book that is to be built...
#                  Also, if all books are to be built, the OSF FOSI entities
#                  are re-copied into SRC_PATH...

umask 1
if [[ ${1} = "" ]]; then
  echo "\nUsage: do_build.ksh {all | <book_name>}\n"
  echo "Possible <book_name>s are:\n"
  for book in ${BOOKS}
  do
     echo "     "${book}
  done
  echo "\n"
  exit

elif [[ ${1} = "all" ]]; then
  echo "Building all books"

  if [[ -d ${SRC_PATH} ]]; then
      cd ${SRC_PATH}
      rm -rf *
  else
      echo "${SRC_PATH} does not exist!"
      exit
  fi

  if [[ -d ${TREE_PATH} ]]; then
      cd ${TREE_PATH}; tar cf - . | \
      (cd ${SRC_PATH}; tar xf -)
  else
      echo "${TREE_PATH} does not exist!"
      exit
  fi

  cd ${SRC_PATH}
  rm -f common-characterfills common-counters common-eics common-textIDs
  rm -f index-eics revflag stylesets
  cp entities/common-characterfills.ent ./common-characterfills
  cp entities/common-counters.ent ./common-counters
  cp entities/common-eics.ent ./common-eics
  cp entities/common-textIDs.ent ./common-textIDs
  cp entities/index-eics.ent ./index-eics
  cp entities/revflag.ent ./revflag
  cp entities/stylesets.ent ./stylesets

else
  echo "Building ${1}"
  BOOKS=${1}
  if [[ -d ${SRC_PATH}/${BOOKS} ]]; then
      cd ${SRC_PATH}/${BOOKS}
      rm -rf *
  else
      echo "${SRC_PATH}/${BOOKS} does not exist!"
      exit
  fi

  cd ${TREE_PATH}/${BOOKS}; tar cf - . | \
  (cd ${SRC_PATH}/${BOOKS}; tar xf -)

fi

# -------------------------------------------------------------------------
# Step 2: Remove former build debris...
# 

for book in ${BOOKS}
do

  if [[ -d ${OUT_PATH}/${book} ]]; then
      cd ${OUT_PATH}/${book}
      rm -f *.ps
  else
      echo "${OUT_PATH}/${book} does not exist!"
      exit
  fi

done

# 
# 
echo "\n-------------------------------------------------------------------------\n"
echo "DCE 1.2.2 SGML Book Build\n"
DATE=`date '+DATE: %m/%d/%y%nTIME: %H:%M:%S%n'`
echo ${DATE}
echo "\n\n\n"
echo "-------------------------------------------------------------------------\n"

# -------------------------------------------------------------------------
# Step 3: Build the books...
# 

for book in ${BOOKS}
do
  build_book $book
done

# 
# 
# 
# -------------------------------------------------------------------------
# Step 4: Finally, set all the new files' and directories' permissions etc...
# 

cd ${BUILD_PATH}/dce_books_sgml
mv DocBook-da/DocBook .
rm -rf DocBook-da

cd ${BUILD_PATH}/dce_books_sgml
# find . -type f -exec chmod 666 {} \;
find . -type d -exec chmod 777 {} \;
# 
cd ${BUILD_PATH}/built_books
# find . -type f -exec chmod 666 {} \;
find . -type d -exec chmod 777 {} \;
# 
# 
# 
# 
# 
# -----------------------------THE END-------------------------------------
# 
# -------------------------------------------------------------------------
