...\"
...\" @OSF_COPYRIGHT@
...\" COPYRIGHT NOTICE
...\" Copyright (c) 1990, 1991, 1992, 1993 Open Software Foundation, Inc.
...\" ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
...\" src directory for the full copyright text.
...\"
...\"
...\" HISTORY
...\" $Log: 3o_example_07.c,v $
...\" Revision 1.1.4.4  1995/06/07  16:47:43  buckler
...\" 	1.1 edits.
...\" 	PRENTICE HALL reformat.
...\" 	[1995/06/01  20:51:58  buckler]
...\"
...\" Revision 1.1.4.3  1993/01/29  17:19:24  cjd
...\" 	Embedded copyright notice
...\" 	[1993/01/29  17:03:16  cjd]
...\" 
...\" Revision 1.1.4.2  1992/09/01  16:30:28  weir
...\" 	Moved
...\" 	[1992/09/01  16:23:39  weir]
...\" 
...\" Revision 1.1.2.2  1992/03/06  16:33:31  steiner
...\" 	replaced comment leader
...\" 	[1992/03/06  15:47:55  steiner]
...\" 
...\" Revision 1.1  1992/01/29  15:40:57  damon
...\" 	Initial revision
...\" 
...\" $EndLog$
...\"
/*
 * util.c
 *
 * Utility routine(s) shared by "greet" client and server programs.
 */

#include <stdio.h>
#include <dce/nbase.h>
#include <dce/dce_error.h>

.nL
.ne 6
void
error_exit(
    error_status_t status,
    char *text
)
{
    unsigned char error_text[100];
    int dummy;

    dce_error_inq_text(status, error_text, &dummy);
    fprintf(stderr, "Error: %s - %s\en", text, error_text);
    exit(1);
}
