/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 * 
 */
/*
 * HISTORY
 * $Log: context_server.c,v $
 * Revision 1.1.7.3  1996/02/18  18:25:58  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  17:48:11  marty]
 *
 * Revision 1.1.7.2  1995/12/08  20:54:21  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  20:49:32  root]
 * 
 * Revision 1.1.2.2  1994/10/27  20:06:25  rrizzo
 * 	expand copyright
 * 	[1994/10/27  19:38:48  rrizzo]
 * 
 * Revision 1.1.2.1  1994/10/21  19:09:18  weir
 * 	Submit sample sources (CR 12635)
 * 	[1994/10/21  19:08:10  weir]
 * 
 * $EndLog$
 */
/****************************************************************************/
/* [27.VI.94]                                                               */
/*                                                                          */
/* context_server.c -- initialization for "context" server.                 */
/*                                                                          */
/*                                                                          */
/*                                                                          */
/*                            -77 cols-                                     */
/****************************************************************************/

#include <stdio.h>
#include <malloc.h>
#include <time.h>
#include <pthread.h>
#include <dce/dce_error.h>
#include <dce/rpc.h>
#include <dce/sec_login.h>
#include <dce/keymgmt.h>
#include <dce/uuid.h>

#include "context.h"

#define EXPORT_ENTRY "/.:/sample/context_server_entry"


void print_server_error(char *,
		error_status_t);



/******
*
*
* main -- 
*
*
******/
int
main(
int argc,
char *argv[]
)
{

	unsigned32 status;
	rpc_binding_vector_t *binding_vector;

	printf("context_server: Starting up . . .\n");

	/* Register interface with RPC runtime...                           */
	fprintf(stdout, "context_server: Calling rpc_server_register_if()...\n");
	rpc_server_register_if(
		store_v1_0_s_ifspec,
		NULL,
		NULL,
		&status);
	if (status != error_status_ok)
	{
		print_server_error("rpc_server_register_if()", status);
		return;
	}

	/* Use all protocol sequences that are available...                 */
	fprintf(stdout, "context_server: Calling rpc_server_use_all_protseqs()...\n");
	rpc_server_use_all_protseqs(
		rpc_c_protseq_max_reqs_default,
		&status);
	if (status != error_status_ok)
	{
		print_server_error("rpc_server_use_all_protseqs()", status);
		return;
	}

	/* Get the binding handles generated by the runtime...              */
	fprintf(stdout, "context_server: Calling rpc_server_inq_bindings()...\n");
	rpc_server_inq_bindings(&binding_vector, &status);
	if (status != error_status_ok)
	{
		print_server_error("rpc_server_inq_bindings()", status);
		return;
	}

	/* Register assigned endpoints with endpoint mapper (RPCD)...       */
	fprintf(stdout, "context_server: Calling rpc_ep_register()...\n");
	rpc_ep_register(
		store_v1_0_s_ifspec,
		binding_vector,
		NULL,
		(unsigned_char_p_t) "context server version 1.0",
		&status);
	if (status != error_status_ok)
	{
		print_server_error("rpc_ep_register()", status);
		return;
	}

	/* Export the bindings...                                           */
	fprintf(stdout, "context_server: Calling rpc_ns_binding_export()...\n");
	rpc_ns_binding_export(rpc_c_ns_syntax_default,
		(unsigned_char_t *)EXPORT_ENTRY,
		store_v1_0_s_ifspec,
		binding_vector,
		NULL,
		&status);
	if (status != error_status_ok)
	{
		print_server_error("rpc_ns_binding_export()", status);
		return;
	}

	/* Start listening for calls...                                     */
	printf("context_server: Listening for calls. . .\n");

	rpc_server_listen(rpc_c_listen_max_calls_default, &status);
	if (status != error_status_ok)
	{
		print_server_error("rpc_server_listen()", status);
		return;
	}


}




/*****
*
* print_server_error-- Server version. Prints text associated with
*                      bad status code.
*
*
*****/

void
print_server_error(
char *caller,           /* Routine that received the error.                 */
error_status_t status)  /* Status we want to print the message for.         */
{
	dce_error_string_t error_string;
	int print_status;

	dce_error_inq_text(status, error_string, &print_status);
	fprintf(stderr," Server: %s: %s\n", caller, error_string);

}
