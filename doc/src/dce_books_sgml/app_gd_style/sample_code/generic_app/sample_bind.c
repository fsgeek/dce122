<!--
# COPYRIGHT NOTICE
# Copyright (c) 1990-1996 Open Software Foundation, Inc. 
# ALL RIGHTS RESERVED (DCE). See the file named COPYRIGHT.DCE in the 
# src directory for the full copyright text. 
# 
# 
# HISTORY
# $Log: sample_bind.c,v $
# Revision 1.1.2.3  1996/12/17  20:49:44  damon
# 	Expanded OSF C O P Y R I G H T   N O T I C E
# 	[1996/12/17  20:46:57  damon]
#
# Revision 1.1.2.2  1996/11/21  16:54:30  weir
# 	Minor corrections
# 	[1996/11/21  16:53:57  weir]
# 
# Revision 1.1.2.1  1996/11/21  16:43:07  weir
# 	Initial submission
# 	[1996/11/21  16:42:09  weir]
# 
# $EndLog$
# 
-->
/****************************************************************************/
/* [27.VI.94]                                                               */
/*                                                                          */
/* sample_bind.c -- The remote binding interface implementation             */
/*                         code.                                            */
/*                                                                          */
/*                                                                          */
/*                                                                          */
/* The code below is built and linked into the server object; meanwhile     */
/* the sample_bind.idl file is processed and the output of that is          */
/* a set of client and server stubs for the implementation. The server stub */
/* is generated with the -no_mepv option, which allows us to call our im-   */
/* plementation by our own names, and explicitly initialize the entry point */
/* vector structure with it (see the end of this file for how that hap-     */
/* pens). The client of course calls the routines by its standard name,     */
/* as generated in the client stub from sample_bind.idl.                    */
/*                                                                          */
/* In order to make the call remotely accessible, the server has to go      */
/* through the steps of registering the sample_bind interface (sep-         */
/* arately from all other interfaces, of course) with the name service,     */
/* and of registering its endpoints with the sample_bind interface (and     */
/* the "sample_bind_epv" vector) with the runtime. Then the client          */
/* has to import bindings to the sample_bind interface separately as        */
/* well. How all this is done can be seen in sample_client.c and            */
/* sample_server.c.                                                         */
/*                                                                          */
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

/* Serviceability sams-generated header files...                            */
#include "dcesmpsvc.h"
#include "dcesmpmsg.h"
#include "dcesmpmac.h"

/* Following is our IDL-generated header...                                 */
#include "sample_bind.h"

#include "sample_server.h"

/* Declaration of the bind interface's routines' entry point vector. The    */
/*  actual addresses are filled in at the bottom of this file...            */
struct sample_bind_v1_0_epv_t	sample_bind_epv;



/******
 *
 * name_to_object -- The remote bind operation implementation code:
 *                   receives a name, returns an object UUID.
 *
 *     Essentially what this routine is is a remote operation that doesn't
 *     actually "do" anything; it just returns a given object's UUID.
 * 
 *
 ******/
void
name_to_object(handle_t binding_h, /* The binding that got us here.         */
unsigned_char_t *component,   /* The backing store's key.                   */
uuid_t *object_uuid,          /* For the UUID we will return.               */
uuid_t *mgr_type_uuid,        /* Type Manager UUID.                         */
unsigned32 *st                /* Status.                                    */
)

{

	dce_error_string_t error_string;
	int print_status;


	*st = error_status_ok;

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_binder, svc_c_debug6,
			"Entering name_to_object()..."));

	if (!component || !*component)
	{
		dce_svc_printf(CANNOT_RESOLVE_NAME_MSG);
		return;
	}

	/* dce_db_fetch_by_name() retrieves data from the string-indexed    */
	/*  backing store identified by the handle parameter, which was     */
	/*  obtained from dce_db_open(). It is a specialized retrieval      */
	/*  routine for backing stores that are indexed by string, as sel-  */
	/*  ected by the db_c_index_by_name bit in the flags parameter to   */
	/*  dce_db_open() when the backing store was created.               */
	/* Here it's the object_uuid that is to be returned...              */
	DCE_SVC_DEBUG((smp_svc_handle, smp_s_binder, svc_c_debug6,
			"Calling dce_db_fetch_by_name()..."));
	dce_db_fetch_by_name(
		db_name,  /* Name-indexed database, globally-known handle.  */
		(char *)component, /* Pointer to the key we're using, i.e.  */
					/*  the name.                       */
		object_uuid, /* What we're hoping to get, i.e. object UUID. */
		st);
	if (*st != error_status_ok)
	{
		dce_error_inq_text(*st, error_string, &amp;print_status);
		dce_svc_printf(BINDER_ERROR_MSG, "dce_db_fetch_by_name()",
				error_string);
		return;
	}

	DCE_SVC_DEBUG((smp_svc_handle, smp_s_binder, svc_c_debug6,
			"Successfully exiting name_to_object()"));
}


/* The bind interface's routines' entry point vector. Here the actual ad-   */
/*  dresses are filled in...                                                */
sample_bind_v1_0_epv_t	sample_bind_epv = {
	name_to_object
};

