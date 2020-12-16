/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: indpresort.c,v $
 * Revision 1.1.2.9  1994/06/23  19:49:04  fred
 * 	free copyright
 * 	[1994/06/23  19:43:36  fred]
 *
 * Revision 1.1.2.8  1994/06/23  18:37:53  fred
 * 	free copyright
 * 	[1994/06/22  15:29:50  fred]
 * 
 * Revision 1.1.2.7  1993/08/10  15:15:43  fred
 * 	allow local and master switches.
 * 	[1993/08/10  15:15:27  fred]
 * 
 * Revision 1.1.2.6  1993/04/10  01:03:24  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:43  bowe]
 * 
 * Revision 1.1.2.5  1992/12/14  20:13:00  bowe
 * 	Define TRUE and FALSE if not yet defined.
 * 	[1992/12/14  20:12:32  bowe]
 * 
 * Revision 1.1.2.4  1992/12/10  18:37:52  fred
 * 	various changes to implement the new master index
 * 	[1992/12/10  18:36:20  fred]
 * 
 * Revision 1.1.2.3  1992/10/23  17:40:06  bowe
 * 	Got rid of const.
 * 	[1992/10/23  17:39:38  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:36:33  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:34:06  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/indpresort.c,v 1.1.2.9 1994/06/23 19:49:04 fred Exp $";
#endif

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#ifndef TRUE
# define TRUE	1
#endif
#ifndef FALSE
# define FALSE	0
#endif

static char      err_usage[] = "Usage: indpresort [-p prep filespec]\n";
static char      err_prep_file[] = "Cant access Preposition File: ";
static char      err_prep_many[] = "Too many words in preposition file\n";
static char      err_flags[] = "Unknown flag\n";
static char      err_flags_comb[] = "Illegal flag combination\n";
static char      err_unterm_conceal[] = "unterminated concealed text\n";

/* #define DEBUG 1 */

#define KEYN   5	/* Number of keys -- primary secondard tertiary flags */
#define INPSZ  200	/* max length of input record */
#define PREPN  20	/* max number of words in preposition file */
#define PAGESZ 10	/* max size of page number */
#define FLAGSZ 10	/* max size of flag string */
#define NAMESZ 100	/* max size of preposition filename */
#define MAXKEY 4	/* max number of text fields (terms) */

/*
 int   get_args      (int, char* argv[]);
 void  load_prep     ();
 void  unload_prep   ();
 int   read_entry    (char [][INPSZ]);
 int   locate_fields ();
 void  show_entry    ();
 void  change_tabs   (char*);
 void  clean_space  (char*);
 char  convert_lower (char*);
 void  remove_prep   (char*);
 void  remove_concealed(char*);
 void  hide_quoted   (char*);
 void  reveal_quoted (char*);
 char  remove_format (char*);
 void  remove_commands (char*);
 char  rearrange_punct (char*, char*);
 void  write_entry   ();
 void  strupr (char*);
 void  strnset (char*, char, int);
 char *Strstr (char*, char*);   
 */

int	get_args();
void	load_prep();
void	unload_prep();
int	read_entry();
int	locate_fields();
void	show_entry();
void	change_tabs();
void	clean_space();
char	convert_lower();
void	remove_prep();
void	remove_concealed();
void	hide_quoted();
void	reveal_quoted();
char	remove_format();
void	remove_commands();
char	rearrange_punct();
void	write_entry();
void	strupr();
void	strnset();
char	*Strstr();


char	inp[KEYN][INPSZ];
char	key[KEYN][INPSZ];
char	punct[KEYN][INPSZ];
char	*inp_p[KEYN];
char	alpha_flag[KEYN];
char	case_flag[KEYN];
char	font_flag[KEYN];
char	page[PAGESZ];
char	flags[FLAGSZ];
char	prep_filename[NAMESZ];

char	unused[] = "";
static char      valid_flags[] = "lm![];: ";
static char      quoted_chars[] = "\\{}~-";
char	*prep_tbl[PREPN];
int	prep_l[PREPN];
int	prep_n;

#define AlsoAlpha	"!@#$%^&*_+=|.,/;:\\?<>"
#define NotAlpha	"\\\"\'"

int IsAlpha(c)
char c;
{
	return isalpha(c);

#if FALSE	/* obsolete */
	if ((strchr(NotAlpha, c)) || (c < ' '))
		return FALSE;
	else
		return TRUE;
#endif
}


int 
main(argc, argv)
int	argc;
char	*argv[];

{
	int	ret_code;
	int	i, k, entry_levels;

	if (i = get_args(argc, argv))
		return i;

	load_prep();

	while ((entry_levels=read_entry(inp)) >= 0) {

		if (entry_levels == 0)
			continue;

		if (locate_fields())
			show_entry();

		else {
			for (k = 0; k < KEYN; k++) {
				strcpy(key[k], inp_p[k]);

				hide_quoted(key[k]);
				change_tabs(key[k]);
				case_flag[k] = convert_lower(key[k]);
/*			remove_concealed(key[k]);*/
				remove_prep(key[k]);
				font_flag[k] = remove_format(key[k]);
				clean_space(key[k]);
				alpha_flag[k] = rearrange_punct(key[k], punct[k]);
				reveal_quoted(key[k]);

				change_tabs(inp_p[k]);
				hide_quoted(inp_p[k]);
/*			remove_commands(inp_p[k]);*/
				reveal_quoted(inp_p[k]);
				clean_space(inp_p[k]);
			}
			write_entry();
		}
	}
	unload_prep();
	return FALSE;
}

/*	get_args() -- get command line arguments
 *
 */



int 
get_args(argc, argv)
int	argc;
char	*argv[];
{
	int	i, errors;
	char	*cp;


	errors = 0;
	*prep_filename = '\0';

	for (i = 1; i < argc && *argv[i] == '-'; i++) {

		switch (*++argv[i]) {

		case 'p':
			if (*++argv[i])
				strcpy(prep_filename, argv[i]);
			else if (++i < argc)
				strcpy(prep_filename, argv[i]);
			break;

		default:
			(void)fprintf(stderr, err_usage);
			errors++;
		}
	}
	if (i != argc && !errors) {
		(void)fprintf(stderr, err_usage);
		errors++;
	}
	return errors;
}

/*	load_prep() -- load the preposition file, if any
 *
 */


void 
load_prep()
{
	int	i, j;
	char	*cp, *lp;
	FILE	*prep_file;
	char	buf[100];


	prep_n = 0;
	if (!*prep_filename)
		return;

	if ((prep_file = fopen(prep_filename, "r")) != NULL) {
		for (i = 0; (cp = fgets(buf, 100, prep_file)) && i < PREPN; i++) {
			if (lp = strchr(cp, '\n'))
				*lp = '\0';
			clean_space(cp);
			if (*cp) {
				strupr(cp);
				(void)strcat(cp, " ");
				prep_l[i] = strlen(cp);
				if (prep_tbl[i] = (char *) malloc((unsigned int)(prep_l[i]+1)))
					strcpy(prep_tbl[i], cp);
				else break;
				prep_n++;
			}
		}
		if (i >= PREPN) (void)fprintf(stderr, err_prep_many);
		(void)fclose(prep_file);
	}
	else {
		(void)fprintf(stderr, err_prep_file);
		(void)fprintf(stderr, "%s\n", prep_filename);
	}
}

/*	unload_prep() -- free space used by the preposition file
 *
 */


void 
unload_prep()
{
	int	i;

	for (i = 0; i < prep_n; i++)
		(void)free(prep_tbl[i]);
}

/* read_entry() -- read one entry from the input
 *
 *  Typical input:
 *	2 1\(mi001 OSF/1 networking facilities
 *	overview
 *	1 1\(mi001 TLI
 *	2 1\(mi001 -: TLI
 *	Transport Layer Interface
 *
 *  where the first number of an entry is the number of arguments to the .iX
 *  macro (optional flags, primary, secondary, tertiary).
 *
 *  Read 1st line of entry.
 *  Checking how many lines (1st char)
 *  If # lines is > MAXKEY,
 *	read rest of entry and print error message.
 *  if OK,
 *	point inp_p[0] to "data" of 1st line and read rest of lines into buffer.
 *
 *  Returns depths (levels) of index entry.  0 is bad entry, but we can reover.
 *  Return of -1 means something bad was found and the program bails out.
 */


int 
read_entry(Inp)
char	Inp[][INPSZ];
{
	int	i, j, maxkey;
	char	*cp;

	i = -1;
	if (inp_p[0] = fgets(Inp[0], INPSZ, stdin)) {

		(void)sscanf(Inp[0], "%d %n", &i, &j);		/* get # args and length of # */

		maxkey = MAXKEY;
		if (cp=strchr(Inp[0], '-')) {		/* BUG IF ARG CONTAINS A DASH??? */
			cp--;
			if (*cp == ' ') maxkey++;		/* bump maxkey if flags present */
		}

		if (i > maxkey) {		/* error: too many args */

			if (cp=strchr(Inp[0], '\n'))
				*cp = 0;
			fprintf(stderr, "ERROR: too many index levels (%d). Entry: %s", i, Inp[0]);
			for (j = 1; j < i; j++) {
				fgets(Inp[1], INPSZ, stdin);
				if (cp=strchr(Inp[1], '\n')) *cp = 0;
				fprintf(stderr, "...%s", Inp[1]);
			}
			fprintf(stderr, "\n");
			return FALSE;
		}

		inp_p[0] += j;			/* skip arg count in string */

		for (j = 1; j < i; j++)		/* get remaining args */
			inp_p[j] = fgets(Inp[j], INPSZ, stdin);

		for (j = 0; j < i; j++)
			Inp[j][strlen(Inp[j]) - 1] = '\0';

		for (; j < KEYN; j++)
			inp_p[j] = unused;
	}
#ifdef DEBUG
	printf ("read "); for (j=0; j<KEYN; j++)  printf("%s/", inp_p[j]);
	printf ("\n"); 
#endif
	return i;
}

/*	write_entry() -- write one entry to the output stream
 *
 * Output form (from left to right on one line...):
 *
 *	DELIM	CONTENT		LENGTH		DESCRIPTION
 *
 *		alpha_flag[0]	1		returned from rearrange_punct --
 *						(1 - no alphabetics, 2 - starts with
 *						 a symbol, 3 - starts with a digit,
 *						 4 - contains alphabetics)
 *		key[0]		string		primary term
 *	^B			1		(delim)
 *		case_flag[0]	1		returned from convert_lower --
 *						(1 - no lowercase, 3 - no uppercase,
 *						 2 - only first char is uppercase,
 *						 4 - uppercase after first char)
 *		punct[0]	string		contains punctuation remnants from
 *						mixed alphabetic/punct term (created
 *						by rearrange_punct)
 *	^B			1		(delim)
 *		font_flag[0]	1		returned by remove_format (0 - no font
 *						changes, 1 - font changes)
 *	^A			1		(delim)
 *  <repeat above for [1], [2], and [3]>
 *		page		string		the page number
 *	^A			1		(delim)
 *		pf		1		(1 - start of range, 3 - end of range,
 *						 2 - regular entry)
 *		flags		string		index item flags
 *	^A			1		(delim)
 *  <terms [0], [1], [2], [3], each followed by a ^A delimiter>
 */


void 
write_entry()
{
	int	i;
	char	pf;

#ifdef DEBUG
	printf ("page %s flags %s \n", page, flags);
	for (i=0; i<KEYN; i++)
		printf ("input=%s     key=%s    punct=%s    ACF=%c%c%c\n",
			 inp_p[i],    key[i],   punct[i],   alpha_flag[i],
							    case_flag[i],
							    font_flag[i] );
	printf ("\n"); 
#endif

	for (i = 0; i < KEYN; i++) {
		printf("%c%s%c%c%s%c%c%c",
			alpha_flag[i], key[i], 0x02, case_flag[i], punct[i], 0x02,
			font_flag[i], 0x01);
	}
	pf = '2';
	if (strchr(flags, '['))
		pf = '1';
	if (strchr(flags, ']'))
		pf = '3';

	printf("%s%c%c%s%c", page, 0x01, pf, flags, 0x01);

	for (i = 0; i < KEYN; i++) {
		if (inp_p[i][0] == '\007')
			printf("%s%c", &inp_p[i][1], 0x01);	/* skip BEL */
		else
			printf("%s%c", inp_p[i], 0x01);
	}
	printf("\n");
}

/*	locate_fields() -- parse the input entry
 *
 */


int 
locate_fields()
{
	int	i, j;
	char	*fp, *rp, *cp;


	fp = inp_p[0];
	i = (cp = strchr(fp, ' ')) - fp;
	(void)strncpy(page, fp, i);
	page[i] = '\0';
	*flags = '\0';
	fp = cp + strspn(cp, " ");

	if (*fp == '-' && *(fp + 1) != '-') {
		if (rp = strpbrk(fp, ":;"))
			i = rp - fp + 1;
		else
			i = strlen(fp);

		if (i >= FLAGSZ) {
			(void)fprintf(stderr, err_flags);
			return TRUE;
		}
		(void)strncpy(flags, fp, i);
		flags[i] = '\0';
		if (strspn(flags + 1, valid_flags) != strlen(flags + 1)) {
			(void)fprintf(stderr, err_flags);
			return TRUE;
		}
		if (strlen(flags) > ( strchr(flags, '!') &&
			(strchr(flags, ']') || strchr(flags, '[')) ? 3 : 2 ) )
		{
			(void)fprintf(stderr, err_flags_comb);
			return TRUE;
		}
		fp += i;
		for (i = 0; i < KEYN - 1; i++)
			inp_p[i] = inp_p[i + 1];
		if (rp) {
			inp_p[i] = fp;
			strcpy(page, "zzzzzzz");
		}
		else inp_p[i] = unused;
	}
	else
		inp_p[0] = (*fp == '-') ? fp + 1 : fp;

#ifdef DEBUG
	printf ("inp field "); for (i=0; i<KEYN; i++) printf("%s/",inp_p[i]);
	printf ("\n"); 
#endif

	return FALSE;
}

/*	show_entry() -- show entry (esp if an error is discovered)
 *
 */


void 
show_entry()
{
	int	i;

	(void)fprintf(stderr, "Entry: ");
	for (i = 0; i < KEYN; i++)
		if (inp_p[i] != unused)
			(void)fprintf(stderr, "\"%s\"   ", inp_p[i]);

	(void)fprintf(stderr, "page: \"%s\"   flags: \"%s\"\n", page, flags);
}

/*	change_tabs() -- change tabs into spaces
 *
 */

void 
change_tabs(str)
char	*str;
{
	char	*cp;

	while (cp = strchr(str, '\t'))
		*cp = ' ';
}


/*	clean_space() -- turn multiple spaces into single spaces and
 *			 trim leading and trailing spaces
 *
 */

void 
clean_space(str)
char	*str;
{
	int		i;
	char	*sp, *dp, prev;

	for (prev = 'x', sp = dp = str; prev; prev = *sp++)
		if (prev != ' ' || *sp != ' ')
			*dp++ = *sp;

	if (str[0] == ' ')
		strcpy(str, str + 1);

	if (str[i = strlen(str) - 1] == ' ' && i >= 0)
		str[i] = '\0';
}

/*	convert_lower() -- convert str to upper case (return info code)
 *
 *	turns all lowercase characters into uppercase
 *
 *  info code:
 *
 *	1	no lowercase in (str)
 *	3	no uppercase in (str)
 *	2	only the first character is uppercase
 *	4	uppercase after the first character
 *
 */


char 
convert_lower(str)
char	*str;
{
	char	c;
	int	i, upper, lower;

	for (upper=lower=i=0;  str[i];  i++) {

		if (isalpha(str[i])) {		/* alphabetics only */

			if (isupper(str[i]))
				upper++;	/* already uppercase */
			else
				lower++;	/* lowercase */
		}
	}

	if (lower == 0)
		c = '1';
	else if (upper == 0)
		c = '3';
	else if (upper == 1 && isupper(str[0]))
		c = '2';
	else
		c = '4';

	strupr(str);
	return c;
}


void 
remove_prep(str)
char	*str;
{
	char	*cp;
	int	i;

	for (i = strlen(str) - 1; i >= 0 && str[i] == ' '; i--);
	str[++i] = '\0';
	cp = str;

	while (*cp) {
		cp += strspn(cp, " ");
		if (*cp == '~' && isalpha(*++cp)) {
			*(cp - 1) = ' ';
		}
		else if (isalpha(*cp)) {
			for (i = 0; i < prep_n; i++) {
				if (!strncmp(cp, prep_tbl[i], prep_l[i])) {
					strnset(cp, ' ', prep_l[i]);
					break;
				}
			}
			if (i == prep_n) break;
		}
		cp += strcspn(cp, " ");
	}
}


void 
hide_quoted(str)
char	*str;
{
	char	*cp;
	int	span, i;
	char	string_quote[2];

	cp = str;
	while (*(cp += strcspn(cp, quoted_chars))) {
		string_quote[0] = *cp;
		string_quote[1] = '\0';
		span = strspn(cp, string_quote);
		cp += span % 2;
		for (i = 0; i < span / 2; i++)
			*cp++ |= 0x80;
/*		*cp++ |= '\x80';*/
		if (span > 1)
			strcpy(cp, cp + span / 2);
		cp += span / 2;
	}
}


void 
reveal_quoted(str)
char	*str;
{
	char	*cp;

	for (cp = str; *cp; cp++)
		*cp &= 0x7F;
}

/*	remove_format() -- remove font changes from (str) -- return code
 *			   indicating what was done
 *
 *  code returned:
 *
 *	0	no font changes found
 *	1	font change found
 */


char 
remove_format(str)
char	*str;
{
	char	*sp, flag;
	char	*cp;

	flag = '0';
	for (sp = str; sp;) {

		if (sp = Strstr(sp, "\\F")) {
			flag = '1';
			strcpy(sp, (*(sp + 2) == '(') ? sp + 5 : sp + 3);
		}
	}
	return flag;
}

/*	rearrange_punct() -- rearrage the punctuation in (str) and (Punct) and
 *			     return a code to explain what happenned
 *
 *	if (str) doesn't start with a digit, then this function will strip all
 *	double quotes from (str).
 *
 *  code returned:
 *
 *	3	(str) starts with a digit.  Punct cleared.  Doesn't look beyond
 *		the first character.
 *	2	(str) starts with a symbol.  Punct cleared.  Doesn't look beyond
 *		the first character.
 *	1	(str) contains no alphabetics.  Punct cleared, (str) unchanged.
 *	4	(str) contains an alphabetic.  For any punctuation in (str),
 *		Punct contains 2 bytes naming the position of the punctuation
 *		(eg, "12") followed by the punctuation character.  The punctuation
 *		is stripped from (str).
 *
 *	Also, there is a special trick for forcing entries to be sorted first (they
 *	get a '2' to become a symbol entry).  If a term starts with a BEL character
 *	(\007 == ^G), then the BEL will get stripped, but the 2 gets assigned.  This
 *	is used to cause book names to be sorted first in a master index.
 */


char 
rearrange_punct(str, Punct)
char	*str;
char	*Punct;
{
	char	*sp, *dp, *pp, content;

	sp = str;
	pp = Punct;

	if (isdigit(*sp))
		content = '3';

	else if ( ! IsAlpha(*sp) )	{
		content = '2';

		if (*sp == '\007')
			strcpy(sp, sp+1);	/* skip the BEL */

	} else {
		for (content = '1'; *sp && content == '1'; sp++)

			if (IsAlpha(*sp))
				content = '4';

		for (dp=sp=str; *sp; sp++) {

			if (*sp == '~')
				*dp++ = *++sp;
			else {
				if (content == '4' && !IsAlpha(*sp)) {
					(void)sprintf(pp, "%02d", sp - str);
					pp += 2;
					*pp++ = *sp;
				}
				else
					*dp++ = *sp;
			}
		}
		*dp = '\0';
	}
	*pp = '\0';
	return content;
}

void 
strupr(cp)
char	*cp;
{
	for (; *cp; cp++)
		*cp = toupper(*cp);
}

void 
strnset(cp, c, len)
char	*cp;
char	c;
int	len;
{
	for (; len-- > 0; *cp++ = c);
}

char	*
Strstr(src, pat)
char	*src;
char	*pat;
{
	char	*sp;
	int	l;

	sp = src;
	l = strlen(pat);
	while (sp) {
		if (sp = strchr(sp, *pat)) {
			if (!strncmp(sp, pat, l)) break;
			else sp++;
		}
	}
	return sp;
}

/***** OBSOLETE FUNCTIONS *****/

#if 0

void 
remove_concealed(str)
char	*str;
{
	char	*sp, *ep;

	sp = str;
	while (sp = strchr(sp, '{')) {

		if (ep = strchr(sp, '}'))
			strcpy(sp, ep + 1);
		else {
			(void)fprintf(stderr, err_unterm_conceal);
			show_entry();
			sp = 0;
		}
	}
}

void 
remove_commands(str)
char	*str;
{
	char	*cp;

	for (cp = str; *cp; cp++) {
		cp += strcspn(cp, "{}~");
		if (*cp)
			strcpy(cp, cp + 1);
	}
}

#endif
