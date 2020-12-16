...\"
...\" @OSF_COPYRIGHT@
...\" COPYRIGHT NOTICE
...\" Copyright (c) 1990, 1991, 1992, 1993 Open Software Foundation, Inc.
...\" ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
...\" src directory for the full copyright text.
...\"
...\"
...\" HISTORY
...\" $Log: 3o_example_06.c,v $
...\" Revision 1.1.4.3  1993/01/29  17:19:21  cjd
...\" 	Embedded copyright notice
...\" 	[1993/01/29  17:03:11  cjd]
...\"
...\" Revision 1.1.4.2  1992/09/01  16:30:22  weir
...\" 	Moved
...\" 	[1992/09/01  16:23:34  weir]
...\" 
...\" Revision 1.1.2.2  1992/03/06  16:33:26  steiner
...\" 	replaced comment leader
...\" 	[1992/03/06  15:47:27  steiner]
...\" 
...\" Revision 1.1  1992/01/29  15:40:55  damon
...\" 	Initial revision
...\" 
...\" $EndLog$
...\"
/* 
 * greet_manager.c
 *
 * Implementation of "greet" interface.
 */

#include <stdio.h>
#include "greet.h"

void 
greet(
    handle_t h, 
    idl_char *client_greeting, 
    idl_char *server_reply
)
{
    printf("The client says: %s\en", client_greeting);

    strcpy(server_reply, "Hi, client!");
}
