...\"
...\" @OSF_COPYRIGHT@
...\" COPYRIGHT NOTICE
...\" Copyright (c) 1990, 1991, 1992, 1993 Open Software Foundation, Inc.
...\" ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
...\" src directory for the full copyright text.
...\"
...\"
...\" HISTORY
...\" $Log: 3o_example_04.c,v $
...\" Revision 1.1.4.4  1993/01/29  17:19:16  cjd
...\" 	Embedded copyright notice
...\" 	[1993/01/29  17:03:02  cjd]
...\"
...\" Revision 1.1.4.3  1992/09/01  16:30:10  weir
...\" 	Moved
...\" 	[1992/09/01  16:22:09  weir]
...\" 
...\" Revision 1.1.4.2  1992/08/25  19:57:21  weir
...\" 	1.0.2doc test.
...\" 	[1992/08/25  19:55:34  weir]
...\" 
...\" Revision 1.1.2.2  1992/03/06  16:33:13  steiner
...\" 	replaced comment leader
...\" 	[1992/03/06  15:46:15  steiner]
...\" 
...\" Revision 1.1  1992/01/29  15:40:52  damon
...\" 	Initial revision
...\" 
...\" $EndLog$
...\"
/* 
 * greet_client.c
 *
 * Client of "greet" interface.
 */

#include <stdio.h>
#include <dce/nbase.h>
#include <dce/rpc.h>

#include "greet.h"
#include "util.h"

int
main(
    int argc,
    char *argv[]
)
{
    rpc_ns_handle_t import_context;
    handle_t binding_h;
    error_status_t status;
    idl_char reply[REPLY_SIZE];

    if (argc < 2) {
        fprintf(stderr, "usage: greet_client <CDS pathname>\en");
        exit(1);
    }

    /*
     * Start importing servers using the name specified
     * on the command line.
     */
    rpc_ns_binding_import_begin(
        rpc_c_ns_syntax_default, (unsigned_char_p_t) argv[1], 
            greetif_v1_0_c_ifspec, NULL, &import_context, &status);
    ERROR_CHECK(status, "Can't begin import");

    /*
     * Import the first server (we could interate here,
     * but we'll just take the first one).
     */
    rpc_ns_binding_import_next(import_context, &binding_h, &status);
    ERROR_CHECK(status, "Can't import");

    /*
     * Make the remote call.
     */
    greet(binding_h, (idl_char *) "hello, server", reply);

    printf("The Greet Server said: %s\en", reply);
}
