<!--
# COPYRIGHT NOTICE
# Copyright (c) 1990-1996 Open Software Foundation, Inc. 
# ALL RIGHTS RESERVED (DCE). See the file named COPYRIGHT.DCE in the 
# src directory for the full copyright text. 
# 
# 
# HISTORY
# $Log: sample_manager.c,v $
# Revision 1.1.2.3  1996/12/17  20:49:50  damon
# 	Expanded OSF C O P Y R I G H T   N O T I C E
# 	[1996/12/17  20:47:02  damon]
#
# Revision 1.1.2.2  1996/11/21  16:54:35  weir
# 	Minor corrections
# 	[1996/11/21  16:54:01  weir]
# 
# Revision 1.1.2.1  1996/11/21  16:43:13  weir
# 	Initial submission
# 	[1996/11/21  16:42:13  weir]
# 
# $EndLog$
# 
-->
/****************************************************************************/
/* [27.VI.94]                                                               */
/*                                                                          */
/* sample_manager.c -- Implementation of "sample" interface.                */
/*                                                                          */
/*   Routines in this file consist only of remote calls or routines that    */
/*    are internal to those calls.                                          */
/*                                                                          */
/*                                                                          */
/*                            -77 cols-                                     */
/****************************************************************************/

#define DCE_DEBUG


#include &lt;stdio.h&gt;
#include &lt;malloc.h&gt;
#include &lt;time.h&gt;
#include &lt;pthread.h&gt;
#include &lt;errno.h&gt;
#include &lt;unistd.h&gt;
#include &lt;signal.h&gt;
#include &lt;sys/param.h&gt;

#include &lt;dce/nbase.h&gt;
#include &lt;dce/dce.h&gt;
#include &lt;dce/dce_cf.h&gt;
#include &lt;dce/dce_error.h&gt;
#include &lt;dce/rpc.h&gt;
#include &lt;dce/sec_login.h&gt;
#include &lt;dce/keymgmt.h&gt;
#include &lt;dce/uuid.h&gt;
#include &lt;dce/exc_handling.h&gt;
#include &lt;dce/dce_msg.h&gt; 
#include &lt;dce/dbif.h&gt;
#include &lt;dce/aclif.h&gt;
#include &lt;dce/dceacl.h&gt;
#include &lt;dce/pgo.h&gt;

#include &lt;dce/dcesvcmsg.h&gt;
#include &lt;dce/svcremote.h&gt;

#include "dcesmpsvc.h"
#include "dcesmpmsg.h"
#include "dcesmpmac.h"

#include "sample.h"
#include "sample_db.h"
#include "sample_bind.h"
#include "sample_server.h"

void sample_call(rpc_binding_handle_t,
		idl_long_int *,
		error_status_t *);

void sample_get_text(rpc_binding_handle_t,
		uuid_t,
		idl_char *,
		idl_long_int *,
		error_status_t *);

void sample_put_text(rpc_binding_handle_t,
		uuid_t,
		idl_char *,
		idl_long_int *,
		error_status_t *);

void print_manager_error(char *,
		error_status_t);



/******
 *
 * sample_call -- It don't do too much right now...
 *
 *
 *
 *
 ******/
/****************************************************************************/
void 
sample_call(
	rpc_binding_handle_t binding,       /* Client binding.              */
	idl_long_int *status,
	error_status_t *remote_status)
{

	extern uuid_t sample_acl_mgr_uuid, sample_acl_uuid;
	boolean32 authorized = 0;
/****************************************************************************/
	/* We have to explicitly initialize the remote status value;        */
	/*  otherwise, if no error occurs in the transmission (which        */
	/*  would cause the runtime to assign an error value to this        */
	/*  variable), its value will be whatever it happened to be         */
	/*  when the RPC was made by the client...                          */
	*remote_status = rpc_s_ok;

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Entering sample_call()..."));

	/* Check whether client is authorized or not...                     */
	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Calling dce_acl_is_client_authorized()..."));
	dce_acl_is_client_authorized(
		binding,          /* Client's binding handle.               */
		&amp;sample_acl_mgr_uuid,    /* ACL manager type UUID.          */
		&amp;sample_acl_uuid,        /* The ACL UUID.                   */
		NULL,                   /*         Pointer to owner's UUID. */
		NULL,                   /* Pointer to owner's group's UUID. */
		sec_acl_perm_read,      /* The desired privileges.          */
		&amp;authorized,            /* Will be TRUE or FALSE on return. */
		remote_status);

	if (*remote_status != error_status_ok)
	{
		print_manager_error("dce_acl_is_client_authorized()",
					*remote_status);
		return;
	}


	if (authorized)
	{
		DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug8,
				"Call authorized"));

		/* HERE'S WHERE WE SHOULD ACTUALLY DO SOMETHING!            */

	*status = error_status_ok;
	}
	else
	{
		DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug8,
				"Call not authorized"));

		/* Return no_permissions status to client...                */
		*status = no_permissions;
	}

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Successfully exiting sample_call()"));

}



/******
 *
 * sample_get_text -- Extracts and returns an object's text information.
 *
 * 
 *    Called from the client using its "object-bound" handle.
 *
 ******/
void sample_get_text(
rpc_binding_handle_t h,         /* Client binding handle passed into the    */
				/*  server stub. sec_acl_bind() is used to  */
				/*  create this handle.                     */
uuid_t object_uuid,             /* Desired object's UUID.                   */
idl_char text[TEXT_SIZE],       /* To return extracted text information.    */
idl_long_int *status,
error_status_t *remote_st       /* To return status.                        */
)
{

	/* Our backing store data type. For a full explanation, see the     */
	/*  body of sample_resolve_by_name(), in sample_server.c.           */
	sample_data_t data;

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Entering sample_get_text()..."));

	*remote_st = rpc_s_ok;

	/* Get the object's data header...                                  */
	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Calling dce_db_fetch_by_uuid()..."));
	dce_db_fetch_by_uuid(db_object, &amp;object_uuid, (void *)&amp;data, remote_st);
	if (*remote_st != error_status_ok)
	{
		dce_svc_printf(OBJECT_NOT_FOUND_MSG);
 		return;
	}

	/* Copy the text, if any, into the return parameter...              */
	if (data.s_data.message)
	{
		DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug8,
				"Text exists"));
		strcpy(text, data.s_data.message);
	}
	else
	{
		DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug8,
				"No text"));
		strcpy(text, "-No text-");
	}

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug8,
			"Recovered text == %s", data.s_data.message));
	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug8,
			"Message == %s", text));

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Successfully exiting sample_get_text()"));

}




/******
 *
 * sample_put_text -- Puts some text information "into" an object.
 *
 * 
 *    Not called from anywhere.
 *
 ******/

void sample_put_text(
rpc_binding_handle_t h,         /* Client binding handle passed into the    */
				/*  server stub. sec_acl_bind() is used to  */
				/*  create this handle.                     */
uuid_t object_uuid,             /* Desired object's UUID.                   */
idl_char text[TEXT_SIZE],	/* Text information to put.                 */
idl_long_int *status,
error_status_t *remote_st       /* To return status.                        */
)
{

	/* Our backing store data type. For a full explanation, see the     */
	/*  body of sample_resolve_by_name(), in sample_server.c. See also  */
	/*  the contents of sample_db.idl.                                  */
	sample_data_t data;

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Entering sample_put_text()..."));

	*remote_st = rpc_s_ok;

	/* Get the object's data header...                                  */
	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Calling dce_db_fetch_by_uuid()..."));
	dce_db_fetch_by_uuid(db_object, &amp;object_uuid, (void *)&amp;data, remote_st);
	if (*remote_st != error_status_ok)
	{
		dce_svc_printf(OBJECT_NOT_FOUND_MSG);
		return;
	}

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug8,
			"Storing text in object database"));

	/* Now insert the text and stick it back in the backing store...    */
	strcpy(data.s_data.message, text);
	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Calling dce_db_store_by_uuid()..."));
	dce_db_store_by_uuid(db_object, &amp;object_uuid, (void *)&amp;data, remote_st);

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_manager, svc_c_debug6,
			"Successfully exiting sample_put_text()"));

}



/******
 *
 * print_manager_error-- Manager version. Prints text associated with bad
 *                       status code.
 *
 *
 ******/
void
print_manager_error(
char *caller,  /* String identifying the routine that received the error.   */
error_status_t status) /* the status we want to print the message for.      */
{
	dce_error_string_t error_string;
	int print_status;

	dce_error_inq_text(status, error_string, &amp;print_status);
	dce_svc_printf(MANAGER_ERROR_MSG, caller, error_string);

}

