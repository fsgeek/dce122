/** POSCON.C *********************************************************/
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
#ifdef IBMOS2
  #define INCL_DOSPROCESS
  #define INCL_VIO

  #include <os2.h>
  #include <bse.h>
#endif

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

#ifdef IBMOS2
  #include <sys\timeb.h>
  #include <sys\types.h>
  #include <conio.h>
  #include <io.h>
#elif AIX_PROD
  #include <cur00.h>
  #include <signal.h>
  #include <sys/timeb.h>
  #include <sys/ioctl.h>
  #include <sys/types.h>
#endif

/**** DCE *****/
#include "rpc.h"
#include <pthread.h>
#include "pos_idl.h"
/* #include "dceerror.h" */
#include "dce_error.h"

void DCE_2(rpc_binding_handle_t *bind_h );
void DCE_3(rpc_binding_handle_t *bind_h );
void perhaps_an_error( error_status_t st1 );
void SetCursorPosition(int RR, int CC);
void PrintBigNumbers(long CurrentCSPM, long AverageCSPM);
void get_uresp(void);
void ShowStatus(void);
void ShowMainMenu(void);
void ShowLocalMenu(void);
void ShowThinkMenu(void);
void ShowServerMenu(void);
void ShowAuthMenu(void);
void ShowClientMenu(void);
void PrintF(void);
void clear_screen(void);
#ifdef AIX_PROD
  void die(void);
  /*
  void startscr(void);
  */
#endif
long                           ThinkTime=0L;
unsigned long                  AuthLvl=3;
short                          SamplePeriod=50;
char *                         pszStringBinding;
int                            CurrentMenu=0;
char                           OutTxt[96];

char *MeterBox[]= {"ษอออออออออออออออออออออป",
                   "บ     0 ด             บ",
                   "บ       ด             บ",
                   "บ       ด             บ",
                   "บ       ด             บ",
                   "บ       ด             บ",
                   "บ      ฤด             บ",
                   "บ       ด             บ",
                   "บ       ด             บ",
                   "บ       ด             บ",
                   "บ       ด             บ",
                   "บ     0 ล             บ",
                   "ศอออออออออออออออออออออผ"};

char  Bars[12][12];

char *Numbers[]={
     "Û฿฿฿Û ", "Û   Û ", "Û   Û ", "Û   Û ", "ÛÜÜÜÛ ",
     "  Û   ", "  Û   ", "  Û   ", "  Û   ", "  Û   ",
     "฿฿฿฿Û ", "    Û ", "Û฿฿฿฿ ", "Û     ", "ÛÜÜÜÜ ",
     "฿฿฿฿Û ", "    Û ", " ฿฿฿Û ", "    Û ", "ÜÜÜÜÛ ",
     "Û   Û ", "Û   Û ", "฿฿฿฿Û ", "    Û ", "    Û ",
     "Û฿฿฿฿ ", "Û     ", "฿฿฿฿Û ", "    Û ", "ÜÜÜÜÛ ",
     "Û     ", "Û     ", "Û฿฿฿Û ", "Û   Û ", "ÛÜÜÜÛ ",
     "฿฿฿฿Û ", "    Û ", "    Û ", "    Û ", "    Û ",
     "Û฿฿฿Û ", "Û   Û ", "Û฿฿฿Û ", "Û   Û ", "ÛÜÜÜÛ ",
     "Û฿฿฿Û ", "Û   Û ", "฿฿฿฿Û ", "    Û ", "    Û ",
     "      ", "      ", "      ", "      ", "      ",
     "      ", "      ", "      ", "      ", "      "};

/**************/

/*
 * Function prototypes
 */
void main(int argc, char * argv[]);

char szStringBinding[80]="Initializing..";

double                   perf_array[16]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
double                   mean_array[16]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

double             AvgCSPM=0.0;
FILE               *fp;
int                POSSignal=0;
double             MaxCSPM=0.0, ScaleFactor=0.0;

unsigned short     Flags[12]={0,0,1,0,0,0,0,0,0,0,0,0};
/*
   flag_1 =  no_bind
   flag_2 =  poscon on line
   flag_3 =  no_print
   flag_4 =  refresh_cache
   flag_5 =  data collection on-off
   flag_6 =
   flag_7 =  kill clients
   flag_8 =  do dcelogin
 */
/************************ **************************************************
 *
 ************************ *************************************************/
void main(int argc, char  * argv[])
{
  int                   i,j;
  rpc_binding_handle_t  bind_h;
  double                CSPM=0.0, BarSize=0.0, MeanCount=0.0;
  struct timespec       THINK;

  fp=fopen("poscon.err","w");
  fclose(fp);

  /*
   * Re Initialize the LOG file
   */
  fp=fopen("poscon.log","w");
    fprintf(fp,"flag_1 = no_bind\n");
    fprintf(fp,"flag_2 = poscon on line\n");
    fprintf(fp,"flag_3 = no_print\n");
    fprintf(fp,"flag_4 = refresh_cache\n");
    fprintf(fp,"flag_5 = data collection on-off\n");
    fprintf(fp,"flag_6 = (unused)\n");
    fprintf(fp,"flag_7 = kill clients\n");
    fprintf(fp,"flag_8 = do dcelogin\n");
    fprintf(fp,"\n");
    fprintf(fp,"    CSPM  AvgCSPM  ThinkMs A 1 2 3 4 5 6 7 8\n");
    fprintf(fp,"======== ======== ======== = = = = = = = = =\n");
  fclose(fp);


   /* clear and initialize screen */
   #ifdef AIX_PROD
     startscr();
     signal( SIGINT, die );
   #elif IBMOS2
     clear_screen();
   #endif

  DCE_2(&bind_h);

 /*
  for (i=0;i<24;i++)
  {
    (void)sprintf(OutTxt,"\0");
    PrintF();
  }
  */
  clear_screen();

  SetCursorPosition(1,23);
  (void)sprintf(OutTxt,"Point of Sale Control Program\0");
  PrintF();
  SetCursorPosition(3,0);
  (void)sprintf(OutTxt,
    "Current Status                                                Mean CSPM\0");
    PrintF();
  for (i=0;i<13;i++)
  {
    SetCursorPosition(5+i,55);
    (void)sprintf(OutTxt,"%s\0", MeterBox[i]);
    PrintF();
  }
  SetCursorPosition(23,17);
  (void)sprintf(OutTxt,"Current CSPM                     12 Sample Mean CSPM\0");
  PrintF();

  ShowMainMenu();

  do
  {

    pos_CNTRL
    (
        bind_h,
        Flags[1],
        Flags[2],
        Flags[3],
        Flags[4],
        Flags[5],
        Flags[6],
        Flags[7],
        Flags[8],
        ThinkTime,
        AuthLvl,
        &CSPM
    );

    perf_array[11] = CSPM;

    ShowStatus();

    MaxCSPM=0.0;
    AvgCSPM=CSPM;
    if (CSPM > 0.0) MeanCount = 1.0;
    for (j=0;j<11;j++)
    {
      perf_array[j] = perf_array[j+1];
      mean_array[j] = mean_array[j+1];
      if (mean_array[j] > MaxCSPM) MaxCSPM = mean_array[j];
      AvgCSPM += perf_array[j];
      if (perf_array[j] > 0.0) MeanCount += 1.0;
    }

    if (MeanCount > 0.0) AvgCSPM /= MeanCount;
    mean_array[11]=AvgCSPM;
    if (mean_array[11] > MaxCSPM) MaxCSPM = mean_array[11];

    SetCursorPosition(17,0);
    (void)sprintf(OutTxt,"Avg RPC/Sec..%7ld\0",
          (long)((double)AvgCSPM*5.5)/60L);
          PrintF();

    fp=fopen("poscon.log","a");
    fprintf(fp,"%8.3f %8.3f %8ld %d %d %d %d %d %d %d %d %d\n",
                perf_array[11],
                mean_array[11],
                ThinkTime,
                AuthLvl,
                Flags[1],
                Flags[2],
                Flags[3],
                Flags[4],
                Flags[5],
                Flags[6],
                Flags[7],
                Flags[8]);
    fclose(fp);

    if (MaxCSPM <= 1.0)          { ScaleFactor = 100.0; BarSize =     0.1; }
    else if (MaxCSPM <= 2.0)     { ScaleFactor = 50.0 ; BarSize =     0.2; }
    else if (MaxCSPM <= 5.0)     { ScaleFactor = 20.0 ; BarSize =     0.5; }
    else if (MaxCSPM <= 10.0)    { ScaleFactor = 10.0 ; BarSize =     1.0; }
    else if (MaxCSPM <= 20.0)    { ScaleFactor = 5.0  ; BarSize =     2.0; }
    else if (MaxCSPM <= 50.0)    { ScaleFactor = 2.0  ; BarSize =     5.0; }
    else if (MaxCSPM <= 100.0)   { ScaleFactor = 1.0  ; BarSize =    10.0; }
    else if (MaxCSPM <= 200.0)   { ScaleFactor = 0.5  ; BarSize =    20.0; }
    else if (MaxCSPM <= 500.0)   { ScaleFactor = 0.2  ; BarSize =    50.0; }
    else if (MaxCSPM <= 1000.0)  { ScaleFactor = 0.1  ; BarSize =   100.0; }
    else if (MaxCSPM <= 2000.0)  { ScaleFactor = 0.05 ; BarSize =   200.0; }
    else if (MaxCSPM <= 5000.0)  { ScaleFactor = 0.02 ; BarSize =   500.0; }
    else if (MaxCSPM <= 10000.0) { ScaleFactor = 0.01 ; BarSize =  1000.0; }
    else                         { ScaleFactor = 0.005; BarSize =  5000.0; }

    SetCursorPosition(6,57);
    (void)sprintf(OutTxt,"%5ld\0",(long)(10.0 * BarSize));
    PrintF();

    for (j=0;j<11;j++)
    {
      strcpy(Bars[j],"\0");
      for (i=0;i<12;i++)
      {

        if      (mean_array[i] >= (double)j * BarSize + BarSize * 0.66)
        {
          if (j > 0)
            strcat(Bars[j],"Û");
          else
            strcat(Bars[j],"฿");
        }
        else if (mean_array[i] >= (double)j * BarSize + BarSize * 0.33)
        {
          if (j > 0)
            strcat(Bars[j],"Ü");
          else
            strcat(Bars[j],"ฤ");
        }
        else
        {
          if (j > 0)
            strcat(Bars[j]," ");
          else
            strcat(Bars[j],"ฤ");
        }
        /*
        if      (mean_array[i] >= (double)j * BarSize + BarSize * 0.66)
        {
          if (j > 0)
            strcat(Bars[j],"X");
          else
            strcat(Bars[j],"X");
        }
        else if (mean_array[i] >= (double)j * BarSize + BarSize * 0.33)
        {
          if (j > 0)
            strcat(Bars[j],"x");
          else
            strcat(Bars[j],"-");
        }
        else
        {
          if (j > 0)
            strcat(Bars[j]," ");
          else
            strcat(Bars[j],"ฤ");
        }
        */
      }
      SetCursorPosition(16-j,64);
      (void)sprintf(OutTxt,"%s\0",Bars[j]);
      PrintF();
    }

    PrintBigNumbers(perf_array[11], mean_array[11]);

    if (POSSignal == 888)
    {
      suicide(bind_h);
      POSSignal=999;
    }

    for (i=0;i<SamplePeriod;i++)
    {
      get_uresp();
      if (POSSignal == 999) break;

      THINK.tv_sec =(0L);
      THINK.tv_nsec=(100000000L);

      pthread_delay_np(&THINK);

      if (POSSignal == 777)  /* ReBind to Server */
      {
        DCE_3(&bind_h);
        DCE_2(&bind_h);
        POSSignal = 0;
        SetCursorPosition(1,23);
        (void)sprintf(OutTxt,"Point of Sale Control Program\0");
        PrintF();
        SetCursorPosition(4,0);
        (void)sprintf(OutTxt,
          "Current Status                                              Average CSPM\0");
          PrintF();
        for (i=0;i<13;i++)
        {
          SetCursorPosition(5+i,55);
          (void)sprintf(OutTxt,"%s\0", MeterBox[i]);
          PrintF();
        }
        SetCursorPosition(23,17);
        (void)sprintf(OutTxt,"Current CSPM                        Average CSPM\0");
        PrintF();
        ShowLocalMenu();
      }
    }

    if (Flags[6]) Flags[5]=0;

  }while (POSSignal != 999) ;

  SetCursorPosition(24,1);
  (void)sprintf(OutTxt,"Good Bye Cruel World !\0");
  PrintF();

} /* End of Main */

/*************************************************************
 * RPC Connect - Lookup application via CDS
 *************************************************************/
void
DCE_2( rpc_binding_handle_t *bind_h )
{
  /* RPC variables */
   error_status_t  st;
   rpc_ns_handle_t import_h;

   unsigned char * pszAuthPrincipal     = "cell_admin";
   unsigned32      longAuthLevel        = 2;
   unsigned32      longAuthnProtocol    = 1;
   unsigned32      longAuthzProtocol    = 2;

   (void)sprintf(OutTxt,"rpc_ns_binding_import_begin\0");PrintF();

   rpc_ns_binding_import_begin (rpc_c_ns_syntax_default,
                                "/.:/PointOfSale",
                                PointOfSale_v0_0_c_ifspec,
                                NULL,
                                &import_h,
                                &st);

   perhaps_an_error(st);

   (void)sprintf(OutTxt,"rpc_ns_mgmt_handle_set_exp_age\0");PrintF();

   rpc_ns_mgmt_handle_set_exp_age(import_h, 0L, &st);

   perhaps_an_error(st);

   (void)sprintf(OutTxt,"rpc_ns_binding_import_next\0");PrintF();

   rpc_ns_binding_import_next (import_h, bind_h, &st);

   perhaps_an_error(st);

   (void)sprintf(OutTxt,"rpc_ns_binding_import_done\0");PrintF();

   rpc_ns_binding_import_done (&import_h, &st);

   perhaps_an_error(st);

   (void)sprintf(OutTxt,"rpc_ep_resolve_binding\0");PrintF();

   rpc_ep_resolve_binding (*bind_h, PointOfSale_v0_0_c_ifspec, &st);

   perhaps_an_error(st);

   (void)sprintf(OutTxt,"rpc_binding_to_string_binding\0");PrintF();

   rpc_binding_to_string_binding (*bind_h, &pszStringBinding, &st);

   perhaps_an_error(st);

   (void)sprintf(OutTxt,"%s\0", pszStringBinding);
   strcpy(szStringBinding, pszStringBinding);

   rpc_string_free(&pszStringBinding, &st);

   perhaps_an_error(st);

   (void)sprintf(OutTxt,"rpc_mgmt_is_server_listening\0");PrintF();

   rpc_mgmt_is_server_listening (*bind_h, &st);

   perhaps_an_error(st);

   longAuthLevel     = 2L;          /* connect */

   longAuthnProtocol = 1;           /* secret */

   longAuthzProtocol = 2;           /* DCE */


   (void)sprintf(OutTxt,"rpc_binding_set_auth_info\0");PrintF();

   rpc_binding_set_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );

   perhaps_an_error(st);

} /* End of Connect with Import Binding */
/****************************************************
 *     End the Connection to the Application Server *
 ****************************************************/
void DCE_3(rpc_binding_handle_t *bind_h )
{
     error_status_t  st;

     rpc_binding_free(bind_h, &st);
     perhaps_an_error(st);

}
/***************************************************
 * Quick version of error handler
 ***************************************************/
 void perhaps_an_error( error_status_t st1 )
 {
     int           st2=0;
     unsigned char msgstring[160];

     if (st1 != error_status_ok)
     {
         fp=fopen("poscon.err","a");
         fprintf(fp,"%s\n",OutTxt);
         fprintf(fp,"Error=%ld\n",st1);

         dce_error_inq_text(st1, (unsigned char *)msgstring, &st2);

         if (st2 == error_status_ok)
         {
             (void)sprintf(OutTxt,"%s\0",msgstring);
             PrintF();
             fprintf(fp,"%s\n",msgstring);
         }
     }

     fclose(fp);
 }
/*******************************************************************/
void SetCursorPosition(int RR, int CC)
{
   #ifdef AIX_PROD
    /*
     fp=fopen("poscon.err","a");
     fprintf(fp,"MOVE CURSOR %d %d\n",RR,CC);
     fclose(fp);
     */
    move(RR, CC);
   #elif IBMOS2
    VioSetCurPos(RR, CC, 0);
   #endif
   return;
}
/*******************************************************************/
void PrintBigNumbers(long CurrentCSPM, long AverageCSPM)
{
  char     NumString[6][80];
  char     WorkString[16]="";
  char     WorkChar[2];
  int      i, j, pntr;


  (void)sprintf(WorkString," %5ld %5ld \0",  CurrentCSPM, AverageCSPM);


    for (j=0; j<5; j++) NumString[j][0]=0x00;
    for (i=0; i<12; i++)
    {
      if (WorkString[i] == 0x20)
        pntr = 10;
      else
      {
        WorkChar[0]=WorkString[i];
        WorkChar[1]=0x00;
        pntr = atoi(WorkChar);
      }

      for (j=0; j<5; j++)
      {
        strcat(NumString[j], Numbers[pntr*5+j]);
      }
    }

    for (j=0; j<5; j++)
    {
      SetCursorPosition(18+j,5);
      (void)sprintf(OutTxt,"%s\0",NumString[j]);
      PrintF();
    }

  return;
}
/**************************************************************/
void ShowMainMenu(void)
{
  CurrentMenu = 0;

  SetCursorPosition(5,24);
  (void)sprintf(OutTxt,"ษออออออออออออออออออออออออออป\0");PrintF();
  SetCursorPosition(6,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(7,24);
  (void)sprintf(OutTxt,"บ       Main Menu          บ\0");PrintF();
  SetCursorPosition(8,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(9,24);
  (void)sprintf(OutTxt,"บ    1. Local Options      บ\0");PrintF();
  SetCursorPosition(10,24);
  (void)sprintf(OutTxt,"บ    2. Kill Server        บ\0");PrintF();
  SetCursorPosition(11,24);
  (void)sprintf(OutTxt,"บ    3. Think Time         บ\0");PrintF();
  SetCursorPosition(12,24);
  (void)sprintf(OutTxt,"บ    4. Authentication     บ\0");PrintF();
  SetCursorPosition(13,24);
  (void)sprintf(OutTxt,"บ    5. Client Options     บ\0");PrintF();
  SetCursorPosition(14,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(15,24);
  #ifdef IBMOS2
   (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
   SetCursorPosition(16,24);
   (void)sprintf(OutTxt,"บ  Type number to select.  บ\0");PrintF();
  #elif AIX_PROD
   (void)sprintf(OutTxt,"บ  Type number then press  บ\0");PrintF();
   SetCursorPosition(16,24);
   (void)sprintf(OutTxt,"บ  Enter to select.        บ\0");PrintF();
  #endif
  SetCursorPosition(17,24);
  (void)sprintf(OutTxt,"ศออออออออออออออออออออออออออผ\0");PrintF();


  return;
}
/*********************************************************************/
void ShowLocalMenu(void)
{

  CurrentMenu=1;

  SetCursorPosition(5,24);
  (void)sprintf(OutTxt,"ษออออออออออออออออออออออออออป\0");PrintF();
  SetCursorPosition(6,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(7,24);
  (void)sprintf(OutTxt,"บ       Local Menu         บ\0");PrintF();
  SetCursorPosition(8,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(9,24);
  (void)sprintf(OutTxt,"บ    1. Get New Binding    บ\0");PrintF();
  SetCursorPosition(10,24);
  (void)sprintf(OutTxt,"บ    2. Sample 5 Seconds   บ\0");PrintF();
  SetCursorPosition(11,24);
  (void)sprintf(OutTxt,"บ    3. Sample 10 Seconds  บ\0");PrintF();
  SetCursorPosition(12,24);
  (void)sprintf(OutTxt,"บ    4. Exit Control Pgm   บ\0");PrintF();
  SetCursorPosition(13,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(14,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(15,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(16,24);
  (void)sprintf(OutTxt,"บ    9. Quit               บ\0");PrintF();
  SetCursorPosition(17,24);
  (void)sprintf(OutTxt,"ศออออออออออออออออออออออออออผ\0");PrintF();

  return;
}
/*********************************************************************/
void ShowClientMenu(void)
{

  CurrentMenu=5;

  SetCursorPosition( 5,24);
  (void)sprintf(OutTxt,"ษออออออออออออออออออออออออออป\0");PrintF();
  SetCursorPosition( 6,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 7,24);
  (void)sprintf(OutTxt,"บ       Client Menu        บ\0");PrintF();
  SetCursorPosition( 8,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 9,24);
  (void)sprintf(OutTxt,"บ    1. No Rebind          บ\0");PrintF();
  SetCursorPosition(10,24);
  (void)sprintf(OutTxt,"บ    2. No Print           บ\0");PrintF();
  SetCursorPosition(11,24);
  (void)sprintf(OutTxt,"บ    3. Refresh CDS        บ\0");PrintF();
  SetCursorPosition(12,24);
  (void)sprintf(OutTxt,"บ    4. Do DCE Login       บ\0");PrintF();
  SetCursorPosition(13,24);
  (void)sprintf(OutTxt,"บ    5. Data Collect       บ\0");PrintF();
  SetCursorPosition(14,24);
  (void)sprintf(OutTxt,"บ    6. Kill Clients       บ\0");PrintF();
  SetCursorPosition(15,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(16,24);
  (void)sprintf(OutTxt,"บ    9. Quit               บ\0");PrintF();
  SetCursorPosition(17,24);
  (void)sprintf(OutTxt,"ศออออออออออออออออออออออออออผ\0");PrintF();

  return;
}
/*********************************************************************/
void ShowServerMenu(void)
{

  CurrentMenu=2;

  SetCursorPosition( 5,24);
  (void)sprintf(OutTxt,"ษออออออออออออออออออออออออออป\0");PrintF();
  SetCursorPosition( 6,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 7,24);
  (void)sprintf(OutTxt,"บ       Server Menu        บ\0");PrintF();
  SetCursorPosition( 8,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 9,24);
  (void)sprintf(OutTxt,"บ    1. Kill Server        บ\0");PrintF();
  SetCursorPosition(10,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(11,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(12,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(13,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(14,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(15,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(16,24);
  (void)sprintf(OutTxt,"บ    9. Quit               บ\0");PrintF();
  SetCursorPosition(17,24);
  (void)sprintf(OutTxt,"ศออออออออออออออออออออออออออผ\0");PrintF();

  return;
}
/*********************************************************************/
void ShowAuthMenu(void)
{

  CurrentMenu=4;

  SetCursorPosition( 5,24);
  (void)sprintf(OutTxt,"ษออออออออออออออออออออออออออป\0");PrintF();
  SetCursorPosition( 6,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 7,24);
  (void)sprintf(OutTxt,"บ    Authentication Menu   บ\0");PrintF();
  SetCursorPosition( 8,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 9,24);
  (void)sprintf(OutTxt,"บ    2. Connect            บ\0");PrintF();
  SetCursorPosition(10,24);
  (void)sprintf(OutTxt,"บ    3. Call               บ\0");PrintF();
  SetCursorPosition(11,24);
  (void)sprintf(OutTxt,"บ    4. Packet             บ\0");PrintF();
  SetCursorPosition(12,24);
  (void)sprintf(OutTxt,"บ    5. Packet Integrity   บ\0");PrintF();
  SetCursorPosition(13,24);
  (void)sprintf(OutTxt,"บ    6. Packet Privacy     บ\0");PrintF();
  SetCursorPosition(14,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(15,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(16,24);
  (void)sprintf(OutTxt,"บ    9. Quit               บ\0");PrintF();
  SetCursorPosition(17,24);
  (void)sprintf(OutTxt,"ศออออออออออออออออออออออออออผ\0");PrintF();

  return;
}
/*********************************************************************/
void ShowThinkMenu(void)
{

  CurrentMenu=3;

  SetCursorPosition( 5,24);
  (void)sprintf(OutTxt,"ษออออออออออออออออออออออออออป\0");PrintF();
  SetCursorPosition( 6,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 7,24);
  (void)sprintf(OutTxt,"บ    Think Time Menu       บ\0");PrintF();
  SetCursorPosition( 8,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition( 9,24);
  (void)sprintf(OutTxt,"บ 1. 100 mSec Faster  (-)  บ\0");PrintF();
  SetCursorPosition(10,24);
  (void)sprintf(OutTxt,"บ 2. 100 mSec Slower  (+)  บ\0");PrintF();
  SetCursorPosition(11,24);
  (void)sprintf(OutTxt,"บ 3. 10 Seconds            บ\0");PrintF();
  SetCursorPosition(12,24);
  (void)sprintf(OutTxt,"บ 4. 3  Seconds            บ\0");PrintF();
  SetCursorPosition(13,24);
  (void)sprintf(OutTxt,"บ 5. 1  Second             บ\0");PrintF();
  SetCursorPosition(14,24);
  (void)sprintf(OutTxt,"บ 6. 0 (Zero) Seconds      บ\0");PrintF();
  SetCursorPosition(15,24);
  (void)sprintf(OutTxt,"บ                          บ\0");PrintF();
  SetCursorPosition(16,24);
  (void)sprintf(OutTxt,"บ    9. Quit               บ\0");PrintF();
  SetCursorPosition(17,24);
  (void)sprintf(OutTxt,"ศออออออออออออออออออออออออออผ\0");PrintF();

  return;
}
/*********************************************************************/
void ShowStatus(void)
{
/*
   flag_1 =  no_bind
   flag_2 =  poscon on line
   flag_3 =  no_print
   flag_4 =  refresh_cache
   flag_5 =  data collection on-off
   flag_6 =
   flag_7 =  kill clients
   flag_8 =  do dcelogin
 */
  SetCursorPosition(5,0);
  (void)sprintf(OutTxt,"ThinkTime(+-)%7ld\0",ThinkTime);
  PrintF();
  SetCursorPosition(6,0);
  (void)sprintf(OutTxt,"PerHour Parm %7ld\0",3600000L/(ThinkTime+1L));
  PrintF();
  SetCursorPosition(7,0);
  (void)sprintf(OutTxt,"AuthLevel..........%1ld\0",AuthLvl);
  PrintF();
  SetCursorPosition(8,0);
  (void)sprintf(OutTxt,"SampleSeconds....%3d\0",SamplePeriod/10);
  PrintF();
  SetCursorPosition(10,0);
  (void)sprintf(OutTxt,"No Re-Bind.........%ld\0",Flags[1]);
  PrintF();
  SetCursorPosition(11,0);
  (void)sprintf(OutTxt,"No Print...........%ld\0",Flags[3]);
  PrintF();
  SetCursorPosition(12,0);
  (void)sprintf(OutTxt,"Refresh CDS........%ld\0",Flags[4]);
  PrintF();
  SetCursorPosition(13,0);
  (void)sprintf(OutTxt,"Do DCE Login.......%ld\0",Flags[8]);
  PrintF();
  SetCursorPosition(14,0);
  (void)sprintf(OutTxt,"Data Collect.......%ld\0",Flags[5]);
  PrintF();
  SetCursorPosition(15,0);
  (void)sprintf(OutTxt,"Kill Clients.......%ld\0",Flags[7]);
  PrintF();
  SetCursorPosition(3,22);
  (void)sprintf(OutTxt,"%s\0",szStringBinding);
  PrintF();
  return;
}
/************************************************************
 * Read response from keyboard
 ************************************************************/
void get_uresp(void)
{
   char       ch='\0';
   char       buffer[4];
   int        Numbytes=0;

   buffer[0]=0x00;

   #ifdef IBMOS2
     if (kbhit())
     {
       SetCursorPosition(6,26);
       ch = getche();
       strcpy(buffer,&ch);
       buffer[1]=0x00;
     }
   #else

     ioctl(0,FIONREAD,&Numbytes);

     if(Numbytes >= 1)
     {
       SetCursorPosition(6,26);
       buffer[0]='\0';
       read(0,&ch,1);
       strcpy(buffer,&ch);
       buffer[1]=0x00;

     }

   #endif


     /*
   if (buffer[0] != 0x00)
   {
     strcpy(buffer,&ch);
     buffer[1]=0x00;
     SetCursorPosition(6,26);
     strcpy(OutTxt,buffer);
     PrintF();
   }
     */

   if (CurrentMenu != 0 && buffer[0] == 0x39) ShowMainMenu();
   else
   if (buffer[0] == '-' && ThinkTime > 99L)
   {
     ThinkTime -= 100L;
     ShowStatus();
   }
   else
   if (buffer[0] == '+')
   {
     ThinkTime += 100L;
     ShowStatus();
   }
   else
   {
     switch(CurrentMenu)
     {
       case 0:
           if (buffer[0] == 0x31)
           {
             ShowLocalMenu();
           }
           else
           if (buffer[0] == 0x32)
           {
             ShowServerMenu();
           }
           else
           if (buffer[0] == 0x33)
           {
             ShowThinkMenu();
           }
           else
           if (buffer[0] == 0x34)
           {
             ShowAuthMenu();
           }
           else
           if (buffer[0] == 0x35)
           {
             ShowClientMenu();
           }
           break;
       case 1:
           if (buffer[0] == 0x34)
           {
             POSSignal=999;
             ShowMainMenu();
           }
           else
           if (buffer[0] == 0x31)
           {
             POSSignal = 777;
             ShowMainMenu();
           }
           else
           if (buffer[0] == 0x32)
           {
             SamplePeriod = 50;
           }
           else
           if (buffer[0] == 0x33)
           {
             SamplePeriod = 100;
           }
           ShowStatus();
           break;
       case 2:
           if (buffer[0] == 0x31)
           {
             POSSignal = 888;
           }
           break;
       case 3:
           if (buffer[0] == 0x31 && ThinkTime > 99L) ThinkTime -= 100L;
           else if (buffer[0] == 0x32) ThinkTime += 100L;
           else if (buffer[0] == 0x33) ThinkTime = 10000L;
           else if (buffer[0] == 0x34) ThinkTime = 3000L;
           else if (buffer[0] == 0x35) ThinkTime = 1000L;
           else if (buffer[0] == 0x36) ThinkTime = 0L;
           ShowStatus();
           break;
       case 4:
           if (buffer[0] == 0x32) AuthLvl = rpc_c_protect_level_connect;
           else
           if (buffer[0] == 0x33) AuthLvl = rpc_c_protect_level_call;
           else
           if (buffer[0] == 0x34) AuthLvl = rpc_c_protect_level_pkt;
           else
           if (buffer[0] == 0x35) AuthLvl = rpc_c_protect_level_pkt_integ;
           else
           if (buffer[0] == 0x36) AuthLvl = rpc_c_protect_level_pkt_privacy;
           ShowStatus();
          break;
       case 5:
           if (buffer[0] == 0x31)
           {
             if (Flags[1] == 0) Flags[1] = 1; else Flags[1] = 0;
           }
           else
           if (buffer[0] == 0x32)
           {
             if (Flags[3] == 0) Flags[3] = 1; else Flags[3] = 0;
           }
           else
           if (buffer[0] == 0x33)
           {
             if (Flags[4] == 0) Flags[4] = 1; else Flags[4] = 0;
           }
           else
           if (buffer[0] == 0x34)
           {
             if (Flags[8] == 0) Flags[8] = 1; else Flags[8] = 0;
           }
           else
           if (buffer[0] == 0x35)
           {
             if (Flags[5] == 0) Flags[5] = 1; else Flags[5] = 0;
           }
           else
           if (buffer[0] == 0x36)
           {
             if (Flags[7] == 0) Flags[7] = 1; else Flags[7] = 0;
           }
           ShowStatus();
           break;

       default:
           break;
     }
   }

   return;
}
/************************************************************
 * 'printf' routine for OS/2 and AIX differences
 ************************************************************/
void PrintF(void)
{
   #ifdef AIX_PROD
     printw("%s",OutTxt);
     SetCursorPosition(0,0);
     refresh();
   #elif IBMOS2
     printf("%s\n",OutTxt);
   #endif
  return;
}
/*********************************************************
 * Screen Init Stuff
 *********************************************************/
#ifdef AIX_PROD
startscr(void)
 {
   initscr();
   noecho();
   leaveok(stdscr,TRUE);
   scrollok(stdscr,FALSE);
   return;
 }
/*****************************/
void die(void)
 {
   signal( SIGINT, SIG_IGN);
   endwin();
   exit (0);
 }
#endif
void clear_screen(void)
{

   char  FillChar[2]={0x20,0x0F};

   #ifdef AIX_PROD
    wclear(curscr);
    wrefresh(curscr);
   #elif IBMOS2
    VioScrollUp(0,0,-1,-1,-1,(char *)FillChar,0);
   #endif
   return;
}
