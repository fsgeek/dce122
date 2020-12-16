<!--
# COPYRIGHT NOTICE
# Copyright (c) 1990-1996 Open Software Foundation, Inc. 
# ALL RIGHTS RESERVED (DCE). See the file named COPYRIGHT.DCE in the 
# src directory for the full copyright text. 
# 
# 
# HISTORY
# $Log: sample_client.c,v $
# Revision 1.1.2.3  1996/12/17  20:49:46  damon
# 	Expanded OSF C O P Y R I G H T   N O T I C E
# 	[1996/12/17  20:46:59  damon]
#
# Revision 1.1.2.2  1996/11/21  16:54:32  weir
# 	Minor corrections
# 	[1996/11/21  16:53:58  weir]
# 
# Revision 1.1.2.1  1996/11/21  16:43:09  weir
# 	Initial submission
# 	[1996/11/21  16:42:11  weir]
# 
# $EndLog$
# 
-->
/****************************************************************************/
/* [27.VI.94]                                                               */
/*                                                                          */
/* sample_client.c -- Client of "sample" interface.                         */
/*                                                                          */
/*                                                                          */
/*                                                                          */
/*                            -77 cols-                                     */
/****************************************************************************/



#include &lt;stdio.h&gt;
#include &lt;string.h&gt;
#include &lt;dce/dce_error.h&gt;
#include &lt;dce/nbase.h&gt;
#include &lt;dce/rpc.h&gt;
#include &lt;dce/dce_msg.h&gt; 
#include &lt;dce/dbif.h&gt;
#include &lt;dce/dce.h&gt;
#include &lt;dce/dce_cf.h&gt;
#include &lt;dce/dcesvcmsg.h&gt;
#include &lt;dce/svcremote.h&gt;
#include &lt;dce/sec_login.h&gt;
#include &lt;dce/pgo.h&gt;
#include &lt;dce/secidmap.h&gt;

#include "sample.h"
#include "sample_bind.h"


/* Data structure for holding object entry names...                         */
typedef struct {
	unsigned32 count;
	unsigned_char_t *name[1];
} objectname_vector_t;


/* ANSI-C style prototypes for functions private to this module...          */

int do_client_command_line(int,
		char **,
		unsigned32 *,
		objectname_vector_t *);

boolean32 is_valid_principal(unsigned_char_t *_1,
		unsigned_char_t *_2,
		unsigned32 *_3);

void bind_to_object(unsigned_char_t *,
		rpc_if_handle_t,
		uuid_t *,
		handle_t *,
		uuid_t *,
		uuid_t *,
		unsigned_char_t **,
		unsigned_char_t **,
		error_status_t *);

void print_error(char *_1,
		error_status_t _2);

extern unsigned_char_t *malloc();

#define SGROUP "sample_servers"


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
	rpc_ns_handle_t import_context;  /* Context for importing bindings. */
	rpc_binding_handle_t binding_h;  /* Our binding handle.             */
	error_status_t status;           /* For DCE library error returns.  */
	error_status_t rpc_remote_status; /* For remote error returns.      */
	idl_long_int rpc_status;    /* Application-returned status from re- */
					/*  mote calls.                     */
	unsigned_char_t *string_binding; /* For string binding conversions. */
	unsigned_char_t *server_princ_name;
	handle_t object_handle;     /* For binding we get through junction. */
	uuid_t object_uuid, mgr_uuid;   /* Various UUIDs.                   */
	unsigned_char_t *u_string;      /* For converting UUIDs to strings. */
	objectname_vector_t objectname_vector; /* For entry names read from */
					/*  command line.                   */
	unsigned32 kill_server = FALSE; /* TRUE =&gt; invoker requested "kill  */
					/*  server" option.                 */
	idl_char server_message[TEXT_SIZE]; /* For message string returned  */
					/*  from the server to us.          */
	unsigned_char_t *entry_name = NULL; /* Object entry name from       */
					/*  bind_to_object().               */
	unsigned_char_t *object_name = NULL; /* Residual object name from   */
					/*  bind_to_object().               */


	/* Process the command line...                                      */
	do_client_command_line(argc, argv, &amp;kill_server, &amp;objectname_vector);

	/* Start importing servers. Note that the contents of the environ-  */
	/*  ment variable RPC_DEFAULT_ENTRY are used to determine the entry */
	/*  to import from...                                               */
	fprintf(stdout,
		"sample_client: Calling rpc_ns_binding_import_begin()...&bsol;n");
	rpc_ns_binding_import_begin(
		rpc_c_ns_syntax_default,
		NULL,                         /* Use the RPC_DEFAULT_ENTRY. */
		sample_v1_0_c_ifspec,
		NULL,
		&amp;import_context,
		&amp;status);
	if (status != rpc_s_ok)
	{
		print_error("rpc_ns_binding_import_begin()", status);
		exit(1);
	}

	/* Import the first server (we could iterate here, but we'll just   */
	/*  take the first one)...                                          */
	fprintf(stdout,
		"sample_client: Calling rpc_ns_binding_import_next()...&bsol;n");
	rpc_ns_binding_import_next(import_context, &amp;binding_h, &amp;status);
	if (status != rpc_s_ok)
	{
		print_error("rpc_ns_binding_import_next()", status);
		exit(1);
	}

	/* Free the import context...                                       */
	fprintf(stdout,
		"sample_client: Calling rpc_ns_binding_import_done()...&bsol;n");
	rpc_ns_binding_import_done(&amp;import_context, &amp;status);
	if (status != rpc_s_ok)
	{
		print_error("rpc_ns_binding_import_done()", status);
		exit(1);
	}

	/* Resolve the partial binding...                                   */
	fprintf(stdout,
		"sample_client: Calling rpc_ep_resolve_binding()...&bsol;n");
	rpc_ep_resolve_binding(binding_h,
		sample_v1_0_c_ifspec,
		&amp;status);
	if (status != rpc_s_ok)
	{
		print_error("rpc_ep_resolve_binding()", status);
		exit(1);
	}

	/* Convert the binding to a readable string...                      */
	fprintf(stdout,
		"sample_client: Calling rpc_binding_to_string_binding()...&bsol;n");
	rpc_binding_to_string_binding(binding_h, &amp;string_binding, &amp;status);
	if (status != rpc_s_ok)
	{
		print_error("rpc_binding_to_string_binding()", status);
		exit(1);
	}

	/* Print it...                                                      */
	fprintf(stdout,
		"sample_client: Imported resolved binding == %s&bsol;n",
		string_binding);

	/* Free the string binding space...                                 */
	fprintf(stdout, "sample_client: Calling rpc_string_free()...&bsol;n");
	rpc_string_free(&amp;string_binding, &amp;status);
	if (status != rpc_s_ok)
	{	
		print_error("rpc_string_free()", status);
		exit(1);
	}

	/* Find out what the server's principal name is...                  */
	fprintf(stdout,
		"sample_client: Calling rpc_mgmt_inq_server_princ_name()...&bsol;n");
	rpc_mgmt_inq_server_princ_name(binding_h,
		rpc_c_authn_dce_secret,
		&amp;server_princ_name,
		&amp;status);
	if (status != rpc_s_ok)
	{
		print_error("rpc_mgmt_inq_server_princ_name()", status);
	}
	fprintf(stdout, "sample_client: Principal name returned == %s&bsol;n",
		server_princ_name);

	/* And now find out if it's a valid member of our sample_servers    */
	/*  group...                                                        */
	fprintf(stdout, "sample_client: Calling is_valid_principal()...&bsol;n");
	if (is_valid_principal(server_princ_name, (unsigned_char_t *)SGROUP, &amp;status))
	{
		fprintf(stdout,
			"sample_client: Calling rpc_binding_set_auth_info()...&bsol;n");
		rpc_binding_set_auth_info(binding_h,
			server_princ_name,
			rpc_c_protect_level_pkt_integ,
			rpc_c_authn_dce_secret,
			NULL,
			rpc_c_authz_dce,
			&amp;status);

	}
	if (status != rpc_s_ok)
	{
		print_error("rpc_binding_set_auth_info()", status);
		exit(1);
	}

	/********************************************************************/
	/* Everything's okay, so do some remote stuff. There are currently  */
	/*  two possibilities: Either stop the server via the remote mgmt   */
	/*  interface, or actually bind to an object and call a couple of   */
	/*  remote operations.                                              */

	/* First alternative: Kill the server via the mgmt interface...     */
	if (kill_server)
	{
		fprintf(stdout,
			"sample_client: Kill server option enacted...&bsol;n");
		fprintf(stdout,
			"sample_client: Calling rpc_ep_resolve_binding()...&bsol;n");
		rpc_ep_resolve_binding(binding_h,
			sample_v1_0_c_ifspec,
			&amp;status);
		if (status != rpc_s_ok)
		{
			print_error("rpc_ep_resolve_binding()", status);
			exit(1);
		}

		fprintf(stdout,
			"sample_client: Calling rpc_mgmt_stop_server_listening()...&bsol;n");
		rpc_mgmt_stop_server_listening(binding_h, &amp;status);
		if (status != rpc_s_ok)
		{
			print_error("rpc_mgmt_stop_server_listening()", status);
			exit(1);
		}

	fprintf(stdout, "sample_client: Server successfully killed.&bsol;n&bsol;n");

	}
	/* Second alternative: Do remote operations...                      */
	else
	{
		/* This is a local call...                                  */
		fprintf(stdout,
			"sample_client: Remote call option enacted...&bsol;n");
		fprintf(stdout,
			"sample_client: Preparing to bind to object %s&bsol;n",
			(char *)objectname_vector.name[0]);
		fprintf(stdout,
			"sample_client: Calling bind_to_object()...&bsol;n");
		bind_to_object(
			(unsigned_char_t *)objectname_vector.name[0],
					/* ...Name of object to bind to.    */
			NULL,              /* Interface spec "hint".        */
			NULL,              /* Object UUID "hint".           */
			&amp;object_handle,    /* Here's where binding will be. */
			&amp;object_uuid,  /* Here's where object UUID will be. */
			&amp;mgr_uuid,     /* Type manager UUID will be here.   */
			&amp;entry_name,   /* Full entry name returned here.    */
			&amp;object_name,  /* "Unresolved", i.e. object name.   */
			&amp;status);
		if (status != error_status_ok)
		{
			fprintf(stdout, "Can't bind to object %s&bsol;n",
				objectname_vector.name[0]);
			return;
		}

		/* Display the binding, just for fun...                     */
		fprintf(stdout, "View object %s:&bsol;n",
			(char *)objectname_vector.name[0]);
		fprintf(stdout, "     Via junction: %s&bsol;n     Object name: %s&bsol;n",
			entry_name, object_name);

		/* Convert to string form...                                */
		fprintf(stdout,
			"sample_client: Calling rpc_binding_to_string_binding()...&bsol;n");
		rpc_binding_to_string_binding(object_handle,
					&amp;string_binding,
					&amp;status);
		if (status != rpc_s_ok)
		{
			print_error("rpc_binding_to_string_binding()", status);
			exit(1);
		}

		/* Show it...                                               */
		fprintf(stdout, "     Binding: %s&bsol;n", string_binding);

		/* Now convert the type manager UUID to a string...         */
		fprintf(stdout, "sample_client: Calling uuid_to_string()...&bsol;n");
		uuid_to_string(&amp;mgr_uuid, &amp;u_string, &amp;status);
		if (status != uuid_s_ok)
		{
			print_error("uuid_from_string()", status);
			exit(1);
		}

		/* Show it...                                               */
		fprintf(stdout, "     Manager Type UUID: %s&bsol;n", u_string);

		/* Convert the object UUID to string form...                */
		fprintf(stdout, "sample_client: Calling uuid_to_string()...&bsol;n");
		uuid_to_string(&amp;object_uuid, &amp;u_string, &amp;status);
		if (status != uuid_s_ok)
		{
			print_error("uuid_to_string()", status);
			exit(1);
		}

		/* And show it...                                           */
		fprintf(stdout, "     Object UUID: %s&bsol;n", u_string);

		/* Now free the space...                                    */
		rpc_string_free(&amp;string_binding, &amp;status);
		if (status != rpc_s_ok)
		{
			print_error("rpc_string_free()", status);
			exit(1);
		}
		rpc_string_free(&amp;u_string, &amp;status);
		if (status != rpc_s_ok)
		{
			print_error("rpc_string_free()", status);
			exit(1);
		}

		/* Make call on returned handle to get object data...       */
		fprintf(stdout,
			"sample_client: Calling [remote] sample_get_text()...&bsol;n");
		sample_get_text(object_handle,
				object_uuid,
				server_message,
				&amp;rpc_status,
				&amp;rpc_remote_status);
		fprintf(stdout, "     Object Text: %s&bsol;n", server_message);

		/* Call the sample_call() operation...                      */
		/* First, get rid of the object UUID...                     */
		rpc_binding_set_object(
			binding_h,
			NULL,
			&amp;status);
		if (status != error_status_ok)
		{
			print_error("rpc_binding_set_object()", status);		
			return;
		}

		/* Then display the binding...                              */
		/* Convert to string form...                                */
		fprintf(stdout,
			"sample_client: Calling rpc_binding_to_string_binding()...&bsol;n");
		rpc_binding_to_string_binding(binding_h, &amp;string_binding, &amp;status);
		if (status != rpc_s_ok)
		{
			print_error("rpc_binding_to_string_binding()", status);
			exit(1);
		}

		/* Show it...                                               */
		fprintf(stdout,
			"sample_client: Binding about to be used == %s&bsol;n",
			string_binding);

		/* Free it...                                               */
		rpc_string_free(&amp;string_binding, &amp;status);
		if (status != rpc_s_ok)
		{
			print_error("rpc_string_free()", status);
			exit(1);
		}

		fprintf(stdout,
			"sample_client: Calling [remote] sample_call()...&bsol;n");
		sample_call(binding_h, &amp;rpc_status, &amp;rpc_remote_status);
		if (rpc_remote_status != error_status_ok)
		{
			print_error("sample_call()", rpc_remote_status);
			exit(1);
		}

		fprintf(stdout,
			"sample_client: Remote call option successfully completed.&bsol;n&bsol;n");

	}

	fprintf(stdout, "sample_client: Calling rpc_string_free()...&bsol;n");
	rpc_string_free(&amp;server_princ_name, &amp;status);
	if (status != rpc_s_ok)
	{	
		print_error("rpc_string_free()", status);
		exit(1);
	}

}




/******
 *
 * do_client_command_line -- Get and interpret arguments and options from
 *                    the command line, and do other setup related to the
 *                    command line's contents.
 *
 *    Called from main().
 *
 ******/

int do_client_command_line(
int argc,
char *argv[],
unsigned32 *kill_server,
objectname_vector_t *objectname_vector
)
{
	unsigned32 status;

	/* Check the command line...                                        */

	/* The "Usage" message requires some explanation. There are two     */
	/*  modes for running the client: you can either specify that       */
	/*  the server be killed, or you can specify a single object to     */
	/*  bind to. It is possible that the object name is not a namespace */
	/*  entry (for example, I suppose, if it's the management object,   */
	/*  whatever its name is). That is when things get interesting, be- */
	/*  cause the application in effect implements a junction located   */
	/*  at its server entry in the namespace, and clients are supposed  */
	/*  to be able to bind to objects under the junction. Essentially   */
	/*  this is done as follows. The client tries to bind to the over-  */
	/*  qualified CDS entry formed by concatenating the specified ob-   */
	/*  ject name to the server entry name; it ends up getting a part-  */
	/*  ial binding to (what else?) the server; and it then makes a     */
	/*  call to the remote bind operation with that binding, ostensibly */
	/*  to get the object UUID of the object whose name was specified   */
	/*  (to bind to) when the client was invoked. These objects are     */
	/*  held in a backing store database. The remote call makes its way */
	/*  by the familiar procedure to the server; the name_to_object()   */
	/*  routine then simply looks up the desired object UUID by access- */
	/*  ing the name-indexed backing store. When the remote call com-   */
	/*  pletes, the client finds itself with a full binding and the de- */
	/*  sired object UUID. It is pointed out below that remote calls    */
	/*  are not routed by object UUID, so this is actually useless in   */
	/*  regard to further operations, and can be discarded. Whether     */
	/*  this is the way things ought to be I'm not sure.                */
	/*                                                                  */
	/* If the object binding option is specified, the following things  */
	/*  should happen:                                                  */
	/*                                                                  */
	/*    1. The message "View object &lt;object_name_specified&gt;" is dis-  */
	/*       played.                                                    */
	/*                                                                  */
	/*    2. The message "Via junction: &lt;server_entry&gt;                  */
	/*                    Object name: &lt;object_name&gt;"                   */
	/*       is displayed.                                              */
	/*                                                                  */
	/*    3. The message "Binding: &lt;full_binding_to_object&gt;" is dis-    */
	/*       played.                                                    */
	/*                                                                  */
	/*    4. The message "Manager Type ID: &lt;manager_UUID_string&gt;" is    */
	/*       displayed.                                                 */
	/*                                                                  */
	/*    5. The message "Object ID: &lt;object_UUID_string&gt;" is dis-      */
	/*       played.                                                    */
	/*                                                                  */
	/*    6. The message "Object Text: &lt;text_string&gt;" is displayed.     */
	/*                                                                  */
	/*    7. --And this should be followed by some serviceability in-   */
	/*       formational (soon to be debug) messages, from the server.  */
	/*                                                                  */
	/*  ...This is all assuming, of course, that no errors occur.       */

	fprintf(stdout, "sample_client: Entering do_client_command_line()...&bsol;n");

	if (argc &lt; 2)
	{
		fprintf(stdout, "&bsol;n Usage:&bsol;n");
		fprintf(stdout, "       %s {&lt;object_name&gt; | kill}&bsol;n&bsol;n", argv[0]);
		fprintf(stdout, "Note that the client imports via RPC_DEFAULT_ENTRY!&bsol;n&bsol;n");
		exit(1);
	}

	if ((argc == 2) &amp;&amp; !strcmp("kill", argv[1]))
	{
		fprintf(stdout, "sample_client: Kill server option selected.&bsol;n");
		*kill_server = TRUE;
	}
	else
	{
		fprintf(stdout, "sample_client: Remote call option selected.&bsol;n");

		/* Get the list of object entry names from the command      */
		/*  line...                                                 */
		objectname_vector-&gt;count = 1;
		objectname_vector-&gt;name[0] = (unsigned_char_p_t)malloc(strlen(argv[1]));
		strcpy((char *)objectname_vector-&gt;name[0], argv[1]);
		fprintf(stdout,
			"sample_client: objectname_vector-&gt;name == %s&bsol;n",
			objectname_vector-&gt;name[0]);
	}		

	return 0;
}


/******
 *
 *
 * is_valid_principal -- Find out whether the specified principal is a
 *                       member of the group he's supposed to be.
 *
 *
 ******/

boolean32 is_valid_principal(
unsigned_char_t *princ_name,          /* Full name of principal to test.    */
unsigned_char_t *group,               /* Group we want principal to be in.  */
unsigned32 *status)
{

	unsigned_char_t *local_name;       /* For principal's local name.   */
	char *cell_name;                   /* Local cell name.              */
	sec_rgy_handle_t rhandle;          /* Local registry binding.       */
	boolean32 is_valid;             /* To hold result of registry call. */

	fprintf(stdout, "sample_client: Entering is_valid_principal()...&bsol;n");
	fprintf(stdout, "sample_client: Initial principal name == %s&bsol;n", princ_name);
	fprintf(stdout, "sample_client: Initial group name     == %s&bsol;n", group);

	/* Find out the local cell name...                                  */
	fprintf(stdout, "sample_client: Calling dce_cf_get_cell_name()...&bsol;n");
	dce_cf_get_cell_name(&amp;cell_name, status);
	if (*status != dce_cf_st_ok)
	{
		print_error("dce_cf_get_cell_name()", *status);
		return 0;
	}

	/* Now bind to the local cell registry...                           */
	fprintf(stdout, "sample_client: Calling sec_rgy_site_open()...&bsol;n");
	sec_rgy_site_open(cell_name, &amp;rhandle, status);
	if (*status != error_status_ok)
	{
		free(cell_name);
		print_error("sec_rgy_site_open()", *status);
		return 0;
	}

	/* Free the cellname string space...                                */
	free(cell_name);
	if (*status != rpc_s_ok)
	{
		print_error("free()", *status);
		return 0;
	}

	/* Get the specified principal's local (cell-relative) name...      */
	local_name = malloc(strlen((char *)princ_name));

	fprintf(stdout, "sample_client: Calling sec_id_parse_name()...&bsol;n");
	sec_id_parse_name(rhandle,    /* Handle to the registry server.     */
			princ_name, /* Global (full) name of the principal. */
			NULL, /* Principal's home cell name returned here.  */
			NULL, /* Pointer to UUID of above returned here.    */
			local_name, /* Principal local name returned here.  */
			NULL, /* Pointer to UUID of above returned here.    */
			status);
	if (*status != error_status_ok)
	{
		free(local_name);
		print_error("sec_id_parse_name()", *status);
		return 0;
	}
	else
	{
		fprintf(stdout,
			"sample_client: Full principal name  == %s&bsol;n",
			princ_name);
		fprintf(stdout,
			"sample_client: Local principal name == %s&bsol;n",
			local_name);
	}

	/* And finally, find out from the registry whether that principal   */
	/*  is a valid member of the specified group...                     */
	fprintf(stdout, "sample_client: Calling sec_rgy_pgo_is_member()...&bsol;n");
	is_valid = sec_rgy_pgo_is_member(rhandle,
		sec_rgy_domain_group,
		group,
		local_name,
		status);
	if (*status != error_status_ok)
	{
		free(local_name);
		print_error("sec_rgy_pgo_is_member()", *status);
		return 0;
	}

	/* Free the principal name string area...                           */
	free(local_name);
	return(is_valid);

}


/******
 *
 * bind_to_object -- Local client call to get UUID from object name.
 *
 *   (The real sub-title of this saga seems to be "How to Implement
 *    a Junction".)
 *
 *    Called from main().
 *
 ******/

void bind_to_object(
unsigned_char_t *object_name,   /* The name of the object we're to bind to. */
rpc_if_handle_t if_hint,      /* Interface specification; NULL from main(). */
uuid_t *id_hint,         /* Presumably the object's UUID; NULL from main(). */
rpc_binding_handle_t *binding_h,     /* Binding will be returned here.      */
uuid_t *object_uuid,     /* Object's object UUID will be returned here.     */
uuid_t *mgr_type_uuid, /* Object's type manager UUID will be returned here. */
unsigned_char_t **entry_name, /* Full entry name (?) will be returned here. */
unsigned_char_t **residual,   /* Unresolved (?) name part returned here.    */
error_status_t *status)
{

	unsigned_char_p_t resolved_name = NULL; /* To hold resolved part of */
					/* object name.                     */
	rpc_ns_handle_t import_context;    /* For NSI import operations.    */
	unsigned_char_t *uuid_string;      /* Not used.                     */
	unsigned_char_t *string_binding;   /* Not used.                     */

	fprintf(stdout, "sample_client: Entering bind_to_object()...&bsol;n");

	/* Attempt to resolve the entry (i.e., object) name we were         */
	/*  given. The idea is that we are feeding this routine an over-    */
	/*  qualified name, which it will be able to resolve only to a cer- */
	/*  tain depth. What's left should be only a simple name, i.e. of   */
	/*  the object we want to bind to...                                */
	fprintf(stdout, "sample_client: Object name == %s&bsol;n", object_name);
	fprintf(stdout, "sample_client: Calling rpc_ns_entry_inq_resolution()...&bsol;n");
	rpc_ns_entry_inq_resolution(
		rpc_c_ns_syntax_dce, /* Syntax for object_name.             */
		object_name,         /* Entry name to be resolved.          */
		&amp;resolved_name,  /* Pointer to resolved name returned here. */
		residual, /* Pointer to unresolved name part returned here. */
		status);
	if (*status != rpc_s_ok)
	{
		print_error("rpc_ns_entry_inq_resolution()", *status);
	}
	
	/* Object name only, try default search path... [original note]     */
	/*  (Apparently the assumption is that if we gave an incomplete     */
	/*  name, that must mean that we were passed only a simple object   */
	/*  name, which means that we must try to reconstruct the path to   */
	/*  the "junction"...                                               */
	if (*status == rpc_s_incomplete_name)
	{
		fprintf(stdout,
		"sample_client: Object name only given, trying default search path...&bsol;n");

		/* Make the object name the "residual"...                   */
		*residual = (unsigned_char_t *)malloc(strlen((char *)object_name));
		strcpy((char *)*residual, (char *)object_name);

		/* Try importing from the RPC_DEFAULT_ENTRY, with interface */
		/*  and object UUID specified, if any were given to us      */
		/*  (which they weren't in the original call made from      */
		/*  main())...                                              */
		fprintf(stdout, "sample_client: Calling rpc_ns_binding_import_begin()...&bsol;n");
		rpc_ns_binding_import_begin(
			rpc_c_ns_syntax_default,
			NULL,
			if_hint,
			id_hint,
			&amp;import_context,
			status);

		/* If that didn't succeed, we're at a loss...               */
		if (*status != rpc_s_ok)
		{
			print_error("rpc_ns_binding_import_begin()", *status);
			return;
		}
		fprintf(stdout, "sample_client: Found object.&bsol;n");
	}

	/* We either resolved the name completely, or we resolved every-    */
	/*  thing but the simple object name part. But if the latter is     */
	/*  the case, that's the same thing for us as having a full entry   */
	/*  name to import from, since the whole point of this exercise is  */
	/*  that the object part of the name isn't in the namespace in the  */
	/*  the first place. So...                                          */

	/* Import a binding...                                              */
	else if (*status == rpc_s_partial_results || *status == error_status_ok)
	{
		fprintf(stdout, "sample_client: Binding to resolved name...&bsol;n");
		fprintf(stdout, "sample_client: Calling rpc_ns_binding_import_begin()...&bsol;n");
		rpc_ns_binding_import_begin(
			rpc_c_ns_syntax_default,
			resolved_name, /* This should be a namespace leaf.  */
			if_hint,  /* Interface we were originally given.    */
			id_hint,  /* Object UUID we were originally given.  */
			&amp;import_context,
			status);

		/* If this has failed, one possible reason is that we sup-  */
		/*  plied an id_hint and this wasn't in the junction. We    */
		/*  could try to import with the nil-UUID at this point and */
		/*  then put the id_hint into the returned binding. That    */
		/*  way, we would succeed if the correct UUID was in the    */
		/*  endpoint map. For now, though, we'll just fail.         */
		/*  [--original note]                                       */
		/*                                                          */
		/* Well, it's hard to see what sense the above makes when   */
		/*  the only way this function is ever called is with a     */
		/*  null interface...                                       */
		if (*status != error_status_ok)
		{
			print_error("rpc_ns_binding_import_begin()", *status);
			return;
		}

	}

	fprintf(stdout, "sample_client: Calling rpc_ns_binding_import_next()...&bsol;n");
	rpc_ns_binding_import_next(
		import_context,
		(rpc_binding_handle_t*)binding_h,
		status);
	if (*status != error_status_ok)
	{
		print_error("rpc_ns_binding_import_next()", *status);
		return;
	}

	fprintf(stdout, "sample_client: Calling rpc_ns_binding_import_done()...&bsol;n");
	rpc_ns_binding_import_done(&amp;import_context, status);
	if (*status != error_status_ok)
	{
		print_error("rpc_ns_binding_import_done()", *status);
		return;
	}

	/* We succeeded in importing a (partial) binding. Presumably the    */
	/*  name we successfully used is in resolved_name, but for some     */
	/*  reason he wants to make the following call to get that name.    */
	/*  Note that this is only for the purpose of returning the name    */
	/*  to the caller; we have no further use for it here...            */
	fprintf(stdout, "sample_client: Imported partial binding.&bsol;n");
	fprintf(stdout, "sample_client: Calling rpc_ns_binding_inq_entry_name()...&bsol;n");
	rpc_ns_binding_inq_entry_name(
		(rpc_binding_handle_t)*binding_h, 
		rpc_c_ns_syntax_default,
		entry_name,
		status);
	if (*status != error_status_ok)
	{
		print_error("rpc_ns_binding_inq_entry_name()", *status);
		return;
	}

	/* Note that at this point, we can only assume that the server      */
	/*  has put at least one object UUID in the endpoint map and        */
	/*  the name space. If id_hint was null, we got one of the object   */
	/*  UUIDs from the namespace at random. If id_hint was supplied,    */
	/*  we either got that UUID or failed. If no UUIDs were exported,   */
	/*  then the binding contains none, so when we make the call        */
	/*  we are only guaranteed to get to some server that supports      */
	/*  the sample_bind interface on the bound-to host. It may          */
	/*  well be the wrong one, in which case we will now fail...        */

	/* This is the "remote binding interface" call. What we are hoping  */
	/*  to get from it is the object UUID of the object whose name is   */
	/*  pretending (via a junction) to be in the namespace. These       */
	/*  things, not being in the namespace, are held in a backing store */
	/*  database maintained by the server...                            */
	fprintf(stdout, "sample_client: Calling [remote] rs_bind_to_object()...&bsol;n");
	rs_bind_to_object(
		*binding_h,      /* The partial binding we just got.        */
		*residual,    /* The backing store "key", i.e. object name. */
		object_uuid,     /* To return the object UUID.              */
		mgr_type_uuid,   /* To return the type manager UUID.        */
		status);
	if (*status != error_status_ok)
	{
		print_error("rs_bind_to_object()", *status);
		return;
	}

	/* The binding handle is now fully bound. Our request for the ob-   */
	/*  ject UUID was really only a pretext for doing the namespace     */
	/*  lookup and getting the binding handle completed with a server   */
	/*  endpoint. The object UUID is not used for routing within the    */
	/*  server. So we can now clear out any UUID set by id_hint and re- */
	/*  place it with any type manager UUID returned from the server... */
	fprintf(stdout, "sample_client: Fully bound to object.&bsol;n");
/*	fprintf(stdout, "sample_client: Calling rpc_binding_set_object()...&bsol;n");
	rpc_binding_set_object(
		(rpc_binding_handle_t)*binding_h,
		mgr_type_uuid,
		status);
	if (*status != error_status_ok)
	{
		print_error("rpc_binding_set_object()", *status);		
		return;
	}
*/
	fprintf(stdout, "sample_client: Calling rpc_string_free()...&bsol;n"); 
	rpc_string_free(&amp;resolved_name, status);
	if (*status != error_status_ok)
	{
		print_error("rpc_string_free()", *status);
		return;
	}

}



/******
 *
 * print_error-- Client version. Prints text associated with bad status code.
 *
 *
 *
 ******/

void
print_error(char *caller, /* Routine that received the error.               */
error_status_t status)    /* The status we want to print the message for.   */
{
	dce_error_string_t error_string;
	int print_status;

	dce_error_inq_text(status, error_string, &amp;print_status);
	fprintf(stderr," Client: %s: %s&bsol;n", caller, error_string);
}

