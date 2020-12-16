#
# @OSF_FREE_COPYRIGHT@
#
# HISTORY
# $Log: osf.rules.mk,v $
# Revision 1.1.2.2  1992/06/02  14:44:34  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:42:17  damon]
#
# $EndLog$

.if !defined(_OSF_RULES_MK_)
_OSF_RULES_MK_=

.include <osf.std.mk>
.if !defined(TOSTAGE)
.if defined(PROGRAMS)
.include <osf.prog.mk>
.endif
.if defined(LIBRARIES) || defined(SHARED_LIBRARIES)
.include <osf.lib.mk>
.endif
.if defined(BINARIES)
.include <osf.obj.mk>
.endif
.if defined(SCRIPTS)
.include <osf.script.mk>
.endif
.if defined(MANPAGES)
.include <osf.man.mk>
.endif
.if defined(DOCUMENTS)
.include <osf.doc.mk>
.endif
.if defined(DEPENDENCIES)
.include <osf.depend.mk>
.endif
.endif

.endif
