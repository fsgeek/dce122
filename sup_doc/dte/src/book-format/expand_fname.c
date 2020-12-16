/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: expand_fname.c,v $
 * Revision 1.1.2.5  1994/06/23  19:48:33  fred
 * 	free copyright
 * 	[1994/06/23  19:41:44  fred]
 *
 * Revision 1.1.2.4  1994/06/23  18:37:26  fred
 * 	free copyright
 * 	[1994/06/22  15:28:29  fred]
 * 
 * Revision 1.1.2.3  1993/04/10  01:03:04  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:10  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:35:58  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:33:36  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/expand_fname.c,v 1.1.2.5 1994/06/23 19:48:33 fred Exp $";
#endif

/* ______________________________________________________________________
 *
 *  This is used to expand filenames.  The DTE doesn't need it, but can
 *  use it for some fancier operations.
 * ______________________________________________________________________
 */
/*
 * Copyright (c) 1989 The Regents of the University of California.
 * All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Guido van Rossum.
 *
 * Redistribution and use in source and binary forms are permitted provided
 * that: (1) source distributions retain this entire copyright notice and
 * comment, and (2) distributions including binaries display the following
 * acknowledgement:  ``This product includes software developed by the
 * University of California, Berkeley and its contributors'' in the
 * documentation or other materials provided with the distribution and in
 * all advertising materials mentioning features or use of this software.
 * Neither the name of the University nor the names of its contributors may
 * be used to endorse or promote products derived from this software without
 * specific prior written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#if defined(LIBC_SCCS) && !defined(lint)
static char sccsid[] = "@(#)glob.c	5.3 (Berkeley) 6/23/90";
#endif /* LIBC_SCCS and not lint */

/*
 * Glob: the interface is a superset of the one defined in POSIX 1003.2,
 * draft 9.
 *
 * The [!...] convention to negate a range is supported (SysV, Posix, ksh).
 *
 * Optional extra services, controlled by flags not defined by POSIX:
 *	GLOB_QUOTE: escaping convention: \ inhibits any special meaning
		the following character might have (except \ at end of
 *		string is kept);
 */

#include <sys/param.h>
#include <sys/stat.h>
#include <dirent.h>
/*#include <glob.h>*/
#include <ctype.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

/* __________________________________________________________________ */
/*  This stuff is from <glob.h>.  I am inserting it in-line for
 *  convenience.  This is intended to be self-contained.
 */

typedef struct {
	int gl_pathc;		/* count of paths matching pattern */
	int gl_offs;		/* reserved at beginning of gl_pathv */
	int gl_flags;		/* copy of flags parameter to glob() */
	int (*gl_errfunc)();	/* copy of errfunc parameter to glob() */
	char **gl_pathv;	/* list of paths matching pattern */
} glob_t;

#define	GLOB_ERR	0x01	/* return on error */
#define	GLOB_MARK	0x02	/* append / to matching directories */
#define	GLOB_NOSORT	0x04	/* don't sort */
#define	GLOB_NOCHECK	0x08	/* return pattern itself if nothing matches */
#define	GLOB_DOOFFS	0x10	/* use gl_offs */
#define	GLOB_APPEND	0x20	/* append to output from previous call */

/*#ifndef _POSIX_SOURCE*/
#define	GLOB_QUOTE	0x40	/* quote special chars with \ */
/*#endif*/

#define	GLOB_NOSPACE	(-1)	/* malloc call failed */
#define	GLOB_ABEND	(-2)	/* unignored error */

void globfree();

/* __________________________________________________________________ */

char *malloc(), *realloc();

typedef int bool_t;

#define	DOLLAR		'$'
#define	DOT		'.'
#define	EOS		'\0'
#define	LBRACKET	'['
#define	NOT		'!'
#define	QUESTION	'?'
#define	QUOTE		'\\'
#define	RANGE		'-'
#define	RBRACKET	']'
#define	SEP		'/'
#define	STAR		'*'
#define	TILDE		'~'
#define	UNDERSCORE	'_'

#define	METABIT		0x80
#define	META(c)		((c)|METABIT)
#define	M_ALL		META('*')
#define	M_END		META(']')
#define	M_NOT		META('!')
#define	M_ONE		META('?')
#define	M_RNG		META('-')
#define	M_SET		META('[')
#define	ismeta(c)	(((c)&METABIT) != 0)

static
compare(p, q)
	void **p, **q;
{
	return(strcmp(*(char **)p, *(char **)q));
}


/*
 * The main glob() routine: compiles the pattern (optionally processing
 * quotes), calls glob1() to do the real pattern matching, and finally
 * sorts the list (unless unsorted operation is requested).  Returns 0
 * if things went well, nonzero if errors occurred.  It is not an error
 * to find no matches.
 */
glob(pattern, flags, errfunc, pglob)
	char *pattern;
	int flags, (*errfunc)();
	glob_t *pglob;
{
	int err, oldpathc;
	char *bufnext, *bufend, *compilebuf, *compilepat, *patnext;
	char c, patbuf[MAXPATHLEN+1];

	patnext = pattern;
	if (!(flags & GLOB_APPEND)) {
		pglob->gl_pathc = 0;
		pglob->gl_pathv = NULL;
		if (!(flags & GLOB_DOOFFS))
			pglob->gl_offs = 0;
	}
	pglob->gl_flags = flags;
	pglob->gl_errfunc = errfunc;
	oldpathc = pglob->gl_pathc;

	bufnext = patbuf;
	bufend = bufnext+MAXPATHLEN;

	compilebuf = bufnext;
	compilepat = patnext;
	while (bufnext < bufend && (c = *patnext++) != EOS) {
		switch (c) {
		case LBRACKET:
			c = *patnext;
			if (c == NOT)
				++patnext;
			if (*patnext == EOS ||
			    strchr(patnext+1, RBRACKET) == NULL) {
				*bufnext++ = LBRACKET;
				if (c == NOT)
					--patnext;
				break;
			}
			*bufnext++ = M_SET;
			if (c == NOT)
				*bufnext++ = M_NOT;
			c = *patnext++;
			do {
				/* todo: quoting */
				*bufnext++ = c;
				if (*patnext == RANGE &&
				    (c = patnext[1]) != RBRACKET) {
					*bufnext++ = M_RNG;
					*bufnext++ = c;
					patnext += 2;
				}
			} while ((c = *patnext++) != RBRACKET);
			*bufnext++ = M_END;
			break;
		case QUESTION:
			*bufnext++ = M_ONE;
			break;
		case QUOTE:
			if (!(flags & GLOB_QUOTE))
				*bufnext++ = QUOTE;
			else {
				if ((c = *patnext++) == EOS) {
					c = QUOTE;
					--patnext;
				}
				*bufnext++ = c;
			}
			break;
		case STAR:
			*bufnext++ = M_ALL;
			break;
		default:
			*bufnext++ = c;
			break;
		}
	}
	*bufnext = EOS;

	if ((err = glob1(patbuf, pglob)) != 0)
		return(err);

	if (pglob->gl_pathc == oldpathc && flags & GLOB_NOCHECK) {
		if (!(flags & GLOB_QUOTE))
			(void)strcpy(compilebuf, compilepat);
		else {
			/*
			 * copy pattern, interpreting quotes; this is slightly
			 * different than the interpretation of quotes above
			 * -- which should prevail?
			 */
			while (*compilepat != EOS) {
				if (*compilepat == QUOTE) {
					if (*++compilepat == EOS)
						--compilepat;
				}
				*compilebuf++ = *compilepat++;
			}
			*compilebuf = EOS;
		}
		return(globextend(patbuf, pglob));
	} else if (!(flags & GLOB_NOSORT))
		qsort((char*) (pglob->gl_pathv + pglob->gl_offs + oldpathc),
		    pglob->gl_pathc - oldpathc, sizeof(char*), compare);
	return(0);
}

static
glob1(pattern, pglob)
	char *pattern;
	glob_t *pglob;
{
	char pathbuf[MAXPATHLEN+1];

	/*
	 * a null pathname is invalid -- POSIX 1003.1 sect. 2.4. */
	if (*pattern == EOS)
		return(0);
	return(glob2(pathbuf, pathbuf, pattern, pglob));
}

/*
 * functions glob2 and glob3 are mutually recursive; there is one level
 * of recursion for each segment in the pattern that contains one or
 * more meta characters.
 */
static
glob2(pathbuf, pathend, pattern, pglob)
	char *pathbuf, *pathend, *pattern;
	glob_t *pglob;
{
	struct stat sbuf;
	bool_t anymeta = 0;
	char *p, *q;

	/*
	 * loop over pattern segments until end of pattern or until
	 * segment with meta character found.
	 */
	for (;;) {
		if (*pattern == EOS) {		/* end of pattern? */
			*pathend = EOS;
			if (stat(pathbuf, &sbuf) != 0)
				return(0);	/* need error call here? */
			if ((pglob->gl_flags & GLOB_MARK) &&
			    pathend[-1] != SEP && S_ISDIR(sbuf.st_mode)) {
				*pathend++ = SEP;
				*pathend = EOS;
			}
			return(globextend(pathbuf, pglob));
		}

		/* find end of next segment, copy tentatively to pathend */
		q = pathend;
		p = pattern;
		while (*p != EOS && *p != SEP) {
			if (ismeta(*p))
				anymeta = 1;
			*q++ = *p++;
		}

		if (!anymeta) {		/* no expansion, do next segment */
			pathend = q;
			pattern = p;
			while (*pattern == SEP)
				*pathend++ = *pattern++;
		} else			/* need expansion, recurse */
			return(glob3(pathbuf, pathend, pattern, p, pglob));
	}
	/* NOTREACHED */
}

static
glob3(pathbuf, pathend, pattern, restpattern, pglob)
	char *pathbuf, *pathend, *pattern, *restpattern;
	glob_t *pglob;
{
	extern int errno;
	DIR *dirp;
	struct dirent *dp;
	int len, err;

	*pathend = EOS;
	errno = 0;
	if (!(dirp = opendir(pathbuf)))
		/* todo: don't call for ENOENT or ENOTDIR? */
		if (pglob->gl_errfunc &&
		    (*pglob->gl_errfunc)(pathbuf, errno) ||
		    (pglob->gl_flags & GLOB_ERR))
			return(GLOB_ABEND);
		else
			return(0);

	err = 0;

	/* search directory for matching names */
	while ((dp = readdir(dirp))) {
		/* initial DOT must be matched literally */
		if (dp->d_name[0] == DOT && *pattern != DOT)
			continue;
		if (!match(dp->d_name, pattern, restpattern))
			continue;
		len = dp->d_namlen;
		(void)strcpy(pathend, dp->d_name);
		err = glob2(pathbuf, pathend+len, restpattern, pglob);
		if (err)
			break;
	}
	/* todo: check error from readdir? */
	(void)closedir(dirp);
	return(err);
}


/*
 * Extend the gl_pathv member of a glob_t structure to accomodate a new item,
 * add the new item, and update gl_pathc.
 *
 * This assumes the BSD realloc, which only copies the block when its size
 * crosses a power-of-two boundary; for v7 realloc, this would cause quadratic
 * behavior.
 *
 * Return 0 if new item added, error code if memory couldn't be allocated.
 *
 * Invariant of the glob_t structure:
 *	Either gl_pathc is zero and gl_pathv is NULL; or gl_pathc > 0 and
 *	 gl_pathv points to (gl_offs + gl_pathc + 1) items.
 */
static
globextend(path, pglob)
	char *path;
	glob_t *pglob;
{
	register char **pathv;
	register int i;
	u_int copysize, newsize;
	char *copy;

	newsize = sizeof(*pathv) * (2 + pglob->gl_pathc + pglob->gl_offs);
	pathv = (char **)realloc((char *)(pathv = pglob->gl_pathv), newsize);
	if (pathv == NULL)
		return(GLOB_NOSPACE);

	if (pglob->gl_pathv == NULL && pglob->gl_offs > 0) {
		/* first time around -- clear initial gl_offs items */
		pathv += pglob->gl_offs;
		for (i = pglob->gl_offs; --i >= 0; )
			*--pathv = NULL;
	}
	pglob->gl_pathv = pathv;

	copysize = strlen(path) + 1;
	if ((copy = malloc(copysize)) != NULL) {
		(void)strcpy(copy, path);
		pathv[pglob->gl_offs + pglob->gl_pathc++] = copy;
	}
	pathv[pglob->gl_offs + pglob->gl_pathc] = NULL;
	return((copy == NULL) ? GLOB_NOSPACE : 0);
}


/*
 * pattern matching function for filenames.  Each occurrence of the *
 * pattern causes a recursion level.
 */
static bool_t
match(name, pat, patend)
	register char *name, *pat, *patend;
{
	bool_t ok, negate_range;
	char c, k;

	while (pat < patend) {
		c = *pat++;
		switch (c & 0xff) {
		case M_ALL:
			if (pat == patend)
				return(1);
			for (; *name != EOS; ++name) {
				if (match(name, pat, patend))
					return(1);
			}
			return(0);
		case M_ONE:
			if (*name++ == EOS)
				return(0);
			break;
		case M_SET:
			ok = 0;
			k = *name++;
			if (negate_range = (*pat & 0xff) == M_NOT)
				++pat;
			while (((c = *pat++) & 0xff) != M_END) {
				if ((*pat & 0xff) == M_RNG) {
					if (c <= k && k <= pat[1])
						ok = 1;
					pat += 2;
				}
				else if (c == k)
					ok = 1;
			}
			if (ok == negate_range)
				return(0);
			break;
		default:
			if (*name++ != c)
				return(0);
			break;
		}
	}
	return(*name == EOS);
}

/* free allocated data belonging to a glob_t structure */
void
globfree(pglob)
	glob_t *pglob;
{
	register int i;
	register char **pp;

	if (pglob->gl_pathv != NULL) {
		pp = pglob->gl_pathv + pglob->gl_offs;
		for (i = pglob->gl_pathc; i--; ++pp)
			if (*pp)
				(void)free(*pp);
		(void)free((char *)pp);
	}
}
/* __________________________________________________________________
 * __________________________________________________________________
 */

#define GLOB_flags	 (GLOB_ERR|GLOB_MARK|GLOB_APPEND)

static int	verbose = 0;
static char	*inputs[5000], *outputs[5000];
static int	ninputs=0, noutputs=0;

ER(p,e) char *p; int e; { fprintf(stderr, "ER: %s %d\n", p, e); }

main(ac,av)
int ac; char *av[];
{
    glob_t	g;
    int		i, in, out, alen;
    char	*s;
    char	buf[MAXPATHLEN];
    char	alt[MAXPATHLEN], *alt_dir=NULL;

    g.gl_offs = 0;
    while (--ac > 0) {
	av++;
	if (!strcmp(*av, "-v")) { verbose = 1; }
	else if (!strcmp(*av, "-alt")) {
	    av++; ac--;
	    alt_dir = *av;
	}
	else if (*av[0] != '-') {
	    while (**av && isspace(**av)) (*av)++;
	    inputs[ninputs++] = *av;
	}
    }

    if (verbose) {
	if (alt_dir) printf("Alternate dir\t= %s.\n", alt_dir);
	for (in=0; in<ninputs; in++)
	    printf("Pattern [%d]\t= %s.\n", in, inputs[in]);
    }

    if (alt_dir) {
	alen = strlen(alt_dir) - 1;
	strcpy(alt, alt_dir);
	if (alt[alen] != '/') {
	    alt[++alen] = '/';
	    alt[alen+1] = '\0';
	}
    }

    for (in=0; in<ninputs; in++) {
	glob(inputs[in], GLOB_flags, ER, &g);
	if (alt_dir) {
	    strcpy(buf, alt);
	    strcat(buf, inputs[in]);
	    glob(buf, GLOB_flags, ER, &g);
	}
    }

    /*	Here we go through the matching file names, forgetting the directories
     *	and file names that we've matched already.
     *	Note: this will need more work if we will support
     *	  multiple alternate directories.
     */
    for (i=0; i<g.gl_pathc; i++) {
	int l, skip;

	skip = 0;
	l = strlen(g.gl_pathv[i]) - 1;
	if (g.gl_pathv[i][l] == '/') continue;		/* skip directories */
/*printf("\nconsider %2d: %s.\n", i, g.gl_pathv[i]);*/
	for (out=0; out<noutputs; out++) {
/*printf("compare %2d: %s,%s,%s.\n", out,outputs[out],alt,g.gl_pathv[i]+alen);*/
	    if ( !strncmp(alt, g.gl_pathv[i], alen) &&
			strlen(g.gl_pathv[i]) > alen &&
			!strcmp(g.gl_pathv[i]+alen+1, outputs[out]) ) {
		if (verbose) printf("match: %s, %s. 2nd dropped\n",
					outputs[out], g.gl_pathv[i]);
		skip = 1;
	    }
	}
	if (skip) continue;
	outputs[noutputs++] = g.gl_pathv[i];
    }
    if (verbose) printf("\n");

    for (out=0; out<noutputs; out++) puts(outputs[out]);

    globfree(&g);
}

/* __________________________________________________________________ */

