#
# @OSF_FREE_COPYRIGHT@
# 
# HISTORY
# $Log: osf.script.mk,v $
# Revision 1.1.2.2  1992/06/02  14:44:39  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:42:22  damon]
#
# $EndLog$

.if !defined(_OSF_SCRIPT_MK_)
_OSF_SCRIPT_MK_=

#
#  Definitions for rules using sed
#
_N_A_S_F_=THIS IS NOT A SOURCE FILE - DO NOT EDIT

#
#  Default single suffix compilation rules
#
.csh:
	${SED} -e '1s;^#!;&;' -e t\
	       -e 's;^#\(.*\)\@SOURCEWARNING\@;\1${_N_A_S_F_};' -e t\
	       ${${.TARGET}_SED_OPTIONS:U${SED_OPTIONS}}\
	       -e '/^[ 	]*#/d'\
	 ${.IMPSRC} > ${.TARGET}.X
	${CHMOD} +x ${.TARGET}.X
	${MV} -f ${.TARGET}.X ${.TARGET}

.sh:
	${SED} -e '1s;^#!;&;' -e t\
	       -e 's;^#\(.*\)\@SOURCEWARNING\@;\1${_N_A_S_F_};' -e t\
	       ${${.TARGET}_SED_OPTIONS:U${SED_OPTIONS}}\
	       -e '/^[ 	]*#/d'\
	 ${.IMPSRC} > ${.TARGET}.X
	${CHMOD} +x ${.TARGET}.X
	${MV} -f ${.TARGET}.X ${.TARGET}

.endif
