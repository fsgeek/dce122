<!--
# @OSF_COPYRIGHT@
# 
# 
# HISTORY
# $Log: 3o_example_11.c,v $
# Revision 1.1.2.2  1996/11/05  20:11:59  weir
# 	Cleaned up history
# 	[1996/11/05  20:11:04  weir]
#
# Revision 1.1.2.1  1996/10/28  19:46:33  wardr
# 	{edit,R1.2.2}
# 	Initial checkin after sgml conversion
# 	[1996/10/28  19:46:04  wardr]
# 
# Revision 1.1.1.2  1996/10/28  19:46:04  wardr
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
<!-- Revision 1.1.4.4  1995/06/07  16:47:45  buckler -->
<!-- 	1.1 edits. -->
<!-- 	PRENTICE HALL reformat. -->
<!-- 	[1995/06/01  20:52:21  buckler] -->
<!--  -->
<!-- Revision 1.1.4.3  1993/01/29  17:19:37  cjd -->
<!-- 	Embedded copyright notice -->
<!-- 	[1993/01/29  17:03:33  cjd] -->
<!--  -->
<!-- Revision 1.1.4.2  1992/09/01  16:32:07  weir -->
<!-- 	Moved -->
<!-- 	[1992/09/01  16:23:58  weir] -->
<!--  -->
<!-- Revision 1.1.2.2  1992/03/06  16:34:02  steiner -->
<!-- 	replaced comment leader -->
<!-- 	[1992/03/06  15:50:32  steiner] -->
<!--  -->
<!-- Revision 1.1  1992/01/29  15:41:03  damon -->
<!-- 	Initial revision -->
<!--  -->
<!--  -->
<!--  -->
/*
 * DCE Program Example Using DFS
 * dfs_greet_client.c
 *
 * The client writes a message for the server into
 * a well-known file.  It waits until the server has
 * created its own well-known file, then reads the
 * server's message from the file, prints it, and
 * deletes the file.
 */

#include &lt;stdio.h>
#include "dfs_greet.h"

#define C_GREET_TEXT "Hi, server!"

main()
{
	FILE *f;
	size_t ret;
	char s[BUFSIZ];

	f = fopen(C_GREET_FILE, "w");
	ret = fwrite(C_GREET_TEXT, sizeof(C_GREET_TEXT), 1, f);
	fclose(f);
	while ((f = fopen(S_GREET_FILE, "r")) == NULL)
		sleep(3);
	ret = fread(s, sizeof(char), BUFSIZ, f);
	fclose(f);
	printf("Server says: %s\n", s);
	unlink(S_GREET_FILE);
}
