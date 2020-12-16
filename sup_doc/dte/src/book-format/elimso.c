/*
 * @OSF_FREE_COPYRIGHT@
 *
 * Copyright 1991,1992,1993 Open Software Foundation, Inc.,
 * Cambridge, Massachusetts
 * All rights reserved.
 */

/*
 * HISTORY
 * $Log: elimso.c,v $
 * Revision 1.1.2.6  1994/06/23  19:48:30  fred
 * 	free copyright
 * 	[1994/06/23  19:41:36  fred]
 *
 * Revision 1.1.2.5  1994/06/23  18:37:23  fred
 * 	free copyright
 * 	[1994/06/22  15:28:23  fred]
 * 
 * Revision 1.1.2.4  1993/04/10  01:03:02  bowe
 * 	Add OSF copyright.
 * 	[1993/04/10  01:00:07  bowe]
 * 
 * Revision 1.1.2.3  1992/08/28  17:40:51  bowe
 * 	Fix uninitialized variable.  Also tested if we're reading stdin before
 * 	closing file.  CR 402. Reported by sony.
 * 	[1992/08/28  17:40:29  bowe]
 * 
 * Revision 1.1.2.2  1992/07/07  18:35:53  bowe
 * 	Initial rev.
 * 	[1992/07/07  18:33:31  bowe]
 * 
 * $EndLog$
 */
#ifndef lint
static char *RCSid =
  "$Header: /u1/rcs/dte/book-format/elimso.c,v 1.1.2.6 1994/06/23 19:48:30 fred Exp $";
#endif
/*
 *  This is a "soelim" equivalent - since some releases of DWB do not
 *  come with it.
 */

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#define		P_LENGTH	135
#define 	L_SIZE		1200
#define		W_SIZE		1200
#define		STACK_SIZE	1500
#define		F_NUMB		1500
#define		INCL_MACRO1	".so"
#define		INCL_MACRO2	".dI"	/* for SML */

	/* Globals	*/
int Verbose;
int Level;
char	Cur_way[STACK_SIZE][P_LENGTH+1];

	/* prototypes	*/

int inp_file() ;
void print_er();

main(argc, argv)
int argc;
char* argv[];
{
char name[W_SIZE+1];
char f_names[F_NUMB][P_LENGTH+1];
int i, j, f_numb, inp_file_numb;
int rez;

	/*	initialization	*/

	Verbose = 1;
	Level = 0;
	j = 0;
	strcpy(f_names[0],"");

	/*	Parameters prossecing	*/

	if ( argc > 1 ) {
		for ( i=1, j=0 ; i< argc; i++) {
			if ( strcmp(argv[i],"-v") == 0 ) Verbose =1;
			else if ( strcmp(argv[i],"-q") == 0 ) Verbose = 0;
			else {
				strcpy(f_names[j],argv[i]);
				j++;
			}
		}
	}
	f_numb = j ;
	if ( f_numb < 1 ) f_numb =1;
	for ( inp_file_numb = 0; inp_file_numb < f_numb; inp_file_numb++ ) {
		strcpy(name,f_names[inp_file_numb]);
		strcpy(Cur_way[Level],name);
		rez = inp_file(name);
		if ( rez ) print_er(rez, name);
	}
}
int inp_file(f_name) 
char* f_name;
{
FILE* file;
char line[L_SIZE];
char word[L_SIZE];
int i, std_input, end, len, rez;
char *ptr;
	for ( i=0; i < Level; i++ ) {
		if ( strcmp(f_name,Cur_way[i]) == 0 ) {
			return(2);
		}
	}
	Level++;
	strcpy(Cur_way[Level],f_name);
	if ( strcmp(f_name,"") == 0 ) std_input =1;
	else std_input = 0;
	if ( std_input && ( Level > 1 ) ) {
		Level--;
		return(1);
	}
	if ( !std_input) {
		if ( (file = fopen(f_name,"r") ) == NULL ) {
			Level--;
			return(1);
		}
	}
	end = 0;
	while ( !end ) {
		if ( std_input ) ptr = gets(line);
		else ptr = fgets(line,L_SIZE,file);
		if ( ptr == NULL ) {
			end = 1;
		}
		else {
			strcpy(word,line);
			i = strcspn(word," \t\n");
			word[i] = '\0';
			if ( ( strcmp(word,INCL_MACRO1) != 0 ) &&
				 ( strcmp(word,INCL_MACRO2) != 0 ) ) {
				i = strlen(line);
				if ( i ) {
					if (line[i-1] == '\n') line[i-1] = '\0';
				}
				puts(line);
			}
			else {
				len = strlen(line);
				if ( len > i ) 
				strcpy(word,&line[i+1]);
				else strcpy(word,"");
				i = strspn(word," \t\n\"");
				strcpy(word,&word[i]);
				i = strcspn(word," \t\n\"");
				word[i] = '\0';
				rez = inp_file(word);
				if ( rez ) print_er(rez,word);
			}
		}
	}
	Level--;
	if (!std_input) fclose(file);
	return(0);
}
void print_er(reason, f_name) 
int reason;
char* f_name;
{
	if ( Verbose && ( reason == 1 ) )	/* Can not open file	*/
	fprintf(stderr, "ERROR: ***** Can't open file '%s'\n",f_name);
	if ( reason == 2 ) 
	fprintf(stderr, "ERROR: ***** Processing file '%s' will loop, so skip it!\n",
	f_name);
}

