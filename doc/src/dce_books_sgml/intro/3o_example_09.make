<!--
# @OSF_COPYRIGHT@
# 
# 
# HISTORY
# $Log: 3o_example_09.make,v $
# Revision 1.1.2.2  1996/11/05  20:11:57  weir
# 	Cleaned up history
# 	[1996/11/05  20:11:03  weir]
#
# Revision 1.1.2.1  1996/10/28  19:46:31  wardr
# 	{edit,R1.2.2}
# 	Initial checkin after sgml conversion
# 	[1996/10/28  19:46:03  wardr]
# 
# Revision 1.1.1.2  1996/10/28  19:46:03  wardr
# 	{edit,R1.2.2}
# 	Initial checkin after sgml conversion
# 
# $EndLog$
-->
<!---->
<!-- Fragment document type declaration subset:
ArborText, Inc., 1988-1993, v.4001
<!DOCTYPE Book PUBLIC "-//Davenport//DTD DocBook V2.4//EN" [
]>
-->
<!--  -->
<!--  -->
<!-- COPYRIGHT NOTICE -->
<!-- Copyright (c) 1990, 1991, 1992, 1993 Open Software Foundation, Inc. -->
<!-- ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the -->
<!-- src directory for the full copyright text. -->
<!--  -->
<!--  -->
<!-- HISTORY -->
<!--  -->
<!-- Revision 1.1.4.4  1995/06/07  16:47:44  buckler -->
<!-- 	1.1 edits. -->
<!-- 	PRENTICE HALL reformat. -->
<!-- 	[1995/06/01  20:52:10  buckler] -->
<!--  -->
<!-- Revision 1.1.4.3  1993/01/29  17:19:31  cjd -->
<!-- 	Embedded copyright notice -->
<!-- 	[1993/01/29  17:03:24  cjd] -->
<!--  -->
<!-- Revision 1.1.4.2  1992/09/01  16:30:40  weir -->
<!-- 	Moved -->
<!-- 	[1992/09/01  16:23:49  weir] -->
<!--  -->
<!-- Revision 1.1.2.2  1992/03/06  16:33:51  steiner -->
<!-- 	replaced commnet leader -->
<!-- 	[1992/03/06  15:49:28  steiner] -->
<!--  -->
<!-- Revision 1.1  1992/01/29  15:41:07  damon -->
<!-- 	Initial revision -->
<!--  -->
<!--  -->
<!--  -->
DCEROOT		= /opt/dcelocal
CC		= /bin/cc
IDL		= idl
LIBDIRS		= -L${DCEROOT}/usr/lib
LIBS		= -ldce
LIBALL		= ${LIBDIRS} ${LIBS}
INCDIRS		= -I. -I${DCEROOT}/usr/include
CFLAGS		= -g ${INCDIRS} 
IDLFLAGS	= -v ${INCDIRS} -cc_cmd "${CC} ${CFLAGS} -c"

all:	greet_client greet_server

greet.h greet_cstub.o greet_sstub.o: greet.idl
	${IDL} ${IDLFLAGS} greet.idl

greet_client:	greet.h greet_client.o util.o greet_cstub.o
	${CC} -o greet_client greet_client.o greet_cstub.o &bsol;
		util.o ${LIBALL}

greet_server:	greet.h greet_server.o greet_manager.o util.o &bsol;
		greet_sstub.o
	${CC} -o greet_server greet_server.o greet_manager.o &bsol;
		greet_sstub.o util.o ${LIBALL}

greet_client.c greet_server.c util.c: util.h
greet_manager.c greet_client.c greet_server.c: greet.h
