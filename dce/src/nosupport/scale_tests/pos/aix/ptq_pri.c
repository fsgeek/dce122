/*************************************************************************
 *      ptqstub.c  Price Table Query for POS Benchmark.
 * MODIFICATION HISTORY:
 *
 *    10-15-92  Bob Russell Created
 *    11-15-92  Bob Russell Completed
 *    09-17-93  Bob Russell Begin conversion to distributed stubs
 *    03-14-95  Bob Russell Add DB22 function
 ************************************************************************/
/** PTQSTUB.C ********************************************************/
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
#include "pos_def.h"
#include "rpc.h"
#include "pos.h"

#ifdef DB22
 #include "sqlagent.h"
#endif

 ITEM_ROW_IDL NO_PRICE_REC[] = {
 {
 9999,          /* long       item_no       ;*/
 1234,          /* long       upc_no        ;*/
 "NO PRICE RECORD FOUND", /* char       descr[36]     ;*/
 "UNKN",        /* char       dept_no[4]    ;*/
 10,            /* long       qty_on_hand   ;*/
 "case",        /* char       inv_unit[8]   ;*/
 5,             /* long       ord_at_qty    ;*/
 5,             /* long       qty_to_ord    ;*/
 6,             /* long       inv_cnt       ;*/
 "12-04-1993",     /* char       inv_date[12]  ;*/
 5,             /* long       qty_on_ord    ;*/
 "12-11-1993",    /* char       lst_ord_dt[12];*/
9.99,           /* double     price_1       ;*/
"12-11-1993",     /* char       eff_dt_1[12]  ;*/
9.99,           /* double     price_2       ;*/
"12-11-1993",     /* char       eff_dt_2[12]  ;*/
9.99,           /* double     price_3       ;*/
"12-11-1993",     /* char       eff_dt_3[12]  ;*/
9.99            /* double     unit_cost     ;*/
}
 };


#ifndef POS_SECONDARY
 #include "pos_idl.h"
#endif

#ifndef POS_STANDALONE
 #include "ptq_idl.h"
#endif

#ifndef POS_PRIMARY
 #ifdef NODBM
   int           PriceDat_handle,
                 PriceInx_handle;
   int           PriceInx_rows, PriceDat_rows;

   INX_HEADER    PriceInx_header;

   INX_ROW       PriceInx_array0[LVL_0_PGS * 64];
   INX_ROW       PriceInx_array1[LVL_1_PGS * 64];


   void               ClosePriceFiles(void);
   void               OpenPriceFiles(void);
 #endif
#endif

#ifdef POS_PRIMARY
 rpc_binding_handle_t POS_BINDINGS[5];
 void CrashRecovery (rpc_binding_handle_t *bind_h, int sid );
 short         the_server_crashed;
#endif

#ifdef POS_SECONDARY
 void               hari_kari(void);
#endif

/*****************************************************************
 ** PRICE TABLE QUERY
 *****************************************************************/
#ifdef NODBM
 #ifndef POS_PRIMARY

  void ClosePriceFiles(void)
  {

    printf("Closing the PRICE database.\n");

    close(PriceDat_handle);
    close(PriceInx_handle);
  }

  #endif

  #ifndef POS_PRIMARY

  /**************************/
  void OpenPriceFiles(void)
  {
     char          *price_path;
     char          dat_name[80];
     char          inx_name[80];
     long          off_set=0L;
     int           bytes_read=0;
     unsigned long bytes_to_read=0;
     long          newptr=-1L;

     /*
      * Open the Price Table
      */

     /*
      * Get the path to the price table and index.
      */

     if (!(price_path = getenv("PTQDIR")))
     {

       printf("ScanEnv 'PTQDIR' Environment variable not set <%ld>.\n");

       strcpy(dat_name,"PRICE.DAT\0");
       strcpy(inx_name,"PRICE.INX\0");

     }
     else
     {
       strcpy(dat_name,price_path);
       strcat(dat_name,BACK_SLASH);
       strcat(dat_name,"PRICE.DAT");

       strcpy(inx_name,price_path);
       strcat(inx_name,BACK_SLASH);
       strcat(inx_name,"PRICE.INX");

     }

     printf("Opening PRICE FILE <%s>\n",dat_name);

     if ((PriceDat_handle =
         #ifdef IBMOS2
          open(dat_name,O_RDONLY | O_BINARY,S_IREAD)
         #else
          open(dat_name,O_RDONLY ,S_IREAD)
         #endif
         ) == -1)
     {
       printf("Open <%s> Failed %d\n", dat_name, PriceDat_handle);
       goto BailOut;
     }


     /*
      * Open Index File
      */

     printf("Opening INDEX FILE <%s>\n", inx_name);

     if ((PriceInx_handle =
         #ifdef IBMOS2
          open(inx_name,O_RDONLY | O_BINARY,S_IREAD)
         #else
          open(inx_name,O_RDONLY ,S_IREAD)
         #endif
         ) == -1)
     {
       printf("Open <%s> Failed %d\n", inx_name, PriceInx_handle);
       goto BailOut;
     }

     /*
      * read the index header
      */

     printf("Reading INDEX HEADER\n");

     if ((bytes_read = read(PriceInx_handle,
                           &PriceInx_header,
                           sizeof(INX_HEADER))) == -1)
     {
       printf("Read <%s> Failed %d\n", inx_name, bytes_read);
       goto BailOut;
     }

     #ifdef DEBUGIT
      printf("HEADER - INX0 Pages = %ld\n",PriceInx_header.levl_0_pages);
      printf("HEADER - INX1 Pages = %ld\n",PriceInx_header.levl_1_pages);
      printf("HEADER - INX2 Pages = %ld\n",PriceInx_header.levl_2_pages);
      printf("HEADER - DATA Pages = %ld\n",PriceInx_header.data_pages);
     #endif

     /*
      * position file pointer to page 1
      */

     off_set = 512L;

     if ((newptr =
          lseek(PriceInx_handle, off_set, SEEK_SET)
         ) == -1L)
     {
       printf("SetFilePtr  Failed %ld\n", newptr);
       goto BailOut;
     }

     /*
      * read leaf-0 index page(s)
      */

     printf("Reading LEAF0\n");


     bytes_to_read =(long)(sizeof(INX_PAGE) * PriceInx_header.levl_0_pages);

     if ((bytes_read =
          read(PriceInx_handle, &PriceInx_array0, bytes_to_read)
         ) == -1)
     {
       printf("Read <%s> Failed %d\n", inx_name, bytes_read);
       goto BailOut;
     }

     #ifdef DEBUGIT
      printf("Bytes Read = %d\n",bytes_read);
     #endif


     /*
      * read leaf-1 index page
      */

     printf("Reading LEAF1\n");

     off_set = 512L + sizeof(INX_PAGE) * PriceInx_header.levl_0_pages;

     /*
      * position file pointer first leaf1 page
      */
     if ((newptr =
          lseek(PriceInx_handle, off_set, SEEK_SET)
         ) == -1L)
     {
       printf("SetFilePtr  Failed %ld\n", newptr);
     }

     bytes_to_read = (long)(sizeof(INX_PAGE) * PriceInx_header.levl_1_pages);

     if ((bytes_read =
          read(PriceInx_handle, &PriceInx_array1, bytes_to_read)
         ) == -1)
     {
       printf("Read <%s> Failed %d\n", inx_name, bytes_read);
       goto BailOut;
     }

     #ifdef DEBUGIT
      printf("Bytes Read = %ld\n",bytes_read);
     #endif


     /*
      * set rows per page from definitions
      * (need to make this dynamic)
      */

     PriceInx_rows = (int)INX_PG_ROWS - 1;
     PriceDat_rows = (int)DAT_PG_ROWS - 1;

     BailOut:
     printf("PRICE database initialized.\n");
  }   /* End OpenPriceFiles */

 #endif
#endif   /*NODBM*/
/*****************************************************************
 ** PRICE TABLE QUERY Application Server Stub
 *****************************************************************/
#ifdef POS_PRIMARY
 void rpc_PTQ
 (
    handle_t       hBinding,
    long           in_key,
    unsigned short ptq_len,
    long           *appl_time,
    ITEM_ROW_IDL   *ptq_buf
 )
 {
     /* Make the RPC call to the distributed stub */
      the_server_crashed = 0;
      TRY
        PTQ_STUB
        ( (handle_t) POS_BINDINGS[3],
          in_key,
          ptq_len,
          appl_time,
          ptq_buf
        );
      CATCH_ALL
        the_server_crashed = 1;
        printf("RPC Exception raised by PTQ_STUB...\n");
        memcpy((ITEM_ROW_IDL *)ptq_buf,
               (ITEM_ROW_IDL *)&NO_PRICE_REC,
                sizeof(ITEM_ROW_IDL));
      ENDTRY

      if (the_server_crashed) CrashRecovery((handle_t *) &POS_BINDINGS[3], 3);

 }
#endif

/***********************************************
 * End of rpc_PTQ
 ***********************************************/
/*****************************************************************
 ** PRICE TABLE QUERY - DISTRIBUTED STUB
 *****************************************************************/
#ifndef POS_PRIMARY
 #ifdef POS_STANDALONE
  void rpc_PTQ
 #else
  void PTQ_STUB
 #endif
 (
    handle_t       hBinding,
    long           in_key,
    unsigned short ptq_len,
    long           *appl_time,
    ITEM_ROW_IDL   *ptq_buf

 )
 {
    struct timeb  t1, t2;
    int           i;
    short         PTQNotFound=0;
    #ifdef NODBM
     INX_PAGE      inx_2;
     int           max_i;
     long          off_set=0L;
     ITEM_PAGE     item_page;

     int           bytes_read=0;
     long          newptr=-1L;
    #endif
    #ifdef DB22
     int  MyAgent = -1;
    #endif
    /******************************************/

    ftime(&t1);

    #ifdef DB22

     if ((MyAgent = PosDispatcher())<0)
     {
       PTQNotFound = 1;
       memcpy((ITEM_ROW_IDL *)ptq_buf,
              (ITEM_ROW_IDL *)&NO_PRICE_REC,
               sizeof(ITEM_ROW_IDL));
       goto Bailout;
     }
     else
     {
       PosAgentRam[MyAgent]->item_row.item_no   = in_key;
       PosAgentRam[MyAgent]->order_qty          = 1L;

       #ifdef DEBUGIT
         printf("PTQSTUB item_no %ld %ld\n",
              PosAgentRam[MyAgent]->item_row.item_no, in_key);
       #endif

       PosAgentRam[MyAgent]->tx_code               = 2L;
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
         memcpy((ITEM_ROW_IDL *)ptq_buf,
                (ITEM_ROW_IDL *)&PosAgentRam[MyAgent]->item_row,
                sizeof(ITEM_ROW_IDL));
       else
         memcpy((ITEM_ROW_IDL *)ptq_buf,
                (ITEM_ROW_IDL *)&NO_PRICE_REC,
                 sizeof(ITEM_ROW_IDL));

       /******************************************/
       /*
        * Now unlock the Agent so someone else can use it
        */
       PosDispatchFree(MyAgent);

     }

    #elif NODBM
    /************************************************************
     * Now, start doing real work,
     * Scan leaf 0 of the index
     ************************************************************/

     i = 0;
     max_i = LVL_0_PGS * INX_PG_ROWS;
     while (PriceInx_array0[i].item_no < in_key &&
            PriceInx_array0[i].item_no < MAX_ITEMS+10000000L &&
            i < max_i )

     {
       #ifdef DEBUGIT
        printf ("   Leaf 0 Item Key = %11ld %11ld\n", in_key, PriceInx_array0[i].item_no);
       #endif

       i++;

     }

       #ifdef DEBUGIT
        printf ("   Leaf 0 Item Key = %11ld %11ld\n", in_key, PriceInx_array0[i].item_no);
       #endif

     if (PriceInx_array0[i].item_no < in_key ||
         PriceInx_array0[i].item_no > MAX_ITEMS+10000000L ||
         i >= max_i)
     {
       printf("Leaf 0 of Price Failed\n");
       NotFound(in_key);
       PTQNotFound=1;
       goto Bailout;
     }

     /*
      * Now, calculate the offset into the index array
      * to read the appropriate leaf1 page (64 entries per page).
      */

     off_set = (PriceInx_array0[i].page_no - 1) * 64L;



     #ifdef DEBUGIT
      printf("RND = %6ld  INX0 ROW = %d  INX1 PAGE = %ld  OFFSET=%ld\n",
                                   in_key, i, PriceInx_array0[i].page_no,off_set);
     #endif


     /************************************************************
      * Scan leaf 1 of the index
      ************************************************************/

     i = (int)off_set;
     max_i = i + LVL_1_PGS * INX_PG_ROWS;

     while (PriceInx_array1[i].item_no < in_key &&
            PriceInx_array1[i].item_no < MAX_ITEMS+10000000L &&
            i < max_i)
     {
       #ifdef DEBUGIT
        printf ("   Leaf 1 Item Key = %11ld %11ld\n",in_key, PriceInx_array1[i].item_no);
       #endif

       i++;

     }

       #ifdef DEBUGIT
        printf ("   Leaf 1 Item Key = %11ld %11ld\n",in_key, PriceInx_array1[i].item_no);
       #endif

     if (PriceInx_array1[i].item_no < in_key ||
         PriceInx_array1[i].item_no > MAX_ITEMS+10000000L ||
         i >= max_i)
     {
       printf("Leaf 1 of Price\n");
       printf("%ld was in array.\n",PriceInx_array1[i].item_no);
       printf("%ld was in in_key.\n",in_key);
       NotFound(in_key);
       PTQNotFound=1;
       goto Bailout;
     }

     /*
      * OFFSET into index file to read next LEVL-2 page. For level 2
      * we really read from the file, not preloaded.
      */

     off_set = (PriceInx_header.levl_0_pages +
                PriceInx_header.levl_1_pages +
                PriceInx_array1[i].page_no) * 512L;

     #ifdef DEBUGIT
      printf("              INX1 ROW = %d  INX2 PAGE = %ld  OFFSET=%ld\n",
                                         i, PriceInx_array1[i].page_no,off_set);
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
            lseek(PriceInx_handle, off_set, SEEK_SET)
           ) == -1L)
       {
         printf("SetFilePtr  Failed %ld\n", newptr);
         PTQNotFound=1;
         goto Bailout;
       }

       /*
        * Read page into buffer
        */

       if ((bytes_read =
            read(PriceInx_handle, &inx_2, sizeof(INX_PAGE))
           ) == -1)
       {
         printf("Read <PRICE.INX> Failed %d\n", bytes_read);
         PTQNotFound=1;
         goto Bailout;
       }
     }
     pthread_unlock_global_np();


     /*
      * Now scan the index page
      */

     i = 0;
     while (inx_2.inx_data[i].item_no < in_key && i < PriceInx_rows)
     {
       #ifdef DEBUGIT
        printf ("   leaf 2 Item Key = %11ld %11ld\n",in_key,inx_2.inx_data[i].item_no);
       #endif

       i++;

     }

     if (inx_2.inx_data[i].item_no < in_key ||
         inx_2.inx_data[i].item_no > MAX_ITEMS+10000000L)
     {
       printf("Leaf 2 of Price\n");
       NotFound(in_key);
       PTQNotFound=1;
       goto Bailout;
     }

     /*
      * OK, now we know which page of PRICE.DAT contains
      * the item number requested.
      * Set the offset into PRICE.DAT.
      */

     off_set = (inx_2.inx_data[i].page_no-1) * 512L;

     #ifdef DEBUGIT
      printf("              INX2 ROW = %d  DATA PAGE = %ld  OFFSET=%ld\n",
                                         i, inx_2.inx_data[i].page_no,off_set);
     #endif

     /************************************************************
      * Scan PRICE DATA
      ************************************************************/
     /*
      * Set the file pointer in PRICE.DAT
      */

     pthread_lock_global_np();
     {
       if ((newptr =
            lseek(PriceDat_handle, off_set, SEEK_SET)
           ) == -1L)
       {
         printf("SetFilePtr  Failed %ld\n", newptr);
         PTQNotFound=1;
         goto Bailout;
       }

       if ((bytes_read = read(PriceDat_handle,
                             &item_page,
                             sizeof(ITEM_PAGE))) == -1)
       {
         printf("Read <PRICE.DAT> Failed %d\n", bytes_read);
         PTQNotFound=1;
         goto Bailout;
       }
     }
     pthread_unlock_global_np();

     /*
      * Scan the data page for the item number.
      */

     i = 0;
     while (item_page.data[i].item_no < in_key && i < PriceDat_rows)
     {
       i++;

       #ifdef DEBUGIT
        printf ("   Data   Item Num = %11ld %11ld\n",in_key,item_page.data[i].item_no);
       #endif
     }

     if (item_page.data[i].item_no != in_key)
       {
         printf("Find row in <PRICE.DAT> Failed \n");
         PTQNotFound=1;
         goto Bailout;
       }

    #endif /* NODBM */
     /*
      * Copy the record into the RPC buffer.
      */
    Bailout:                               /* Come here is something bombs */

     if (PTQNotFound)
     {
       memcpy((ITEM_ROW_IDL *)ptq_buf, (ITEM_ROW_IDL *)&NO_PRICE_REC, sizeof(ITEM_ROW_IDL));
     }
     else
     {
       memcpy((ITEM_ROW_IDL *)ptq_buf, (ITEM_ROW_IDL *)&item_page.data[i], sizeof(ITEM_ROW_IDL));
     }

    /******************************************/
    ftime(&t2);                         /* Application STOP TIME */
    /*
     * Return the elapsed Application Time as a long integer
     */
    *appl_time = (t2.time*1000+t2.millitm)-(t1.time*1000+t1.millitm);
    /******************************************/

 }
#endif

/***********************************************
 * End of PTQ_STUB
 ***********************************************/

void NotFound(long dice)
{
  printf("Item/Customer Number %11ld was not found.\n", dice);
  return;
}
/***************************************************/


/**********************************************************
 * This call will kill the server.
 * Invoked by a transaction type = 9 from a requester.
 **********************************************************/
#ifdef POS_SECONDARY
void KILL_PTQ
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


