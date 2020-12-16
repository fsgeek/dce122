/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: roff-cmd.c,v $
 * Revision 1.1.2.5  1994/06/23  19:49:21  fred
 * 	free copyright
 * 	[1994/06/23  19:44:38  fred]
 *
 * Revision 1.1.2.4  1994/06/23  18:38:08  fred
 * 	free copyright
 * 	[1994/06/22  15:30:39  fred]
 * 
 * Revision 1.1.2.3  1993/04/10  01:03:34  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:01:00  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:36:55  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:34:22  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/roff-cmd.c,v 1.1.2.5 1994/06/23 19:49:21 fred Exp $";
#endif

/*
 *  roff-cmd.c  --  generate an nroff or troff command line, with
 *		    appropriate pre-processors, from information
 *		    contained in the header line of source files
 */

/*#define DEBUG 0*/

#include <string.h>
#include <stdio.h>
#include <ctype.h>


/*	defines, typedefs */

#ifndef TRUE
#define TRUE	1
#endif
#ifndef FALSE
#define FALSE	0
#endif

#define forward	/**/

#define MAXFILES 1500			/* max files to be processed */

typedef short bool;

/*	globals */

static bool oneWithout = FALSE;	/* turns TRUE if some input file */
				/* doesn't include a specification */

static bool tbl = TRUE;		/* tbl required */
static bool pic = TRUE;		/* pic required */
static bool eqn = TRUE;		/* eqn/neqn required */
static bool rmifdef = FALSE;	/* rmifdef required */

static char prep[10000];	/* user-supplied extra preprocessor(s) */
static char options[10000];	/* user-supplied options */

static char * files[MAXFILES];	/* filenames being processed */
static int filei = 0;		/* index into files[] */

static bool nroff = TRUE;	/* formatting for nroff (default) or troff? */

static char *defines[256];	/* defines for rmifdef command -Dabc */
static int  ndefines=0;


/*	table of contents	*/

forward bool fileParse();	/* handle a user-supplied filename */
forward void outputFiles();	/* output a command with filenames */

/*  main() -- process the command line and run the action
 *
 *  synopsis:
 *
 *	roff-cmd [-n|-t] [-p "extra_preprocessors"] [-o "options"] file ...
 *
 *	where:
 *
 *		-n or -t	for nroff or troff (nroff is the default)
 *		-p "pre-p"	adds "pre-p" as a filter at the front of the
 *				generated command line
 *		-o "options"	send "options" to nroff/troff
 *		file ...	file(s) to be formatted
 */

int
main(argc, argv, envp)
int argc;
char ** argv;
char ** envp;
{
    register int i, j;
    register bool usageErr = FALSE;
    register bool putFiles;
    char cmdBuf[10000];
    char *cp;
    extern char *getenv();

    (void)strcpy(prep, "");
    (void)strcpy(options, "");

    for (i=1;  !usageErr && (i < argc);  i++)	{

	if (argv[i][0] == '-')	{

	    switch (argv[i][1])	{

		case 'n':	nroff = TRUE;
				continue;

		case 't':	nroff = FALSE;
				continue;

		case 'p':	if (++i >= argc)	{
					usageErr = TRUE;
					break;
				} else	{
					(void)strcpy(prep, argv[i]);
				}
				continue;

		case 'o':	if (++i >= argc)	{
					usageErr = TRUE;
					break;
				} else	{
					(void)strcpy(options, argv[i]);
				}
				continue;
		case 'D':	defines[ndefines++] = argv[i];
				continue;

		default:	usageErr = TRUE;
				break;
	    }

	} else	{			/* handle file names */

	    if ( fileParse(argv[i]) )	{
		files[filei++] = argv[i];	/* save name for later */
	    } else	{
		(void)fprintf(stderr, "ERROR: can't find file %s\n", argv[i]);
		exit(1);
	    }
	}
    }

    if (usageErr || !filei)	{
	    (void)fprintf(stderr, "usage: %s [-n|-t] [-p pre-processor] [-o options] file ...\n",
				    argv[0]);
	    exit(2);
    }

/* everything processed.  output the command line
*
*/

    if ( oneWithout )	{
	    pic = tbl = eqn = TRUE;		/* must do all if something */
    }								/* didn't specify */

    outputFiles("elimso", TRUE);	/* run elimso to remove .so's */

    if ( prep[0] )	{
	    /* can't trust preprocessors to take filenames */
/*		outputFiles("cat", TRUE);*/
	    outputFiles(prep, TRUE);
    }

    if ( rmifdef )	{
	    int d, last;
	    (void)printf((cp=getenv("RMIFDEF")) ? cp : "rmifdef");
	    for (d=0,last=ndefines-1; d<ndefines; d++)
		    (void)printf(" %s", defines[d]);
	    (void)printf(" | ");
    }

    if ( pic )	{
	    outputFiles((cp=getenv("PIC")) ? cp : "pic -D", TRUE);
#if FALSE
	    if ( nroff )	{		/* then let's fix line motions */
		    outputFiles("fixVertMot", TRUE);
	    }
#endif
    }

    if ( tbl )	{
	    if ( nroff )	{		/* then must remove boxes */
		    outputFiles("rmboxes", TRUE);
	    }
	    outputFiles((cp=getenv("TBL")) ? cp : "tbl", TRUE);
    }

    if ( eqn )	{
	    if ( nroff )	{
		    outputFiles((cp=getenv("NEQN")) ? cp :"neqn", TRUE);
	    } else	{
		    outputFiles((cp=getenv("EQN")) ? cp :"eqn", TRUE);
	    }
    }

    if ( nroff )	{
	    (void)strcpy(cmdBuf, (cp=getenv("NROFF")) ? cp : "nroff");
    } else	{
	    (void)strcpy(cmdBuf, (cp=getenv("TROFF")) ? cp : "troff");
    }

    if ( options[0] )	{
	    (void)strcat(cmdBuf, " ");
	    for (i=0;  cmdBuf[i];  i++) ;
	    for (j=0;  options[j]; j++)		{
		    if (options[j] == '$')
			    cmdBuf[i++] = '\\';
		    else if (options[j] == '^')
			    cmdBuf[i++] = '\\';
		    cmdBuf[i++] = options[j];
	    }
	    cmdBuf[i++] = 0;
    }

    outputFiles(cmdBuf, FALSE);

    (void)printf("\n");

    exit(0);
}

/*	fileParse()  --  make sure a file exists, and see it it specifies
 *					 what preprocessors it requires..
 */

bool
fileParse(file)
char * file;
{
    register int i, li, word;
    register bool quote;
    FILE * fP;
    char line[1000], *cp;
    bool found_directive=FALSE;

    if ((fP = fopen(file, "r")) == NULL)	{
	return FALSE;
    }

    while (1) {
	int skip=0;

	if (fgets(line, sizeof(line), fP) == 0) break;
	if (cp=strchr(line, '\n')) *cp = '\0';		/* get rid of newline */

	/* end of comments?  (accept either ...\" or .\") */
#ifdef OLD
	if (strncmp(line, "...\\\"", 5) && strncmp(line, ".\\\"", 3) &&
	    strncmp(line, "... \\\"", 6) ) break;
	if (strncmp(line, "...\\\"build", 10)) continue;
#endif
	if (!strncmp(line, "...\\\"", 5))	skip = 5;
	else if (!strncmp(line, ".\\\"", 3))	skip = 3;
	else if (!strncmp(line, "... \\\"", 6))	skip = 6;
	if (skip == 0) break;	/* break if not a special comment line? */
	cp = line + skip;
	while (isspace(*cp) && *cp)	cp++;
	if (strncmp(cp, "build", 5)) continue;

	/* now, figure out what options, if any, it specifies */

	for (li=0;  cp[li];  li++)	{

	    for (i=li;  cp[i];  i++)	{	/* remove leading spaces */
		if (isspace(cp[i]))	li++;
		else break;
	    }

	    for (i=li;  cp[i];  i++)	{	/* find end of next word */
		if (isspace(cp[i]))	{
		    cp[i] = 0;	/* found end - stop here */
		    break;
		}
		else continue;
	    }

		if (i != li)	{		/* look at next word */
#if DEBUG
fprintf(stderr, "next word is '%s'\n", &cp[li]);
#endif
/*		    if (!strcmp(&cp[li], "...\\\"build"))*/
		    if (!strcmp(&cp[li], "build"))
			found_directive = TRUE;

		    else if (!strcmp(&cp[li], "rmifdef"))	{
			rmifdef = TRUE;
		    } else if (!strcmp(&cp[li], "-rmifdef")){
			rmifdef = FALSE;

		    } else if (!strcmp(&cp[li], "tbl"))	{
			tbl = TRUE;
		    } else if (!strcmp(&cp[li], "-tbl"))	{
			tbl = FALSE;

		    } else if (!strcmp(&cp[li], "eqn"))	{
			eqn = TRUE;
		    } else if (!strcmp(&cp[li], "-eqn"))	{
			eqn = FALSE;

		    } else if (!strcmp(&cp[li], "pic"))	{
			pic = TRUE;
		    } else if (!strcmp(&cp[li], "-pic"))	{
			pic = FALSE;

		    } else if (!strcmp(&cp[li], "-mm"))	{
			(void)strcat(options, " -mm");

		    } else if (!strcmp(&cp[li], "-man"))	{
			(void)strcat(options, " -man");

		    } else if (!strcmp(&cp[li], "options"))	{
			while ( cp[++i] == ' ' ) ;
			if (cp[i] == '"')	{
			    quote = TRUE;
			    i++;
			} else	{
			    quote = FALSE;
			}
			(void)strcat(options, " ");
			li = i;
			for ( ;  cp[i];  i++)	{
			    if ((quote && (cp[i] == '"')) ||
				(!quote && (cp[i] == ' ')))	{
				    cp[i] = 0;
				    break;
			    }
			}
			(void)strcat(options, &cp[li]);	/* add to options[] */
		    } else	{
			(void)fprintf(stderr,
				"ERROR: ignoring unknown build param '%s'\n",
				&cp[li]);
		    }
		}

		li = i;				/* next word, please */
	}
    }
    if (!found_directive)
	oneWithout = TRUE;

/* close up */

    (void)fclose(fP);
    return TRUE;
}

/*  outputFiles()  --	output a command, filenames if they haven't been
 *			output yet, and a pipe symbol if requested
 */

void
outputFiles(command, pipe)
char * command;		/* command name to output */
int pipe;			/* ned a pipe symbol? */
{
    register int i;
    static bool didFiles = FALSE;


    (void)printf(command);
    if ( ! didFiles )	{
	for (i=0;  i < filei;  i++)	{
	    (void)printf(" %s", files[i]);
	}
	didFiles = TRUE;
    }
    if ( pipe ) (void)printf(" | ");
}

