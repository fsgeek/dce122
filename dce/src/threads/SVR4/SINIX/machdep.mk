# @OSF_COPYRIGHT@
# COPYRIGHT NOTICE
# Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
# ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
# the full copyright text.
# 
# (c) Copyright 1991, 1992 Siemens-Nixdorf Information Systems
# Burlington, MA, USA
# All Rights Reserved
# (c) Copyright 1990, 1991, 1992
# 
# 
# HISTORY
# $Log: machdep.mk,v $
# Revision 1.1.7.2  1996/03/09  23:30:52  marty
# 	Update OSF copyright year
# 	[1996/03/09  22:46:07  marty]
#
# Revision 1.1.7.1  1995/12/07  21:54:21  root
# 	Submit OSF/DCE 1.2.1
# 	[1995/12/07  21:02:39  root]
# 
# Revision 1.1.5.2  1994/06/09  13:36:39  devsrc
# 	 CR10892 - fix copyright in file
# 	[1994/06/09  13:26:52  devsrc]
# 
# Revision 1.1.5.1  1994/04/14  21:32:11  ohara
# 	add CPATHS
# 	[1994/04/14  20:29:50  ohara]
# 
# Revision 1.1.3.3  1992/12/15  22:24:18  alan
# 	Insert copyright notices
# 	[1992/12/07  16:11:01  alan]
# 
# Revision 1.1.3.2  1992/09/29  21:26:45  devsrc
# 	[OT 5373]    SNI/SVR4 merge.
# 	[1992/09/17  20:40:02  sekhar]
# 
# $EndLog$
# 
#

CFLAGS          += `genpath -I${TARGET_MACHINE}/${TARGET_OS_PLATFORM}`

#It is necessary to remove the #line statements from the file that comes 
#	from the compiler, which is why:
#	${SED} '/^\#/d'
#is invoked.
#	The command:
#	${SED} 's/% \([a-z]*\)/%\1/g'
#is used to work around a bug in the SVR4 preprocessor.  The bug in the 
#preprocessor is as follows:  
#The following lines:
#	#define STACK_ARG1 4
#	movl STACK_ARG1(%esp),%ebx
#are transformed into:
#	movl 4 ( % esp ) , % ebx
#which is not valid assembly language.
#The sed command transforms lines like:
#	movl 4 ( % esp ) , % ebx
#into:
#	 4 ( %esp ) , %ebp

cma_assem.o: cma_assem.s
	${RM} -f file1.s
	${_CC_} -E ${_CCFLAGS_}  ${_GENINC_} ${${TARGET_MACHINE}_AFLAGS} $> | ${SED} -e '/^\#/d' -e 's/% \([a-z]*\)/%\1/g' -e '//d' > file1.s
	${AS} -o cma_assem.o file1.s

