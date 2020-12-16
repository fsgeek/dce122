/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: check-gloss.c,v $
 * Revision 1.1.2.7  1994/06/24  15:49:18  fred
 * 	free copyright
 * 	[1994/06/24  15:43:49  fred]
 *
 * Revision 1.1.2.6  1994/06/23  18:42:31  fred
 * 	free copyright
 * 	[1994/06/22  20:17:54  fred]
 * 
 * Revision 1.1.2.5  1993/04/10  00:17:55  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  00:16:38  bowe]
 * 
 * Revision 1.1.2.4  1993/02/27  22:18:57  bowe
 * 	Remove an unnecessary func prototype.  (It bothered the AIX compiler.)
 * 	[1993/02/27  22:18:23  bowe]
 * 
 * Revision 1.1.2.3  1993/01/08  13:33:15  bowe
 * 	Fixed to recognize comments.  (used to cause coredump)  CR 431.  Fixed
 * 	so it does not get lost when bogus lines are encountered.  Also fixed a
 * 	few lint errors/warnings.
 * 	[1993/01/08  13:31:52  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:35:47  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:33:26  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/util/check-gloss.c,v 1.1.2.7 1994/06/24 15:49:18 fred Exp $";
#endif

/* ___________________________________________________________
 *
 *  Program to check validity of glossary files.
 *  Note - this is just a hack!
 * ___________________________________________________________
 */

#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define TERM	"|.TERM|"
#define ACR	"|.ACR|"
#define DEFIN	"|.DEFIN|"
#define XREF	"|.XREF|"
#define BOOK	"|.BOOK|"
#define TOPIC	"|.TOPIC|"

#define TERML	7
#define ACRL	6
#define DEFINL	8
#define XREFL	7
#define BOOKL	7
#define TOPICL	8

#define sINIT	0
#define sTERM	1
#define sACR	2
#define sDEFIN	3
#define sXREF	4
#define sBOOK	5
#define sTOPIC	6

#define BUFLEN	400

static char	buf[BUFLEN], *filename, term[128];
static int	state, lineno, errflag;

/* print error message */
void
handle_error(t)
char *t;
{
    if (term[0] != '\0')
	printf("File=%s, line=%d, term=%s:\n", filename, lineno, term);
    else
	printf("File=%s, line=%d: ", filename, lineno);
    if (buf[0] == '\0')
	printf("blank line not allowed.\n");
    else
	printf("%s missing.  Line is:\n%s\n", t, buf);
    errflag = 1;
    state = sINIT;
}

int
main(ac, av)
int ac;
char *av[];
{
    FILE	*fp;
    int		a=1, line_ready, ex_status=0;
    char	*bp;

    while (--ac) {
	filename = av[a];
	if (!(fp = fopen(filename, "r")))
	{
	    perror(filename);
	    continue;
	}
	state = sINIT;
	lineno = 0;
	errflag = 0;
	line_ready = 0;
	term[0] = '\0';
	while (line_ready || (errflag == 0 && fgets(buf, BUFLEN, fp)))
	{
	    line_ready = 0;
	    lineno++;
	    if (!strncmp(buf, "|.#", 3)) continue;	/* skip comment line */
	    if ((bp = strchr(buf, '\n'))) *bp = '\0';
	    bp = buf;
	    while (isspace(*bp)) bp++;
	    /* this is supposed to be a state machine... */
	    switch(state)
	    {
		case sINIT:
		    if (strncmp(bp, TERM, TERML)) handle_error(TERM);
		    bp++;
		    while (*bp && *bp != '|') bp++;
		    if (*bp == 0) bp = "UNKNOWN";
		    strcpy(term, bp);
		    state = sTERM;
		    break;
		case sTERM:
		    if (strncmp(bp, ACR, ACRL)) handle_error(ACR);
		    state = sACR;
		    break;
		case sACR:
		    if (strncmp(bp, DEFIN, DEFINL)) handle_error(DEFIN);
		    state = sDEFIN;
		    break;
		case sDEFIN:
		    if (*bp != '|') continue;
		    if (strncmp(bp, XREF, XREFL)) handle_error(XREF);
		    state = sXREF;
		    break;
		case sXREF:
		    if (!strncmp(bp, XREF, XREFL)) continue;
		    if (strncmp(bp, BOOK, BOOKL)) handle_error(BOOK);
		    state = sBOOK;
		    break;
		case sBOOK:
		    if (!strncmp(bp, BOOK, BOOKL)) continue;
		    if (strncmp(bp, TOPIC, TOPICL)) handle_error(TOPIC);
		    state = sTOPIC;
		    break;
		case sTOPIC:
		    if (!strncmp(bp, TOPIC, TOPICL)) continue;
		    if (!strncmp(bp, DEFIN, DEFINL))
			state = sDEFIN;
		    else if (!strncmp(bp, TERM, TERML))
		    {
			bp++; while (*bp++ != '|') ; strcpy(term, bp);
			state = sTERM;
		    }
		    else {
			term[0] = '\0';
			handle_error(TERM);
		    }
		    break;
	    }
	    if (errflag)
	    {
		/* try to sync-up with next TERM */
		while (fgets(buf, BUFLEN, fp))
		{
		    if ((bp = strchr(buf, '\n'))) *bp = '\0';
		    bp = buf;
		    while (isspace(*bp)) bp++;
		    if (!strncmp(bp, TERM, TERML))
		    {
			state = sINIT;
			line_ready = 1;
			errflag = 0;
			break;
		    }
		    else lineno++;
		}
		ex_status = 1;
	    }
	}
	fclose(fp);
	a++;
    }
    return ex_status;
/*    exit(ex_status);*/
}

