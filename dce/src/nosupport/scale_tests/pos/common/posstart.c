/*********************************************************************/
/*************** IBM Confidential and Proprietary ********************/
/*** IBM Corporation                                               ***/
/*** OS/2 Database Performance                                     ***/
/*** Department 57LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 3108                                         ***/
/*** (512) 823-3115 TL 793-3115                                    ***/
/*********************************************************************/


#include <stdio.h>
#include <stdlib.h>
#ifdef IBMOS2
#include <string.h>
#include <os2.h>
#include <os2def.h>
#endif

#include "rpc.h"
#include "dce_error.h"
#include "mom.h"
#include "pos_idl.h"


#define MAX_PROC 201

#include <rpcexc.h>
EXCEPTION input_status;

void main (int argc, char *argv[]);


/****** MAIN *********************************************************/
void main (int argc, char *argv[])
{
   FILE *fp;
   unsigned short proc_cnt;
   int reset=0;
   int i,j;
   rpc_binding_handle_t bind_h;

   EXCEPTION_INIT (input_status);



   if (argc < 1)
   {
        printf("Incorrect number of parameters.\n");
        printf("posstart num_of_requestors \n");
        exit(1);
   }

   proc_cnt = atoi(argv[1]);

   
   if(proc_cnt > MAX_PROC)
   {
        printf("Maximum %d processes.\n",MAX_PROC);
        exit(2);
   }

printf("*******************************************\n");
printf("*           IBM Confidential              *\n");
printf("*       OS/2 Database Performance         *\n");
printf("*           Department 57LS               *\n");
printf("*             Austin, TX                  *\n");
printf("*******************************************\n");

printf("reset the server\n");
DCE_2(fp, &bind_h);

TRY

resetsrv(bind_h,proc_cnt);

CATCH (input_status)
{
		printf("resetsrv: communication error:\n");
		exit (1);
}

ENDTRY
DCE_3(&bind_h);
fclose(fp);

exit(0);
}

/*************************************************************
 * RPC Connect - Lookup application via CDS
 *************************************************************/
void
DCE_2(  FILE          * fp,
        rpc_binding_handle_t *bind_h)
{
  /* RPC variables */
   unsigned char * pszUuid             = "334A2E24-0000-0000-0D00-379834040000";
   unsigned char * pszProtocolSequence = "ncadg_ip_udp";
   unsigned char * pszOptions          = NULL;
            char * pszStringBinding;
   error_status_t  st;
   int              tenths=0;
   rpc_ns_handle_t import_h;

   char          * env_ptr;
   unsigned char * pszAuthPrincipal    = "cell_admin";
   unsigned char * pszAuthPrincipalL   = "";
   unsigned32      longAuthLevel       = 3;
   unsigned32      longAuthLevelL      = 0;
   /*
      rpc_c_protect_level_default (0)
      rpc_c_protect_level_none (1)
      rpc_c_protect_level_connect (2)
      rpc_c_protect_level_call (3)
      rpc_c_protect_level_pkt (4)
      rpc_c_protect_level_pkt_integ (5)
      rpc_c_protect_level_pkt_privacy (6)
    */
   unsigned32      longAuthnProtocol    = 1;
   unsigned32      longAuthnProtocolL   = 0;
   /*
      rpc_c_authn_none (0)
      rpc_c_authn_dce_secret (1)
      rpc_c_authn_dce_public (2)
      rpc_c_authn_dce_dummy (3)
      rpc_c_authn_dssa_public (4)
      rpc_c_authn_default (-1)
    */
   unsigned32      longAuthzProtocol    = 2;
   unsigned32      longAuthzProtocolL   = 0;
   /*
      rpc_c_authz_none (0)
      rpc_c_authz_name (1)
      rpc_c_authz_dce (2)
    */


   /*
    * User did not specify an endpoint, so we gotta
    * IMPORT it from CDS
    */


   rpc_ns_binding_import_begin (rpc_c_ns_syntax_default,
                                "/.:/PointOfSale",
                                PointOfSale_v0_0_c_ifspec,
                                NULL,
                                &import_h,
                                &st);



   /**********************************************************************/
   /*
    * Force the Client to refresh his local cache
    */

   printf("Force the Client to refresh his local cache!\n");


   rpc_ns_mgmt_handle_set_exp_age(import_h,
                                  0L,
                                  &st);


   /**********************************************************************/


   rpc_ns_binding_import_next (import_h,
                               bind_h,
                               &st);


   /**********************************************************************/

   rpc_ns_binding_import_done (&import_h, &st);



   /**********************************************************************/

   rpc_ep_resolve_binding (*bind_h, PointOfSale_v0_0_c_ifspec, &st);


   /**********************************************************************/

   rpc_binding_to_string_binding (*bind_h, &pszStringBinding, &st);


   printf("Binding=<%s>\n", pszStringBinding);

   rpc_string_free(&pszStringBinding, &st);
   printf("RpcStringFree returned %ld\n", st);

   /**********************************************************************/


   rpc_mgmt_is_server_listening (*bind_h, &st);


   /**********************************************
    * Authentication Stuff
    **********************************************/
   if ((env_ptr = getenv("AUTHP")))
   {
     strcpy(pszAuthPrincipal, env_ptr);
   }
   else
     strcpy(pszAuthPrincipal, "cell_admin");

   /*****************/
   if ((env_ptr = getenv("AUTHL")))
     longAuthLevel = atol(env_ptr);
   else
     longAuthLevel = 3;           /* call */

   /*****************/
   if ((env_ptr = getenv("AUTHN")))
     longAuthnProtocol = atol(env_ptr);
   else
     longAuthnProtocol = 1;           /* secret */

   /*****************/
   if ((env_ptr = getenv("AUTHZ")))
     longAuthzProtocol = atol(env_ptr);
   else
     longAuthzProtocol = 2;            /* DCE */



   /*****************/
   if (longAuthLevel != 0)
   {

     rpc_binding_set_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );



     /****************************************************/
     /*

     rpc_ss_register_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );

     */
     /****************************************************/

     rpc_binding_inq_auth_info(*bind_h,
                               &pszAuthPrincipalL,
                               &longAuthLevelL,
                               &longAuthnProtocolL,
                               NULL,
                               &longAuthzProtocolL,
                               &st );


     printf("Auth Info: Principal        =%s\n", pszAuthPrincipalL);
     printf("Auth Info: Level            =%ld\n", longAuthLevelL);
     printf("Auth Info: AuthNProtocol    =%ld\n", longAuthnProtocolL);
     printf("Auth Info: AuthZProtocol    =%ld\n", longAuthzProtocolL);
   }
} /* End of Connect with Import Binding */
/****************************************************
 *     End the Connection to the Application Server *
 ****************************************************/
void DCE_3(rpc_binding_handle_t *bind_h )
{
     error_status_t  st;

     rpc_binding_free(bind_h, &st);
     printf("RpcBindingFree returned %ld\n", st);

     printf("Register Signed Off.                                             \n");

}

