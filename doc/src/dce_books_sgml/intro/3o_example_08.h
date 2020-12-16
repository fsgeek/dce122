<!--
# @OSF_COPYRIGHT@
# 
# 
# HISTORY
# $Log: 3o_example_08.h,v $
# Revision 1.1.2.2  1996/11/05  20:11:56  weir
# 	Cleaned up history
# 	[1996/11/05  20:11:02  weir]
#
# Revision 1.1.2.1  1996/10/28  19:46:30  wardr
# 	{edit,R1.2.2}
# 	Initial checkin after sgml conversion
# 	[1996/10/28  19:46:02  wardr]
# 
# Revision 1.1.1.2  1996/10/28  19:46:02  wardr
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
<!-- Revision 1.1.4.3  1993/01/29  17:19:27  cjd -->
<!-- 	Embedded copyright notice -->
<!-- 	[1993/01/29  17:03:20  cjd] -->
<!--  -->
<!-- Revision 1.1.4.2  1992/09/01  16:30:34  weir -->
<!-- 	Moved -->
<!-- 	[1992/09/01  16:23:44  weir] -->
<!--  -->
<!-- Revision 1.1.2.2  1992/03/06  16:33:40  steiner -->
<!-- 	replaced comment leader -->
<!-- 	[1992/03/06  15:48:25  steiner] -->
<!--  -->
<!-- Revision 1.1  1992/01/29  15:40:59  damon -->
<!-- 	Initial revision -->
<!--  -->
<!--  -->
<!--  -->
/*
 * util.h
 *
 * Declarations of utility routine(s) shared by "greet" client
 * and server programs.
 */

#define ERROR_CHECK(status, text) &bsol;
    if (status != error_status_ok) error_exit(status, text)

void
error_exit(
    error_status_t status,
    char *text
);
