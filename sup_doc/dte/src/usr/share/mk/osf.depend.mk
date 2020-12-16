#
# @OSF_FREE_COPYRIGHT@
# 
# HISTORY
# $Log: osf.depend.mk,v $
# Revision 1.1.2.2  1992/06/02  14:43:53  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:41:40  damon]
#
# $EndLog$

.if !defined(_OSF_DEPEND_MK_)
_OSF_DEPEND_MK_=

nodep_all:
	${RM} ${_RMFLAGS_} depend.mk

.if !empty(.TARGETS:Mnodep_*.o)
${TARGETS:Mnodep_*.o}:
	${RM} -f ${.TARGET:S/^nodep_//} ${.TARGET:S/^nodep_//:.o=.d}
	echo "${.TARGET:S/^nodep_//}: ${.TARGET:S/^nodep_//}" \
		> ${.TARGET:S/^nodep_//:.o=.d}
.endif

.EXIT:
	${MD} ${_MDFLAGS_} .

.endif
