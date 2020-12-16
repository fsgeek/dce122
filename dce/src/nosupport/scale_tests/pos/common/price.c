/*********************************************************************/
/*************** IBM Confidential and Proprietary ********************/
/*** IBM Corporation                                               ***/
/*** OS/2 LAN Systems Performance                                  ***/
/*** Department 59LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 9151                                         ***/
/*** (512) 838-0454 TL 678-0454                                    ***/
/*********************************************************************/
/**** Calculate TPC TPS and other data **************************************/
/* * * * * * * * * * * * OS/2 include files (continued) * * * * * * * * * * */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef NODBM
 #include <fcntl.h>
 #include <io.h>
#endif

#include <os2.h>
#include <os2def.h>

#include <sys\stat.h>
#include <sys\timeb.h>
#include <sys\types.h>
#include "pos.h"

#ifdef DB22
 #include "sql.h"
 #include "sqlenv.h"
 #include "sqlca.h"
 #include "sqlcodes.h"
 #include "sqlutil.h"
 #include "sqlda.h"

 EXEC SQL INCLUDE SQLCA;
#endif
/* * * * * * * * * * * * * * * global/external variables  * * * * * * * * * */
#ifdef NODBM
 int         file_handle_inx0=0, file_handle_inx1=0, file_handle_inx2=0 ;
 unsigned long action_inx0=0,      action_inx1=0,      action_inx2=0      ;
 unsigned long bytecnt_inx0=0,     bytecnt_inx1=0,     bytecnt_inx2=0     ;
 unsigned long newptr_inx0=0,      newptr_inx1=0,      newptr_inx2=0      ;
 int         file_handle_dat=0;
 unsigned long action_dat=0;
 unsigned long bytecnt_dat=0;
 unsigned long newptr_dat=0;
 INX_HEADER    inx_header;
 INX_PAGE      inx_0;
#endif

#define SPACE " "

char *brand_names[]={"Berding","Sharpin",
                   "Zipperer","Bost","Russell",
                   "Orlosky","Pekowski","Corn","Lee","Li",
                   "Nichols","Weeks","Gordon","Knaus","Nazereth",
                   "Brissette","Snider",
                   "Sur","Handy","Dandy","Austin","Texas",
                   "Thomas","Petrosky","Keller","Norman","Forrest",
                   "Doggett","Means","Curry","Amsler","Bullock",
                   "Jones","Jordan","Emrick",
                   "McLean","Reininger","Bost","Humphrey","Antioch"};

char *items[]={"Widget","Object","Clamp","Ladder","Hammer",
              "Windmill","Bucksaw","Chair","Belt","Tool",
              "Hat","Necktie","Gadget","Thing","Cleaner",
              "Tray","Seat","Box","Container","Ball",
              "Stick","Baloon","Book","Framus","Junk"};

char *sizes[]={"Sm","Med","Lg","XL"};

char *adjective[]={"Pink", "White", "Black", "Brown", "Green",
                   "Grey", "Purple", "Orange", "Yellow", "Red",
                   "Improved", "Used", "Compact", "Adjusting", "Blue",
                   "Light", "Plastic", "Elastic", "Portable", "Invisable",
                   "Personal", "Preppy", "Golden", "Original", "New"};

char *alphabet[]={"A","B","C","D","E","F","G","H","I","J",
                 "K","L","M","N","O","P","Q","R","S","T",
                 "U","V","W","X","Y","Z"};

#define PERMS 0777

/***********************************************
 Begin MAIN
 ***********************************************/


void main(short argc, unsigned char * argv[]);
void main(short argc, unsigned char * argv[])
{
  #ifdef NODBM
    INX_PAGE      inx_1;
    INX_PAGE      inx_2;
    ITEM_PAGE     itm;
  #elif DB22
    ITEM_ROW      item_row;
  #endif

  long          cntr=0;
  int           i, j, k, l, m;
  long          max_rows=100000L;
  int           ret_code;
  FILE          *fp;
  int           d=0, inx0_cnt=0, inx1_cnt=0, inx2_cnt=0;
  char          * env_ptr;
  int           pos_scale=40;
  int           work_int;

  #ifdef DB22
   int                commit_count=0;
   long               total_count=0L;
   unsigned char      database[24];

   EXEC SQL BEGIN DECLARE SECTION;
     long       ITEM_NO       ;
     long       UPC_NO        ;
     char       DESCR[36]     ;
     char       DEPT_NO[4]    ;
     long       QTY_ON_HAND   ;
     char       INV_UNIT[8]   ;
     long       ORD_AT_QTY    ;
     long       QTY_TO_ORD    ;
     long       INV_CNT       ;
     char       INV_DATE[12]  ;
     long       QTY_ON_ORD    ;
     char       LST_ORD_DT[12];
     double     PRICE_1       ;
     char       EFF_DT_1[12]  ;
     double     PRICE_2       ;
     char       EFF_DT_2[12]  ;
     double     PRICE_3       ;
     char       EFF_DT_3[12]  ;
     double     UNIT_COST     ;
   EXEC SQL END DECLARE SECTION;
  #endif

  fprintf(stderr,"\n Inside the Main");

  /******************************************************/
   printf("*******************************************\n");
   printf("*        IBM Corporation(c) 1995          *\n");
   printf("*        PSP Systems Performance          *\n");
   printf("*       Point of Sale DCE Benchmark       *\n");
   printf("*           Department 59LS               *\n");
   printf("*             Austin, TX                  *\n");
   printf("*******************************************\n");
  /******************************************************/
  srand(3);

  #ifdef NODBM
    for (m=0; m<4;  m++) itm.filler[m]=0xFF;

    for (m=0; m<64; m++)
    {
      inx_0.inx_data[m].item_no = 0xFFFFFFFF;
      inx_0.inx_data[m].page_no = 0xFFFFFFFF;
      inx_1.inx_data[m].item_no = 0xFFFFFFFF;
      inx_1.inx_data[m].page_no = 0xFFFFFFFF;
      inx_2.inx_data[m].item_no = 0xFFFFFFFF;
      inx_2.inx_data[m].page_no = 0xFFFFFFFF;
    }

    fprintf(stderr,"\n Before the creat statement the Main");


    /* from posutil             open(file_name, O_CREAT | O_TRUNC | O_RDWR, S_IWRITE ) */
    if ((file_handle_inx0 = open ("inx0.inx", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
    { printf("open inx0.inx Failed, file_handle_inx0 %d  \n",file_handle_inx0); }

    if ((file_handle_inx1 = open ("inx1.inx", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
    { printf("open inx1.inx Failed, file_handle_inx1 %d  \n",file_handle_inx1); }

    if ((file_handle_inx2 = open ("inx2.inx", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
    { printf("open inx2.inx Failed, file_handle_inx2 %d  \n",file_handle_inx2); }

    if ((file_handle_dat = open ("price.dat", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
    { printf("open price.dat Failed, file_handle_dat %d  \n",file_handle_dat); }


    fprintf(stderr,"\n After the creat statement the Main");


    /* Make Index Header */
    inx_header.num_rows      = 0L;
    inx_header.levl_0_pages  = 1L;
    inx_header.levl_1_pages  = 1L;
    inx_header.levl_2_pages  = 1L;
    inx_header.data_pages    = 1L;
    inx_header.max_item_no   = max_rows + 10000000L;
    inx_header.min_item_no   =            10000001L;

    for (i=0;i<476;i++) inx_header.filler[i] = 0x00;

    for (i=0;i<3;i++)
    {
      itm.data[i].qty_on_hand   = 60L;
      sprintf(itm.data[i].inv_unit,"EACH\0");
      itm.data[i].ord_at_qty    = 50L;
      itm.data[i].qty_to_ord    = 50L;
      itm.data[i].inv_cnt       = 0L;
      sprintf(itm.data[i].inv_date,"07-01-1992\0");
      itm.data[i].qty_on_ord    = 0L;
      sprintf(itm.data[i].lst_ord_dt,"06-30-1992\0");
      itm.data[i].price_1       = 9.99;
      sprintf(itm.data[i].eff_dt_1  ,"07-15-1992\0");
      itm.data[i].price_2       = 8.88;
      sprintf(itm.data[i].eff_dt_2  ,"07-13-1992\0");
      itm.data[i].price_3       = 7.77;
      sprintf(itm.data[i].eff_dt_3  ,"01-01-1992\0");
      itm.data[i].unit_cost     = 0.25;
    }
    itm.itm_page_no = 0L;

  #elif DB22

    item_row.qty_on_hand   = 60L;
    sprintf(item_row.inv_unit,"EACH\0");
    item_row.ord_at_qty    = 50L;
    item_row.qty_to_ord    = 50L;
    item_row.inv_cnt       = 0L;
    sprintf(item_row.inv_date,"07-01-1992\0");
    item_row.qty_on_ord    = 0L;
    sprintf(item_row.lst_ord_dt,"06-30-1992\0");
    item_row.price_1       = 9.99;
    sprintf(item_row.eff_dt_1  ,"07-15-1992\0");
    item_row.price_2       = 8.88;
    sprintf(item_row.eff_dt_2  ,"07-13-1992\0");
    item_row.price_3       = 7.77;
    sprintf(item_row.eff_dt_3  ,"01-01-1992\0");
    item_row.unit_cost     = 0.25;

    /************* GET DB2/2 database name ****************/
    if (!(env_ptr = getenv("POSDBNAME")))
      strcpy(database,"POS96");
    else
      sprintf(database,env_ptr);

    /************* Open the Database *********************/
    printf("Start Using Database <%s> ", database);
    sqlestrd( database, SQL_USE_SHR, &sqlca);
    printf("SQLCODE= %ld\n",sqlca.sqlcode);

  #endif

  /************* GET Override for database size ****************/
  if (!(env_ptr = getenv("POSSCALE")))
    pos_scale=MAX_AREA_CODE;
  else
    pos_scale=atoi(env_ptr);
  if (pos_scale > 40) pos_scale = 40;
  printf("Database scaling will be %d\n",pos_scale);
  /*************************************************************/

  /* Load Table */
    cntr = 0L;
    for (i=0; i<4; i++)
    {
      for (j=0; j<25; j++)
      {
        printf("%11ld rows loaded\n", (long)i*25000L+(long)j*1000);

        #ifdef NODBM
          (void)sprintf(itm.data[d].dept_no,"D%.2d\0",1 + j % 10);
        #elif DB22
          (void)sprintf(item_row.dept_no,"D%.2d\0",1 + j % 10);
        #endif

        for (k=0; k<25; k++)
        {
          /*** for (l=0; l<40; l++) ***/
          for (l=0; l<pos_scale; l++)
          {
            /* price list */
            cntr++;

            #ifdef NODBM
              itm.data[d].item_no = cntr + 10000000L;
              itm.data[d].upc_no  = cntr + 90000000L;

              if (pos_scale < 40)
                work_int  = rand() % 40;
              else
                work_int=l;

              strcpy(itm.data[d].descr,brand_names[work_int]);
              strcat(itm.data[d].descr,SPACE);
              strcat(itm.data[d].descr,sizes[i]);
              strcat(itm.data[d].descr,SPACE);
              strcat(itm.data[d].descr,adjective[k]);
              strcat(itm.data[d].descr,SPACE);
              strcat(itm.data[d].descr,items[j]);

              ++inx_header.num_rows;

              inx_0.inx_data[inx0_cnt].item_no = itm.data[d].item_no;
              inx_1.inx_data[inx1_cnt].item_no = itm.data[d].item_no;
              inx_2.inx_data[inx2_cnt].item_no = itm.data[d].item_no;

              inx_0.inx_data[inx0_cnt].page_no = inx_header.levl_1_pages;
              inx_1.inx_data[inx1_cnt].page_no = inx_header.levl_2_pages;
              inx_2.inx_data[inx2_cnt].page_no = inx_header.data_pages;
            #elif DB22
              item_row.item_no = cntr + 10000000L;
              item_row.upc_no  = cntr + 90000000L;

              item_row.qty_on_hand   = 50 + rand() % 10;

              strcpy(item_row.descr,brand_names[l]);
              strcat(item_row.descr,SPACE);
              strcat(item_row.descr,sizes[i]);
              strcat(item_row.descr,SPACE);
              strcat(item_row.descr,adjective[k]);
              strcat(item_row.descr,SPACE);
              strcat(item_row.descr,items[j]);
            #endif

            #ifdef NODBM
              if(++d == 3 && cntr < max_rows)
              {
                /* Now write the data row */
                if ((ret_code = write (file_handle_dat, &itm, sizeof(ITEM_PAGE)) ) != sizeof(ITEM_PAGE))
                { printf("write data Failed %d\n",ret_code); }


                d = 0;                         /* reset the count */
                ++itm.itm_page_no;
                ++inx_header.data_pages;

                if (++inx2_cnt == 64)
                {
                  if ((ret_code =
                       write (file_handle_inx2,
                                 &inx_2,
                                  sizeof(INX_PAGE)) ) != sizeof(INX_PAGE))
                  {
                    printf("write inx_2 Failed %d\n",ret_code);
                  }

                  for (m=0;m<3;m++)
                  {
                    itm.data[m].item_no = 0xFFFFFFFF;
                    itm.data[m].upc_no  = 0xFFFFFFFF;
                  }

                  inx2_cnt = 0L;
                  ++ inx_header.levl_2_pages;

                  for (m=0; m<64; m++)
                  {
                    inx_2.inx_data[m].item_no = 0xFFFFFFFF;
                    inx_2.inx_data[m].page_no = 0xFFFFFFFF;
                  }

                  if (++inx1_cnt == 64L)
                  {
                    if ((ret_code =
                       write (file_handle_inx1,
                                 &inx_1,
                                  sizeof(INX_PAGE)) ) != sizeof(INX_PAGE))
                    {
                      printf("write inx_1 Failed %d\n",ret_code);
                    }

                    inx1_cnt = 0L;
                    ++inx_header.levl_1_pages;

                    for (m=0; m<64; m++)
                    {
                      inx_1.inx_data[m].item_no = 0xFFFFFFFF;
                      inx_1.inx_data[m].page_no = 0xFFFFFFFF;
                    }

                    if (++inx0_cnt == 64L)
                    {
                      if ((ret_code =
                       write (file_handle_inx0,
                                 &inx_0,
                                  sizeof(INX_PAGE)) ) != sizeof(INX_PAGE))
                      {
                        printf("write inx_0 Failed %d\n",ret_code);
                      }

                      inx0_cnt = 0L;
                      ++inx_header.levl_0_pages;

                      for (m=0; m<64; m++)
                      {
                        inx_0.inx_data[m].item_no = 0xFFFFFFFF;
                        inx_0.inx_data[m].page_no = 0xFFFFFFFF;
                      }
                    }
                  }
                }
              }
            #elif DB22

              /***** ifdef DB22 *****/

                               ITEM_NO            = item_row.item_no         ;
                               UPC_NO             = item_row.upc_no          ;
              strcpy(          DESCR              , item_row.descr           );
              strcpy(          DEPT_NO            , item_row.dept_no         );
                               QTY_ON_HAND        = item_row.qty_on_hand     ;
              strcpy(          INV_UNIT           , item_row.inv_unit        );
                               ORD_AT_QTY         = item_row.ord_at_qty      ;
                               QTY_TO_ORD         = item_row.qty_to_ord      ;
                               INV_CNT            = item_row.inv_cnt         ;
              strcpy(          INV_DATE           , item_row.inv_date        );
                               QTY_ON_ORD         = item_row.qty_on_ord      ;
              strcpy(          LST_ORD_DT         , item_row.lst_ord_dt      );
                               PRICE_1            = item_row.price_1         ;
              strcpy(          EFF_DT_1           , item_row.eff_dt_1        );
                               PRICE_2            = item_row.price_2         ;
              strcpy(          EFF_DT_2           , item_row.eff_dt_2        );
                               PRICE_3            = item_row.price_3         ;
              strcpy(          EFF_DT_3           , item_row.eff_dt_3        );
                               UNIT_COST          = item_row.unit_cost       ;


              EXEC SQL
                INSERT INTO posadmin.price
                VALUES (   :ITEM_NO      ,
                           :UPC_NO       ,
                           :DESCR        ,
                           :DEPT_NO      ,
                           :QTY_ON_HAND  ,
                           :INV_UNIT     ,
                           :ORD_AT_QTY   ,
                           :QTY_TO_ORD   ,
                           :INV_CNT      ,
                           :INV_DATE     ,
                           :QTY_ON_ORD   ,
                           :LST_ORD_DT   ,
                           :PRICE_1      ,
                           :EFF_DT_1     ,
                           :PRICE_2      ,
                           :EFF_DT_2     ,
                           :PRICE_3      ,
                           :EFF_DT_3     ,
                           :UNIT_COST
                       );

              if (SQLCODE || kbhit())
              {
                printf("INSERT sqlcode= %ld\n",sqlca.sqlcode);
                goto BailOut;
              }

              if (++commit_count >= 1000)
              {
                EXEC SQL COMMIT;
                total_count += (long)commit_count;
                commit_count = 0;
                printf("Rows committed = %8ld SQLCODE=%ld\n",
                                total_count,SQLCODE);
              }

            #endif
          }
        }
      }
    }
#ifdef DB22
  BailOut:

    EXEC SQL COMMIT;
    total_count += (long)commit_count;
    commit_count = 0;
    printf("Rows committed = %8ld SQLCODE=%ld\n",
                                total_count,SQLCODE);
    printf ("STOP USING DATABASE. ");
    sqlestpd(&sqlca);
    printf("SQLCODE= %d\n",sqlca.sqlcode);

#endif

#ifdef NODBM
    /* Flush indices to disk */
if (d > 0)
      /* Now write the data row */

       if ((ret_code = write (file_handle_dat, &itm, sizeof(ITEM_PAGE)) ) != sizeof(ITEM_PAGE))
       { printf("write data Failed %d\n",ret_code); }

if (inx2_cnt > 0)
       if ((ret_code = write (file_handle_inx2, &inx_2, sizeof(INX_PAGE)) ) != sizeof(INX_PAGE))
       { printf("write inx2 Failed %d\n",ret_code); }

if (inx1_cnt > 0)
       if ((ret_code = write (file_handle_inx1, &inx_1, sizeof(INX_PAGE)) ) != sizeof(INX_PAGE))
       { printf("write inx1 Failed %d\n",ret_code); }

       if ((ret_code = write (file_handle_inx0, &inx_header, sizeof(INX_HEADER)) ) != sizeof(INX_HEADER))
       { printf("write inx header Failed %d\n",ret_code); }
       if ((ret_code = write (file_handle_inx0, &inx_0, sizeof(INX_PAGE)) ) != sizeof(INX_PAGE))
       { printf("write inx_0 Failed %d\n",ret_code); }



    close (file_handle_inx0);

    close (file_handle_inx1);

    close (file_handle_inx2);

    close (file_handle_dat);

  printf("DATA ROWS ................ %11ld\n",inx_header.num_rows);
  printf("DATA PAGES ............... %11ld\n",inx_header.data_pages);
  printf("INDEX LEVEL 0 PAGES ...... %11ld\n",inx_header.levl_0_pages);
  printf("INDEX LEVEL 1 PAGES ...... %11ld\n",inx_header.levl_1_pages);
  printf("INDEX LEVEL 2 PAGES ...... %11ld\n",inx_header.levl_2_pages);
  printf("LOWEST ITEM NUMBER ....... %11ld\n",inx_header.min_item_no);
  printf("HIGHEST ITEM NUMBER ...... %11ld\n",inx_header.max_item_no);
  printf("sizeof(ITEM_PAGE) ........ %11ld\n",sizeof(ITEM_PAGE));
  printf("sizeof(ITEM_ROW) ......... %11ld\n",sizeof(ITEM_ROW));


  fp = fopen("PRICE.RPT","w");

  fprintf(fp,"DATA ROWS ................ %11ld\n",inx_header.num_rows);
  fprintf(fp,"DATA PAGES ............... %11ld\n",inx_header.data_pages);
  fprintf(fp,"INDEX LEVEL 0 PAGES ...... %11ld\n",inx_header.levl_0_pages);
  fprintf(fp,"INDEX LEVEL 1 PAGES ...... %11ld\n",inx_header.levl_1_pages);
  fprintf(fp,"INDEX LEVEL 2 PAGES ...... %11ld\n",inx_header.levl_2_pages);
  fprintf(fp,"LOWEST ITEM NUMBER ....... %11ld\n",inx_header.min_item_no);
  fprintf(fp,"HIGHEST ITEM NUMBER ...... %11ld\n",inx_header.max_item_no);
  fprintf(fp,"sizeof(ITEM_PAGE) ........ %11ld\n",sizeof(ITEM_PAGE));
  fprintf(fp,"sizeof(ITEM_ROW) ......... %11ld\n",sizeof(ITEM_ROW));

  fclose(fp);
#endif


  return;
} /* end main */

/***********************************************
 End of Main
 ***********************************************/
