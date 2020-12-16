/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: fixVertMot.c,v $
 * Revision 1.1.2.5  1994/06/23  19:48:38  fred
 * 	free copyright
 * 	[1994/06/23  19:42:27  fred]
 *
 * Revision 1.1.2.4  1994/06/23  18:37:29  fred
 * 	free copyright
 * 	[1994/06/22  15:28:42  fred]
 * 
 * Revision 1.1.2.3  1993/04/10  01:03:07  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:16  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:36:03  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:33:45  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/fixVertMot.c,v 1.1.2.5 1994/06/23 19:48:38 fred Exp $";
#endif

#include "stdio.h"

char line[1000];	/* input line */
char compensate[1000];	/* compensation */

main(argc, argv, envp)
int argc;
char ** argv;
char ** envp;
{
    register int i, j;

    j = ! EOF;

    while ( j != EOF ) {

	    for (i=0; ((j = getchar()) != EOF) && ( j != '\n'); i++) {
		    line[i] = j;
	    }
	    line[i] = compensate[0] = 0; 

	    for (i=0; i < (strlen(line) - 3); i++) {

		    if (line[i] != '\\')
			    continue;

		    switch ( line[++i] )	{
		    case 'L':
		    case 'v':	addDist(i+1);
					    break;
		    default:	break;
		    }
	    }

	    /* line parsed -- output compensation, if necessary */

	    if ( compensate[0] )	{
		    printf("%s\\v'%s'\n", line, compensate);
	    } else	{
		    printf("%s\n",line);
	    }
    }
}

/*	addDist() -- gather the movement value and save it
*
*/

addDist(offset)
int offset;
{
    register int i, j, terminate;

    if ( !line[offset] || !line[offset+1] )
	    return;

    terminate = line[offset];

    j = strlen(compensate);

    i = offset + 1;			/* point at first part of number */

    if ((line[i] != '+') && (line[i] != '-')) {
	    compensate[j++] = '-';
    }

    for ( ; line[i] && (line[i] != terminate); i++, j++)	{

	    if ((line[i] == '\\') && line[i+1] && (line[i+1] == '(')) {
		    i += 3;
		    j--;
		    continue;
	    }

	    if ( line[i] == '+' )
		    compensate[j] = '-';
	    else if ( line[i] == '-' ) {
			    if ( j )
				    compensate[j] = '+';
			    else j--;
	    } else 
		    compensate[j] = line[i];
    }
    compensate[j] = 0;
}

