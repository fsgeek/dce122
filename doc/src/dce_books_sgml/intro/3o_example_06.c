<!--
# @OSF_COPYRIGHT@
# 
# 
# HISTORY
# $Log: 3o_example_06.c,v $
# Revision 1.1.2.2  1996/11/05  20:11:55  weir
# 	Cleaned up history
# 	[1996/11/05  20:11:00  weir]
#
# Revision 1.1.2.1  1996/10/28  19:46:28  wardr
# 	{edit,R1.2.2}
# 	Initial checkin after sgml conversion
# 	[1996/10/28  19:46:00  wardr]
# 
# Revision 1.1.1.2  1996/10/28  19:46:00  wardr
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
<!-- Revision 1.1.4.3  1993/01/29  17:19:21  cjd -->
<!-- 	Embedded copyright notice -->
<!-- 	[1993/01/29  17:03:11  cjd] -->
<!--  -->
<!-- Revision 1.1.4.2  1992/09/01  16:30:22  weir -->
<!-- 	Moved -->
<!-- 	[1992/09/01  16:23:34  weir] -->
<!--  -->
<!-- Revision 1.1.2.2  1992/03/06  16:33:26  steiner -->
<!-- 	replaced comment leader -->
<!-- 	[1992/03/06  15:47:27  steiner] -->
<!--  -->
<!-- Revision 1.1  1992/01/29  15:40:55  damon -->
<!-- 	Initial revision -->
<!--  -->
<!--  -->
<!--  -->
/* 
 * greet_manager.c
 *
 * Implementation of "greet" interface.
 */

#include &lt;stdio.h>
#include "greet.h"

void 
greet(
    handle_t h, 
    idl_char *client_greeting, 
    idl_char *server_reply
)
{
    printf("The client says: %s&bsol;n", client_greeting);

    strcpy(server_reply, "Hi, client!");
}
