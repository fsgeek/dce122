/*************************************************************************
 *      cmrstub.c  Customer Master Record Query for POS Benchmark.
 * MODIFICATION HISTORY:
 *
 *    01-06-93  Bob Russell Created
 *    09-21-93  Bob Russell Modified for distributed stubs
 ************************************************************************/
/** CMRSTUB.C ********************************************************/
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
 #include <process.h>
 #include <os2.h>
 #include <io.h>
 #include <sys\stat.h>
 #include <sys\timeb.h>
 #include <sys\types.h>
#else
 #include <sys/stat.h>
 #include <sys/timeb.h>
 #include <sys/types.h>
#endif

/*#include "exchandl.h"*/
#include "exc_handling.h"
#include "rpc.h"
#include "pos_def.h"
#include "pos.h"

#ifdef DB22
 #include "sqlagent.h"
#endif

CUST_DATA_IDL NO_CUST_REC[]= {
{512,           /* long       area_code;*/
 3434444,       /* long       phone_no;*/
 "4444",        /* char       extn[8];*/
 9999,          /* long       acct_id;*/
 "Scalatitus",  /* char       cust_last_name[48];*/
 "Fintunas",    /* char       cust_first_name[24];*/
 "Cod",         /* char       cust_MI[4];*/
 "Some Sea",    /* char       ship_addr[72];*/
 "Ocean Blvd",  /* char       mail_addr[72];*/
 "TX",          /* char       state[4];*/
 "Lakeside",    /* char       city[48];*/
 78645,         /* long       zip_code;*/
 "ish",        /* char       cust_type[4];*/
 0.08,          /* double     disc_pcnt;*/
0.08,           /* double     tax_pcnt;*/
 "1003458",     /* char       drv_lic[24];*/
 "TX",          /* char       drv_lic_state[4];*/
"12-18-93",     /* char       date_last_purch[12];*/
"NOREF",        /* char       cust_ref[72];*/
"NO CUSTOMER RECORD FOUND"}  /* char       cust_filler[84];*/
};      /* 512 bytes */


#ifndef POS_SECONDARY
 #include "pos_idl.h"
#endif

#ifndef POS_STANDALONE
 #include "cmr_idl.h"
#endif


#ifndef POS_PRIMARY
 int            CustomerDat_handle=-1,
                CustomerInx_handle=-1;

 int            CustomerInx_rows, CustomerDat_rows;
 CUS_INX_HEADER CustomerInx_header;
 CUS_INX_ROW    CustomerInx_array0[CMR_0_PGS * 42];

 void               CloseCMRFiles(void);
 void               OpenCMRFiles(void);
#endif

#ifdef POS_PRIMARY
 rpc_binding_handle_t POS_BINDINGS[5];
 void CrashRecovery (rpc_binding_handle_t *bind_h, int sid );
 short         the_server_crashed;
#endif

#ifdef POS_SECONDARY
 void               hari_kari(void);
#endif

#ifndef POS_PRIMARY
 /*** POS Console Definitions ****/
 long           throughput = 0;
 double         base_time = 0.0;
 long           base_cnt = 0;
 long           tx_cnt = 0;
 long           old_think_time = 0;
 unsigned32     old_auth_lvl = 0;
 short          FLAG_1 = 0;                   /* no_bind */
 short          FLAG_2 = 0;                   /* cntrl pgm on line */
 short          FLAG_3 = 0;                   /* no_print */
 short          FLAG_4 = 0;                   /* refresh_cache */
 short          FLAG_5 = 0;                   /* data collection on-off */
 short          FLAG_6 = 0;
 short          FLAG_7 = 0;                   /* kill clients */
 short          FLAG_8 = 0;                   /* DCE Login */
#endif

struct timeb   t1, t2;
/*****************************************************************
 ** CUSTOMER Master Record TABLE QUERY
 *****************************************************************/

#ifndef POS_PRIMARY
 #ifdef NODBM
 void CloseCMRFiles(void)
 {

   printf("Closing the CUSTOMER database.\n");

   close(CustomerDat_handle);
   close(CustomerInx_handle);
 }

 /***********************************************/
 void OpenCMRFiles(void)
 {
    char          *cmr_path;
    char          dat_name[80];
    char          inx_name[80];
    long          off_set=0L;
    int           i=0;

    int           bytes_read=0; /*, byte_count=0;*/
    int           bytes_to_read=0;
    long          newptr=-1L;
    /******************************************/

        /*
         * Get the path to the CUSTOMER table and index.
         */
        if (!(cmr_path = getenv("CMRDIR")))
        {

          printf("ScanEnv 'CMRDIR' Environment variable not set <%ld>.\n");

          /*
           * Sorry folks, my default path is F:\CUST
           */
          strcpy(dat_name,"F:\\CUST\\CUSTOMER.DAT\0");
          strcpy(inx_name,"F:\\CUST\\CUSTOMER.INX\0");

        }
        else
        {
          strcpy(dat_name,cmr_path);
          strcat(dat_name,BACK_SLASH);
          strcat(dat_name,"CUSTOMER.DAT");


          strcpy(inx_name,cmr_path);
          strcat(inx_name,BACK_SLASH);
          strcat(inx_name,"CUSTOMER.INX");

        }

        printf("Opening CMR FILE <%s>\n",dat_name);

        if ((CustomerDat_handle =
            #ifdef IBMOS2
             open(dat_name,O_RDONLY | O_BINARY,S_IREAD)
            #else
             open(dat_name,O_RDONLY ,S_IREAD)
            #endif
            ) == -1)
        {
          printf("Open <%s> Failed %d\n", dat_name, CustomerDat_handle);
          goto CmrBailOut;
        }

        printf("Opening INDEX FILE <%s>\n", inx_name);

        if ((CustomerInx_handle =
            #ifdef IBMOS2
             open(inx_name,O_RDONLY | O_BINARY,S_IREAD)
            #else
             open(inx_name,O_RDONLY ,S_IREAD)
            #endif
            ) == -1)
        {
          printf("Open <%s> Failed %d\n", inx_name, CustomerInx_handle);
          goto CmrBailOut;
        }

        /*
         * read the index header
         */
        printf("Reading INDEX HEADER\n");

        if ((bytes_read = read(CustomerInx_handle,
                              &CustomerInx_header,
                              sizeof(CUS_INX_HEADER))) == -1)
        {
          printf("Read <%s> Failed %d\n", inx_name, bytes_read);
          goto CmrBailOut;
        }

        #ifdef DEBUGIT
        printf("HEADER - INX0 Pages = %ld\n",CustomerInx_header.levl_0_pages);
        printf("HEADER - INX1 Pages = %ld\n",CustomerInx_header.levl_1_pages);
        printf("HEADER - INX2 Pages = %ld\n",CustomerInx_header.levl_2_pages);
        printf("HEADER - DATA Pages = %ld\n",CustomerInx_header.data_pages);
        #endif

      /*
       * position file pointer to page 1
       */
      printf("Reading LEAF0\n");

      for (i=0; i<CustomerInx_header.levl_0_pages; i++)
      {
        off_set = 512L + 8L + (long)(i * 512);

        #ifdef DEBUGIT
         printf("Level0 Page %d Offset=%ld\n",i+1, off_set);
        #endif

        if ((newptr =
             lseek(CustomerInx_handle, off_set, SEEK_SET)
            ) == -1L)
        {
          printf("SetFilePtr  Failed %ld\n", newptr);
          goto CmrBailOut;
        }

        /*
         * read leaf-0 index page(s)
         */


       bytes_to_read = sizeof(CUS_INX_PAGE) - 8;

       if ((bytes_read =
            read(CustomerInx_handle, &CustomerInx_array0[i*CMR_INX_PG_ROWS], bytes_to_read)
          ) == -1)
       {
         printf("Read <%s> Failed %d\n", inx_name, bytes_read);
         goto CmrBailOut;
       }

       #ifdef DEBUGIT
        printf("Bytes Read = %ld\n",bytes_read);
       #endif
     }
     /*
      * set rows per page from definitions
      * (need to make this dynamic)
      */
     CustomerInx_rows = (int)CMR_INX_PG_ROWS - 1;
     CustomerDat_rows = (int)CMR_DAT_PG_ROWS - 1;


     CmrBailOut:
     printf("CUSTOMER database initialized.\n");
 }
 #endif
#endif


/*****************************************************************
 ** CUSTOMER MASTER RECORD Application Server Stub
 *****************************************************************/
#ifdef POS_PRIMARY
 void rpc_CMR
 (
   handle_t       hBinding,
   long           in_area_code,
   long           in_phone_no,
   unsigned short cmr_len,
   long           *appl_time,
   CUST_DATA_IDL  *cmr_buf,
   long          *new_think_time,
   unsigned long *new_auth_lvl,
   unsigned short                 *flag_1,
   unsigned short                 *flag_2,
   unsigned short                 *flag_3,
   unsigned short                 *flag_4,
   unsigned short                 *flag_5,
   unsigned short                 *flag_6,
   unsigned short                 *flag_7,
   unsigned short                 *flag_8
 )
 {
    /* Make the RPC call to the distributed stub */
    the_server_crashed = 0;
    TRY
      CMR_STUB
      ( (handle_t) POS_BINDINGS[4],
        in_area_code,
        in_phone_no,
        cmr_len,
        appl_time,
        cmr_buf,
        new_think_time,
        new_auth_lvl,
        flag_1,
        flag_2,
        flag_3,
        flag_4,
        flag_5,
        flag_6,
        flag_7,
        flag_8
      );
    CATCH_ALL
      the_server_crashed = 1;
      printf("RPC Exception raised by CMR_STUB...\n");
      strcpy(NO_CUST_REC->cust_filler,
             "somestuff in filler");
      memcpy((CUST_DATA_IDL *)cmr_buf,
             (CUST_DATA_IDL *)&NO_CUST_REC,
              sizeof(CUST_DATA_IDL));
    ENDTRY

    if (the_server_crashed) CrashRecovery((handle_t *) &POS_BINDINGS[4], 4);

 }
#endif

/**************************/
/*****************************************************************
 ** CUSTOMER MASTER RECORD - DISTRIBUTED STUB
 *****************************************************************/
#ifndef POS_PRIMARY
 #ifdef POS_STANDALONE
  void rpc_CMR
 #else
  void CMR_STUB
 #endif
 (
   handle_t       hBinding,
   long           in_area_code,
   long           in_phone_no,
   unsigned short cmr_len,
   long           *appl_time,
   CUST_DATA_IDL  *cmr_buf,
   long          *new_think_time,
   unsigned long *new_auth_lvl,
   unsigned short                 *flag_1,
   unsigned short                 *flag_2,
   unsigned short                 *flag_3,
   unsigned short                 *flag_4,
   unsigned short                 *flag_5,
   unsigned short                 *flag_6,
   unsigned short                 *flag_7,
   unsigned short                 *flag_8
 )
 {
   CUS_INX_PAGE   inx_1, inx_2;
   CUST_DATA      cust_page;
   int           i, max_i;
   long          off_set=0L;
   int           CMRNotFound=0;

   int           bytes_read=0;  /*, byte_count=0;*/
   long          newptr=-1L;

   #ifdef DB22
    int  MyAgent = -1;
   #endif

   /******************************************/
   ftime(&t1);
   /************************************************************
    * Now, start doing real work,
    * Scan leaf 0 of the index
    ************************************************************/
   #ifdef DB22
     if ((MyAgent = PosDispatcher())<0)
     {
       CMRNotFound = 1;
       memcpy((CUST_DATA_IDL *)cmr_buf,
              (CUST_DATA_IDL *)&NO_CUST_REC,
               sizeof(CUST_DATA_IDL));
       goto CmrBailout;
     }
     else
     {
       PosAgentRam[MyAgent]->cust_data.area_code   = in_area_code;
       PosAgentRam[MyAgent]->cust_data.phone_no    = in_phone_no;
       #ifdef DEBUGIT
         printf("CMRSTUB Area Code %ld %ld\n",
              PosAgentRam[MyAgent]->cust_data.area_code, in_area_code);
         printf("CMRSTUB Phone No. %ld %ld\n",
         PosAgentRam[MyAgent]->cust_data.phone_no, in_phone_no);
       #endif
       PosAgentRam[MyAgent]->tx_code               = 1L;
       PosAgentRam[MyAgent]->sql_code              = 0L;

       SetServrSem(MyAgent);
       ClearAgentSem(MyAgent);
       WaitServrSem(MyAgent);

       /********************/

       #ifdef DEBUGIT
         printf("%ld\n",PosAgentRam[MyAgent]->tx_code);
       #endif
       /********************/
       if (PosAgentRam[MyAgent]->sql_code == 0L)
         memcpy((CUST_DATA_IDL *)cmr_buf,             // cust_page,
                (CUST_DATA_IDL *)&PosAgentRam[MyAgent]->cust_data,
                sizeof(CUST_DATA_IDL));
       else
         memcpy((CUST_DATA_IDL *)cmr_buf,
                (CUST_DATA_IDL *)&NO_CUST_REC,
                 sizeof(CUST_DATA_IDL));
       /******************************************/
       /*
        * Now unlock the Agent so someone else can use it
        */
       PosDispatchFree(MyAgent);

     }
   #elif NODBM
     i = 0;
     max_i = CMR_0_PGS * CMR_INX_PG_ROWS;
     while ((CustomerInx_array0[i].area_code < in_area_code  &&
             CustomerInx_array0[i].area_code < 999L)          ||
            (CustomerInx_array0[i].area_code <= in_area_code &&
             CustomerInx_array0[i].phone_no  < in_phone_no   &&
             CustomerInx_array0[i].phone_no  < 9999999L)      &&
             i < max_i )

     {
       #ifdef DEBUGIT
        printf ("   Leaf 0 Item Key = %11ld=%11ld %11ld=%11ld\n",
               in_area_code, CustomerInx_array0[i].area_code,
               in_phone_no, CustomerInx_array0[i].phone_no);
       #endif

       i++;

     }
     #ifdef DEBUGIT
      printf ("   Leaf 0 LastPage = %11ld=%11ld %11ld=%11ld %8ld i=%d\n",
              in_area_code, CustomerInx_array0[i].area_code,
              in_phone_no, CustomerInx_array0[i].phone_no, CustomerInx_array0[i].page_no,i);
     #endif


     if (CustomerInx_array0[i].area_code < in_area_code    ||
         (CustomerInx_array0[i].area_code == in_area_code &&
          CustomerInx_array0[i].phone_no < in_phone_no)    ||
             i >= max_i )
     {
       NotFound(in_area_code);
       NotFound(in_phone_no);
       CMRNotFound=1;
       goto CmrBailout;
     }

     /*
      * Set the offset into CUSTOMER.INX to read the appropriate
      * Leaf-1 index page.
      */
     off_set = 512L + (CustomerInx_array0[i].page_no-1) * 512L +
         sizeof(CUS_INX_PAGE) * CustomerInx_header.levl_0_pages;

     #ifdef DEBUGIT
      printf ("   Leaf 0 Page = %8ld Offset=%11ld\n",
             CustomerInx_array0[i].page_no, off_set);
     #endif
     /************************************************************
      * Scan leaf 1 of the index
      ************************************************************/

     /*
      * Set the file pointer
      */
     pthread_lock_global_np();
     {
       if ((newptr =
            lseek(CustomerInx_handle, off_set, SEEK_SET)
           ) == -1L)
       {
         printf("SetFilePtr  Failed %ld\n", newptr);
         CMRNotFound=1;
         goto CmrBailout;
       }

       /*
        * Read page into buffer
        */
       if ((bytes_read =
            read(CustomerInx_handle, &inx_1, sizeof(CUS_INX_PAGE))
           ) == -1)
       {
         printf("Read <CUSTOMER INDEX> Failed %d\n", bytes_read);
         CMRNotFound=1;
         goto CmrBailout;
       }
     }
     pthread_unlock_global_np();

       #ifdef DEBUGIT
        printf ("   Found Index-1 Page# %ld\n",
                   inx_1.cus_inx_page_no);
       #endif

     /*
      * Now scan the index page
      */
     i = 0;
     while ((inx_1.cus_inx_data[i].area_code < in_area_code &&
             inx_1.cus_inx_data[i].area_code < 999L) ||
            (inx_1.cus_inx_data[i].area_code <= in_area_code &&
             inx_1.cus_inx_data[i].phone_no  < in_phone_no &&
             inx_1.cus_inx_data[i].phone_no  < 9999999L)  &&
                                           i < CustomerInx_rows )
     {
       #ifdef DEBUGIT
        printf ("   leaf 1 Item Key = %11ld=%11ld %11ld=%11ld\n",
                   in_area_code,inx_1.cus_inx_data[i].area_code,
                   in_phone_no,inx_1.cus_inx_data[i].phone_no);
       #endif

       i++;

     }
     #ifdef DEBUGIT
      printf ("   leaf 1 LastPage = %11ld=%11ld %11ld=%11ld\n",
                 in_area_code,inx_1.cus_inx_data[i].area_code,
                 in_phone_no,inx_1.cus_inx_data[i].phone_no);
     #endif

     if ( inx_1.cus_inx_data[i].area_code < in_area_code ||
         (inx_1.cus_inx_data[i].area_code == in_area_code &&
          inx_1.cus_inx_data[i].phone_no < in_phone_no))
     {
       NotFound(in_phone_no);
       NotFound(in_area_code);
       CMRNotFound=1;
       goto CmrBailout;
     }

     /*
      * OK, now we know which page of CUSTOMER.INX contains
      * the Leaf-2 index page requested.
      * Set the offset into CUSTOMER.INX.
      */
     off_set = 512L + (inx_1.cus_inx_data[i].page_no-1) * 512L +
         sizeof(CUS_INX_PAGE) * CustomerInx_header.levl_0_pages +
         sizeof(CUS_INX_PAGE) * CustomerInx_header.levl_1_pages;

     #ifdef DEBUGIT
      printf("              INX1 ROW = %d  INDEX PAGE = %ld  OFFSET=%ld\n",
                                    i, inx_1.cus_inx_data[i].page_no,off_set);
     #endif

     /************************************************************
      * Scan leaf 2 of the index
      ************************************************************/
     /*
      * Set the file pointer
      */
     pthread_lock_global_np();
     {
       if ((newptr =
            lseek(CustomerInx_handle, off_set, SEEK_SET)
           ) == -1L)
       {
         printf("SetFilePtr  Failed %ld\n", newptr);
         CMRNotFound=1;
         goto CmrBailout;
       }

       /*
        * Read page into buffer
        */
       if ((bytes_read =
            read(CustomerInx_handle, &inx_2, sizeof(CUS_INX_PAGE))
           ) == -1)
       {
         printf("Read <CUSTOMER INDEX> Failed %d\n", bytes_read);
         CMRNotFound=1;
         goto CmrBailout;
       }
     }
     pthread_unlock_global_np();


     /*
      * Now scan the index page
      */
     i = 0;
     while ((inx_2.cus_inx_data[i].area_code < in_area_code &&
             inx_2.cus_inx_data[i].area_code < 999L) ||
            (inx_2.cus_inx_data[i].area_code <= in_area_code &&
             inx_2.cus_inx_data[i].phone_no  < in_phone_no &&
             inx_2.cus_inx_data[i].phone_no  < 9999999L)  &&
                                           i < CustomerInx_rows )
     {
       #ifdef DEBUGIT
        printf ("   leaf 2 Item Key = %11ld=%11ld %11ld=%11ld\n",
                   in_area_code,inx_2.cus_inx_data[i].area_code,
                   in_phone_no,inx_2.cus_inx_data[i].phone_no);
       #endif

       i++;

     }

     if ( inx_2.cus_inx_data[i].area_code < in_area_code ||
         (inx_2.cus_inx_data[i].area_code == in_area_code &&
          inx_2.cus_inx_data[i].phone_no  < in_phone_no))
     {
       NotFound(in_phone_no);
       NotFound(in_area_code);
       CMRNotFound=1;
       goto CmrBailout;
     }

     /*
      * OK, now we know which page of CUSTOMER.DAT contains
      * the item number requested.
      * Set the offset into CUSTOMER.DAT.
      */
     off_set = (inx_2.cus_inx_data[i].page_no-1) * 512L;

     #ifdef DEBUGIT
      printf("              INX2 ROW = %d  DATA PAGE = %ld  OFFSET=%ld\n",
                                  i, inx_2.cus_inx_data[i].page_no,off_set);
     #endif

     /************************************************************
      * Scan CUSTOMER DATA
      ************************************************************/
     /*
      * Set the file pointer in CUSTOMER.DAT
      */
     pthread_lock_global_np();
     {
       if ((newptr =
            lseek(CustomerDat_handle, off_set, SEEK_SET)
           ) == -1L)
       {
         printf("SetFilePtr  Failed %ld\n", newptr);
         CMRNotFound=1;
         goto CmrBailout;
       }

       if ((bytes_read = read(CustomerDat_handle,
                             &cust_page,
                             sizeof(CUST_DATA))) == -1)
       {
         printf("Read <CUSTOMER DATA> Failed %d\n", bytes_read);
         CMRNotFound=1;
         goto CmrBailout;
       }
     }
     pthread_unlock_global_np();

     /*
      * Scan the data page for the item number.
      */
     if (cust_page.area_code != in_area_code ||
         cust_page.phone_no  != in_phone_no)
     {

       printf ("CUSTOMER NOT FOUND !! IN=%3ld-%7ld FOUND=%3ld-%7ld\n",
                in_area_code, in_phone_no, cust_page.area_code,
                 cust_page.phone_no);
       CMRNotFound=1;
       goto CmrBailout;
     }


     /*
      * Copy the record into the RPC buffer.
      */



    CmrBailout:                               /* Come here is something bombs */

    if (CMRNotFound)
    {
  strcpy(NO_CUST_REC->cust_filler,"somestuff in filler                     somestuff in filleropopopopopopopopopoooo");
      memcpy((CUST_DATA_IDL *)cmr_buf, (CUST_DATA_IDL *)&NO_CUST_REC, sizeof(CUST_DATA_IDL));
    }
    else
    {

  strcpy(cust_page.cust_filler,"somestuff in filler                     somestuff in filleropopopopopopopopopoooo");
      memcpy((CUST_DATA_IDL *)cmr_buf, (CUST_DATA_IDL *)&cust_page, sizeof(CUST_DATA_IDL));

 /*
 fprintf(stderr,"sizeof  CUST_DATA_IDL[%d] sizeof CUST_DATA[%d]\n",sizeof(CUST_DATA_IDL), sizeof(CUST_DATA));
 fprintf(stderr,"sizeof  cmr_buf[%d] sizeof cust_page[%d]\n",sizeof(*cmr_buf), sizeof(cust_page));
 fprintf(stderr,"[%d] [%d]\n", cmr_buf->area_code, cust_page.area_code);
 fprintf(stderr,"[%d] [%d]\n", cmr_buf->phone_no, cust_page.phone_no);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->extn, cust_page.extn);
 fprintf(stderr,"[%d] [%d]\n", cmr_buf->acct_id, cust_page.acct_id);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->cust_last_name, cust_page.cust_last_name);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->cust_first_name, cust_page.cust_first_name);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->cust_MI, cust_page.cust_MI);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->ship_addr, cust_page.ship_addr);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->mail_addr, cust_page.mail_addr);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->state, cust_page.state);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->city, cust_page.city);
 fprintf(stderr,"[%d] [%d]\n", cmr_buf->zip_code, cust_page.zip_code);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->cust_type, cust_page.cust_type);
 fprintf(stderr,"[%f] [%f]\n", cmr_buf->disc_pcnt, cust_page.disc_pcnt);
 fprintf(stderr,"[%f] [%f]\n", cmr_buf->tax_pcnt, cust_page.tax_pcnt);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->drv_lic , cust_page.drv_lic);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->drv_lic_state , cust_page.drv_lic_state);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->date_last_purch , cust_page.date_last_purch);
 fprintf(stderr,"[%s] [%s]\n", cmr_buf->cust_ref , cust_page.cust_ref);
 */

      #ifdef DEBUGIT
       printf ("FOUND................ IN=%3ld-%7ld   OUT=%3ld-%7ld\n",
                 in_area_code, in_phone_no, cust_page.area_code,
                  cust_page.phone_no);

       printf("%8ld\n", cust_page.acct_id);
       printf("%48s %24s %2s\n",cust_page.cust_last_name,
                                    cust_page.cust_first_name,
                                    cust_page.cust_MI);
       printf("%72s\n", cust_page.ship_addr);
       printf("%72s\n", cust_page.mail_addr);
       printf("%48s  State %2s  Zip %9ld\n", cust_page.city,
                                            cust_page.state,
                                            cust_page.zip_code);
       printf("%24s Drv State %2s\n", cust_page.drv_lic,
                                     cust_page.drv_lic_state);
       printf("%72s\n", cust_page.cust_ref);
       printf("%6.2f\n", cust_page.disc_pcnt);
       printf("%6.2f\n", cust_page.tax_pcnt);
       printf("%8s\n", cust_page.date_last_purch);
      #endif
    }
   #endif /* NODBM */
   #ifdef DB22
    CmrBailout:                               /* Come here is something bombs */
   #endif
    /******************************************/
    ftime(&t2);                         /* Application STOP TIME */
    /*
     * Return the elapsed Application Time as a long integer
     */
    *appl_time = (t2.time*1000+t2.millitm)-(t1.time*1000+t1.millitm);
    /******************************************/
    #ifndef POS_PRIMARY
      if (tx_cnt == 0)
      {
        base_cnt   = 0L;
        base_time  = (t2.time*1000+t2.millitm)*0.001;
      }
      tx_cnt++;
    #endif


    *flag_1   =    FLAG_1;             /* no_bind */
    *flag_2   =    FLAG_2;             /* cntrl pgm on line */
    *flag_3   =    FLAG_3;             /* no_print */
    *flag_4   =    FLAG_4;             /* refresh_cache */
    *flag_5   =    FLAG_5;             /* data collection on-off */
    *flag_6   =    FLAG_6;             /* client sync on-off */
    *flag_7   =    FLAG_7;             /* kill clients */
    *flag_8   =    FLAG_8;             /* DCE Login */

    *new_think_time = old_think_time;
    *new_auth_lvl   = old_auth_lvl;
    /******************************************/

 }
 #endif
 /***********************************************
  End of Main
  ***********************************************/


 /**********************************************************
  * This call will kill the server.
  * Invoked by a transaction type = 9 from a requester.
  **********************************************************/
#ifdef POS_SECONDARY
 void KILL_CMR
 (
    handle_t d1
 )
 {
    /*
     * I put this routine in the same C file as the other
     * RPC calls for convienience of compilation.
     */
    printf("I heard a bang....?\n");
    hari_kari();
 }

#endif
 /******************************************************************/
 /**********************
  * POS Console RPC
  **********************/
#ifdef POS_PRIMARY
 void pos_CNTRL
 (
     handle_t                       hBinding,
     unsigned short                 flag_1,
     unsigned short                 flag_2,
     unsigned short                 flag_3,
     unsigned short                 flag_4,
     unsigned short                 flag_5,
     unsigned short                 flag_6,
     unsigned short                 flag_7,
     unsigned short                 flag_8,
     long                           think_time,
     unsigned long                  auth_lvl,
     double                         *CSPM
 )
 {
     CNTRL_STUB
     ( (handle_t)  POS_BINDINGS[4],
                   flag_1,
                   flag_2,
                   flag_3,
                   flag_4,
                   flag_5,
                   flag_6,
                   flag_7,
                   flag_8,
                   think_time,
                   auth_lvl,
                   CSPM
     );
 }
#endif

#ifndef POS_PRIMARY
 #ifdef POS_STANDALONE
  void pos_CNTRL
 #else
  void CNTRL_STUB
 #endif
 (
    handle_t                       hBinding,
    unsigned short                 flag_1,
    unsigned short                 flag_2,
    unsigned short                 flag_3,
    unsigned short                 flag_4,
    unsigned short                 flag_5,
    unsigned short                 flag_6,
    unsigned short                 flag_7,
    unsigned short                 flag_8,
    long                           think_time,
    unsigned long                  auth_lvl,
    double                         *CSPM
 )
 {
   double    CurTime,work_time;

   CurTime  = (t2.time*1000+t2.millitm)*0.001;

   work_time = (CurTime - base_time);

   if (work_time > 0)
     *CSPM = ((double)(tx_cnt - base_cnt) / work_time) * 60.0;
   else
     *CSPM = 0.0;

   /*  printf("CSPM = %6.1f \n",*CSPM); */

   base_cnt   = tx_cnt;
   base_time  = CurTime;


   if (flag_2)
   {
     if (think_time != old_think_time)
     {
       printf("Think Time changed from<%ld> to <%ld>\n",old_think_time, think_time);
       old_think_time = think_time;
     }


     if (auth_lvl != old_auth_lvl)
     {
       printf("Auth Level changed from<%ld> to <%ld>\n",old_auth_lvl, auth_lvl);
       old_auth_lvl = auth_lvl;
     }



     /* reset the client counter */

     if (flag_1 != FLAG_1) printf("No Bind...........Set to %d\n", flag_1);
     FLAG_1   =    flag_1;             /* no_bind */
     if (flag_2 != FLAG_2) printf("Cntrl Pgm Status .Set to %d\n", flag_2);
     FLAG_2   =    flag_2;             /* cntrl pgm on line */
     if (flag_3 != FLAG_3) printf("No Print..........Set to %d\n", flag_3);
     FLAG_3   =    flag_3;             /* no_print */
     if (flag_4 != FLAG_4) printf("CDS Refresh.......Set to %d\n", flag_4);
     FLAG_4   =    flag_4;             /* refresh_cache */
     if (flag_5 != FLAG_5) printf("Data Collect......Set to %d\n", flag_5);
     FLAG_5   =    flag_5;             /* start_collection */
     if (flag_6 != FLAG_6) printf("????????..........Set to %d\n", flag_6);
     FLAG_6   =    flag_6;             /* sync clients */
     if (flag_7 != FLAG_7) printf("Kill Clients......Set to %d\n", flag_7);
     FLAG_7   =    flag_7;             /* kill_clients */
     if (flag_8 != FLAG_8) printf("Force DCELogin ...Set to %d\n", flag_8);
     FLAG_8   =    flag_8;             /* DCE Login */
   }
 }
#endif

