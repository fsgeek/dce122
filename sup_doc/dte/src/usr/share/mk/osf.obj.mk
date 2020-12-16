#
# @OSF_FREE_COPYRIGHT@
#
# HISTORY
# $Log: osf.obj.mk,v $
# Revision 1.1.2.2  1992/06/02  14:44:24  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:42:08  damon]
#
# $EndLog$

.if !defined(_OSF_OBJ_MK_)
_OSF_OBJ_MK_=

#
# definitions for compilation
#
_ALL_OFILES_=${PROGRAMS:D${PROGRAMS:@.PROG.@${${.PROG.}_OFILES:U${.PROG.}.o}@}:U${OFILES}}
_OFILES_=${${.TARGET}_OFILES:U${OFILES:U${.TARGET}.o}}

#
#  Default double suffix compilation rules
#

.c.o:
	${_CC_} -c ${_CCFLAGS_} ${.IMPSRC}

.y.o:
	${YACC} ${_YFLAGS_} ${.IMPSRC}
	${_CC_} -c ${_CCFLAGS_} y.tab.c
	-${RM} -f y.tab.c
	${MV} -f y.tab.o ${.TARGET}

.y.c:
	${YACC} ${_YFLAGS_} ${.IMPSRC}
	${MV} -f y.tab.c ${.TARGET}
	${RM} -f y.tab.h

.y.h:
	${YACC} -d ${_YFLAGS_} ${.IMPSRC}
	${MV} -f y.tab.h ${.TARGET}
	${RM} -f y.tab.c

.l.o:
	${LEX} ${_LFLAGS_} ${.IMPSRC}
	${_CC_} -c ${_CCFLAGS_} lex.yy.c
	-${RM} -f lex.yy.c
	${MV} -f lex.yy.o ${.TARGET}

.l.c:
	${LEX} ${_LFLAGS_} ${.IMPSRC}
	${MV} -f lex.yy.c ${.TARGET}

.c.pp:
	${_CC_} -E ${_CCFLAGS_} ${.IMPSRC} > ${.TARGET}

.if defined(OFILES) || defined(PROGRAMS)
${_ALL_OFILES_}: ${HFILES}
.endif

.endif
