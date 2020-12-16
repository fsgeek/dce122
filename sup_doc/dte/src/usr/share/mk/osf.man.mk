#
# @OSF_FREE_COPYRIGHT@
# 
# HISTORY
# $Log: osf.man.mk,v $
# Revision 1.1.2.2  1992/06/02  14:44:19  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:42:03  damon]
#
# $EndLog$

.if !defined(_OSF_MAN_MK_)
_OSF_MAN_MK_=

#
# default nroff program to run
#
NROFF?=nroff

#
# default flags to nroff
#
DEF_NROFFFLAGS?=-man -h

#
# all flags for nroff
#
_NROFFFLAGS_=${${.TARGET}_DEF_NROFFFLAGS:U${DEF_NROFFFLAGS}} ${${.TARGET}_NROFFENV:U${NROFFENV}} ${${.TARGET}_NROFFFLAGS:U${NROFFFLAGS}} ${${.TARGET}_NROFFARGS:U${NROFFARGS}}

#
#  Default single suffix compilation rules
#
.SUFFIXES: .0 .${MANSECTION}

#
#  Default double suffix compilation rules
#
.${MANSECTION}.0:
	${NROFF} ${_NROFFFLAGS_} ${.IMPSRC} > ${.TARGET}.X
	${MV} -f ${.TARGET}.X ${.TARGET}

.endif
