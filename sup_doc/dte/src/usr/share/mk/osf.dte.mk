#
# @OSF_FREE_COPYRIGHT@
# 
# HISTORY
# $Log: osf.dte.mk,v $
# Revision 1.1.2.4  1992/07/08  13:21:43  damon
# 	Fixed to be the same as ODE's
# 	[1992/07/08  13:20:41  damon]
#
# Revision 1.1.2.3  1992/06/02  15:00:36  damon
# 	Changed from osc to ode base
# 	[1992/06/02  15:00:05  damon]
# 
# Revision 1.1.2.2  1992/06/02  14:44:03  damon
# 	Initial Version, from ODE
# 	[1992/06/02  14:41:49  damon]
# 
# $EndLog$

.if !defined(_OSF_DTE_MK_)
_OSF_DTE_MK_=

#
#  Define MAILSYSTEM (used by rcs, etc. to send mail)
#
MAILSYSTEM?=SENDMAIL

#
#  Shared libraries definitions
#
USE_SHARED_LIBRARIES=0

.endif
