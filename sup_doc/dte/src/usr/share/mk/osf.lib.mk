#
# @OSF_FREE_COPYRIGHT@
# 
# HISTORY
# $Log: osf.lib.mk,v $
# Revision 1.1.2.2  1992/06/02  14:44:14  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:41:59  damon]
#
# $EndLog$

.if !defined(_OSF_LIB_MK_)
_OSF_LIB_MK_=

#
#  Build rules
#
.if defined(LIBRARIES)

.if defined(ORDER_LIBRARIES)
COFF_LORDER=`lorder *.o | tsort`
AIXCOFF_LORDER=`lorder *.o | tsort`
A_OUT_LORDER=${_OFILES_}
MACHO_LORDER=${_OFILES_}
.endif

#_LIBRARY_OFILES_=${_OFILES_:@.OF.@${.TARGET}(${.OF.})@}
#${LIBRARIES}: $${_LIBRARY_OFILES_}

${LIBRARIES}: $${.TARGET}($${_OFILES_})
	${_AR_} ${DEF_ARFLAGS} ${.TARGET} ${.OODATE}
.if defined(ORDER_LIBRARIES)
	${RM} -rf tmp
	mkdir tmp
	cd tmp && { \
	    ${_AR_} x ../${.TARGET}; \
	    ${RM} -f __.SYMDEF __________ELELX; \
	    ${_AR_} cr ${.TARGET} ${${OBJECT_FORMAT}_LORDER}; \
	}
	${MV} -f tmp/${.TARGET} .
	${RM} -rf tmp
.endif
	${_RANLIB_} ${.TARGET}
	${RM} -f ${.OODATE}

.endif

.if defined(SHARED_LIBRARIES)

${SHARED_LIBRARIES}: $${_OFILES_}
	${_LD_} ${_SHLDFLAGS_} -o ${.TARGET}.X ${_OFILES_} ${_LIBS_}
	${MV} ${.TARGET}.X ${.TARGET}

.endif

.endif
