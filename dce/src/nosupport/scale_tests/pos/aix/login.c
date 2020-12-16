/*** LOGIN.C ********************************************************/
/*** IBM Corporation                                               ***/
/*** PSP Systems Performance                                       ***/
/*** Department 57LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78758                                            ***/
/*** Bob Russell, ZIP 9151                                         ***/
/*** (512) 838-0844 TL 678-0844                                    ***/
/*** robert_russell@vnet.ibm.com                                   ***/
/*** ROR@AUSVM1                                                    ***/
/*********************************************************************
 *   Under-the-covers DCELOGIN
 *   Expecting it to be named POSLOGIN.EXE for OS/2 and POSLOGIN for AIX
 *********************************************************************/
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

#ifdef AIXPROD
  #include <cur00.h>
  #include <signal.h>
  #include <sys/types.h>
#endif
#ifdef IBMOS2
 #define INCL_DOSPROCESS
  #include <os2.h>
  #include "os2def.h"
  #include "bse.h"
  #include <process.h>
  #include <sys\types.h>
  #include "dcedef.h"
#endif


#include "rpc.h"
#include "dce_error.h"
#include "sec_login.h"
/*#include "dceerror.h"*/
/*#include "seclgn.h"  */

void perhaps_an_error( error_status_t st1);

/********************** global variables *********************************/


/********************** defines and constants for application ************/


/**************************************************************
 *** MAIN
 **************************************************************/

void main(int argc, char *argv[]);
void main(int argc, char *argv[])
{

   char                  *env_ptr;
   unsigned char          my_hostname[40];
   sec_passwd_rec_t       my_password;
   sec_login_handle_t     login_context;
   sec_login_auth_src_t   auth_src;
   sec_login_passwd_t     pw_entry;
   void                  *server_key;
   error_status_t         DCEst;
   boolean32              identity_valid;
   boolean32              reset_password;
   /**********************************************************************
    * End of Local Variables
    **********************************************************************/

   /************************************************
    * Get the TCP/IP hostname from the environment
    ************************************************/

   if (argc > 1)
     strcpy( my_hostname, argv[1]);   /* HOSTNAME */
   else
   {
     if (!(env_ptr = getenv("HOSTNAME")))
     {
       printf("Environment variable 'HOSTNAME' is not set.\n");
       return; /*exit(0);*/
     }
     else
       strcpy(my_hostname, env_ptr);   /* HOSTNAME */
   }

   if (argc > 2)
     my_password.key.tagged_union.plain = (unsigned char *) argv[2];
   else
   {
     if (!(env_ptr = getenv("POSPASSWORD")))
     {
       printf("Environment variable 'POSPASSWORD' is not set.\n");
       return;/*exit(0);*/
     }
     else
       my_password.key.tagged_union.plain = (unsigned char *) env_ptr;
   }

   my_password.key.key_type = sec_passwd_plain;
   my_password.pepper = NULL;
   my_password.version_number = sec_passwd_c_version_none;


   /**************************************************************
    * Do DCELOGIN
    **************************************************************/
   /*
   printf("Attempting DCELogin <%s %s>\n",
                               my_hostname,
                               my_password.key.tagged_union.plain);
   */
   sec_login_setup_identity( my_hostname,
                             sec_login_no_flags,
                             &login_context,
                             &DCEst
                           );

   perhaps_an_error( DCEst );

   sec_login_validate_identity( login_context,
                                &my_password,
                                &reset_password,
                                &auth_src,
                                &DCEst
                              );

   perhaps_an_error( DCEst );

   sec_login_certify_identity( login_context,
                               &DCEst
                             );

   perhaps_an_error( DCEst );

   sec_login_set_context( login_context,
                          &DCEst
                        );

   perhaps_an_error( DCEst );

   if (auth_src != sec_login_auth_src_network)
     printf("No Network Credentials.\n");

   if (reset_password)
     printf("Password has been re-set.\n");

   /*
   printf("Dummy DCE Login completed sucessfully.\n");


   printf("Deleting Login Context.\n");
   */

   sec_login_purge_context( &login_context,
                            &DCEst
                          );

   perhaps_an_error( DCEst );

} /* End of MAIN */
/**************************************************************************/

/***********************************************
 * DCE Error Checking Routine
 ***********************************************/
 void perhaps_an_error( error_status_t st1)
 {
     int            st2=0;
     unsigned char  msgstring[160];

     if (st1 != error_status_ok)
     {
         printf("Error: %ld ", st1);

         dce_error_inq_text(st1, (unsigned char *)msgstring, &st2);

         if (st2 == error_status_ok)
             printf("<%s>", msgstring);

         printf("\n");

         return;
     }

     return;
 }

/*************************************************************
 * End of Program
 *************************************************************/
