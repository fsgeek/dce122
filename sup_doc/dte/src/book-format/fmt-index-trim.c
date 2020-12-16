/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: fmt-index-trim.c,v $
 * Revision 1.1.2.8  1994/06/23  19:48:42  fred
 * 	free copyright
 * 	[1994/06/23  19:42:38  fred]
 *
 * Revision 1.1.2.7  1994/06/23  18:37:33  fred
 * 	free copyright
 * 	[1994/06/22  15:28:55  fred]
 * 
 * Revision 1.1.2.6  1993/12/08  19:34:14  fred
 * 	fixed printf statement that expanded any % in the source
 * 	index entry...
 * 	[1993/12/08  19:33:34  fred]
 * 
 * Revision 1.1.2.5  1993/04/10  01:03:10  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:21  bowe]
 * 
 * Revision 1.1.2.4  1992/12/14  20:16:48  bowe
 * 	Define TRUE and FALSE if not yet defined.
 * 	[1992/12/14  20:16:34  bowe]
 * 
 * Revision 1.1.2.3  1992/12/10  18:54:36  fred
 * 	fix glitch in comments
 * 	[1992/12/10  18:54:26  fred]
 * 
 * Revision 1.1.2.2  1992/12/10  18:51:22  fred
 * 	new file needed for index creation.
 * 	[1992/12/10  18:40:18  fred]
 * 
 * $EndLog$
 */


/*	fmt-index-trim.c
 *
 *	This program generally reads a list of sync file names from standard
 *	input, reads their content, and spits out Index entries after
 *	trimming off the "!INDEX: " part.
 *
 *	In "master index" mode, the list of Sync filenames are accompanied by
 *	book abbreviations which are "tacked onto" the end of each index entry.
 *
 *	This program is called by fmt-index(.sh), which places this
 *	program in a pipe that feeds the index formatting software.  The
 *	typical index preparer programs, indpresort and indpostsort, are used
 *	to prepare the raw index data for formatting.
 */


#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/fmt-index-trim.c,v 1.1.2.8 1994/06/23 19:48:42 fred Exp $";
#endif


#include <stdio.h>
#include <string.h>

#ifndef TRUE
# define TRUE	1
#endif
#ifndef FALSE
# define FALSE	0
#endif


/* #define DEBUG */

#define INDEX_STRING	"!INDEX: "	/* text of index line preface */


void	output_items();		/* read a syncfile, extract INDEX items, enhance for
				 * master use, and output them. */

int	master = FALSE;		/* doing a master index? */

int
main(argc, argv, envp)
int argc;
char ** argv;
char ** envp;
{
	register int i;
	register char * cp;
	char	buf[2000];		/* input buffer */
	char	syncpath[1000];		/* the "current" sync file path/name */
	char	bookname[1000];		/* the "current" book name */


	if ((argc > 2) || ((argc == 2) && strcmp(argv[1], "-m")))	{
		fprintf(stderr, "only one option, -m, is valid\n");
		exit(1);
	} else	{
		if (argc == 2)
			master = TRUE;
	}

	while ((cp = fgets(buf, sizeof(buf)-1, stdin)))	{

		while ((*cp == ' ') || (*cp == '\t'))
			cp++;

	/* get the next syncfile name */

		for (i=0;  *cp && (*cp != ',') && (*cp != ' ') && (*cp != '\t') &&
				(*cp != '\n') && (i < sizeof(syncpath)-1);  i++, cp++)	{
			syncpath[i] = *cp;
		}
		syncpath[i] = 0;

		if ( master )	{
			while ((*cp == ' ') || (*cp == '\t'))
				cp++;

			if (*cp != ',')	{
				fprintf(stderr, "bad format in input: missing book name\n");
				exit(2);
			}

			cp++;

		/* get the book name */

			for (i=0;  *cp && (*cp != '\n') && (i < sizeof(bookname)-1);  i++, cp++)	{
				bookname[i] = *cp;
			}
			bookname[i] = 0;
		}

	/* go read through the sync file and send out the index items */

#ifdef DEBUG
		if ( master )
			fprintf(stderr, "got sync file '%s', book name '%s'\n", syncpath, bookname);
		else
			fprintf(stderr, "got sync file '%s'", syncpath);
#endif
		output_items(syncpath, bookname);
	}
	return 0;
}


/*	output_items()  --  read a syncfile, extract INDEX items, perhaps enhance for
 *			    master use, and output them.
 */


void
output_items(file, bname)
char * file;		/* in: sync file to read */
char * bname;		/* in: book name to use for this sync file */
{
	register int entries, do_this_one;
	register char * cp, * sp;
	char	buf[2000];		/* input buffer */
	FILE * fp;


	if ((fp = fopen(file, "r")) == NULL)	{
		fprintf(stderr, "can't open sync file %s\n", file);
		exit(3);
	}

/* cycle through all lines of the sync file finding INDEX entries */

	entries = 0;

	while ((cp = fgets(buf, sizeof(buf)-1, fp)))	{

#ifdef DEBUG
		fprintf(stderr, "sync input: %s", cp);
#endif

		if ( strstr(cp, INDEX_STRING) != cp )
			continue;	/* only look at index strings */

		cp += strlen(INDEX_STRING);	/* skip preface */

#ifdef DEBUG
		fprintf(stderr, "using sync input: %s", cp);
#endif

		if ( ! entries )	{	/* the first entry */
			entries = *cp++;	/* get number of entries */
			cp++;			/* skip space */

		/* look for local/global switches */

			for (sp=cp;  *sp && (*sp != ' ');  sp++)
				;		/* skip page number */
			while ( *sp && (*sp == ' ') )
				sp++;		/* skip spaces */

			do_this_one = TRUE;	/* default */

			if ( *sp == '-' )	/* then need to check flags */
				for ( ; *sp && (*sp != ' ');  sp++ )	{
					if ( *sp == 'l' )	/* local only */
						do_this_one = ! master;
					else if ( *sp == 'm' )
						do_this_one = master;
				}

			if ( do_this_one )
				if ( master )
					printf("%c ", entries+1);
				else
					printf("%c ", entries);
		}

		while ((sp = strchr(cp, '')))
			strcpy(sp, sp+1);	/* throw away ^R's */

		if ( do_this_one )
			printf( "%s", cp );	/* output this line */

		if ( master )	{

			if ( entries == '1' )	{	/* then last line for this entry */
				if ( do_this_one )
					printf( "\007%s\n",  bname );	/* so book name follows */
						/* the BEL character is a trick to get the
						 * book name to sort first -- indpresort will
						 * trim it */
				entries = 0;
			} else
				entries--;
		}
	}

	fclose( fp );			/* done with this file */
}

