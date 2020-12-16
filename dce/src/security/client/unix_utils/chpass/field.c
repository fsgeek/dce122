/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: field.c,v $
 * Revision 1.1.6.2  1996/02/18  00:07:54  marty
 * 	Update OSF copyright years
 * 	[1996/02/17  22:59:02  marty]
 *
 * Revision 1.1.6.1  1995/12/13  16:24:10  root
 * 	Submit
 * 	[1995/12/11  15:13:59  root]
 * 
 * Revision 1.1.4.2  1992/12/29  13:05:05  zeliff
 * 	Embedding copyright notice
 * 	[1992/12/28  20:42:42  zeliff]
 * 
 * Revision 1.1.2.2  1992/07/17  19:00:44  burati
 * 	Integration with DCE
 * 	[1992/07/17  18:49:10  burati]
 * 
 * 	Initial version from BSD4.4
 * 	[1992/07/13  18:54:02  burati]
 * 
 * $EndLog$
 */

/*
 * Copyright (c) 1988 The Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that: (1) source distributions retain this entire copyright
 * notice and comment, and (2) distributions including binaries display
 * the following acknowledgement:  ``This product includes software
 * developed by the University of California, Berkeley and its contributors''
 * in the documentation or other materials provided with the distribution
 * and in all advertising materials mentioning features or use of this
 * software. Neither the name of the University nor the names of its
 * contributors may be used to endorse or promote products derived
 * from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#ifndef lint
static char sccsid[] = "@(#)field.c	5.12 (Berkeley) 6/1/90";
#endif /* not lint */

#include <sys/param.h>
#include <pwd.h>
#include <grp.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <dce/lbase.h>
#include <chpass.h>
#include <pathnames.h>

/* ARGSUSED */
p_login(p, pw, ep)
	char *p;
	struct passwd *pw;
	struct entry *ep;
{
	if (!*p) {
		(void)fprintf(stderr, "chpass: empty login field.\n");
		return(1);
	}
	if (*p == '-') {
		(void)fprintf(stderr,
		    "chpass: login names may not begin with a hyphen.\n");
		return(1);
	}
	if (!(pw->pw_name = strdup(p))) {
		(void)fprintf(stderr, "chpass: can't save entry.\n");
		return(1);
	}
	if (index(p, '.'))
		(void)fprintf(stderr,
		    "chpass: \'.\' is dangerous in a login name.\n");
	for (; *p; ++p)
		if (isupper(*p)) {
			(void)fprintf(stderr,
			    "chpass: upper-case letters are dangerous in a login name.\n");
			break;
		}
	return(0);
}

/* ARGSUSED */
p_passwd(p, pw, ep)
	char *p;
	struct passwd *pw;
	struct entry *ep;
{
	if (!*p)
		pw->pw_passwd = "";	/* "NOLOGIN"; */
	else if (!(pw->pw_passwd = strdup(p))) {
		(void)fprintf(stderr, "chpass: can't save password entry.\n");
		return(1);
	}
	
	return(0);
}

/* ARGSUSED */
p_uid(p, pw, ep)
	register char *p;
	struct passwd *pw;
	struct entry *ep;
{
	int id;

	if (!*p) {
		(void)fprintf(stderr, "chpass: empty uid field.\n");
		return(1);
	}
	if (!isdigit(*p)) {
		(void)fprintf(stderr, "chpass: illegal uid.\n");
		return(1);
	}
	id = atoi(p);
	pw->pw_uid = id;
	return(0);
}

/* ARGSUSED */
p_gid(p, pw, ep)
	register char *p;
	struct passwd *pw;
	struct entry *ep;
{
	struct group *gr;
	int id;

	if (!*p) {
		(void)fprintf(stderr, "chpass: empty gid field.\n");
		return(1);
	}
	if (!isdigit(*p)) {
		if (!(gr = getgrnam(p))) {
			(void)fprintf(stderr,
			    "chpass: unknown group %s.\n", p);
			return(1);
		}
		pw->pw_gid = gr->gr_gid;
		return(0);
	}
	id = atoi(p);
	pw->pw_gid = id;
	return(0);
}

/* ARGSUSED */
p_class(p, pw, ep)
	char *p;
	struct passwd *pw;
	struct entry *ep;
{
	if (!*p)
		pw->pw_class = "";
	else if (!(pw->pw_class = strdup(p))) {
		(void)fprintf(stderr, "chpass: can't save entry.\n");
		return(1);
	}
	
	return(0);
}

/* ARGSUSED */
p_change(p, pw, ep)
	char *p;
	struct passwd *pw;
	struct entry *ep;
{
	if (!atot(p, &pw->pw_change))
		return(0);
	(void)fprintf(stderr, "chpass: illegal date for change field.\n");
	return(1);
}

/* ARGSUSED */
p_expire(p, pw, ep)
	char *p;
	struct passwd *pw;
	struct entry *ep;
{
	if (!atot(p, &pw->pw_expire))
		return(0);
	(void)fprintf(stderr, "chpass: illegal date for expire field.\n");
	return(1);
}

/* ARGSUSED */
p_gecos(p, pw, ep)
	char *p;
	struct passwd *pw;
	struct entry *ep;
{
	if (!*p)
		ep->save = "";
	else if (!(ep->save = strdup(p))) {
		(void)fprintf(stderr, "chpass: can't save entry.\n");
		return(1);
	}
	return(0);
}

/* ARGSUSED */
p_hdir(p, pw, ep)
	char *p;
	struct passwd *pw;
	struct entry *ep;
{
	if (!*p) {
		(void)fprintf(stderr, "chpass: empty home directory field.\n");
		return(1);
	}
	if (!(pw->pw_dir = strdup(p))) {
		(void)fprintf(stderr, "chpass: can't save entry.\n");
		return(1);
	}
	return(0);
}

/* ARGSUSED */
p_shell(p, pw, ep)
	register char *p;
	struct passwd *pw;
	struct entry *ep;
{
	char *t, *ok_shell();

	if (!*p) {
		pw->pw_shell = _PATH_BSHELL;
		return(0);
	}
	/* only admin can change from or to "restricted" shells */
	if (uid && pw->pw_shell && !ok_shell(pw->pw_shell)) {
		(void)fprintf(stderr,
		    "chpass: %s: current shell non-standard.\n", pw->pw_shell);
		return(1);
	}
	if (!(t = ok_shell(p))) {
		if (uid) {
			(void)fprintf(stderr,
			    "chpass: %s: non-standard shell.\n", p);
			return(1);
		}
	}
	else
		p = t;
	if (!(pw->pw_shell = strdup(p))) {
		(void)fprintf(stderr, "chpass: can't save entry.\n");
		return(1);
	}
	return(0);
}
