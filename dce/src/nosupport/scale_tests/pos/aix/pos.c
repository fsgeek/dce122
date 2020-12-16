/** POS.C ************************************************************/
/*** IBM Corporation                                               ***/
/*** OS/2-AIX PSP Systems Performance                              ***/
/*** Department 57LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 9151                                         ***/
/*** (512) 838-0844 TL 678-0844                                    ***/
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
/*
 * Links to MOM.C to make client
 */

#ifdef AIX_PROD
  #include <cur00.h>
  #include <signal.h>
  #include <sys/timeb.h>
  #include <sys/types.h>
#elif IBMOS2
  #include <sys\timeb.h>
  #include <sys\types.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "rpc.h"
#include "exc_handling.h"
/*#include "exchandl.h"    */
#include "sec_login.h"
/*#include "seclgn.h"*/
#include "mom.h"
#include "pos_idl.h"
#include "pos_def.h"

void perhaps_an_error_2( error_status_t st1 );
void CrashRecovery (rpc_binding_handle_t *bind_h );
/*** Catalog Variables ***/
unsigned char catalog_buffer[CAT_BUFF];

short                   PosCatalog;
long                    PosCatalogPage;

char *cat_names[]={"GENERAL",
                   "SUMMER",
                   "SPRING",
                   "AUTUMN",
                   "WINTER",
                   "SPECIAL",
                   "GARDEN",
                   "TRUCKS",
                   "TRACTORS",
                   "TRAINS",
                   "TOOLS",
                   "TOYS"};

int           display_row=12;
short         the_server_crashed;

char          pad[72]=
  "                                                                        ";
 FILE        *fp;

/* Changes for POSCNTRL */
long            interval; /* Think Time Parameter */
unsigned32      longAuthLevel;
unsigned short  flag_1;
unsigned short  flag_2;
unsigned short  flag_3;
unsigned short  flag_4;
unsigned short  flag_5;
unsigned short  flag_6;
unsigned short  flag_7;
unsigned short  flag_8;
int             pos_scale;


/*** PRICE LOOKUP *********************************************************/
long PriceInq( long *appl_time,
               int NoPrint,
               struct timeb *d1,
               struct timeb *d2,
               SAVE_DATA *save_data,
               rpc_binding_handle_t bind_h)

{
  long          dice, work_int, item_no;
  ITEM_ROW_IDL  item_row;
  char          today[12];
  ITEM_ROW_IDL *ptq_buffer;


  /*
   * Pseudo Sales Data - matches price dates in database
   */
  dice = get_random(6L) + 10L;            /* Database DD < 13 >< 15 > */
  (void)sprintf(today,"07-%.2ld-1992\0", dice);
  save_data->line_item[save_data->trans_header.item_cnt].qty =
                                                     ((short)dice % 3) + 1;

  if (pos_scale == 1)
  {
    /* going to scale down range for mini-DB2/2 database testing */
    work_int = (MAX_ITEMS / 40L);
    item_no = get_random(work_int) + 10000000L;       /* Make item number  */
  }
  else
    item_no = get_random(MAX_ITEMS) + 10000000L;       /* Make item number  */
  save_data->line_item[save_data->trans_header.item_cnt].item_no = item_no;

  /*
   * Number of items on sales slip
   */
  if (! NoPrint)
  {
    display_row = 12 + save_data->trans_header.item_cnt;
    SetCursorPosition(display_row,3);                  /* Display the key   */
    #ifdef AIX_PROD
      printw ( "%4d %11ld",
        save_data->line_item[save_data->trans_header.item_cnt].qty, item_no);
      refresh();
    #elif IBMOS2
      printf ( "%4d %11ld\n",
        save_data->line_item[save_data->trans_header.item_cnt].qty,
        item_no );
    #endif
  }

  ptq_buffer = &item_row;

  ftime(d1);                                     /* Start timestamp   */

  the_server_crashed = 0;
  TRY

    rpc_PTQ(bind_h,                            /* Make the RPC call */
            item_no,
            sizeof(ITEM_ROW_IDL),
            appl_time,
            ptq_buffer);

  CATCH_ALL
    SetCursorPosition(22,0);
    #ifdef AIX_PROD
      printw ( "Price RPC Retry in progress...");
      refresh();
    #elif IBMOS2
      printf ( "Price RPC Retry in progress...\n");
    #endif
    the_server_crashed = 1;
  ENDTRY


  ftime(d2);                                     /* Stop timestamp    */

  /* Now we gotta take the right price based on date */
  if (today[4] < item_row.eff_dt_2[4])
      save_data->line_item[save_data->trans_header.item_cnt].price_each =
      item_row.price_3;
  else if (today[4] < item_row.eff_dt_1[4])
      save_data->line_item[save_data->trans_header.item_cnt].price_each =
      item_row.price_2;
  else
      save_data->line_item[save_data->trans_header.item_cnt].price_each =
      item_row.price_1;


  if (the_server_crashed == 0)
  {
    save_data->line_item[save_data->trans_header.item_cnt].price_total  =
      save_data->line_item[save_data->trans_header.item_cnt].price_each *
      (float)save_data->line_item[save_data->trans_header.item_cnt].qty;
    strcpy(save_data->line_item[save_data->trans_header.item_cnt].descr,
      item_row.descr);
  }

  if (! NoPrint)
  {
    prtf(display_row,20,item_row.descr,sizeof(item_row.descr));
    SetCursorPosition(display_row,61);
    #ifdef AIX_PROD
      printw ("%8.2f  %8.2f",
    #elif IBMOS2
      printf ("%8.2f  %8.2f\n",
    #endif
      save_data->line_item[save_data->trans_header.item_cnt].price_each,
      save_data->line_item[save_data->trans_header.item_cnt].price_each *
      (float)save_data->line_item[save_data->trans_header.item_cnt].qty);
    #ifdef AIX_PROD
      refresh();
    #endif
  }
}
/* End Price Lookup */

/*** CATALOG LOOKUP *******************************************************/
long Catalog( long *appl_time,
              int NoPrint,
              struct timeb *d1,
              struct timeb *d2,
              rpc_binding_handle_t bind_h)

{
  char          *cat_buffer;
  char           cat_name[40];
  unsigned short name_len;
  unsigned short out_len = CAT_BUFF;


  PosCatalog = (short)get_random(MAX_CATALOGS) -1;
  if (pos_scale == 1)
    PosCatalogPage = 1;
  else
    PosCatalogPage = get_random(MAX_PAGES);


  (void)sprintf(cat_name, "%s.%.3ld\0", cat_names[PosCatalog], PosCatalogPage);
  name_len = strlen(cat_name);


  if (! NoPrint)
  {
    SetCursorPosition( 2, 24);
    /*if (++display_row == 17) display_row = 12;*/
    display_row = 12;

    #ifdef AIX_PROD
      printw ( " %10s ", cat_name);
      refresh();
    #elif IBMOS2
      printf ( " %10s \n", cat_name);
    #endif
  }

  cat_buffer = (char *)&catalog_buffer;

  ftime(d1);                                     /* Start timestamp   */

  the_server_crashed = 0;
  TRY

    rpc_CAT(bind_h,                        /* Make the RPC call */
            PosCatalog,
            name_len,
            CAT_NAME_LEN,
            cat_name,
            &out_len,
            appl_time,
            cat_buffer);

  CATCH_ALL
    SetCursorPosition(22,0);
    #ifdef AIX_PROD
      printw ( "Catalog RPC Retry in progress...");
      refresh();
    #elif IBMOS2
      printf ( "Catalog RPC Retry in progress...\n");
    #endif
    the_server_crashed = 1;
  ENDTRY

  ftime(d2);                                     /* Stop timestamp    */

  return;

}
/* End Catalog */

/*** CUSTOMER LOOKUP *********************************************************/
long CustInq( long *appl_time,
              int NoPrint,
              struct timeb *d1,
              struct timeb *d2,
              SAVE_DATA *save_data,
              rpc_binding_handle_t bind_h)

{
  long          dice;
  CUST_DATA_IDL     cust_data;
  CUST_DATA_IDL          *cmr_buffer;
  long          area_cd, phone_no;
  long          new_think_time;
  unsigned32    new_auth_level;

  char          *pntr;
  int           i, j;

  /* Make an AREA_CODE and PHONE_NO in the database  range*/

  area_cd   = get_random(MAX_AREA_CODE) + 499L;       /* Make Area Code  */
  if (pos_scale == 1)
    area_cd   = get_random(pos_scale) + 499L;     /* Make Area Code */
  else
    area_cd = 500L;

  phone_no  = get_random(MAX_EXCHANGE) * 10000L + 999999L;/*Make Exchange*/

  phone_no +=(dice = get_random(MAX_EXTENSION));      /* Make extension  */

  if (! NoPrint)
  {
    SetCursorPosition(7,5);                  /* Display the key   */
    #ifdef AIX_PROD
      printw ( "(%3ld) Ph %7ld", area_cd, phone_no);
      refresh();
    #elif IBMOS2
      printf ( "(%3ld) Ph %7ld\n", area_cd, phone_no);
    #endif
  }

  cmr_buffer = &cust_data;

  ftime(d1);                                     /* Start timestamp   */

  the_server_crashed = 0;
  TRY


    rpc_CMR(bind_h,                       /* Make the RPC call */
            area_cd,
            phone_no,
            sizeof(CUST_DATA_IDL),
            appl_time,
            cmr_buffer,
            &new_think_time,
            &new_auth_level,
            &flag_1,
            &flag_2,
            &flag_3,
            &flag_4,
            &flag_5,
            &flag_6,
            &flag_7,
            &flag_8
            );

  CATCH_ALL
    SetCursorPosition(22,0);
    #ifdef AIX_PROD
      printw ( "Customer RPC Retry in progress...");
      refresh();
    #elif IBMOS2
      printf ( "Customer RPC Retry in progress...\n");
    #endif
    the_server_crashed = 1;
  ENDTRY

  ftime(d2);                                     /* Stop timestamp    */

  if(flag_2){
        interval=new_think_time;
        longAuthLevel=new_auth_level;
  }

                 /* HEX dump of the buffer being returned
                 pntr=(char *)&cust_data;
                 fp=fopen("x.bin","a");
                 j=0;
                 for (i=0;i<512;i++)
                 {
                   fprintf(fp,"%.2x ",*(pntr+i));
                   if (++j==16){j=0; fprintf(fp,"\n");}
                 }
                 fprintf(fp,"\n");

                 fclose(fp);
                 */


  if (! NoPrint)
  {
    SetCursorPosition(2,6);

    #ifdef AIX_PROD
      printw("%8ld", cust_data.acct_id);
    #elif IBMOS2
      printf("%8ld\n", cust_data.acct_id);
    #endif

    prtf(3,5, cust_data.cust_last_name,sizeof(cust_data.cust_last_name));
    prtf(3,54,cust_data.cust_first_name,sizeof(cust_data.cust_first_name));

    SetCursorPosition(3,77);

    #ifdef AIX_PROD
      printw("%s",cust_data.cust_MI);
    #elif IBMOS2
      printf("%s\n",cust_data.cust_MI);
    #endif

    prtf(4,9,cust_data.ship_addr,sizeof(cust_data.ship_addr)-1);
    if (flag_1)
      prtf(5,9,cust_data.mail_addr,sizeof(cust_data.mail_addr)-1);
    /* else DCE_4 will print binding handle on this line */
    prtf(6,5,cust_data.city,sizeof(cust_data.city));

    SetCursorPosition(6,61);

    #ifdef AIX_PROD
      printw("%2s   Zip %9ld", cust_data.state,
    #elif IBMOS2
      printf("%2s   Zip %9ld\n", cust_data.state,
    #endif
                               cust_data.zip_code);
    prtf(7,45,cust_data.drv_lic,sizeof(cust_data.drv_lic));

    SetCursorPosition(7,78);

    #ifdef AIX_PROD
      printw("%s", cust_data.drv_lic_state);
    #elif IBMOS2
      printf("%s\n", cust_data.drv_lic_state);
    #endif

    prtf(8,8,cust_data.cust_ref,sizeof(cust_data.cust_ref));

    SetCursorPosition(19,62);

    #ifdef AIX_PROD
      printw("%6.2f", cust_data.disc_pcnt);
    #elif IBMOS2
      printf("%6.2f\n", cust_data.disc_pcnt);
    #endif

    SetCursorPosition(20,62);

    #ifdef AIX_PROD
      printw("%6.2f", cust_data.tax_pcnt);
    #elif IBMOS2
      printf("%6.2f\n", cust_data.tax_pcnt);
    #endif

    prtf(21,14,cust_data.date_last_purch,sizeof(cust_data.date_last_purch));

    #ifdef AIX_PROD
      refresh();
    #endif
  }

  save_data->trans_header.acct_id     = cust_data.acct_id;
  save_data->trans_header.employee_no = phone_no;
  strcpy(save_data->trans_header.cust_ref, cust_data.cust_ref);
  strcpy(save_data->trans_header.trans_type, "SALE");
  strcpy(save_data->trans_header.paymt_type, "CHECK");
}
/* End Price Customer */

/*** SAVE TRANSACTION *****************************************************/
long History(long *appl_time,
             int NoPrint,
             struct timeb *d1,
             struct timeb *d2,
             SAVE_DATA    *save_data,
             rpc_binding_handle_t bind_h)
{
  SAVE_DATA_IDL          *sav_buffer;
  unsigned long rc;
  int real_size;
  int m;

  sav_buffer = (SAVE_DATA_IDL *) save_data;

#ifdef DEBUGIT
fprintf(stderr, "sav_buffer.trans_no.dept_no=%s\n", sav_buffer->trans_no.dept_no);
fprintf(stderr, "sav_buffer.trans_no.trans_date=%s\n", sav_buffer->trans_no.trans_date);
fprintf(stderr, "sav_buffer.trans_no.trans_time=%s\n", sav_buffer->trans_no.trans_time);
fprintf(stderr, "sav_buffer.trans_no.reg_no=%d\n", sav_buffer->trans_no.reg_no);


fprintf(stderr, "sav_buffer.trans_header.acct_id=%d\n", sav_buffer->trans_header.acct_id);
fprintf(stderr, "sav_buffer.trans_header.line_item_cnt=%d\n", sav_buffer->trans_header.line_item_cnt);
fprintf(stderr, "sav_buffer.trans_header.item_cnt=%d\n", sav_buffer->trans_header.item_cnt);
fprintf(stderr, "sav_buffer.trans_header.trans_type=%s\n", sav_buffer->trans_header.trans_type);
fprintf(stderr, "sav_buffer.trans_header.paymt_type=%s\n", sav_buffer->trans_header.paymt_type);
fprintf(stderr, "sav_buffer.trans_header.employee_no=%d\n", sav_buffer->trans_header.employee_no);
fprintf(stderr, "sav_buffer.trans_header.cust_ref=%s\n", sav_buffer->trans_header.cust_ref);
fprintf(stderr, "sav_buffer.trans_header.padding=%s\n", sav_buffer->trans_header.padding);

for (m=0;m<4;m++)
{
fprintf(stderr, "sav_buffer.line_item[%d].item_no=%d\n",m, sav_buffer->line_item[m].item_no);
fprintf(stderr, "sav_buffer.line_item[%d].qty=%d\n",m, sav_buffer->line_item[m].qty);
fprintf(stderr, "sav_buffer.line_item[%d].price_each=%f\n",m, sav_buffer->line_item[m].price_each);
fprintf(stderr, "sav_buffer.line_item[%d].price_total=%f\n",m, sav_buffer->line_item[m].price_total);
fprintf(stderr, "sav_buffer.line_item[%d].descr=%s\n",m, sav_buffer->line_item[m].descr);
fprintf(stderr, "sav_buffer.line_item[%d].padding=%s\n",m, sav_buffer->line_item[m].padding);
fprintf(stderr, "save_data.line_item[%d].padding=%s\n",m, save_data->line_item[m].padding);
}
#endif /*DEBUGIT*/

  real_size = sizeof(TRANS_NO) +
              sizeof(TRANS_HEADER) +
              sizeof(LINE_ITEM) * save_data->trans_header.line_item_cnt;

#ifdef DEBUGIT
fprintf(stderr, "real_size=[%d] sizeof  SAVE_DATA_IDL=%d\n",real_size, sizeof(SAVE_DATA_IDL));
#endif /*DEBUGIT*/

  ftime(d1);                                     /* Start timestamp   */

  the_server_crashed = 0;
  TRY

    rpc_SAV(bind_h,                           /* Make the RPC call */
            real_size,
            sizeof(SAVE_DATA_IDL),
            appl_time,
            sav_buffer,
            &rc
            );

  CATCH_ALL
    SetCursorPosition(22,0);
    #ifdef AIX_PROD
      printw ( "History RPC Retry in progress...");
      refresh();
    #elif IBMOS2
      printf ( "History RPC Retry in progress...\n");
    #endif
    the_server_crashed = 1;
  ENDTRY

  ftime(d2);                                     /* Stop timestamp    */

  SetCursorPosition(9,30);

  #ifdef AIX_PROD
    printw("%8ld",rc);
    refresh();
  #elif IBMOS2
    printf("%8ld\n",rc);
  #endif


}
/*******************************************************
 * This is a case to test data transfer between cli and srv
 * this is the same as APPPERF and similar to PERF standard
 * RPC test cases. No normally a part of POS transaction mix
 * use MOM.EXE transaction_type parm = 3 to invoke this
 *******************************************************/
long DataXfer(short num_send,
              short num_recv,
              struct timeb *d1,
              struct timeb *d2,
              rpc_binding_handle_t bind_h)
{

    unsigned char * sendbuf;
    unsigned char * recvbuf;
    unsigned char send_buf[8192];
    unsigned char recv_buf[100];
    int           i;


    for (i=0; i<num_send; i++)
    {
       send_buf[i] = 'X';
    }
    send_buf[num_send-1]='\0';

    sprintf(recv_buf,"EMPTY\0");
    sendbuf = (unsigned char *)send_buf;
    recvbuf = (unsigned char *)recv_buf;

    ftime(d1);                                     /* Start timestamp   */

    for (i = 1; i <= 10; i++)
    {
      the_server_crashed = 0;
      TRY

        char_op( bind_h,
                 num_send,
                 sendbuf,
                 num_recv,
                 recvbuf );
      CATCH_ALL
        SetCursorPosition(22,0);
        #ifdef AIX_PROD
          printw ( "RPC Retry in progress...");
          refresh();
        #elif IBMOS2
          printf ( "RPC Retry in progress...\n");
        #endif
        the_server_crashed = 1;
        i = 10;
      ENDTRY
    }

    ftime(d2);                                     /* Stop timestamp    */

}
/*******************************************************
 * Left Adjust the text in the specified in/output field length
 *******************************************************/
void prtf(int r,int c,char v[74],int l)
{
  int s;
  char w[80];

  SetCursorPosition(r,c);

  s = l - strlen(v);

  strcpy(w,v);

  if (s>0) strncat(w,pad,s);

  #ifdef AIX_PROD
    printw("%s", w);
  #elif IBMOS2
    printf("%s\n", w);
  #endif

  return;
}
/**************************************************************************/
