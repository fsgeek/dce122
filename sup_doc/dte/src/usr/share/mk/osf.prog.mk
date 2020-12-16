#
# @OSF_FREE_COPYRIGHT@
# 
# HISTORY
# $Log: osf.prog.mk,v $
# Revision 1.1.2.2  1992/06/02  14:44:29  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:42:13  damon]
#
# $EndLog$

.if !defined(_OSF_PROG_MK_)
_OSF_PROG_MK_=

#
#  Build rules
#
.if defined(PROGRAMS)

${PROGRAMS}: $${_OFILES_}
	${_CC_} ${_LDFLAGS_} -o ${.TARGET}.X ${_OFILES_} ${_LIBS_}
	${MV} ${.TARGET}.X ${.TARGET}

.endif

.endif
