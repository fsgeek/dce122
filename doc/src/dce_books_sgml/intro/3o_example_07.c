<!--
# @OSF_COPYRIGHT@
# 
# 
# HISTORY
# $Log: 3o_example_07.c,v $
# Revision 1.1.2.2  1996/11/05  20:11:55  weir
# 	Cleaned up history
# 	[1996/11/05  20:11:01  weir]
#
# Revision 1.1.2.1  1996/10/28  19:46:29  wardr
# 	{edit,R1.2.2}
# 	Initial checkin after sgml conversion
# 	[1996/10/28  19:46:01  wardr]
# 
# Revision 1.1.1.2  1996/10/28  19:46:01  wardr
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
<!-- Revision 1.1.4.4  1995/06/07  16:47:43  buckler -->
<!-- 	1.1 edits. -->
<!-- 	PRENTICE HALL reformat. -->
<!-- 	[1995/06/01  20:51:58  buckler] -->
<!--  -->
<!-- Revision 1.1.4.3  1993/01/29  17:19:24  cjd -->
<!-- 	Embedded copyright notice -->
<!-- 	[1993/01/29  17:03:16  cjd] -->
<!--  -->
<!-- Revision 1.1.4.2  1992/09/01  16:30:28  weir -->
<!-- 	Moved -->
<!-- 	[1992/09/01  16:23:39  weir] -->
<!--  -->
<!-- Revision 1.1.2.2  1992/03/06  16:33:31  steiner -->
<!-- 	replaced comment leader -->
<!-- 	[1992/03/06  15:47:55  steiner] -->
<!--  -->
<!-- Revision 1.1  1992/01/29  15:40:57  damon -->
<!-- 	Initial revision -->
<!--  -->
<!--  -->
<!--  -->
/*
 * util.c
 *
 * Utility routine(s) shared by "greet" client and server programs.
 */

#include &lt;stdio.h>
#include &lt;dce/nbase.h>
#include &lt;dce/dce_error.h>

void
error_exit(
    error_status_t status,
    char *text
)
{
    unsigned char error_text[100];
    int dummy;

    dce_error_inq_text(status, error_text, &amp;dummy);
    fprintf(stderr, "Error: %s - %s&bsol;n", text, error_text);
    exit(1);
}
