
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
 * $Log: server_start.c,v $
 * Revision 1.1.4.2  1996/02/18  00:31:22  marty
 * 	Update OSF copyright years
 * 	[1996/02/17  23:17:12  marty]
 *
 * Revision 1.1.4.1  1995/12/11  15:19:54  root
 * 	Submit
 * 	[1995/12/11  14:33:33  root]
 * 
 * Revision 1.1.2.1  1994/09/28  21:48:23  melman
 * 	moved admin tests to test/functional
 * 	[1994/09/28  21:16:01  melman]
 * 
 * Revision 1.1.2.3  1994/09/16  20:10:53  ganni
 * 	enhancements and cleanup of srvrexec tests
 * 	[1994/09/16  20:09:57  ganni]
 * 
 * Revision 1.1.2.2  1994/08/10  19:22:51  annie
 * 	expand copyright with OSF copyright text
 * 	[1994/08/10  17:17:13  annie]
 * 
 * Revision 1.1.2.1  1994/07/20  19:58:10  ganni
 * 	initial version
 * 	[1994/07/20  19:42:01  ganni]
 * 
 * $EndLog$
 */

/*
** Module: 	server_start.c
**
** FACILITY: 	DCE Host Daemon API
**
** ABSTRACT:	This module implements the tests for dced api 
**		dced_server_start 
**
*/

#include <dtapi_impl.h>
#include <dtapi_1_srvr.h>

/*
 *  Global Declarations.
 */
dced_binding_handle_t   exec_handle;
dced_binding_handle_t   conf_handle;
server_t		server_entry;
boolean32		setup_fail;

void setup(void);
void cleanup(void);
void dced_server_start_1(void);          /* Test purposes 1 */
void dced_server_start_2(void);          /* Test purposes 2 */
void dced_server_start_3(void);          /* Test purposes 3 */

void (*tet_startup)(void) = setup;	/* Load the start routine into TET */
void (*tet_cleanup)(void) = cleanup;	/* Load the clean routine into TET */

struct tet_testlist tet_testlist[] =
{
    { dced_server_start_1,  1 },
    { dced_server_start_2,  2 },
    { dced_server_start_3,  3 },
    { NULL, 0 }
};

void
setup()
{
	error_status_t		st;

	setup_fail=false;
        test_srvrconf_init( &conf_handle, &server_entry, &st);
        if (st != error_status_ok)
		setup_fail=true;
	else
		dced_util_binding_create( SRVREXEC_SVC, &exec_handle, &st);
}

void
cleanup()
{
	error_status_t		st;

	if (!setup_fail)
	{
        	dced_binding_free( exec_handle, &st);
		test_srvrconf_free( &conf_handle, &server_entry, &st);
	}
}

/*
** ROUTINE NAME:
**		dced_server_start_1()
**
** DESCRIPTION:
**		This routine verifies Assertion 01(A) for the function
**		dced_server_start(). 
**
*/
void 
dced_server_start_1()
{
	uuid_t			srvr_proc_id;
        unsigned32              fail_stat;
        server_t		*out_data;
	error_status_t		st;

	tet_infoline("dced_server_start_1, Assertion 01(A):");
	tet_infoline(
	"When a srvrconf dced binding handle is supplied to ");
	tet_infoline(
	"dced_server_start along with the server object,");
	tet_infoline(
	"the server is started and the status is set to error_status_ok.");

	fail_stat = false;

	if (setup_fail)
	{
		tet_result(TET_UNRESOLVED);
		return;
	}

	uuid_create_nil( &srvr_proc_id, &st);
	dced_server_start( conf_handle, 
			   &server_entry.id, 
			   NULL,
			   &srvr_proc_id,
			   &st);
	if (st != error_status_ok)
	{
#ifdef DEBUG
		tet_infoline("dced_server_start failed:");
       		dced_util_printerr(st);
#endif
		tet_result(TET_FAIL);
		fail_stat = true;
	}
	else
	{
        	dced_object_read( exec_handle, &srvr_proc_id,
					(void **)&out_data, &st);
		if (st != error_status_ok)
		{
#ifdef DEBUG
		    tet_infoline("dced_object_read failed:");
		    dced_util_printerr(st);
#endif
		    tet_result(TET_FAIL);
		    fail_stat = true;
		}
		else 
		    print_server_t( (server_t *) out_data);

		if ((!fail_stat) && (!test_api_10(error_status_ok)))
		{
			tet_result( TET_FAIL );
			fail_stat = true;
		}

        	dced_server_stop( exec_handle, &srvr_proc_id, 
				  srvrexec_stop_hard, &st);
		if (st != error_status_ok)
        	{
#ifdef DEBUG
                    tet_infoline("dced_server_stop failed:");
                    dced_util_printerr(st);
#endif
		    tet_result(TET_UNRESOLVED);
		    fail_stat = true;
        	}
        }

	if (fail_stat)
		return;
	tet_result(TET_PASS);
	return;

}
/*
** ROUTINE NAME:
**		dced_server_start_2()
**
** DESCRIPTION:
**		This routine verifies Assertion 02(A) for the function
**		dced_server_start(). 
**
*/
void 
dced_server_start_2()
{
	uuid_t			srvr_proc_id;
	error_status_t		st;

	tet_infoline("dced_server_start_2, Assertion 02(A):");
	tet_infoline(
	"When a srvrexec dced binding handle is supplied to ");
	tet_infoline(
	"dced_server_start, dced_s_bad_binding_status is returned.");

	if (setup_fail)
	{
		tet_result(TET_UNRESOLVED);
		return;
	}

	dced_server_start( exec_handle, 
			   &server_entry.id, 
			   NULL,
			   &srvr_proc_id,
			   &st);
	if (st != dced_s_bad_binding)
	{
#ifdef DEBUG
		tet_infoline("dced_server_start failed:");
		tet_infoline("Expected dced_s_bad_binding_status, Received:");
       		dced_util_printerr(st);
#endif
		tet_result(TET_FAIL);
	}
	else
		tet_result(TET_PASS);

	return;

}


/*
** ROUTINE NAME:
**		dced_server_start_3()
**
** DESCRIPTION:
**		This routine verifies Assertion 03(A) for the function
**		dced_server_start(). 
**
*/
void 
dced_server_start_3()
{
	uuid_t			srvr_id, srvr_proc_id;
	error_status_t		st;

	tet_infoline("dced_server_start_3, Assertion 03(A):");
	tet_infoline(
	"When a srvrconf dced binding handle is supplied to ");
	tet_infoline(
	"dced_server_start along with a non-existant server object id,");
	tet_infoline(
	"dced_s_not_found is returned.");

	if (setup_fail)
	{
		tet_result(TET_UNRESOLVED);
		return;
	}

	uuid_create( &srvr_id, &st);
	dced_server_start( conf_handle, 
			   &srvr_id, 
			   NULL,
			   &srvr_proc_id,
			   &st);
	if (st != dced_s_not_found)
	{
#ifdef DEBUG
		tet_infoline("dced_server_start failed:");
		tet_infoline("Expected dced_s_not_found, Received:");
       		dced_util_printerr(st);
#endif
		tet_result(TET_FAIL);
	}
	else
		tet_result(TET_PASS);

	return;

}



