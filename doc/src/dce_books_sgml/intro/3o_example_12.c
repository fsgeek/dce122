<!--
# @OSF_COPYRIGHT@
# 
# 
# HISTORY
# $Log: 3o_example_12.c,v $
# Revision 1.1.2.2  1996/11/05  20:11:59  weir
# 	Cleaned up history
# 	[1996/11/05  20:11:05  weir]
#
# Revision 1.1.2.1  1996/10/28  19:46:34  wardr
# 	{edit,R1.2.2}
# 	Initial checkin after sgml conversion
# 	[1996/10/28  19:46:06  wardr]
# 
# Revision 1.1.1.2  1996/10/28  19:46:06  wardr
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
<!-- Revision 1.1.4.4  1995/06/07  16:47:46  buckler -->
<!-- 	1.1 edits. -->
<!-- 	PRENTICE HALL reformat. -->
<!-- 	[1995/06/01  20:52:33  buckler] -->
<!--  -->
<!-- Revision 1.1.4.3  1993/01/29  17:19:40  cjd -->
<!-- 	Embedded copyright notice -->
<!-- 	[1993/01/29  17:03:38  cjd] -->
<!--  -->
<!-- Revision 1.1.4.2  1992/09/01  16:32:13  weir -->
<!-- 	Moved -->
<!-- 	[1992/09/01  16:24:03  weir] -->
<!--  -->
<!-- Revision 1.1.2.2  1992/03/06  16:34:08  steiner -->
<!-- 	replaced comment leader -->
<!-- 	[1992/03/06  15:50:56  steiner] -->
<!--  -->
<!-- Revision 1.1  1992/01/29  15:41:09  damon -->
<!-- 	Initial revision -->
<!--  -->
<!--  -->
<!--  -->
/*
 * DCE Example Program Using DFS
 * dfs_greet_server.c
 *
 * The server waits until the client has created a
 * well-known file, then reads the client's message
 * from the file, prints the message, and removed the
 * file.  The server then writes a message for the
 * client into another well-known file.
 */

#include &lt;stdio.h>
#include "dfs_greet.h"

#define S_GREET_TEXT "Hi, client!"

main()
{
	FILE *f;
	size_t ret;
	char s[BUFSIZ];

	while ((f = fopen(C_GREET_FILE, "r")) == NULL)
		sleep(3);
	ret = fread(s, sizeof(char), BUFSIZ, f);
	fclose(f);
	printf("Client says: %s\n", s);
	unlink(C_GREET_FILE);

	f = fopen(S_GREET_FILE, "w");
	ret = fwrite(S_GREET_TEXT, sizeof(S_GREET_TEXT), 1, f);
	fclose(f);
}
