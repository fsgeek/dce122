/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 *
 */
/*
 * HISTORY
 * $Log: expect_comm.h,v $
 * Revision 1.1.2.1  1996/08/09  19:16:30  arvind
 * 	DCE 1.2.2 intermediate drop (post bl3/pre bl4)
 * 	[1996/08/09  18:59:57  arvind]
 *
 * $EndLog$
 */

/* expectcomm.h - public symbols common to both expect.h and expect_tcl.h

Written by: Don Libes, libes@cme.nist.gov, NIST, 12/3/90

Design and implementation of this program was paid for by U.S. tax
dollars.  Therefore it is public domain.  However, the author and NIST
would appreciate credit if this program or parts of it are used.
*/

#ifndef _EXPECT_COMM_H
#define _EXPECT_COMM_H

#include <expect_cf.h>

#include <stdio.h>
#include <setjmp.h>
#include <tcl.h>
#include <tclRegexp.h>

/* prefer varargs (for now) */
#ifdef HAVE_VARARGS_H
#  undef HAVE_STDARG_H
#endif

/* as long as we're including tcl.h, we cannot include varargs/stdargs ourselves */
#if 0 /* AA */

/* prefer varargs (for now) */
#ifdef HAVE_VARARGS_H
#  include <varargs.h>
#endif

#ifdef HAVE_STDARG_H
#    include <stdarg.h>
#endif

#endif /*0 AA*/

/* Much of the following stdarg/prototype support is taken from tcl.h
(7.5) with modifications.  Things originally prefaced with TCL_ were
reprefaced with EXP_ because this file is used by some file that
include tcl.h and other files that don't include tcl.h.  (We can't
simply include tcl.h everywhere, because one of the files is the
Tcl-less Expect library.)  Anyway, this could be used with pre-7.5
Tcl, so we have to have the definitions around in any case.
- Don
*/


/*
 * Definitions that allow Tcl functions with variable numbers of
 * arguments to be used with either varargs.h or stdarg.h.  TCL_VARARGS
 * is used in procedure prototypes.  TCL_VARARGS_DEF is used to declare
 * the arguments in a function definiton: it takes the type and name of
 * the first argument and supplies the appropriate argument declaration
 * string for use in the function definition.  TCL_VARARGS_START
 * initializes the va_list data structure and returns the first argument.  */

/* in Tcl 7.5, Tcl now supplies these definitions */
#if defined(TCL_VARARGS)
#   define EXP_VARARGS		TCL_VARARGS
#   define EXP_VARARGS_DEF	TCL_VARARGS_DEF
#   define EXP_VARARGS_START	TCL_VARARGS_START
#else
	/* Tcl's test for this is simply wrong */
#  if defined(HAVE_STDARG_H)
#   define EXP_VARARGS(type, name) (type name, ...)
#   define EXP_VARARGS_DEF(type, name) (type name, ...)
#   define EXP_VARARGS_START(type, name, list) (va_start(list, name), name)
#  else
#   define EXP_VARARGS(type, name) ()
#   define EXP_VARARGS_DEF(type, name) (va_alist) va_dcl
#   define EXP_VARARGS_START(type, name, list) \
	(va_start(list), va_arg(list, type))
#  endif /* defined(HAVE_STDARG_H) */
#endif /* defined(TCL_VARARGS) */

/*
 * Definitions that allow this header file to be used either with or
 * without ANSI C features like function prototypes.
 */

#if ((defined(__STDC__) || defined(SABER)) && !defined(NO_PROTOTYPE)) || defined(__cplusplus) || defined(USE_PROTOTYPE)
#   define _USING_PROTOTYPES_ 1
#   define EXP_PROTO(x)	x
#else
#   define EXP_PROTO(x)	()
#endif

/* support for Standard C and C++ prototypes */
#ifdef __cplusplus
#  define EXP_PROTOTYPES
#  if !defined(EXP_VARARGS)
#    define EXP_VARARGS	...
#  endif
#else
#  if !defined(EXP_VARARGS)
#  define EXP_VARARGS	, ...
#  endif
#  ifdef __STDC__
#    define EXP_PROTOTYPES
#  endif /*__STDC__*/
#endif /*__cplusplus*/

#ifdef EXP_PROTOTYPES
#  define EXP_PROTO(x)	x
#  ifdef EXP_DEFINE_FNS
     /* when functions are really being defined, we have to use va_alist as arg */
#    define EXP_PROTOV(x)	va_alist
#  else
#    define EXP_PROTOV(x)	x
#  endif /*EXP_DEFINE_FNS*/
#else
#  define EXP_PROTO(x)	()
#  define EXP_PROTOV(x)	()
#endif /*EXP_PROTOTYPES*/

/* Put double parens around macro args so they all look like a single arg */
/* to preprocessor.  That way, don't need a different macro for functions */
/* with a different number of arguments. */

EXTERN int errno;

#ifdef NO_STDLIB_H
#  include <compat/stdlib.h>
#else
#  include <stdlib.h>		/* for malloc */
#endif /*NO_STDLIB_H*/

/* common return codes for Expect functions */
/* The library actually only uses TIMEOUT and EOF */
#define EXP_ABEOF	-1	/* abnormal eof in Expect */
				/* when in library, this define is not used. */
				/* Instead "-1" is used literally in the */
				/* usual sense to check errors in system */
				/* calls */
#define EXP_TIMEOUT	-2
#define EXP_TCLERROR	-3
#define EXP_FULLBUFFER	-5
#define EXP_MATCH	-6
#define EXP_NOMATCH	-7
#define EXP_CANTMATCH	EXP_NOMATCH
#define EXP_CANMATCH	-8
#define EXP_DATA_NEW	-9	/* if select says there is new data */
#define EXP_DATA_OLD	-10	/* if we already read data in another cmd */
#define EXP_EOF		-11
#define EXP_RECONFIGURE	-12	/* changes to indirect spawn id lists */
				/* require us to reconfigure things */

/* in the unlikely event that a signal handler forces us to return this */
/* through expect's read() routine, we temporarily convert it to this. */
#define EXP_TCLRET	-20
#define EXP_TCLCNT	-21
#define EXP_TCLCNTTIMER	-22
#define EXP_TCLBRK	-23
#define EXP_TCLCNTEXP	-24
#define EXP_TCLRETTCL	-25

/* yet more TCL return codes */
/* Tcl does not safely provide a way to define the values of these, so */
/* use ridiculously numbers for safety */
#define EXP_CONTINUE		-101	/* continue expect command */
					/* and restart timer */
#define EXP_CONTINUE_TIMER	-102	/* continue expect command */
					/* and continue timer */
#define EXP_TCL_RETURN		-103	/* converted by interact */
					/* and interpeter from */
					/* inter_return into */
					/* TCL_RETURN*/

#define EXP_TIME_INFINITY	-1
#define EXP_SPAWN_ID_BAD	-1

EXTERN int exp_is_debugging;
EXTERN int exp_loguser;
EXTERN int exp_disconnected;		/* proc. disc'd from controlling tty */

EXTERN void (*exp_close_in_child)();	/* procedure to close files in child */
EXTERN void exp_close_tcl_files();	/* deflt proc: close all Tcl's files */

EXTERN void exp_slave_control EXP_PROTO((int,int));

EXTERN char *exp_pty_error;		/* place to pass a string generated */
					/* deep in the innards of the pty */
					/* code but needed by anyone */

#endif /* _EXPECT_COMM_H */
