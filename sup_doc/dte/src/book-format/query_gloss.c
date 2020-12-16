/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: query_gloss.c,v $
 * Revision 1.1.2.5  1994/06/23  19:49:10  fred
 * 	free copyright
 * 	[1994/06/23  19:44:04  fred]
 *
 * Revision 1.1.2.4  1994/06/23  18:37:58  fred
 * 	free copyright
 * 	[1994/06/22  15:30:07  fred]
 * 
 * Revision 1.1.2.3  1993/04/10  01:03:28  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:49  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:36:44  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:34:14  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid=
  "$Header: /u1/rcs/dte/book-format/query_gloss.c,v 1.1.2.5 1994/06/23 19:49:10 fred Exp $";
#endif

/*
 *	Extract glossary definitions for specified terms
 */

#include <stdio.h>
#include <errno.h>
#include <ctype.h>
#include <string.h>

/* status values */
#define SUCCESS		0
#define FAILURE		(-1)

/* string compare functions */
#define STREQ(s,t)	(strcmp(s,t) == 0)
#define STRNE(s,t)      (strcmp(s,t) != 0)

/* define for end of string, delimiter and other */
#define EOS		'\0'

#define BUF_LEN		200

/* internally defined routines */
int	fnd_term();
void    nxt_term();
void	do_term();
void	frm_term();
void	no_term();
void    no_defs();
void	empty_templ();
void	one_defin();
int	frm_def_arr();
int	chk_defin();
void	frm_one_def();
void    print_line();
int	normFile();
int	extr_num();
void	ini_term();
void	frm_text();
void    nxt_line();
int	getRefs();
char	*strsubenD();

/* globally defined data */
char     g_name[200];
char     g_acr[15];
int	 g_num_def;
char     g_def[15][2000];
char     g_xref[40][200];
char     g_book[40][25];
char     g_top[40][100];
int	 g_def_arr[15];
char     g_term[4095];
int      quiet;

main(argc, argv)
int	argc;
char	*argv[];
{
	FILE	*tfd, *glfd=0, *outfd;
	char	path[120];	/* to glossary flat file absolute path name */
	char	flat[150];	/* to hold complete glossary flat file name */
	char	savnam[20], fname[20];
	char	t_name[BUF_LEN];
	char	bk_name[20];
	char	letter;
	char	line[BUF_LEN];
	char	*ptr;
	int	read_ind, pass_ind, fnd_ind, end, bk_ind, tfile_ind, outfile_ind;

	int	status = SUCCESS;

	/* must provide with tree arguments */
	if  (argc < 5)
		return(command_line());

	if (STREQ(argv[1], "-q") ) {
		quiet = 1;
		argv++;
	}
	/* get the book */
	strcpy(bk_name, "");
	bk_ind = 0;
	if (STREQ(argv[1], "-all") )
		bk_ind = 1;
	else
		strcpy(bk_name, argv[1]);

	/* check if terms will be passed via stdin or term file */
	if (STREQ(argv[2], "-") ) {
		tfile_ind = 0;
		tfd = stdin;
	}
	else {
		tfile_ind = 1;
		/* check the input file with terms for existence */
		if ( (tfd = fopen(argv[2], "r")) == NULL ) {
			fprintf(stderr, "Can't open %s input file\n",argv[2]);
			perror("fopen of input file");
			exit(1);
		}
	}

	path[0] = EOS;
	strcat(path, argv[3]);

	/* open output file */
	if (STREQ(argv[4], "-") ) {
		outfile_ind = 0;
		outfd = stdout;
	}
	else {
		outfile_ind = 1;
		if ( (outfd = fopen(argv[4], "w")) ==  NULL ) {
			fprintf(stderr, "Can't open %s output file\n",argv[4]);
			perror("fopen of output file");
			exit(1);
		}
	}

	strcpy(savnam, "");
	end = 0;

	/* read next term name */
	while ( fgets(t_name, BUF_LEN, tfd) && (end == 0) ) {

		/* replace EOL by EOS */
		if (ptr=strchr(t_name,'\n')) *ptr = EOS;
		if (t_name[0] == EOS)	/* if author did .gL with no term */
			continue;
		if (!strncmp(t_name, "|.#", 3))		/* comment */
			continue;

		/* form normalize glossary file name */
		if (isalpha(t_name[0])) {
			if (islower(t_name[0])) letter = toupper(t_name[0]);
			else letter = t_name[0];
		}
		else
			letter = '@';		/* all non-alpha terms */
		sprintf(fname, "gloss%c", letter);
		pass_ind = 0;

		/* compare file names */
		if (STRNE(fname, savnam) ) {
			sprintf(flat, "%s/%s", path, fname);
			/* close old glossary file and open new one */
			if ((status = normFile(1,&glfd,flat,"")) != SUCCESS)
				end = 1;

			/* save new name */
			strcpy(savnam, "");
			strcpy(savnam, fname);
			pass_ind = 1;
			read_ind = 0;
		}

		/* find the next term lines in the glossary file */
		if (status == SUCCESS) {
			status =
		  fnd_term(&pass_ind,&read_ind,&fnd_ind,t_name,&glfd,flat,line);
			/* status != SUCCESS when fopen returned an error */
			if (status != SUCCESS)
				end = 1;
			else {
				/* fnd_ind = 1 if the term is found */
				if (fnd_ind)
					do_term(outfd,bk_ind,bk_name);
				else
					no_term(t_name,outfd);
			}
		}
	} /* end of term file */

	if (tfile_ind)
		fclose(tfd);
	if (outfile_ind)
		fclose(outfd);
	fclose(outfd);
	(void)normFile(3, &glfd, "", "");

	return 0;
}


/*
 *
 *  Function to find the term in the glossary file
 *
 *	fnd_ind -- find term indicator
 *	glfd 	-- glossary file file descriptor
 *	glfname	-- glossary file filename
 *
 *	RETURN:
 *		FAILURE -- failed to reopen glossary file
 *
 *		fnd_ind = 1	- the term is found
 *			= 0	- the term is not found
 *
 */
fnd_term(pass, read, fnd_ind, t_name, glfd, glfname, line)
int	*pass, *read, *fnd_ind;
char	*t_name;
FILE    **glfd;
char	*glfname, *line;
{
	int	end = 0;
	int	status = SUCCESS;

	*fnd_ind = 0;
	while ( (*pass < 2 ) && ( !end ) ) {
		/* initialize all g_* global data */
		ini_term();

		nxt_term(read,glfd,glfname,line);

		/* compare term names */
		if (STREQ(t_name, g_name) ) {
			*fnd_ind = 1;
			end = 1;
		}

		if ( !end ) {
			/* g_name is empty in the EOF case */
			if (STREQ(g_name, "")) {
				(*pass)++;
				*read = 0;
				/* close and open glossary file for the */
				/* second pass */
				if ((status = normFile(1,glfd,glfname,""))
								!= SUCCESS)
					end = 1;
			}
		}
	}
	return(status);
}


command_line()
{
	printf("\nCommand line format is:\n\n");
	printf(" query_gloss <book id/ -all> <file with terms>");
	printf(" <normalized files path> <output file>\n\n");

	return(SUCCESS);
}

/* ______________________________________________________________________ */

/*
 * Extract next term from the normalized glossary file
 *
 */
void nxt_term(read, fd, fname, line)
int	*read;
FILE	**fd;
char	*fname, *line;
{
	char	*ptr;
	int	stop, end, eof, x_ind, b_ind, t_ind;
	int	status = SUCCESS;

	/* read a line if none is read */
	if ( !(*read)) {
		strcpy(line, "");
		status = normFile(2, fd, "", line);
		*read = 1;
	}

	/* find the TERM line */
	end = 0;
	eof = 0;
	while ( ( !end ) && ( !eof ) ) {
		if (STREQ(line, "") )
			/* if the line is empty -- end of file */
			eof = 1;
		else {
			ptr = strsubenD(line, "|.TERM|");
			if ( ptr != NULL )
				/* TERM line is found */
				end = 1;
			else {
				fprintf(stderr,
  "ERROR: Syntax error in file '%s' -- TERM line expected:\n  '%s'.\n",
								fname, line);
				/* read next line */
				status = normFile(2, fd, "", line);
			}
		}
	}

	/* if not end of file */
	if ( !eof ) {
		/* save term name */
		strcpy(g_name, ptr);
		/* replace EOL by EOS in term name */
		if (ptr=strchr(g_name,'\n')) *ptr = EOS;

		/* get the ACR line */
		status = normFile(2, fd, "", line);
		if (STREQ(line, "") )
			eof = 1;
	}

	/* if still not end of file */
	if ( !eof ) {
		stop = 0;
		ptr = strsubenD(line, "|.ACR|");
		if ( ptr == NULL ) {
			fprintf(stderr,
   "ERROR: Syntax error in file '%s' -- ACR line expected:\n  '%s'.\n",
								fname, line);
			stop = 1;
		}
		else {
			/* an ACR line is found */
			strcpy(g_acr, ptr);
			/* replace EOL by EOS in acronym */
			if (ptr=strchr(g_acr,'\n')) *ptr = EOS;

			/* get the DEFIN line */
			status = normFile(2, fd, "", line);
			if (STREQ(line, "") )
				eof = 1;
		}
	}

	/* if neither end of file nor syntax error */
	g_num_def = 0;
	x_ind = 0;
	b_ind = 0;
	t_ind = 0;
	if ( ( !eof ) && ( !stop ) ) {
		/* get all definitions for the term */
		end = 0;
		while ( !end ) {
			ptr = strsubenD(line, "|.DEFIN|");
			if ( ( ptr == NULL ) && ( !g_num_def)  )
				fprintf(stderr,
	     "ERROR: Syntax error in file '%s' -- DEFIN line expected:\n  '%s'.\n",
								fname, line);
			if ( ptr == NULL )
				end = 1;
			else {
				/* get one (next) definition for the term */
				g_num_def++;
				one_defin(fd,line,&x_ind,&b_ind,&t_ind);
				if (STREQ(line, "") )
					eof = 1;
			}
		}
	}
	return;
}

/*
 * Perform definition selection and term output (do the term)
 *
 */
void do_term(fd, bk_ind, bk_name)
FILE	*fd;
int	bk_ind;
char	*bk_name;
{
	int	status;

	status = frm_def_arr(bk_ind, bk_name);

	if (status != SUCCESS) {
	    if (!quiet) {
		fprintf(stderr,
		 "ERROR: Term '%s' is not found in glossary database for book '%s'.\n",
							 g_name, bk_name);
		no_defs(fd);
	    }
	}
	else {
		if (g_num_def != 0)
			frm_term(fd);
		else {
			fprintf(stderr,
				"ERROR: Term '%s' has no definitions.\n", g_name);
			no_defs(fd);
		}
	}

	return;
}


/*
 * Output term (with the appropriate definitions)
 *
 */
void	frm_term(fd)
FILE    *fd;
{
	char	line[200];
	int	i, j, d_num;

	/* count number of definitions */
	j = 0;
	for (i=0; g_def_arr[i] != -1; i++)
		j++;

	sprintf(line,"|.TERM|%s|%d\n|.ACR|%s\n",g_name,j,g_acr);
	strcat(g_term, line);

	/* if no definitions for the book, put empty template lines */
	d_num = 1;
	for (i=0; g_def_arr[i] != -1; i++) {
		frm_one_def(g_def_arr[i],d_num);
		d_num++;
	}

	fputs(g_term,fd);

	return;
}

/*
 * Form empty template lines if term is not found
 */
void	no_term(name, fd)
char	*name;
FILE    *fd;
{

	fprintf(stderr, "ERROR: Term '%s' not found in glossary database.\n",name);

	sprintf(g_term,"|.TERM|%s|0\n|.ACR|\n",name);
	empty_templ(fd);

	return;
}

/*
 * Form empty template lines if no definitions
 */
void    no_defs(fd)
FILE    *fd;
{

	sprintf(g_term,"|.TERM|%s|0\n|.ACR|%s\n",g_name,g_acr);
	empty_templ(fd);

	return;
}


/*
 * Output empty template lines
 */
void    empty_templ(fd)
FILE    *fd;
{
	char    line[200];

	sprintf(line,
	      "  |.DEFIN|1|\n    |.XREF|\n    |.BOOK|\n    |.TOPIC|\n");
	strcat(g_term, line);

	fputs(g_term,fd);

	return;
}

/* ______________________________________________________________________ */

/*
 * Get one (next) definition for the term
 */
void	one_defin(fd, line, x_ind, b_ind, t_ind)
FILE	**fd;
char	*line;
int	*x_ind;
int     *b_ind;
int     *t_ind;
{
	char	*ptr, *ptr1;
	int	num, stop;

	num = g_num_def - 1;
	stop = 0;

	ptr1 = strsubenD(line, "|.DEFIN|");
	if ( ptr1 == NULL )
		stop = 1;

	if ( !stop )
		ptr = strsubenD(ptr1, "|");
		if ( ptr == NULL )
			stop = 1;

	if ( stop ) {
		fprintf(stderr,
			"ERROR: Syntax error in DEFIN line (for term '%s'):\n'%s'.\n",
							 g_name,line);
	}

	/* process definition text */
	if ( !stop )
		stop = getText(fd,line,ptr,num);

	/* get XREF lines */
	if ( !stop )
		stop = getRefs("XREF",x_ind,num,fd,line);

	/* get BOOK lines */
	if ( !stop )
		stop = getRefs("BOOK",b_ind,num,fd,line);

	/* get TOPIC lines */
	if ( !stop )
		stop = getRefs("TOPIC",t_ind,num,fd,line);

	return;
}


/*
 * get definition text
 */
int	getText(fd,line,ptr,num)
FILE    **fd;
char    *line, *ptr;
int     num;
{
	char	*ptr1;
	int	end, stop, i, status;

	stop = 0;
	g_def[num][0] = EOS;

	end = 0;
	while ( !end ) {
		/* append definition text */
		strcat(g_def[num], ptr);

		status = normFile(2, fd, "", line);
		if (STREQ(line, "") ) {
			stop = 1;
			end = 1;
		}
		else {
			ptr = line;
			ptr1 = strsubenD(line, "|.");
			if ( ptr1 != NULL )
				end = 1;
		}
	}

	/* get rid of last leading blank */
	i = strlen(g_def[num]);
	if (g_def[num][i-1] == ' ')
		g_def[num][i-1] = EOS;

	return(stop);
}


/*
 *  form g_def_arr with definition subscripts numbers
 */

int	frm_def_arr(bk_ind, bk_name)
int     bk_ind;
char    *bk_name;
{
	int	i, k, find;
	int	status = SUCCESS;

	k = 0;
	if (g_num_def != 0) {
		for (i = 0; i<g_num_def; i++) {
			if (chk_defin(i, bk_ind, bk_name) == 1)  {
				g_def_arr[k] = i;
				k++;
			}
		}
		if (k == 0)
			status = FAILURE;
	}
	return(status);
}


/*
 * Check if there is a reference for the book in the term definition
 */
int	chk_defin(ind, bk_ind, bk_name)
int	ind, bk_ind;
char    *bk_name;
{
	char	*ptr;
	int	num, status;
	int	i = 0;
	int	find = 0;

	if (bk_ind == 1)
		find = 1;

	while ( (!find) && (STRNE(g_book[i],"")) ) {
		num = -1;
		if ((status = extr_num(g_book[i], &num, &ptr)) == SUCCESS) {
			if ( (num == ind) && (STREQ(ptr, bk_name)) )
				find = 1;
		}
		i++;
	}
	return(find);
}


/*
 * Put out all xref, book and topic lines for one definition
 */
void	frm_one_def(subscr, d_num)
int	subscr;
int	d_num;
{
	char    *ptr;
	int     i, num, status;

	/* form and output definition text lines */
	frm_text(d_num, g_def[subscr]);

	/* output XREF lines */
	for (i=0; STRNE(g_xref[i],""); i++) {
		if ((status = extr_num(g_xref[i], &num, &ptr)) == SUCCESS) {
			/* if matching subscript -- output xref */
			if (num == subscr)
				print_line("XREF",ptr);
		}
	}

	/* output BOOK lines */
	for (i=0; STRNE(g_book[i],""); i++) {
		if ((status = extr_num(g_book[i], &num, &ptr)) == SUCCESS) {
			/* if matching subscript -- output book */
			if (num == subscr)
				print_line("BOOK",ptr);
		}
	}

	/* output TOPIC lines */
	for (i=0; STRNE(g_top[i],""); i++) {
		if ((status = extr_num(g_top[i], &num, &ptr)) == SUCCESS) {
			/* if matching subscript -- output topic */
			if (num == subscr)
				print_line("TOPIC",ptr);
		}
	}

	return;
}


void print_line(name,ptr)
char  *name;
char  *ptr;
{
	char line[200];

	sprintf(line, "      |.%s|%s\n",name,ptr);
	strcat(g_term, line);

	return;
}

/* ______________________________________________________________________ */

/*
 *  Operations on normilizes glossary files
 *
 *	options:
 *		1  -- close previous file and open new file
 *		2  -- read one line
 *		3  -- close file
 *
 *	return: success if new line is read
 *	failure: on EOF
 */
int	normFile(option, fd, fname, line)
int	option;
FILE	**fd;
char	*fname;
char	*line;
{
	int	status;

	status = SUCCESS;

	switch (option) {
		case 1:
			if (*fd != NULL)
				fclose(*fd);
			if ( (*fd = fopen(fname, "r")) == NULL ) {
				status = FAILURE;
				fprintf(stderr,
					"ERROR: Can't open %s glossary file\n",fname);
			}
			break;

		case 2:

			line[0] = EOS;
			while (1) {
			    if (fgets(line, BUF_LEN, *fd) == NULL) {
				status = FAILURE;
				break;
			    }
			    if (strncmp(line, "|.#", 3))	/* comment */
				break;
			}
			break;

		case 3:
			if (*fd != NULL)
				fclose(*fd);
			break;

		default:
			fprintf(stderr,
			    "ERROR: Illegal option '%d' passed to normFile\n",option);
			status = FAILURE;
			break;
	} /* end of switch */

	return(status);
}


/*
 *   Initialize term's global variables
 */
void	ini_term()
{
	int	i;

	strcpy(g_name, "");
	strcpy(g_acr, "");
	strcpy(g_term, "");
	g_num_def = 0;

	for (i=0; i<15; i++) strcpy(g_def[i], "");

	for (i=0; i<40; i++) strcpy(g_xref[i], "");

	for (i=0; i<40; i++) strcpy(g_book[i], "");

	for (i=0; i<40; i++) strcpy(g_top[i], "");

	for (i=0; i<15; i++) g_def_arr[i] = -1;

	return;
}


/*
 * Extract a number from the buffer
 *
 *  Routine extracts number (from the beginning of the buffer to separator)
 *
 *     Return:   -- extracted number
 *               -- pointer, pointing after the delimiter
 */

int	extr_num(buf, pnum, pptr)
char	*buf;
int	*pnum;
char	**pptr;
{
	char	*ptr;
	int	status = SUCCESS;

	if ((ptr=strchr(buf, '|')) == NULL) {
		fprintf(stderr,
  "ERROR: Syntax: no '|' separator found in line:\n%s for term '%s'\n",buf,g_name);
		status = FAILURE;
	}
	else {
		*ptr = EOS;
		*pnum = atoi(buf);
		*ptr = '|';
		ptr++;
		*pptr = ptr;
	}

	return(status);
}


/*
 * Form definition text
 *
 */
void	frm_text(d_num, text)
int	d_num;
char	*text;
{
	char    *ptr;
	char    txt_buf[2000];
	char    out_line[2000];
	char    first_line[30];
	int     l_num, l_len, stat;

	ptr = text;
	sprintf(first_line,"   |.DEFIN|%d|",d_num);

	if (ptr == EOS) {
		fprintf(stderr,
			"ERROR: Syntax: empty definition text for term %s\n", g_name);
		exit(1);
	}

	stat = 1;
	l_num = 0;
	l_len = 65;
	while (stat) {
		if (l_num != 0)
			l_len = 78;
		nxt_line(&ptr, txt_buf, &stat);
		if (l_num == 0)
			sprintf(out_line,"%s%s\n",first_line,txt_buf);
		else
			sprintf(out_line,"%s\n",txt_buf);
		strcat(g_term, out_line);
		l_num++;
	}
	return;
}


/*
 *  form one text line
 */
void    nxt_line(ptr, buf, stat)
char    **ptr;
char    *buf;
int     *stat;
{
	int     i;

	buf[0] = EOS;
	/*  Do not do text filling.  -JBowe */
	strcpy(buf, *ptr);
	*stat = 0;
	i = strlen(buf) - 1;
	if (buf[i] == '\n') buf[i] = EOS;	/* kill trainling newline */
	return;
}


/*
 * get one group of references (xref, book, topic) for the definition
 */

int	getRefs(ref_name,indx,num,fd,line)
char    *ref_name;
int	*indx;
int	num;
FILE    **fd;
char	*line;
{
	int	i, end, stop, first, status;
	char	*ptr, *ptr1;
	char    ref_str[15];

	stop = 0;
	end = 0;
	first = 1;

	/* form reference string */
	sprintf(ref_str,"|.%s|",ref_name);
	i = *indx;

	while ( !end ) {
		ptr = strsubenD(line,ref_str);
		if ( ( ptr == NULL ) && (first) )
			fprintf(stderr,
     "ERROR: Syntax error -- %s line expected:\n'%s' (for term '%s')\n",
							ref_name,line,g_name);
		if ( ptr == NULL )
			end = 1;
		else {
			first = 0;
			/* replace EOL by EOS */
			if (ptr1=strchr(ptr,'\n')) *ptr1 = EOS;

			/* save reference */
			switch (ref_name[0]) {
				case 'X':
					sprintf(g_xref[i],"%d|%s",num,ptr);
					break;

				case 'B':
					sprintf(g_book[i],"%d|%s",num,ptr);
					break;

				case 'T':
					sprintf(g_top[i],"%d|%s",num,ptr);
					break;

				default:
					break;
			}
			i++;

			/* read next line */
			status = normFile(2, fd, "", line);
			if (status == FAILURE || STREQ(line, "") ) {
				stop = 1;
				end = 1;
			}
		}
	}
	*indx = i;

	return(stop);
}


char* strsubenD(str1, str2)
char* str1;
char* str2;
{
int i, j, l;
char* addr;
	addr = NULL;
	l = strlen(str2);
	i =0; j =strlen(str1) - l;
	while ( i <= j ) {
		if ( strncmp(str2,&str1[i],l) == 0 ) {
			addr = &str1[i+strlen(str2)];
			break;
		}
		i++;
	}
	if ( strlen(str1) == 0 ) addr = NULL;
	return( addr);
}

