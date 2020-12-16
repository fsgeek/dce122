/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: rmifdef.c,v $
 * Revision 1.1.2.6  1994/06/23  19:49:19  fred
 * 	free copyright
 * 	[1994/06/23  19:44:20  fred]
 *
 * Revision 1.1.2.5  1994/06/23  18:38:05  fred
 * 	free copyright
 * 	[1994/06/22  15:30:26  fred]
 * 
 * Revision 1.1.2.4  1993/04/10  01:03:32  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:57  bowe]
 * 
 * Revision 1.1.2.3  1992/12/07  16:43:58  bowe
 * 	Added cast of malloc to (char *) in STRDUP macro (fixes compiler warning).
 * 	[1992/12/07  16:43:39  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:36:50  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:34:18  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/rmifdef.c,v 1.1.2.6 1994/06/23 19:49:19 fred Exp $";
#endif

/*
 *  This is a hacked-up version of "unifdef" that attempts to get
 *  rid of some undesirable characteristics.
 */
/*
 *  unifdef - remove ifdef'ed lines
 */

#include <stdio.h>
#include <ctype.h>

#define BSS
FILE *input;
#ifndef YES
#define YES 1
#define NO  0
#endif

extern char	*strcpy(), *strchr();
#define STRDUP(s)	(strcpy((char *)malloc(strlen(s)+2),s))

char *progname BSS;
char *filename BSS;
char lnblank BSS;       /* -l option in effect: blank deleted lines */
char complement BSS;    /* -c option in effect: complement the operation */
#define MAXSYMS 100
char true[MAXSYMS] BSS;
char ignore[MAXSYMS] BSS;
char *sym[MAXSYMS] BSS;
char insym[MAXSYMS] BSS;
char nsyms BSS;
#define QUOTE1 0
#define QUOTE2 1
int exitstat BSS;

main (argc, argv)
int argc;
char **argv;
{
    char **curarg;
    register char *cp;
    register char *cp1;
    char ignorethis;

    progname = argv[0][0] ? argv[0] : "unifdef";

    /* yucky hack - a fake "-Dxxx" - I haven't figured out why we need at
       least one symbol defined.  -bowe
     */
    ignore[nsyms] = YES;
    true[nsyms]   =  YES;
    sym[nsyms++]  = "xyzzy_hack";

    for (curarg = &argv[1]; --argc > 0; curarg++) {
	if (*(cp1 = cp = *curarg) != '-')
	    break;
	if (*++cp1 == 'i') {
	    ignorethis = YES;
	    cp1++;
	}
	else
	    ignorethis = NO;
	if ( (*cp1 == 'D' || *cp1 == 'U') ) {
	    if ( cp1[1] != '\0' ) {
		if (nsyms >= MAXSYMS) {
		    fprintf (stderr, "ERROR: %s: too many symbols.\n", progname);
		    exit (2);
		}
		ignore[nsyms] = ignorethis;
		true[nsyms] = *cp1 == 'D' ? YES : NO;
		sym[nsyms++] = &cp1[1];
	    }
	}
	else if (ignorethis)
	    goto unrec;
	else if (strcmp (&cp[1], "l") == 0)
	    lnblank = YES;
	else if (strcmp (&cp[1], "c") == 0)
	    complement = YES;
	else {
 unrec:
	    fprintf (stderr, "ERROR: %s: unrecognized option: %s\n",progname,cp);
	    goto usage;
	}
    }
    if (nsyms == 0) {
 usage:
	fprintf (stderr, "\
Usage: %s [-l] [-c] [[-Dsym] [-Usym] [-idsym] [-iusym]]... [file]\n\
    At least one arg from [-D -U -id -iu] is required\n", progname);
	exit (2);
    }

    if (argc > 1) {
	fprintf (stderr, "ERROR: %s: can only do one file.\n", progname);
    }
    else if (argc == 1) {
	filename = *curarg;
	if ((input = fopen (filename, "r")) != NULL) {
	    pfile();
	    fclose (input);
	}
	else {
	    fprintf (stderr, "ERROR: %s: ", progname);
	    perror(*curarg);
	}
    }
    else {
	filename = "[stdin]";
	input = stdin;
	pfile();
    }

    fflush (stdout);

    exit (exitstat);
}

/* some system define these already. (it is bad for us to change the values!) */
#ifdef TRUE
#undef TRUE
#endif
#ifdef FALSE
#undef FALSE
#endif
/* types of input lines: */
#define PLAIN       0   /* ordinary line */
#define TRUE        1   /* a true  #ifdef of a symbol known to us */
#define FALSE       2   /* a false #ifdef of a symbol known to us */
#define OTHER       3   /* an #ifdef of a symbol not known to us */
#define ELSE        4   /* #else */
#define ENDIF       5   /* #endif */
#define LEOF        6   /* end of file */

char reject BSS;    /* 0 or 1: pass thru; 1 or 2: ignore comments */
int linenum BSS;    /* current line number */
int stqcline BSS;   /* start of current coment or quote */
char *errs[] = {
#define NO_ERR      0
			"",
#define END_ERR     1
			"",
#define ELSE_ERR    2
			"Inappropriate else",
#define ENDIF_ERR   3
			"Inappropriate endif",
#define IEOF_ERR    4
			"Premature EOF in ifdef",
};

pfile ()
{
    reject = 0;
    doif (-1, NO, reject, 0);
    return;
}

doif (thissym, inif, prevreject, depth)
register int thissym;   /* index of the symbol who was last ifdef'ed */
int inif;               /* YES or NO we are inside an ifdef */
int prevreject;         /* previous value of reject */
int depth;              /* depth of ifdef's */
{
    register int lineval;
    register int thisreject;
    int doret;          /* tmp return valud]e of doif */
    int cursym;         /* index of the symbol returned by checkline */
    int stline;         /* line number when called this time */

    stline = linenum;
    for (;;) {
	switch (lineval = checkline (&cursym)) {
	case PLAIN:
	    flushline (YES);
	    break;

	case TRUE:
	case FALSE:
	    thisreject = reject;
	    if (lineval == TRUE)
		insym[cursym] = 1;
	    else {
		if (reject < 2)
		    reject = ignore[cursym] ? 1 : 2;
		insym[cursym] = -1;
	    }
	    if (ignore[cursym])
		flushline (YES);
	    else {
		exitstat = 1;
		flushline (NO);
	    }
	    if ((doret = doif (cursym, YES, thisreject, depth + 1)) != NO_ERR)
		return error (doret, stline, depth);
    	    break;

	case OTHER:
	    flushline (YES);
	    if ((doret = doif (-1, YES, reject, depth + 1)) != NO_ERR)
		return error (doret, stline, depth);
	    break;

	case ELSE:
	    if (inif != 1)
		return error (ELSE_ERR, linenum, depth);
	    inif = 2;
	    if (thissym >= 0) {
		if ((insym[thissym] = -insym[thissym]) < 0)
		    reject = ignore[thissym] ? 1 : 2;
		else
		    reject = prevreject;
		if (!ignore[thissym]) {
		    flushline (NO);
		    break;
		}
	    }
	    flushline (YES);
	    break;

	case ENDIF:
	    if (inif == 0)
		return error (ENDIF_ERR, linenum, depth);
	    if (thissym >= 0) {
		insym[thissym] = 0;
		reject = prevreject;
		if (!ignore[thissym]) {
		    flushline (NO);
		    return NO_ERR;
		}
	    }
	    flushline (YES);
	    return NO_ERR;

	case LEOF: {
	    int err;
	    err = NO_ERR;
	    if (inif) {
		if (err != NO_ERR)
		    error (err, stqcline, depth);
		return error (IEOF_ERR, stline, depth);
	    }
	    else if (err != NO_ERR)
		return error (err, stqcline, depth);
	    else
		return NO_ERR;
	    }
	}
    }
}

#define endsym(c) (!isalpha (c) && !isdigit (c) && c != '_')

#define MAXLINE 256
char tline[MAXLINE] BSS;

checkline (cursym)
int *cursym;
{
    register char *cp;
    register char *symp;
    register char chr;
    char *scp;
    int retval;
    int symind;
#   define KWSIZE 8
    char keyword[KWSIZE];

    linenum++;
    if (getlin (tline, sizeof tline, input, NO) == EOF)
        return LEOF;

    retval = PLAIN;
    if (*(cp = tline) != '#')
	goto eol;

    ++cp;
    while (*cp == ' ' || *cp == '\t') cp++;
    symp = keyword;
    while (!endsym (*cp)) {
	*symp = *cp++;
	if (++symp >= &keyword[KWSIZE-1]) goto eol;
    }
    *symp = '\0';

    if (strcmp (keyword, "ifdef") == 0) {
	retval = YES;
	goto ifdef;
    }
    else if (strcmp (keyword, "ifndef") == 0) {
	retval = NO;
 ifdef:
	cp++;
	while (*cp == ' ' || *cp == '\t') cp++;
	scp = cp;
	for (symind = 0; ; ) {
	    if (insym[symind] == 0) {
		for ( symp = sym[symind], cp = scp
		    ; *symp && *cp == *symp
		    ; cp++, symp++
		    )
		    {}
		chr = *cp;
		if (*symp == '\0' && endsym (chr)) {
		    *cursym = symind;
		    retval = (retval ^ true[symind]) ? FALSE : TRUE;
		    break;
		}
	    }
	    if (++symind >= nsyms) {
							/* HACK */
		*cursym = nsyms;
		ignore[nsyms] = NO;
		true[nsyms] = NO;
		insym[nsyms] = 1;
		if (cp=strchr(scp, '\n')) *cp = '\0';
		sym[nsyms++] = STRDUP(scp);
		retval = (retval==YES) ? FALSE : TRUE;
		break;
	    }
	}
    }
    else if (strcmp (keyword, "if") == 0)
	retval = OTHER;
    else if (strcmp (keyword, "else") == 0)
	retval = ELSE;
    else if (strcmp (keyword, "endif") == 0)
	retval = ENDIF;

 eol:
    return retval;
}

/*
/*   special getlin - treats form-feed as an end-of-line
/*                    and expands tabs if asked for
/*
/**/
getlin (line, maxline, inp, expandtabs)
register char *line;
int maxline;
FILE *inp;
int expandtabs;
{
    int tmp;
    register int num;
    register int chr;
#ifdef FFSPECIAL
    static char havechar = NO;  /* have leftover char from last time */
    static char svchar BSS;
#endif

    num = 0;
#ifdef FFSPECIAL
    if (havechar) {
	havechar = NO;
	chr = svchar;
	goto ent;
    }
#endif
    while (num + 8 < maxline) {   /* leave room for tab */
        chr = getc (inp);
	if (isprint (chr)) {
#ifdef FFSPECIAL
 ent:
#endif
	    *line++ = chr;
	    num++;
	}
	else
	    switch (chr) {
	    case EOF:
		return EOF;

	    case '\t':
		if (expandtabs) {
		    num += tmp = 8 - (num & 7);
		    do
			*line++ = ' ';
		    while (--tmp);
		    break;
		} 
            default:
                *line++ = chr;
                num++;
		break;

	    case '\n':
                *line = '\n';
                num++;
                goto end;
    
#ifdef FFSPECIAL
	    case '\f':
		if (++num == 1)
		    *line = '\f';
		else {
		    *line = '\n';
		    havechar = YES;
                    svchar = chr;
                }
                goto end;
#endif
	    }
    }
 end:
    *++line = '\0';
    return num;
}

flushline (keep)
{
    if ((keep && reject < 2) ^ complement)
	putlin (tline, stdout);
    else if (lnblank)
	putlin ("\n", stdout);
    return;
}

/*
/*  putlin - for tools
/*
/**/
putlin (line, fio)
register char *line;
register FILE *fio;
{
    register char chr;

    while (chr = *line++)
	putc (chr, fio);
    return;
}

error (err, line, depth)
{
    if (err == END_ERR)
	return err;

#ifndef TESTING
    fprintf (stderr, "ERROR: %s: %s line %d: %s.\n",
	     progname, filename, line, errs[err]);
#endif

#ifdef TESTING
    fprintf (stderr, "ERROR: %s: %s line %d: %s. ",
	     progname, filename, line, errs[err]);
    fprintf (stderr, "ifdef depth: %d\n", depth);
#endif

    exitstat = 2;
    return depth > 1 ? IEOF_ERR : END_ERR;
}

