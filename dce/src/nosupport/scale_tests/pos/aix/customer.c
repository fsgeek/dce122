/*********************************************************************/
/* CUSTOMER.C - Builds Customer Database and Index for POS           */
/*********************************************************************/
/*** IBM Corporation                                               ***/
/*** OS/2 LAN Systems Performance                                  ***/
/*** Department 59LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 9151                                         ***/
/*** (512) 838-0454 TL 678-0454                                    ***/
/*********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef DB22
  #include <fcntl.h>
#endif

#ifdef IBMOS2
 #ifndef DB22
  #include <io.h>
 #endif

 #include <os2.h>
 #include <os2def.h>

 #include <sys\stat.h>
 #include <sys\timeb.h>
 #include <sys\types.h>
 #ifdef DB22
  #include "sql.h"
  #include "sqlenv.h"
  #include "sqlca.h"
  #include "sqlcodes.h"
  #include "sqlutil.h"
  #include "sqlda.h"

  EXEC SQL INCLUDE SQLCA;
 #endif
#elif AIX_PROD
 #include <sys/stat.h>
 #include <sys/timeb.h>
 #include <sys/types.h>
#endif

#include "pos.h"
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

char *last_names[]={"Berding","Sharpin",
                   "Zipperer","Bost","Russell",
                   "Orlosky","Pekowski","Corn","Lee","Li",
                   "Nichols","Weeks","Gordon","Knaus","Nazereth",
                   "Brissette","Snider",
                   "Sur","Handy","Dandy","Austin","Texas",
                   "Thomas","Petrosky","Keller","Norman","Forrest",
                   "Doggett","Means","Curry","Amsler","Bullock",
                   "Jones","Jordan","Emrick",
                   "McLean","Reininger","Bost","Humphrey","Antioch"};

char *first_names[]={"Tom","Ray","Pat","Craig","Robert",
                    "Bob","Cindy","Jerry","Tim","Jesse",
                    "Lynn","Laura","Brenda","Becky","Wally",
                    "Vicky","Miranda","Jessica","Brittany","Todd",
                    "Troy","Odell","Lee","Mary","Ashley",
                    "Ted","Susan","James","Dick","Lefty",
                    "Ken","Linda","Odie","Shyla","Dawn",
                    "Joyce","Debra","Rolland","Madge","Michael",
                    "Kathy","Stephanie","Ben","Jeffery","Suzie",
                    "Jim","Dean","Gypsy","Joan","Don"};

char *middle_names[]={"Ann","Bob","Matt","Doug","Paul",
                      "Art","Beth","Clara","Doris","Peter",
                      "Beverly","Hannah","Luke","Iris","June",
                      "Fred","Gene","Mark","Ivan","Jim",
                      "John","Lea","Marie","Nancy","Opal",
                      "Kirt","Lee","Monte","Ted","Mary",
                      "Buba","James","Penney","Alex","Sue",
                      "Lou","Zoe","Joe","Sam","Sarah"};



char *adjective[]={"Pink", "White", "Black", "Brown", "Green",
                   "Grey", "Purple", "Orange", "Yellow", "Red",
                   "Improved", "Used", "Compact", "Adjusting", "Blue",
                   "Light", "Plastic", "Elastic", "Portable", "Invisable",
                   "Personal", "Preppy", "Golden", "Original", "New"};

char *alphabet[]={"A","B","C","D","E","F","G","H","I","J",
                 "K","L","M","N","O","P","Q","R","S","T",
                 "U","V","W","X","Y","Z",
                 "a","b","c","d","e","f","g","h","i","j",
                 "k","l","m","n","o","p","q","r","s","t",
                 "u","v","w","x","y","z"};

char *cities[]={"Glitter Gultch",
                "Las Vegas",
                "Carson City",
                "Reno",
                "Lathrop Wells",
                "Henderson",
                "Tonopah",
                "Boulder City",
                "Garderville",
                "Genoa", };
/***********************************************
 Begin MAIN
 ***********************************************/


void main(short argc, unsigned char * argv[]);
void main(short argc, unsigned char * argv[])
{
  #ifndef DB22
   CUS_INX_HEADER     inx_header;
   CUS_INX_PAGE       inx_0, inx_1, inx_2;
  #else
   int                commit_count=0;
   long               total_count=0L;
  #endif

  CUST_DATA          cust_data;

  long          cntr=0;
  int           i, j, k, l, m, dice;
  long          max_rows=100000L;
  int           ret_code;
  FILE          *fp;
  int           d=0, inx0_cnt=0, inx1_cnt=0, inx2_cnt=0;
  char          * env_ptr;
  unsigned char database[24];
  int           pos_scale=MAX_AREA_CODE;
  /******************************************************/
  #ifdef DB22
    EXEC SQL BEGIN DECLARE SECTION;

      long       AREA_CODE;
      long       PHONE_NO;
      char       EXTN[8];
      long       ACCT_ID;
      char       CUST_LAST_NAME[48];
      char       CUST_FIRST_NAME[24];
      char       CUST_MI[4];
      char       SHIP_ADDR[72];
      char       MAIL_ADDR[72];
      char       STATE[4];
      char       CITY[48];
      long       ZIP_CODE;
      char       CUST_TYPE[4];
      double     DISC_PCNT;
      double     TAX_PCNT;
      char       DRV_LIC[24];
      char       DRV_LIC_STATE[4];
      char       DATE_LAST_PURCH[12];
      char       CUST_REF[72];
      char       CUST_FILLER[84];

      char       cmdstring[150];
    EXEC SQL END DECLARE SECTION;
  #endif
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

  for (i=0;i<83;i++)
    cust_data.cust_filler[i]=0xFF;
  cust_data.cust_filler[83]=0x00;

  strcpy(cust_data.date_last_purch,"01-01-1900");
  strcpy(cust_data.extn,"1234567");
  strcpy(cust_data.city,"Glitter Gulch");
  strcpy(cust_data.state,"NV");
  strcpy(cust_data.drv_lic_state,"NV");

  #ifndef DB22
   for (m=0; m<476;  m++) inx_header.filler[m]=0xFF;

   inx_0.cus_inx_page_no = 1;
   inx_1.cus_inx_page_no = 1;
   inx_2.cus_inx_page_no = 1;

   for (m=0; m<42; m++)
   {
     inx_0.cus_inx_data[m].area_code = 0xFFFFFFFF;
     inx_0.cus_inx_data[m].phone_no  = 0xFFFFFFFF;
     inx_0.cus_inx_data[m].page_no   = 0xFFFFFFFF;
     inx_1.cus_inx_data[m].area_code = 0xFFFFFFFF;
     inx_1.cus_inx_data[m].phone_no  = 0xFFFFFFFF;
     inx_1.cus_inx_data[m].page_no   = 0xFFFFFFFF;
     inx_2.cus_inx_data[m].area_code = 0xFFFFFFFF;
     inx_2.cus_inx_data[m].phone_no  = 0xFFFFFFFF;
     inx_2.cus_inx_data[m].page_no   = 0xFFFFFFFF;
   }


   #ifdef IBMOS2
     if ((file_handle_inx0 = open ("cinx0.inx", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
     { printf("open inx0.inx Failed, file_handle_inx0 %d  \n",file_handle_inx0); }

     if ((file_handle_inx1 = open ("cinx1.inx", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
     { printf("open inx1.inx Failed, file_handle_inx1 %d  \n",file_handle_inx1); }

     if ((file_handle_inx2 = open ("cinx2.inx", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
     { printf("open inx2.inx Failed, file_handle_inx2 %d  \n",file_handle_inx2); }

     if ((file_handle_dat = open ("customer.dat", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
     { printf("open price.dat Failed, file_handle_dat %d  \n",file_handle_dat); }
   #elif AIX_PROD
     if ((file_handle_inx0 = open ("cinx0.inx", O_CREAT | O_TRUNC | O_RDWR, S_IWRITE)) == -1)
     { printf("open inx0.inx Failed, file_handle_inx0 %d  \n",file_handle_inx0); }

     if ((file_handle_inx1 = open ("cinx1.inx", O_CREAT | O_TRUNC | O_RDWR, S_IWRITE)) == -1)
     { printf("open inx1.inx Failed, file_handle_inx1 %d  \n",file_handle_inx1); }

     if ((file_handle_inx2 = open ("cinx2.inx", O_CREAT | O_TRUNC | O_RDWR, S_IWRITE)) == -1)
     { printf("open inx2.inx Failed, file_handle_inx2 %d  \n",file_handle_inx2); }

     if ((file_handle_dat = open ("customer.dat", O_CREAT | O_TRUNC | O_RDWR, S_IWRITE)) == -1)
     { printf("open price.dat Failed, file_handle_dat %d  \n",file_handle_dat); }
   #endif
   /* Make Index Header */
   inx_header.num_rows      = 0L;
   inx_header.levl_0_pages  = 1L;
   inx_header.levl_1_pages  = 1L;
   inx_header.levl_2_pages  = 1L;
   inx_header.data_pages    = 1L;
   inx_header.min_area_code= 500L;
   inx_header.max_area_code= 0L;
   inx_header.min_phone_no = 1000000L;
   inx_header.max_phone_no = 0L;
  #endif
  /************* GET Override for database size ****************/
  if (!(env_ptr = getenv("POSSCALE")))
    pos_scale=MAX_AREA_CODE;
  else
    pos_scale=atoi(env_ptr);
  printf("Area Code scaling will be %d\n",pos_scale);
  /*************************************************************/
  #ifdef DB22
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

  /* The Load Table */
    cntr = 0L;
    cust_data.acct_id = 0L;
  /*    for (i=0; i<50; i++) */
    for (i=0; i<=pos_scale; i++)
    {
      cust_data.area_code = (long)i + 500L;
      strcpy(cust_data.cust_MI,alphabet[i]);

      #ifdef NODBM
       inx_header.max_area_code= cust_data.area_code;
      #endif

      strcpy(cust_data.cust_type,alphabet[i]);
      switch(cntr)
      {
        case 1:                   /* federal */
        {
          cust_data.disc_pcnt = 20.0;
          cust_data.tax_pcnt = 0.0;
          break;
        }
        case 2:                   /* state  */
        case 3:                   /* local  */
        case 5:                   /* school */
        {
          cust_data.disc_pcnt = 10.0;
          cust_data.tax_pcnt = 0.0;
          break;
        }
        default:                   /* commercial */
        {
          cust_data.disc_pcnt = 0.0;
          cust_data.tax_pcnt = 8.5;
          break;
        }

      }
      if (++cntr > 10) cntr = 0;

      for (j=0; j<40; j++)
      {

        strcpy(cust_data.cust_last_name,'\0');
        strcpy(cust_data.cust_last_name,last_names[j]);
        for (k=0; k<50; k++)
        {
           strcpy(cust_data.cust_first_name,'\0');
           strcpy(cust_data.cust_first_name,first_names[k]);
           cust_data.acct_id++;
           cust_data.phone_no = (long)k + 1000000L + (long)j * 10000L;
           strcpy(cust_data.ship_addr,'\0');
           (void)sprintf(cust_data.ship_addr,"%d %s Street Apt# %d\0",
                         k, middle_names[j],i);
           strcpy(cust_data.mail_addr,'\0');
           (void)sprintf(cust_data.mail_addr,"P.O. Box %ld\0",
                         cust_data.acct_id);

           dice = rand() % 10;
           strcpy(cust_data.city,cities[dice]);

           strcpy(cust_data.drv_lic,'\0');
           (void)sprintf(cust_data.drv_lic,"%s%.11ld\0",
                         alphabet[k],
                         cust_data.acct_id);
           cust_data.zip_code = 89700L + (long)i;
           strcpy(cust_data.cust_ref,'\0');
           (void)sprintf(cust_data.cust_ref,
           "Purchase Order Number %s\0", cust_data.drv_lic);

           #ifndef DB22
            inx_header.max_phone_no = cust_data.phone_no;
           #endif

           /* Now write the data row */
           #ifndef DB22
               if ((ret_code = write (file_handle_dat, &cust_data, sizeof(CUST_DATA)) ) != sizeof(CUST_DATA))
               { printf("write data Failed %d\n",ret_code); }

               inx_2.cus_inx_data[inx2_cnt].area_code = cust_data.area_code;
               inx_2.cus_inx_data[inx2_cnt].phone_no = cust_data.phone_no;
               inx_2.cus_inx_data[inx2_cnt].page_no = inx_header.data_pages++;
               inx_1.cus_inx_data[inx1_cnt].area_code = cust_data.area_code;
               inx_1.cus_inx_data[inx1_cnt].phone_no = cust_data.phone_no;
               inx_1.cus_inx_data[inx1_cnt].page_no = inx_header.levl_2_pages;
               inx_0.cus_inx_data[inx0_cnt].area_code = cust_data.area_code;
               inx_0.cus_inx_data[inx0_cnt].phone_no = cust_data.phone_no;
               inx_0.cus_inx_data[inx0_cnt].page_no = inx_header.levl_1_pages;

               if (++inx2_cnt == 42)
               {
                 if ((ret_code = write (file_handle_inx2, &inx_2, sizeof(CUS_INX_PAGE)) ) != sizeof(CUS_INX_PAGE))
                 { printf("write inx_2 Failed %d\n",ret_code); }

                 inx2_cnt = 0L;
                 inx_2.cus_inx_page_no++;
                 ++inx_header.levl_2_pages;

                 for (m=0; m<42; m++)
                 {
                   inx_2.cus_inx_data[m].area_code = 0xFFFFFFFF;
                   inx_2.cus_inx_data[m].phone_no  = 0xFFFFFFFF;
                   inx_2.cus_inx_data[m].page_no   = 0xFFFFFFFF;
                 }



                 if (++inx1_cnt == 42L)
                 {
                   if ((ret_code = write (file_handle_inx1, &inx_1, sizeof(CUS_INX_PAGE)) ) != sizeof(CUS_INX_PAGE))
                   { printf("write inx_1 Failed %d\n",ret_code); }

                   inx1_cnt = 0L;
                   inx_1.cus_inx_page_no++;
                   ++inx_header.levl_1_pages;

                   for (m=0; m<42; m++)
                   {
                     inx_1.cus_inx_data[m].area_code = 0xFFFFFFFF;
                     inx_1.cus_inx_data[m].phone_no  = 0xFFFFFFFF;
                     inx_1.cus_inx_data[m].page_no   = 0xFFFFFFFF;
                   }



                   if (++inx0_cnt == 42L)
                   {
                     if ((ret_code = write (file_handle_inx0, &inx_0, sizeof(CUS_INX_PAGE)) ) != sizeof(CUS_INX_PAGE))
                     { printf("write inx_0 Failed %d\n",ret_code); }

                     inx0_cnt = 0L;
                     inx_0.cus_inx_page_no++;
                     ++inx_header.levl_0_pages;

                     for (m=0; m<42; m++)
                     {
                       inx_0.cus_inx_data[m].area_code = 0xFFFFFFFF;
                       inx_0.cus_inx_data[m].phone_no  = 0xFFFFFFFF;
                       inx_0.cus_inx_data[m].page_no   = 0xFFFFFFFF;
                     }
                   }
                 }
               }
           #endif
           #ifdef DB22
            /***** ifdef DB22 *****/

                      AREA_CODE          = cust_data.area_code        ;
                      PHONE_NO           = cust_data.phone_no         ;
            strcpy(   EXTN               , cust_data.extn             );
                      ACCT_ID            = cust_data.acct_id          ;
            strcpy(   CUST_LAST_NAME     , cust_data.cust_last_name   );
            strcpy(   CUST_FIRST_NAME    , cust_data.cust_first_name  );
            strcpy(   CUST_MI            , cust_data.cust_MI          );
            strcpy(   SHIP_ADDR          , cust_data.ship_addr        );
            strcpy(   MAIL_ADDR          , cust_data.mail_addr        );
            strcpy(   STATE              , cust_data.state            );
            strcpy(   CITY               , cust_data.city             );
                      ZIP_CODE           = cust_data.zip_code         ;
            strcpy(   CUST_TYPE          , cust_data.cust_type        );
                      DISC_PCNT          = cust_data.disc_pcnt        ;
                      TAX_PCNT           = cust_data.tax_pcnt         ;
            strcpy(   DRV_LIC            , cust_data.drv_lic          );
            strcpy(   DRV_LIC_STATE      , cust_data.drv_lic_state    );
            strcpy(   DATE_LAST_PURCH    , cust_data.date_last_purch  );
            strcpy(   CUST_REF           , cust_data.cust_ref         );
            strcpy(   CUST_FILLER        , cust_data.cust_filler      );

            EXEC SQL
              INSERT INTO posadmin.customer
              VALUES ( :AREA_CODE          ,
                       :PHONE_NO           ,
                       :EXTN               ,
                       :ACCT_ID            ,
                       :CUST_LAST_NAME     ,
                       :CUST_FIRST_NAME    ,
                       :CUST_MI            ,
                       :SHIP_ADDR          ,
                       :MAIL_ADDR          ,
                       :STATE              ,
                       :CITY               ,
                       :ZIP_CODE           ,
                       :CUST_TYPE          ,
                       :DISC_PCNT          ,
                       :TAX_PCNT           ,
                       :DRV_LIC            ,
                       :DRV_LIC_STATE      ,
                       :DATE_LAST_PURCH    ,
                       :CUST_REF           ,
                       :CUST_FILLER
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
BailOut:
   #ifndef DB22
      /* Flush indices to disk */
      if (inx2_cnt > 0)
      {
        if ((ret_code = write (file_handle_inx2, &inx_2, sizeof(CUS_INX_PAGE)) ) != sizeof(CUS_INX_PAGE))
        { printf("write inx_2 Failed %d\n",ret_code); }
      }
      if (inx1_cnt > 0)
      {
        if ((ret_code = write (file_handle_inx1, &inx_1, sizeof(CUS_INX_PAGE)) ) != sizeof(CUS_INX_PAGE))
        { printf("write inx_1 Failed %d\n",ret_code); }
      }
      if (inx0_cnt > 0)
      {
        if ((ret_code = write (file_handle_inx0, &inx_0, sizeof(CUS_INX_PAGE)) ) != sizeof(CUS_INX_PAGE))
        { printf("write inx_0 Failed %d\n",ret_code); }
      }
      close (file_handle_inx0);

      close (file_handle_inx1);

      close (file_handle_inx2);

      close (file_handle_dat);

      #ifdef IBMOS2
       if ((file_handle_inx0 = open ("chead.inx", O_CREAT | O_TRUNC | O_BINARY | O_RDWR, S_IWRITE)) == -1)
       { printf("open inx0.inx Failed, file_handle_inx0 %d  \n",file_handle_inx0); }
      #elif AIX_PROD
       if ((file_handle_inx0 = open ("chead.inx", O_CREAT | O_TRUNC | O_RDWR, S_IWRITE)) == -1)
       { printf("open inx0.inx Failed, file_handle_inx0 %d  \n",file_handle_inx0); }
      #endif

      if ((ret_code = write (file_handle_inx0, &inx_header, sizeof(CUS_INX_HEADER)) ) != sizeof(CUS_INX_HEADER))
      { printf("write chead Failed %d\n",ret_code); }

      close (file_handle_inx0);

    printf("DATA ROWS ................ %11ld\n",inx_header.num_rows);
    printf("DATA PAGES ............... %11ld\n",inx_header.data_pages);
    printf("INDEX LEVEL 0 PAGES ...... %11ld\n",inx_header.levl_0_pages);
    printf("INDEX LEVEL 1 PAGES ...... %11ld\n",inx_header.levl_1_pages);
    printf("INDEX LEVEL 2 PAGES ...... %11ld\n",inx_header.levl_2_pages);
    printf("LOWEST AREA CODE ......... %11ld\n",inx_header.min_area_code);
    printf("HIGHEST AREA CODE ........ %11ld\n",inx_header.max_area_code);
    printf("LOWEST PHNOE NUMBER ...... %11ld\n",inx_header.min_phone_no);
    printf("HIGHEST PHONE NUMBER ..... %11ld\n",inx_header.max_phone_no);
    printf("sizeof(CUST_DATA) ........ %11ld\n",sizeof(CUST_DATA));


    fp = fopen("PRICE.RPT","w");

    fprintf(fp,"DATA ROWS ................ %11ld\n",inx_header.num_rows);
    fprintf(fp,"DATA PAGES ............... %11ld\n",inx_header.data_pages);
    fprintf(fp,"INDEX LEVEL 0 PAGES ...... %11ld\n",inx_header.levl_0_pages);
    fprintf(fp,"INDEX LEVEL 1 PAGES ...... %11ld\n",inx_header.levl_1_pages);
    fprintf(fp,"INDEX LEVEL 2 PAGES ...... %11ld\n",inx_header.levl_2_pages);
    fprintf(fp,"LOWEST AREA CODE ......... %11ld\n",inx_header.min_area_code);
    fprintf(fp,"HIGHEST AREA CODE ........ %11ld\n",inx_header.max_area_code);
    fprintf(fp,"LOWEST PHNOE NUMBER ...... %11ld\n",inx_header.min_phone_no);
    fprintf(fp,"HIGHEST PHONE NUMBER ..... %11ld\n",inx_header.max_phone_no);
    fprintf(fp,"sizeof(CUST_DATA) ........ %11ld\n",sizeof(CUST_DATA));

    fclose(fp);

   #endif

   #ifdef DB22

    EXEC SQL COMMIT;
    total_count += (long)commit_count;
    commit_count = 0;
    printf("Rows committed = %8ld SQLCODE=%ld\n",
                              total_count,SQLCODE);
    printf ("STOP USING DATABASE. ");
    sqlestpd(&sqlca);
    printf("SQLCODE= %d\n",sqlca.sqlcode);

   #endif

  return;
} /* end main */

/***********************************************
 End of Main
 ***********************************************/
