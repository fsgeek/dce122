#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>

FILE *fp;


/*****************************************************************
 ** PRICE TABLE QUERY
 *****************************************************************/
main ()
{
   char          *RC;
   char          dat_name[80];
   char          inx_name[80];
	char     line[5129];

   /******************************************/
         strcpy(dat_name,"price.dat\0");
         strcpy(inx_name,"price.inx\0");


       printf("Opening PRICE FILE <%s>\n",dat_name);

       if ((fp=fopen(dat_name,"rb") ) == NULL)
		printf("ERROR OPENING %s\n",dat_name);

	RC=fgets(line, 1024, fp);

     printf ("   Data %s\n",line);

exit (0);

}
