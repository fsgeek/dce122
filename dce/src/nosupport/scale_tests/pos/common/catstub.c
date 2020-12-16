/*************************************************************************
 *      RPC Server routine to retrieve a catalog page
 ************************************************************************/
/** CATSTUB.C ********************************************************/
/*** IBM Corporation                                               ***/
/*** OS/2-AIX PSP Systems Performance                              ***/
/*** Department 57LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 9151                                         ***/
/*** (512) 838-0844 TL 678-0844                                    ***/
/*** robert_russell@vnet.ibm.com                                   ***/
/*********************************************************************/
/*****************************************************************************
 * COPYRIGHT:                                                                *
 * ----------                                                                *
 * Copyright (C) International Business Machines Corp., 1993,1994,1995,1996. *
 *                                                                           *
 * DISCLAIMER OF WARRANTIES:                                                 *
 * -------------------------                                                 *
 * The following [enclosed] code is sample code created by IBM               *
 * Corporation.  This sample code is not part of any standard IBM product    *
 * and is provided to you solely for the purpose of assisting you in the     *
 * development of your applications.  The code is provided "AS IS",          *
 * without warranty of any kind.  IBM shall not be liable for any damages    *
 * arising out of your use of the sample code, even if they have been        *
 * advised of the possibility of such damages.                               *
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#ifdef IBMOS2
#include <io.h>
#include <os2.h>
#include <os2def.h>
#include <sys\stat.h>
#include <sys\timeb.h>
#include <sys\types.h>
#else
#include <sys/stat.h>
#include <sys/timeb.h>
#include <sys/types.h>
#endif

#include "rpc.h"

#include "pos_idl.h"
#include "pos_def.h"

#include "pos.h"

unsigned long hist_mutex_sem;

/*****************************************************************
 ** Catalog Page Retrival
 *****************************************************************/
void rpc_CAT
(
   handle_t       hBinding,
   unsigned short catalog_code,
   unsigned short lenname,
   unsigned short maxname,
   ndr_byte       filename[],
   unsigned short *cat_len,
   long           *appl_time,
   unsigned char  *cat_buf
)
{
   struct timeb  t1, t2;
   unsigned long ret_code;

   unsigned int  bytes_read=0;
   unsigned int  bytes_to_read=0;
   char          *cat_path;
   unsigned char file_name[80];
   int           catalog_page_handle=-1;
   int           c_p_h;
   unsigned char temp_buf[CAT_BUFF];

   /*
    * Begin Application Timestamp
    */
   ftime(&t1);

   /*******************************************
    * Need to know where to find the catalog files at the
    * server.
    *******************************************/
   switch(catalog_code)
   {
     case 1:
     {
         cat_path = getenv("SUMMER_CAT");
         break;
     }
     case 2:
     {
         cat_path = getenv("SPRING_CAT");
         break;
     }
     case 3:
     {
         cat_path = getenv("AUTUMN_CAT");
         break;
     }
     case 4:
     {
         cat_path = getenv("WINTER_CAT");
         break;
     }
     case 0:
     default:
     {
         cat_path = getenv("CATDIR");
         break;
     }
   }

   if (! cat_path)
   {

     printf("GetEnv CATALOG <%d> Environment variable not set.\n",
             catalog_code);

     /* Default to current directory */
     strcpy(file_name, filename);

   }
   else
   {
     strcpy(file_name,cat_path);
     strcat(file_name,BACK_SLASH);
     strcat(file_name,filename);
   }

   /******************************************/

   #ifdef DEBUGIT
   printf("Opening CATALOG PAGE FILE <%s>\n",file_name);
   #endif

   if ((catalog_page_handle =
        open(file_name,O_RDONLY ,0)
       ) == -1)
   {
     printf("Open <%s> Failed %d\n", file_name, catalog_page_handle);
   }
   else
   {
      c_p_h=catalog_page_handle; /* debug line */

     /*
      * read catalog page into output buffer
      */

     #ifdef DEBUGIT
     printf("     Reading Catalog Page <%s>\n", file_name);
     #endif


     if ((bytes_read =
          read(catalog_page_handle, &temp_buf, CAT_BUFF)
         ) == -1)
     {
       printf("Read <%s> Failed %d\n", file_name, bytes_read);
       cat_buf[0]='\0';
       *cat_len = 0;
     }
     else
     {

       #ifdef DEBUGIT
       printf("Bytes Read = %d\n",bytes_read);
       #endif

       temp_buf[bytes_read]='\0';
       *cat_len = bytes_read;

       cat_buf = (unsigned char *)temp_buf;

       /*
        * Copy the record into the RPC buffer.
        */
       /*
       memcpy((char *)cat_buf, (char *)&item_page.data[i], sizeof(ITEM_ROW));
       */
     }

     if ((ret_code =
          close(catalog_page_handle)
         ))
     {
       printf("Close <%s> Failed %d Handle %d [%d]\n",
                file_name, ret_code, catalog_page_handle,c_p_h);
     }
     #ifdef DEBUGIT
     printf("Closed <%s> RC = %d\n", file_name, ret_code);
     #endif
   }
   /******************************************/
   ftime(&t2);                         /* Application STOP TIME */
   /*
    * Return the elapsed Application Time as a long integer
    */

   *appl_time = (t2.time*1000+t2.millitm)-(t1.time*1000+t1.millitm);

   #ifdef DEBUGIT
   printf("ApplTime = %8ld msec. Exiting.\n", *appl_time);
   #endif
   /******************************************/


}
/*********************************************************************/
void rpc_SAV
(
   handle_t hBinding,
   unsigned short in_len,
   unsigned short sendmax,
   long     *appl_time,
   SAVE_DATA_IDL *sendbuf,
   unsigned long *ret_code
)
{
  pthread_lock_global_np();
  {
   struct timeb  t1, t2;
   unsigned long rc;


   /*
    * Begin Application Timestamp
    */
   ftime(&t1);

   *ret_code = WriteHistory((SAVE_DATA_IDL *) sendbuf, in_len);


   ftime(&t2);                         /* Application STOP TIME */
   /*
    * Return the elapsed Application Time as a long integer
    */

   *appl_time = (t2.time*1000+t2.millitm)-(t1.time*1000+t1.millitm);
  }
  pthread_unlock_global_np();
}
