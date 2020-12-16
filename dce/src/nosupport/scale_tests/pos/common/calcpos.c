/***CALCPOS.C*********************************************************/
/*** IBM Corporation                                               ***/
/*** OS/2 LAN Systems Performance                                  ***/
/*** Department 59LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 9141                                         ***/
/*** (512) 838-0454,0844 TL 678-0454,0844                          ***/
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
/* * * * * * * * * * * * OS/2 include files (continued) * * * * * * * * * * */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <io.h>
#include <fcntl.h>
#include <sys\stat.h>
#include <sys\types.h>
#include "pos.h"
/* * * * * * * * * * * * * * * global/external variables  * * * * * * * * * */
FILE   *fptr, *in_fptr;
char back_s[2] = "\\";
char filepath[20] =".\\";

char ENDOFFILE[]={"End"};

unsigned char *env_ptr;

typedef struct API_info
        {
         unsigned char    in_text[37];
         unsigned char    in_pad[1];
         unsigned char    in_count[8];
         unsigned char    in_pad2[1];
         unsigned char    in_data[8];
         unsigned char    in_null[2];
        } in_api;
typedef struct API_info_2
        {
         unsigned char    in_text[37];
         double           in_data;
         long             in_count;
        } in_api_2;

#define MAX_API_COUNT 40

/***********************************************
 Begin MAIN
 ***********************************************/

int main(int argc, char * argv[]);

int main(int argc, char * argv[])
{

/***********************************************
 Local Variables
 ***********************************************/

 unsigned char   input_file[80], input_path[80],  f_name[12];
 unsigned   rc;
 int      num_files,i,j,wrk_flag=0,tid=0,in_tid,num_hits=0;
 double   tps_rate=0.0,elapsed_time=0.0,wrkD=0.0,avg_resp_time=0.0;
 double   sale_rate=0.0, bind_time=0.0;
 long     total_transactions=0,wrkL=0,under_1[208];
 long     daily_count=0,think_parm=0;
 double   think_time=0.0, max_resp_time = 0.0, avg_serv_time=0.0;
 long     in_between=0L, sale_cnt=0L, work_cnt=0L;
 long     tx_mix[12];
 float    dce_time;
 long     packet_size=1;

 struct tran_info
        {
         unsigned char    in_text[23];
         unsigned char    in_data[8];
         unsigned char    in_null[2];
        } in_rec;

 in_api_2 api_array[MAX_API_COUNT];
 in_api   api_temp;
 unsigned char end_of_file_mark[3]="";
 short    api_index=0;
 short    hit=0;

for (i=0;i<202;i++)
{
  under_1[i]=0L;
  if (i<12) tx_mix[i]=0L;
}
/***********************************************
 Open Input File OUTnn.DAT
 ***********************************************/
printf("*******************************************\n");
printf("*           IBM Confidential              *\n");
printf("*       OS/2 Database Performance         *\n");
printf("*           Department 57LS               *\n");
printf("*             Austin, TX                  *\n");
printf("*******************************************\n");
 if (argc < 3)
 {
   printf("Syntax: CRUNCH n filename\n");
   printf("           n = number of input files\n");
   printf("           filename.ext of output file\n");
   printf("(optional) test case ID               \n");
   return(0);
 }
   fptr=fopen(argv[2],"w");
   if (fptr==NULL)
   {
     printf("Could NOT Open Output File %s\n",argv[2]);
     return(0);
   }

 fprintf(fptr,"*******************************************\n");
 fprintf(fptr,"*      OS/2 LAN Systems Performance       *\n");
 fprintf(fptr,"*           Department 59LS               *\n");
 fprintf(fptr,"*             Austin, TX                  *\n");
 fprintf(fptr,"*******************************************\n");

 num_files=atoi(argv[1]);

 if (argc > 3) tid = atoi(argv[3]);

 for (i=1;i<203;i++)
 {
 under_1[i]=0;
 }


 /* copy root path  name */
 if (!(env_ptr = getenv("POSDIR")))
 {
    strcpy(input_path, filepath);
 }
 else
   strcpy(input_path, env_ptr);

 for (i=0;i<=num_files;i++)
 {
   strcpy(input_file, input_path);
   strcat(input_file, back_s);
   sprintf(f_name,"OUT%d.DAT\0",i);
   strcat(input_file, f_name);
   in_fptr=fopen(input_file,"rb");
   if (in_fptr==NULL)
   {
     printf("Could NOT Open Input File <%s>\n",input_file);
     if (i > 0) return(1);
   }

   if (i == 0) goto Just_API_Data;
/***********************************************/
   /* Read Date and Time                       */
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   fprintf(fptr,"%s", in_rec.in_text);
/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   in_tid=atoi(in_rec.in_data);
   if (tid > 0 && in_tid != tid)
   {
     fprintf(fptr,"Process %.3d Trans ID = %.3d discarded.\n", i, in_tid);
     goto IgnoreIt;
   }
   num_hits++;
/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkL=atol(in_rec.in_data);
   fprintf(fptr,"Process #%.3ld Trans %d ", wrkL, in_tid);
/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkL=atol(in_rec.in_data);
   in_between=wrkL;
   fprintf(fptr,"Cnt=%.8ld ",wrkL);
   total_transactions += wrkL;
   tx_mix[in_tid]+=wrkL;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkL=atol(in_rec.in_data);
   sale_cnt+=wrkL;
   work_cnt=wrkL;
   fprintf(fptr,"Sales=%.8ld ",wrkL);

/***********************************************/

   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkD=atof(in_rec.in_data)*(float)in_between;
   fprintf(fptr,"Elapsed %8.3f ",wrkD);
   elapsed_time += wrkD;

   sale_rate += (float)work_cnt / wrkD;
/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkD=atof(in_rec.in_data);
   fprintf(fptr,"Response %8.3f ",wrkD);
   avg_resp_time += wrkD*(float)in_between;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkD=atof(in_rec.in_data);
   fprintf(fptr,"NS_BIND %8.3f ",wrkD);
   bind_time += wrkD*(float)work_cnt;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkD=atof(in_rec.in_data);
   fprintf(fptr,"ApplTime %8.3f ",wrkD);
   avg_serv_time += wrkD*(float)in_between;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkD=atof(in_rec.in_data);
   fprintf(fptr,"MAX Resp %8.3f ",wrkD);
   if (wrkD > max_resp_time) max_resp_time = wrkD;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   think_parm=atol(in_rec.in_data);
   fprintf(fptr,"Parm %8ld ",think_parm);

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkD=atof(in_rec.in_data)*(float)in_between;
   fprintf(fptr,"Think %8.3f ", wrkD);
   think_time += wrkD;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkD=atof(in_rec.in_data);
   fprintf(fptr,"TPS=%8.3f %8.3f ", wrkD);
   tps_rate += wrkD;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkL=atol(in_rec.in_data);
   fprintf(fptr,"DailyCnt=%8ld\n",wrkL);
   daily_count += wrkL;

/***********************************************/
   rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
   if (rc !=1 )
   {
      printf("Read Input FAILED %s.\n",input_file);
      fclose(in_fptr);
      return(0);
   }
   wrkL=atol(in_rec.in_data);
   fprintf(fptr,"Packet=%8ld\n",wrkL);
   packet_size = wrkL;

/***********************************************/
   for (j=1;j<202;j++)
   {
     rc = fread(&in_rec,sizeof(in_rec),1,in_fptr);
     if (rc !=1 )
     {
        printf("Read Input FAILED %s.\n",input_file);
        fclose(in_fptr);
        return(0);
     }
     wrkL=atol(in_rec.in_data);
     under_1[j] += wrkL;
   }
/***********************************************/
Just_API_Data:
/*
 * Now harvest the API data
 */
 end_of_file_mark[0]='\0';

 while ((strncmp(end_of_file_mark, ENDOFFILE,3)) != 0 && api_index < MAX_API_COUNT)
 {
     rc = fread(&end_of_file_mark,sizeof(end_of_file_mark),1,in_fptr);
     if (rc !=1)
     {
        printf("Read Input FAILED %s.\n",input_file);
        goto IgnoreIt;
     }

//     if (end_of_file_mark != ENDOFFILE)
     if ((strncmp(end_of_file_mark, ENDOFFILE,3)) != 0)
     {
        rc = fread(&api_temp,sizeof(in_api),1,in_fptr);
        if (rc !=1)
        {
           printf("Read Input FAILED %s.\n",input_file);
           goto IgnoreIt;
        }
        hit = 0;
        api_temp.in_text[37]='\0';
        for (j=0;j<api_index;j++)
        {
/*           if (api_array[j].in_text == api_temp.in_text)*/
           if ((stricmp(api_array[j].in_text, api_temp.in_text)) == 0)
           {
              wrkD=atof(api_temp.in_data);
              wrkL=atol(api_temp.in_count);
              api_array[j].in_data += (wrkD * (double)wrkL);
              api_array[j].in_count += wrkL;
              hit = 1;
              break;
           }
        }
        if (hit == 0)
        {
           strcpy(api_array[api_index].in_text, api_temp.in_text);
           api_array[api_index].in_text[37]='\0';
           wrkD=atof(api_temp.in_data);
           wrkL=atol(api_temp.in_count);
           api_array[j].in_data += (wrkD * (double)wrkL);
           api_array[api_index++].in_count = wrkL;
        }
     }
 }

/***********************************************/
   IgnoreIt:
   fclose(in_fptr);
 }
/***********************************************/
   fprintf(fptr,"\n");
   fprintf(fptr,"*******************************************\n");
   fprintf(fptr,"*      IBM PSP Systems Performance        *\n");
   fprintf(fptr,"*             Bob Russell                 *\n");
   fprintf(fptr,"*           Department 57LS               *\n");
   fprintf(fptr,"*             Austin, TX                  *\n");
   fprintf(fptr,"*******************************************\n\n");

   fprintf(fptr,
     "POS Transaction ID                 %8d\n", in_tid);

   fprintf(fptr,
     "Number of Qualifying Transactions  %8d\n", num_hits);

   fprintf(fptr,
     "Number of Input Files Read         %8d\n", num_files);

   if (num_hits < 1) goto nofiles;

   fprintf(fptr,
   "                                 Statistics\n");
   fprintf(fptr,
   "                    컴컴컴컴컴컴컴컴컴컴컴�\n");
   fprintf(fptr,
   "\nData Collection Period Seconds  %11.3f\n",
            elapsed_time/(float)num_hits);
   fprintf(fptr,
   "Average RPC Elapsed Time           %8.3f\n",
            elapsed_time/(float)total_transactions);
   fprintf(fptr,
   "Average Client Time per RPC        %8.3f\n",
            (elapsed_time-avg_resp_time-think_time)/(float)total_transactions);
   fprintf(fptr,
   "Average actual Think Time (sec)    %8.3f\n",
            think_time/(float)total_transactions);
   fprintf(fptr,
   "Average RPC Response Time          %8.3f\n",
            avg_resp_time/(float)total_transactions);

   dce_time = (avg_resp_time-avg_serv_time);
   fprintf(fptr,
   "Average DCE Round-Trip Delta       %8.3f\n",
            dce_time/(float)total_transactions);
   fprintf(fptr,
   "Average Server Application Time    %8.3f\n",
            avg_serv_time/(float)total_transactions);
   if (sale_cnt > 0)
   {
     fprintf(fptr,
     "Average Customer Sale Time         %8.3f\n",
              (elapsed_time-think_time)/(float)sale_cnt);
     fprintf(fptr,
     "Average Binding Sequence Time      %8.3f (Includes POSLOGIN / 15)\n",
              bind_time/(float)sale_cnt);
   }
   fprintf(fptr,
   "Longest Response Time              %8.3f\n",
            max_resp_time);
   fprintf(fptr,
   "Think Time Parameter (sec)         %8.3f\n",(float)think_parm*0.001);
   fprintf(fptr,
   "Total Customer Sales in Window     %8ld\n",sale_cnt);
   fprintf(fptr,
   "Total Transactions in window       %8ld\n",total_transactions);
   fprintf(fptr,
   "Total Daily Transactions           %8ld\n",daily_count);
   fprintf(fptr,
   "\nRPC Transactions/Second    TPS     %8.3f\n", tps_rate);
   fprintf(fptr,
   "Transactions per Minute    TPM %12.3f\n", tps_rate*60.0);
   fprintf(fptr,
   "Transactions per Hour      TPH %12.3f\n", tps_rate*3600.0);
   fprintf(fptr,
   "Customer Sales Per Minute CSPM %12.3f\n\n", sale_rate*60.0);

   /*** data transfer rates **************/
   if (in_tid == 10)
   {
     wrkL += 36 + 16384;
     wrkL += 14 + sizeof(CUST_DATA);
     wrkL += 12 + sizeof(TRANS_NO) + sizeof(TRANS_HEADER);
     wrkD  = (float)(8 + sizeof(ITEM_ROW)) * 2.5;
     wrkD += (float)wrkL + 2.5 * (float)(sizeof(LINE_ITEM));
     wrkD =  wrkD / 5.5;
     fprintf(fptr, "RPC Avg Bytes per Transfer     %12.3f\n", wrkD);
     fprintf(fptr,
     "    Avg seconds per packet         %8.3f\n",
            dce_time/(float)total_transactions);
     wrkD = ((wrkD / 1024) * (float)total_transactions) / dce_time;
     fprintf(fptr,
     "    Data Rate KBytes per Second%12.3f\n", wrkD);
     fprintf(fptr,
     "    Seconds per KByte          %12.5f\n\n", 1.0/wrkD);
   }
   else
   {
     wrkD = (float)packet_size;
     fprintf(fptr, "RPC Avg Bytes per Transfer     %12.3f\n", wrkD);
     fprintf(fptr,
     "    Average seconds per packet     %8.3f\n",
            (dce_time/(float)total_transactions)*0.1);
   }


   /**************************************/
   printf("\nAverage Elapsed Time          %8.3f\n",
           elapsed_time/(float)total_transactions);
   printf(  "Average Remote Call Time      %8.3f\n",
            avg_resp_time/(float)total_transactions);
   printf(  "Average Application Time      %8.3f\n",
            avg_serv_time/(float)total_transactions);
   printf(  "Longest Response Time         %8.3f\n",
            max_resp_time);
   printf(  "Average actual think time     %8.3f\n",
            think_time/(float)total_transactions);
//   printf(  "Think Time Parameter          %8.3f\n",(float)think_parm*0.001);
   printf(  "Total Transactions in window  %8ld\n",total_transactions);
   printf(  "Total Daily Transactions      %8ld\n",daily_count);
   printf(  "TPS Rate (Throughput)         %8.3f\n",tps_rate);
   printf(  "TPH Rate (Throughput       %11.3f\n",tps_rate*3600.0);


   if ((env_ptr = getenv("HOSTNAME")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "Host Name                 : %s\n", input_file);
   }

   if ((env_ptr = getenv("POSPROTOCOL")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "Protocol Sequence         : %s\n", input_file);
   }

   if ((env_ptr = getenv("POSSAVE")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "History File Path         : %s\n", input_file);
   }

   if ((env_ptr = getenv("PTQDIR")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "Price Database Path       : %s\n", input_file);
   }

   if ((env_ptr = getenv("CMRDIR")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "Customer Database Path    : %s\n", input_file);
   }

   if ((env_ptr = getenv("CATDIR")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "GENERAL Catalog Path      : %s\n", input_file);
   }

   if ((env_ptr = getenv("SUMMER_CAT")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "SUMMER Catalog Path       : %s\n", input_file);
   }

   if ((env_ptr = getenv("AUTUMN_CAT")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "AUTUMN Catalog Path       : %s\n", input_file);
   }

   if ((env_ptr = getenv("WINTER_CAT")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "WINTER Catalog Path       : %s\n", input_file);
   }

   if ((env_ptr = getenv("SPRING_CAT")) != NULL)
   {
     strcpy(input_file, env_ptr);
     fprintf(fptr, "SPRING Catalog Path       : %s\n", input_file);
   }

   fprintf(fptr,"\n");
   fprintf(fptr,
   "\n                         Response Histogram\n");
   fprintf(fptr,
     "                    컴컴컴컴컴컴컴컴컴컴컴�\n");


   wrkL=0;
   for (j=1;j<201;j++)
   {
     wrkL += under_1[j];

     if (total_transactions > 0)
     {
       wrkD = ((float)((float)wrkL/(float)total_transactions)*100.0);
     }
     else
     {
       wrkD = 0.0;
     }
     if (wrk_flag ==0)
     fprintf(fptr, "Under %4.1f seconds....%6ld %6ld (%6.2f)\n",
                  (float)j/10.0,
                  under_1[j],wrkL,wrkD);

     if (j==5 || j==10 || j==15 || j==20 )
       printf("Under %4.1f seconds........               %6.2f percent\n",
               (float)j/10.0, wrkD);

     if (wrkL == total_transactions)
            wrk_flag= 1;
   }
     wrkL += under_1[201];

     if (total_transactions > 0)
     {
       wrkD = ((float)((float)wrkL/(float)total_transactions)*100.0);
     }
     else
     {
       wrkD = 0.0;
     }

     if (wrk_flag ==0)
     fprintf(fptr, "Over 20 Seconds ......%6ld %6ld (%6.2f)\n",
                  under_1[201],wrkL,wrkD);

   fprintf(fptr,"\n");

   printf("Transaction Mix: ");
   for (j=1;j<11;j++)
   {
     printf("%2d=%6.2f%% ",j,
               ((float)tx_mix[j]/(float)total_transactions)*100.0);
     fprintf(fptr,"Transaction Mix TID %2d....%6ld (%6.2f percent)\n",j,
               tx_mix[j],(float)tx_mix[j]/(float)total_transactions*100.0);
     if (j == 4 || j == 8) printf("\n                 ");
   }
   printf("\n");
   fprintf(fptr,"\n");

   for (j=0;j<api_index && j<MAX_API_COUNT;j++)
   {
     if (api_array[j].in_count > 0L)
     {
       printf("%40s %7ld %8.3f\n",
             api_array[j].in_text,
             api_array[j].in_count,
             api_array[j].in_data / (float)api_array[j].in_count);
       fprintf(fptr,"%40s %7ld %8.3f\n",
             api_array[j].in_text,
             api_array[j].in_count,
             api_array[j].in_data / (float)api_array[j].in_count);
     }
   }

nofiles:
   fprintf(fptr,"End of CALCPOS report.\n");
   fclose(fptr);
 return(0);
} /* end main */

/***********************************************
 End of Main
 ***********************************************/
