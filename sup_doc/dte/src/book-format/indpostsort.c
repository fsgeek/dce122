/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: indpostsort.c,v $
 * Revision 1.1.2.11  1994/06/23  19:49:00  fred
 * 	free copyright
 * 	[1994/06/23  19:43:28  fred]
 *
 * Revision 1.1.2.10  1994/06/23  18:37:50  fred
 * 	free copyright
 * 	[1994/06/22  15:29:42  fred]
 * 
 * Revision 1.1.2.9  1993/12/09  15:18:05  fred
 * 	add "ERROR:" to error messages as per CR 452.
 * 	[1993/12/09  15:17:52  fred]
 * 
 * Revision 1.1.2.8  1993/04/10  01:03:21  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:39  bowe]
 * 
 * Revision 1.1.2.7  1993/02/23  17:14:39  josh
 * 	Fixed index range error reporting problem from ot bug 434.
 * 	This code was checking error ranges in two locations.  In the first,
 * 	it caught entries that had "-[" but not a closing "-]".  This code was
 * 	reporting the next index entry after the one causing the error.  The
 * 	previous index entry was stored in prev_key, so we now print it
 * 	instead of key.  The second location caught entries that had "-]"
 * 	without a preceding "-[".  It was already printing the correct lines.
 * 	The only change necessary was to change the text of the message.
 * 	[1993/02/23  17:14:16  josh]
 * 
 * Revision 1.1.2.6  1992/12/14  20:12:57  bowe
 * 	Define TRUE and FALSE if not yet defined.
 * 	[1992/12/14  20:10:15  bowe]
 * 
 * Revision 1.1.2.5  1992/12/10  18:37:49  fred
 * 	various changes to implement the new master index
 * 	[1992/12/10  18:36:04  fred]
 * 
 * Revision 1.1.2.4  1992/11/10  14:52:00  bowe
 * 	Made static buffer bigger.  It was being overflowed.
 * 	Fixed a few lint errors.
 * 	[1992/11/10  14:50:56  bowe]
 * 
 * Revision 1.1.2.3  1992/10/23  17:40:03  bowe
 * 	Got rid of const.
 * 
 * Revision 1.1.2.2  1992/07/07  18:36:29  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:33:55  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/indpostsort.c,v 1.1.2.11 1994/06/23 19:49:00 fred Exp $";
#endif

/*
 * -------------------------------------------------------
 *  Program: indpostsort
 *  of:      Indexing Tools for DTE
 *  Usage:   indpostsort
 *  Input: stdin contains sorted index records.
 *  Format is: sortkey1, sortkey2, sortkey3, sortkey4, pagetext, flags,
 *					textkey1, textkey2, textkey3, textkey4.
 *  Each record is terminated with newline. Fields are terminated
 *  with \x01. Sort keys consist of a flag character (unused) followed by text
 *  used to sort the index entrys. We use the first character of the text of
 *  sortkey1 to determine what letter the entry appears under, otherwise the
 *  sortkeys are unsued. The textkeys contain the text passed to the index
 *  generation macros. Textkey4 contains see or see also text.
 *  Output:  stdout contains index macro calls: iL, iP, iS, iT, i#, i:, i;
 * ------------------------------------------------------- 
 */

static char err_range_nest[] = "ERROR: Page ranges improperly formed in\n";

#include "stdio.h"
#include "string.h"
#include "ctype.h"

#ifndef TRUE
# define TRUE	1
#endif
#ifndef FALSE
# define FALSE	0
#endif

/* #define DEBUG */


#define INPSZ 60	/* max length of a key */
#define BUFSZ 1000	/* input line buffer size */
#define PAGESZ 80	/* max size of a page number */
#define FLAGSZ 20	/* max size of a flag */
#define NRKEYS 5	/* max number of keys */

#define LVPAGE (NRKEYS-1)	/* symbol to tell output_list() that this is a page number */
#define LVSEE  (NRKEYS)		/* symbol to tell output_list() that this is a "See" */
#define LVSEA  (NRKEYS+1)	/* symbol to tell output_list() that this is a "See Also" */

#define EOFLD  '\001'	/* field delimiter */


typedef struct ST_entry *entry_ptr;
typedef struct ST_entry	{
	entry_ptr	next;
	int		level;
	int		nr_subord, preem;
	char		*text;
} entry;


entry	*head, *tail;
char	key[NRKEYS][INPSZ], prev_key[NRKEYS][INPSZ], inpbf[BUFSZ];
char	page[PAGESZ], range_start[PAGESZ], flags[FLAGSZ];
char	sort_letter, letter, prev_letter;
int	range_level, diff[NRKEYS];


/*
 * char *read_input(char[][INPSZ]); void set_counts(entry*); void
 * output_list(entry*); entry *new_entry(int,char*); int  range_check(); void
 * double_quote(char*,char*); void error_entry (); char *page_format (char
 * *);  void error_prev();
 */

char	*read_input();
void	set_counts();
void	output_list();
entry	*new_entry();
int	range_check();
void	double_quote();
void	error_entry();
void	error_prev();
char	*page_format();


main()
{
	int	i;
	char	*cp;

	head = NULL;
	range_level = 0;
	strcpy(prev_key[0], "zzzzzz");
	prev_letter = 'z';

	while (read_input(key))	{

		for (i = 0; i < NRKEYS; i++)	{

		/* compare this key to previous -- set diff[i] for changed or not */

			if (strcmp(key[i], prev_key[i]))
				for (; i < NRKEYS; i++)	{
					diff[i] = TRUE;
					if (range_level)	{
					  fprintf(stderr, err_range_nest);
					  error_prev();
					  range_level = 0;
					}
					strcpy(prev_key[i], key[i]);
				}
			else
				diff[i] = FALSE;
		}


		if (diff[0])	{
			if (head)	{
				set_counts(head);
				output_list(head);
			}
			tail = head = new_entry(0, key[0]);
			letter = sort_letter;
		}

		for (i = 1; i < NRKEYS - 1; i++)	{
			if (diff[i])
				tail = ((tail->next) = new_entry(i, key[i]));
		}

		cp = 0;
		if (strchr(flags, ':'))	{
			i = LVSEE;
			cp = key[NRKEYS - 1];

		} else if (strchr(flags, ';'))	{
			i = LVSEA;
			cp = key[NRKEYS - 1];

		} else {
			i = LVPAGE;
			cp = range_check() ? page : NULL;
		}

		if (cp)	{
			tail = ((tail->next) = new_entry(i, cp));
			if (strchr(flags, '!'))
			tail->preem++;
		}
	}

	if (head)	{
		set_counts(head);
		output_list(head);
	}

	return 0;
}

/*	read_input() -- read an input record and grab terms
 *
 */

char	*
read_input(key)
char	key[][INPSZ];
{
	char	*cp, *ep;
	int	i;


	if ((cp = fgets(inpbf, BUFSZ, stdin)))	{

		sort_letter = *++cp;	/* get index "section" */
		if ((sort_letter < 'A' || sort_letter > 'Z') &&
				(sort_letter < 'a' || sort_letter > 'z'))
			sort_letter = ' ';

		for (i = 0; i < NRKEYS; i++)
			cp = strchr(cp, EOFLD) + 1;

		ep = strchr(cp, EOFLD);
		*ep++ = '\0';
		strcpy(page, cp);	/* save page number */
		ep = strchr(cp = ep, EOFLD);
		*ep++ = '\0';
		strcpy(flags, ++cp);	/* save flags */

		for (i = 0; i < NRKEYS; i++)	{
			ep = strchr(cp = ep, EOFLD);
			*ep++ = '\0';
			double_quote(key[i], cp);	/* save term */
		}
	}
	return cp;
}

void 
set_counts(pp)
entry	*pp;
{
	entry	*sp, *tp, *qp, *rp;
	int	count[4];	/* this is a hack -- shouldn't be hardwired */


	sp = pp->next;
	count[0] = 0;

	for ( ; sp && sp->level > 0; sp = qp, count[0]++)	{

		tp = sp->next;
		count[1] = 0;

		for ( ; tp && tp->level > 1; tp = qp, count[1]++)	{

			rp = tp->next;
			count[2] = 0;

			for ( ; rp && rp->level > 2; rp = qp, count[2]++)	{

				qp = rp->next;
				count[3] = 0;

				for ( ; qp && qp->level > 3; qp = qp->next, count[3]++)
					;
				
				rp->nr_subord = count[3];
			}
			tp->nr_subord = count[2];
		}
		sp->nr_subord = count[1];
	}
	pp->nr_subord = count[0];
}

entry	*
new_entry(lv, sp)
int	lv;
char	*sp;
{
	entry	*ep;

#ifdef DEBUG
	fprintf(stderr, "new_entry: lv %d sp %s\n", lv, sp);
#endif

	ep = (entry *) malloc(sizeof(entry));
	ep->next = NULL;
	ep->level = lv;
	ep->nr_subord = 0;
	ep->preem = 0;
	strcpy(ep->text = (char *) malloc(1 + strlen(sp)), sp);
	return ep;
}

static char	lit[] = "\\*L";
static char	ord[] = "\\*O";
static char	unused[] = "";

void 
output_list(pp)
entry	*pp;
{
	entry	*ep, *dp;
	char	*leadem, *trailem;


	for (ep = pp; ep; ep = (dp = ep)->next, free(dp))	{

		if (ep->preem)	{
			leadem = lit;
			trailem = ord;

		} else {
			leadem = unused;
			trailem = unused;
		}

		switch (ep->level)	{

		case 0:	if (letter != prev_letter)	{
				if (letter < 'A')
					printf(".iL \"Symbols\"\n");
				else
					printf(".iL \"%c\"\n", letter);
				prev_letter = letter;
			}
			printf(".iP \"%s\" %d\n", ep->text, ep->nr_subord);
			break;

		case 1:	printf(".iS \"%s\" %d\n", ep->text, ep->nr_subord);
			break;

		case 2:	printf(".iT \"%s\" %d\n", ep->text, ep->nr_subord);
			break;

		case 3:	printf(".iQ \"%s\" %d\n", ep->text, ep->nr_subord);
			break;

		case LVPAGE:
			printf(".i# \"%s%s%s\"\n", leadem, page_format(ep->text), trailem);
			break;

		case LVSEE:
			printf(".i: \"%s\"\n", ep->text);
			break;

		case LVSEA:
			printf(".i; \"%s\"\n", ep->text);
			break;
		}
		free(ep->text);
	}
}

/*	range_check() -- check for proper page ranges 
 *
 */


int 
range_check()
{
	register int	range_preem;	/* page number emphasis flag? */


	if (strchr(flags, '['))	{	/* start of page range */

		if (!range_level++)	{	/* ok */
			strcpy(range_start, page);
			range_preem = strchr(flags, '!') ? TRUE : FALSE;
			return 0;
		}

	} else if (strchr(flags, ']'))	{	/* end of page range */

		if (--range_level <= 0)	{

			if (!range_level)	{	/* ok */

				if (strcmp(range_start, page))	{
					strcat(range_start, " to ");
					strcat(range_start, page);
					strcpy(page, range_start);
				}

			if (range_preem)
				strcat(flags, "!");
			} else {
				fprintf(stderr, err_range_nest);
				error_entry();
				range_level = 0;
			}
		}
	}

	return (range_level == 0);
}



void 
error_entry()
{
	fprintf(stderr, "ERROR: Entry: %s-%s-%s-%s-%s-%s\n",
			key[0], key[1], key[2], key[3], page, flags);
}
void 
error_prev()
{
	fprintf(stderr, "ERROR: Entry: %s-%s-%s-%s-%s-%s\n",
			prev_key[0], prev_key[1], prev_key[2], 
			prev_key[3], page, flags);
}

/*	double_quote() -- copy arg2 into arg1, doubling any quote characters found
 *
 */


void 
double_quote(dp, sp)
char	*dp;
char	*sp;
{

	for (; *sp; sp++)	{

		*dp++ = *sp;
		if (*sp == '"')
			*dp++ = '"';
	}

	*dp++ = '\0';
}



char *
page_format(s)
char *s;
{
	static char buf[32];
	char *cp;
	int num=0;

	cp = buf;
	while (*s) {

		if (isdigit(*s)) {

			if (num == 0 && *s == '0') {

			/* eat leading zeros */

				while (*s && *s == '0')
					s++;

				if (!isdigit(*s))
					s--;
			}
			num = 1;
		} else
			num = 0;

		if (*s == '-')
			*cp++ = '\\';
		*cp++ = *s;
		s++;
	}
	*cp++ = '\0';
	cp = buf;

	return cp;
}


#ifdef OLD
char	*
page_format(cp)
char	*cp;
{
	char	*sp, *dp, *ep;
	int	zero_supp, nr_supp;


	zero_supp = 1;
	nr_supp = 0;

	for (sp = ep = dp = cp; *sp; sp++)	{
		if (*sp == '0' && zero_supp)
			nr_supp++;
		else {
			if (isdigit(*sp) || isalpha(*sp))
				zero_supp = 0;
			else {
				if (dp == ep && nr_supp)
					*dp++ = '0';
				ep = dp + 1;
				zero_supp = 1;
				nr_supp = 0;
			}
			*dp++ = *sp;
		}
	}
	if (dp == ep && nr_supp)
		*dp++ = '0';
	*dp = '\0';
	if (*cp == '-')
		strcpy(cp, cp + 1);
	return cp;
}
#endif
