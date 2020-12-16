...\"
...\" @OSF_COPYRIGHT@
...\" COPYRIGHT NOTICE
...\" Copyright (c) 1990, 1991, 1992, 1993 Open Software Foundation, Inc.
...\" ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
...\" src directory for the full copyright text.
...\"
...\"
...\" HISTORY
...\" $Log: 3o_example_08.h,v $
...\" Revision 1.1.4.3  1993/01/29  17:19:27  cjd
...\" 	Embedded copyright notice
...\" 	[1993/01/29  17:03:20  cjd]
...\"
...\" Revision 1.1.4.2  1992/09/01  16:30:34  weir
...\" 	Moved
...\" 	[1992/09/01  16:23:44  weir]
...\" 
...\" Revision 1.1.2.2  1992/03/06  16:33:40  steiner
...\" 	replaced comment leader
...\" 	[1992/03/06  15:48:25  steiner]
...\" 
...\" Revision 1.1  1992/01/29  15:40:59  damon
...\" 	Initial revision
...\" 
...\" $EndLog$
...\"
/*
 * util.h
 *
 * Declarations of utility routine(s) shared by "greet" client
 * and server programs.
 */

#define ERROR_CHECK(status, text) \e
    if (status != error_status_ok) error_exit(status, text)

void
error_exit(
    error_status_t status,
    char *text
);
