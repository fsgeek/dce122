/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: forward.c,v $
 * Revision 1.1.2.5  1994/06/23  19:48:54  fred
 * 	free copyright
 * 	[1994/06/23  19:43:11  fred]
 *
 * Revision 1.1.2.4  1994/06/23  18:37:44  fred
 * 	free copyright
 * 	[1994/06/22  15:29:25  fred]
 * 
 * Revision 1.1.2.3  1993/04/10  01:03:17  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:32  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:36:08  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:33:50  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/forward.c,v 1.1.2.5 1994/06/23 19:48:54 fred Exp $";
#endif
/* ______________________________________________________________________
 *
 *  This is a "col" equivalent.  Most systems come with "col" so we don't
 *  build and install it.  It is provided just in case.
 * ______________________________________________________________________
 */

/*	forward.c
 *
 *	June 4, 1989
 *
 *	A (working) replacement for col.  This filter will make sure that its
 *	input is transformed into output that always moves from left to right
 *	and top to bottom.
 *
 *	Currently, half line motions are rounded (probably poorly) to full line
 *	positions.  If you don't like this, then don't put the half-line motions
 *	in in the first place (ie, use -Tlp with nroff).
 */

#define DEBUG 1

#include "stdio.h"

extern char * malloc();

/*	definitions and types	*/

#define TRUE	1
#define FALSE	0

#define MOVEMENT	0400		/* sign of movement */
#define MOVEMASK	0377		/* name of token */
#define LINESIZE	8			/* height of a line */
#define GUARANTEE	200			/* # of lines guaranteed correct */
#define HYSTERESIS	66			/* # lines to output, while GUARANTEEing */


typedef long size;				/* generic size */

typedef struct	{
	long	x;
	long	y;
} doc_position;					/* the logical char position in a doc */

typedef struct line_list_item	{
	doc_position	docPosition;	/* where in the document */
	char *			text;			/* current offset in text */
	char *			textStart;		/* orig pos of text */
	struct line_list_item * next;			/* next in list */
} line_list_item;



/* table of contents */

short		parseOpts();		/* parse commandd line options */
void		processFile();		/* do the real work */
int			getToken();			/* return the next token from the input file */
int			getAChar();			/* return the next char - INTERNAL USE ONLY */
void		putAChar();			/* put a char into the lookahead buffer */
void		insItemInList();	/* insert a line_list_item in the list */
line_list_item * crLineItem();	/* create a new line_list_item */
void		outputText();		/* output the appropriate amount of stuff */

/*	input sequences expected in the document */

struct move_sequences	{
	char			sequence[5];	/* the doc sequence */
	int				name;			/* internal token for sequence */
	doc_position	docPosition;	/* internal movement for sequence */
	char			humanName[25];	/* what is this sequence? */
	long			count;			/* how many seen? */
} mvSeqItem[7] =	{

/*	sequence	token	movement				human name of sequence	(count) */

	"\b",		0410,	{ -1, 0 },				"backspace",			0,
	"\f",		0414,	{ 0, 0 },				"formfeed",				0,
	"\r",		0415,	{ 0, 0 },				"carraige return",		0,
	"\n",		0412,	{ 0, LINESIZE },		"newline",				0,
	"\0337",	0400,	{ 0, -LINESIZE },		"full line backward",	0,
	"\0338",	0401,	{ 0, -(LINESIZE/2) },	"half line backward",	0,
	"\0339",	0402,	{ 0,  (LINESIZE/2) },	"half line forward",	0
					};

#define mvSeqTop 7				/* total # elements in mvSeqItem */



/* output sequences used to move vertically */

struct out_move_sequences	{
	int		distance;				/* how far this sequence moves */
	char	sequence[10];			/* the sequence to do it */
} outMvSeq[2] =		{

/*	distance	sequence	*/

	LINESIZE,	"\n",				/* full line */
	LINESIZE/2,	""					/***** no half line movement *****/
					};

#define outMvSeqTop	2			/* total # elements in outMvSerq */

/*	globals	*/


line_list_item	*	lineList = 0;		/* list */
doc_position	docPosition = { 0, 0 };	/* curr pos in doc */
size	basePosition;				/* where we start printing */
char	lastLine[2000];				/* buffer last text seen */
int		lastLtop = 0;				/* top used in buffer */

size	tabPos = 8;					/* width of a tab */
size	pageLen = 66 * LINESIZE;	/* size of a page */
size	guarantee = 200 * LINESIZE;	/* guaranteed # of correct lines */
size	hysteresis = 66 * LINESIZE;	/* lines to output */

short	compress = FALSE;	/* compress out extra vertical space? */
short	first = FALSE;		/* show only 1st element of backspace seq */
short	last = FALSE;		/* show only last element of backspace seq */
short	doSummary = FALSE;	/* show summary when done? */





/* summary counters, etc. */

long	lineItems = 0;		/* total line_list_items allocated */

main( argc, argv, envp )
int		argc;
char **	argv;
char **	envp;
{
	register int i;
	int memoryStart;		/* memory used when starting */
	int memoryEnd;			/* memory used by end */


	if ( ! parseOpts(argc, argv, envp) )	{
		exit(1);
	}

	if ( doSummary )	{
		memoryStart = sbrk( 0 );		/* current top of mem */
	}

	free( malloc( 25000 ) );			/* pre-get memory */

	processFile();						/* do the work */

	if ( doSummary )	{

		fprintf(stderr, "\ntotal line items required: %d\n", lineItems);

		memoryEnd = sbrk( 0 );			/* final top of mem */
		fprintf(stderr, "memory growth required: %d bytes\n",
							(memoryEnd - memoryStart));

		for (i=0;  i < mvSeqTop; i++)	{
			fprintf(stderr, "encountered %d %s%s\n",
								mvSeqItem[i].count,
								mvSeqItem[i].humanName,
								(mvSeqItem[i].count == 1) ? "" : "s");
		}
	}
}

/*	parseOpts()  --  parse the command line
 *
 */


short
parseOpts(argc, argv, envp)
int argc;
char ** argv;
char ** envp;
{
	register int i;
	register short badInit;		/* bad command line? */


	badInit = FALSE;

	for ( i=1;  i < argc;  i++ )	{

		if ( argv[i][0] != '-' )	{
			badInit = TRUE;
			break;
		}

		switch ( argv[i][1] )	{

		case 'c':	compress = TRUE;
					break;

		case 'f':	first = TRUE;
					break;

		case 'l':	last = TRUE;
					break;

		case 'p':	pageLen = atoi( &argv[i][2] ) * LINESIZE;
					break;

		case 't':	tabPos = atoi( &argv[i][2] );
					break;

		case 's':	doSummary = TRUE;
					break;

		case 'y':	hysteresis = atoi( &argv[i][2] ) * LINESIZE;
					break;

		case 'z':	guarantee = atoi( &argv[i][2] ) * LINESIZE;
					break;

		default:	badInit = TRUE;
					break;
		}
	}

	if ( (first && last)  ||
		 (hysteresis < LINESIZE) ||
		 (guarantee < LINESIZE) ||
		 !tabPos ||
		 (pageLen < LINESIZE) )		{

		badInit = TRUE;
	}

	if ( badInit )		{
		fprintf(stderr, "synopsis: %s [-c] [-f | -l] [-p#] [-t#] [-y#] [-z#]\n",
								argv[0]);
		fprintf(stderr, "\t-c\tcompress out extra blank vertical space (default off)\n");
		fprintf(stderr, "\n\t-f | -l\tshow only first or last char at any single position\n");
		fprintf(stderr, "\t\t(default: show all characters separated by backspaces)\n");
		fprintf(stderr, "\t-p#\tset page length in lines (default 66)\n");
		fprintf(stderr, "\t-t#\tset tab stop position in monospace characters (default 8)\n");
		fprintf(stderr, "\t-y#\tnumber of lines to output at one time (default %d)\n",
									HYSTERESIS);
		fprintf(stderr, "\t-z#\tnumber of lines guaranteed correct (default %d)\n",
									GUARANTEE);
	}

	return ! badInit;
}

/*	processFile()  --  the main loop
 *
 *	process the file, locating text and positions.  As enough becomes
 *	processed, output it
 *
 */


void
processFile()
{
	register int i, ch;
	register short moving;
	register line_list_item * lineItem;


	moving = TRUE;

	while ( EOF != (ch = getToken()) )		{

#if XDEBUG
fprintf(stderr, "next token: '%c'=0%o\n", ch, ch);
#endif

		if ( ch & MOVEMENT )	{

			if ( !moving )	{
				insItemInList( lineItem );		/* put into list */
			}

			switch ( ch & MOVEMASK )	{

			case '\n':	docPosition.x = 0;
						docPosition.y += LINESIZE;
						break;

			case '\r':	docPosition.x = 0;
						break;

			case '\t':	docPosition.x =
							((docPosition.x / tabPos) * tabPos) + tabPos;
						break;

			case '\f':	docPosition.x = 0;
						docPosition.y =
							((docPosition.y / pageLen) * pageLen) + pageLen;
						break;

			default:		/* look in table */
						for ( i=0;  i < mvSeqTop;  i++ )	{
							if ( ch == mvSeqItem[i].name )	{
								docPosition.x += mvSeqItem[i].docPosition.x;
								docPosition.y += mvSeqItem[i].docPosition.y;
								break;
							}
						}
						if ( i == mvSeqTop )	{
							fprintf(stderr, "internal error: unknown movement (0%O)\n", ch);
						}
						break;
			}

			if ( docPosition.x < 0 )	{
				if ( doSummary )	{
					fprintf(stderr, "warning: position has moved to left ");
					fprintf(stderr, "of the margin - forced to zero\n");
				}
				docPosition.x = 0;
			}

			if ( docPosition.y < 0 )	{
				if ( doSummary )	{
					fprintf(stderr, "warning: position has moved above the ");
					fprintf(stderr, "top of the document - forced to zero\n");
				}
				docPosition.y = 0;
			}

			moving = TRUE;

		}	/* end of movement */

		else	{		/* not movement */

			if ( moving )	{		/* new text - create line item */
				lineItem = crLineItem(docPosition);
				moving = FALSE;
			}

			docPosition.x++;
		}

		if ((docPosition.y - basePosition) > (guarantee + hysteresis))	{

			outputText( hysteresis );
		}

	} /* end while more text */

	if ( moving )	{		/* create a fake to get final white space */
		lineItem = crLineItem(docPosition);
		lastLine[0] = 0;
		lastLtop = 0;
	}

	insItemInList( lineItem );

	outputText( guarantee + hysteresis + 1 );

	printf("\n");
}

/*	getToken()  --  return the next input token
 *
 *	also responsible for buffering the last text string seen (everything between
 *	movement tokens).
 *
 */


int
getToken()
{
	register int looki, j, k;
	register int ch;
	char lookAhead[10];


	if ( EOF == (ch = getAChar()) )	{
		return EOF;
	}

	if ( (ch < 040) || (ch >= 0200) )	{	/* movement? */

		for ( j=0;  j < mvSeqTop;  j++)	{
			looki = 0;			/* local lookahead */
			for ( k=0;  mvSeqItem[j].sequence[k];  k++)	{
				if (mvSeqItem[j].sequence[k] == ch)	{
					lookAhead[looki++] = ch;
					if ( mvSeqItem[j].sequence[k+1] )
						ch = getAChar();
					if ( looki >= sizeof(lookAhead) )	{
						fprintf(stderr, "internal error: local lookahead overflow (%d)\n",
								looki);
						exit(2);
					}

				} else	{
					if ( looki )	{
						putAChar(ch);		/* backup that one */
						while ( --looki )	/* backup others */
							putAChar(lookAhead[looki]);
						ch = lookAhead[0];
					}
					break;
				}
			}
			if ( ! mvSeqItem[j].sequence[k] )	{
				mvSeqItem[j].count++;		/* (summary info) */
				return mvSeqItem[j].name;	/* found it */
			}
		}

	} else	{
		lastLine[lastLtop++] = ch;		/* save text character */
		if ( lastLtop >= sizeof(lastLine) )	{
			fprintf(stderr, "error: line too long in input (%d chars)\n",
								lastLtop);
			exit(1);
		}
		lastLine[lastLtop] = 0;			/* always null terminate string */
	}

	return ch;
}

/*	getAChar() and putAChar()  --  get a char and stack a char in the
 *	lookahead buf
 *
 */

static char lookAhead[10];
static int lookAbot = 0;
static int lookAtop = 0;


int
getAChar()
{

	if ( lookAtop > lookAbot )	{		/* got lookahead to use */
		return lookAhead[lookAbot++];	/* return it */
	}

	if ( lookAtop )	{
		lookAbot = lookAtop = 0;		/* clear lookahead */
	}

	return getchar();
}


void
putAChar(ch)
char ch;
{
	register int i;


	if ( ! lookAbot && lookAtop )	{	/* no room to put char */

		if ( (lookAtop+1) >= sizeof(lookAhead) )	{
			fprintf(stderr, "too much backup\n");
			exit(2);
		}

		for ( i=lookAtop; i >= lookAbot;  i-- )		{
			lookAhead[i+1] = lookAhead[i];	/* make room in buffer */
		}
		lookAtop++;

	} else if ( lookAbot )	{
		lookAbot--;					/* room - use it */
	}

	lookAhead[lookAbot] = ch;

	if ( lookAbot == lookAtop )
		lookAtop++;
}

/*	crLineItem()  --  create and initialize a line item
 */


line_list_item *
crLineItem( dpos )
doc_position dpos;
{
	line_list_item * new;


	lineItems++;			/* (for summary) */

	new = (line_list_item *) malloc(sizeof(line_list_item));

	new->docPosition = dpos;
	new->text = new->textStart = 0;
	new->next = 0;

	return new;
}

/*	insItemInList()  --  insert a line_list_item into the list
 */

void
insItemInList( item )
line_list_item * item;
{
	register line_list_item ** this,  * next;


/* insert accumulated text line into the item */

	item->textStart = item->text = malloc(lastLtop+1);
	lastLtop = 0;					/* reset for next line */
	strcpy(item->text, lastLine);

	this = &lineList;
	next = lineList;

	while ( next )	{		/* look thru list */

		if ( (item->docPosition.y < next->docPosition.y) ||
			 ( (item->docPosition.y == next->docPosition.y) &&
			   (item->docPosition.x < next->docPosition.x) ) )	{

			item->next = next;
			*this = item;
			return;
		}

		this = &next->next;
		next = next->next;
	}

	*this = item;
}

/*	outputText()  --  output the right amount of stuff
 *
 */


void
outputText( howMuch )
size howMuch;			/* how much space to output */
{
	register int i;
	register line_list_item * this, * temp, ** head;
	char cell = 0;
	short didOneAtX = FALSE;	/* mult chars at one position? */
	short didVert;				/* output vertical space? */
	doc_position nextPos;
	static doc_position currPos = { 0, 0 };	/* position in output doc */


	if ( !lineList )
		return;					/* nothing to output */

	head = &lineList;
	this = lineList;
	nextPos.y = basePosition = this->docPosition.y;	/* where we start */
	nextPos.x = this->docPosition.x;

	while ( TRUE )	{		/* do another line */

		/* make sure we are at the right place */

		didVert = FALSE;

		if ( currPos.y != nextPos.y )	{

			currPos.x = 0;				/* always forced to left margin */

			while ( currPos.y != nextPos.y )	{

				for (i=0;  i < outMvSeqTop;  i++)	{
					if ( outMvSeq[i].distance <= (nextPos.y - currPos.y) )
						break;
				}

				if ( i == outMvSeqTop )		{
					fprintf(stderr, "internal error: can't move by %d vertical units\n",
											(nextPos.y - currPos.y));
					currPos.y = nextPos.y;
					break;
				}

				printf("%s", outMvSeq[i].sequence);
				currPos.y += outMvSeq[i].distance;	/* but this we can move */

				if ( compress && didVert )	{
					currPos.y = nextPos.y;			/* pretend we did it */
				}

				didVert = TRUE;
			}
		}

		while ( currPos.x != nextPos.x )	{
			printf(" ");
			currPos.x++;
		}

		didOneAtX = FALSE;

		/* check for characters at this position */

		while ( this && (this->docPosition.y == nextPos.y) &&
						(this->docPosition.x == nextPos.x))	{

			if ((first && !cell) || last)	{
				cell = *this->text++;
			}

			if ( !first && !last )	{
				if ( didOneAtX )	{
					printf("\b");
				}
				printf("%c", *this->text++);
				didOneAtX = TRUE;
			}

			if ( ! *this->text )	{	/* used up item */
				temp = this->next;		/* unlink used entry */
				free(this->textStart);
				free(this);
				this = temp;
				*head = this;

			} else	{
				this->docPosition.x++;	/* used one char */
				head = &this->next;		/* not used - point at next */
				this = this->next;
			}
		} /* end while same char pos */

		if ( cell )		{
			printf("%c", cell );		/* output only one here */
			cell = 0;
		}

		didOneAtX = FALSE;				/* passed that place */
		currPos.x++;

		if ( ! lineList )				/* end of list */
			break;		

		head = &lineList;				/* reset for next pass */
		this = lineList;

		if ( lineList->docPosition.y != nextPos.y )		{
			nextPos.y = this->docPosition.y;	/* new line */
		}
		nextPos.x = this->docPosition.x;

		if ( howMuch <= (nextPos.y - basePosition) )	{
			break;						/* did enough */
		}
	}
}
