//
// @OSF_COPYRIGHT@
// COPYRIGHT NOTICE
// Copyright (c) 1996 Open Software Foundation, Inc.
// ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
// the full copyright text.
// All Rights Reserved
//
// HISTORY
// $Log: test_pkss1.cxx,v $
// Revision 1.1.2.1  1996/11/14  17:14:11  arvind
// 	OSF DCE 1.2.2 Drop 5
// 	[1996/11/14  16:00:28  arvind]
//
// Revision /main/DCE_1.2.2/1  1996/11/05  22:03 UTC  arvind
// 	Change sec_pk_domain_dce_pk_login to sec_pk_domain_dce_general
// 	[1996/11/04  15:26 UTC  arvind  /main/arvind_pkss/3]
// 
// 	Correction to PKSS tests
// 	[1996/09/11  14:07 UTC  arvind  /main/arvind_pkss/2]
// 
// $EndLog$
//
// (c) Copyright 1996,
// Digital Equipment Corporation, Maynard, Massachusetts, USA
// All Rights Reserved
//
// Module:  test_pkss_1.cxx
//
// Purpose: Unit tests for PKSS:  sec_pvtkey_pkss_open
//				  sec_pvtkey_pkss_store
//				  sec_pvtkey_pkss_get
//				  sec_pvtkey_pkss_delete
//				  sec_pvtkey_pkss_close
//

extern "C"
{
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dce/sec_pk.h>
#include <dce/nbase.h>
#include "sec_bsafe.h"
#include <dce/sec_psm_base.h>
}

#include "sec_pvtkey_pkss.h"
#include "sec_pkss_util.h"

//
// JC Aug 20, 1996
//  this was put in to accomodate for putting the tests
// into the TET environment
//
#ifdef ENVIRONMENT_TET
extern "C" {
#include <tet_api.h>
}

static void startup(void);
static void cleanup(void);
static void tp(void);

void (*tet_startup)() = startup;
void (*tet_cleanup)() = cleanup;

struct tet_testlist tet_testlist[] = {
{tp, 1},
{NULL, 0}
};

static char msg[256];

#endif   // End of ifdef ENVIRONMENT_TET


  void interpret_character_vector (int, char *, int *, char *, char *);
  void cds_ieu_emit (const char *, const char *, const char *);


#define USER1_USERNAME	((unsigned char *)"user1")
#define USER1_PASSWORD	((unsigned char *)"user1pwd")

sec_pk_pvtkey_capability SEC_PVTKEY_CAP_KEYGEN
= { /* 6E78B87A-D4DE-11CF-987D-08002B187D1A */
        0x6e78b87a,
        0xd4de,
        0x11cf,
        0x98,
        0x7d,
        {0x08, 0x00, 0x2b, 0x18, 0x7d, 0x1a}
      };

sec_pk_pvtkey_capability SEC_PVTKEY_CAP_ANYALG
    = { /* 8BE2EEDA-D4DE-11CF-9F9C-08002B187D1A */
        0x8be2eeda,
        0xd4de,
        0x11cf,
        0x9f,
        0x9c,
        {0x08, 0x00, 0x2b, 0x18, 0x7d, 0x1a}
      };

sec_pk_pvtkey_capability SEC_PVTKEY_CAP_KEYALG
    = { /* 7E2D695A-D4DE-11CF-8696-08002B187D1A */
        0x7e2d695a,
        0xd4de,
        0x11cf,
        0x86,
        0x96,
        {0x08, 0x00, 0x2b, 0x18, 0x7d, 0x1a}
      };

sec_pk_pvtkey_capability SEC_PVTKEY_CAP_KEYDEL
    = { /* 9B0523BA-D4DE-11CF-8E7E-08002B187D1A */
        0x9b0523ba,
        0xd4de,
        0x11cf,
        0x8e,
        0x7e,
        {0x08, 0x00, 0x2b, 0x18, 0x7d, 0x1a}
      };

extern "C"
{
#include <stdarg.h>
#include <signal.h>
}

#ifndef CDS_GDB_EXISTS
#define CDS_GDB_EXISTS                  0x10d0afd7
#endif

//
// JC - Aug 20, 1996  
// Naming of the main routine changes to loc_main if 
// running under the TET environment
//

#ifndef ENVIRONMENT_TET
int main (int argc, char **argv){
#else
int loc_main(int argc, char * argv[]) {
#endif // End of ifndef ENVIRONMENT_TET
  //
  // Local variables
  //

  error_status_t estatus = 0;
  error_status_t pstatus = 0;
  unsigned32 pk_key_len = 512;
  unsigned32 key_vno = 1;
  unsigned32 ret_key_vno = 0;
  sec_pk_gen_data_t seed;
  sec_pk_gen_data_t rand;
  sec_pk_data_t kou;
  sec_pk_data_t kxu;
  sec_pk_data_t ret_kou;
  sec_pk_data_t ret_kxu;
  sec_pk_usage_flags_t key_usages;
  sec_pk_mechanism_handle_t user1_psm_context = 0;
  char i_val[512];
  char h_val[2048];
  int size;
  unsigned char uname[32];

  //
  // Construct unique username.
  //

  (void) sprintf ((char *)uname, "%s%d", USER1_USERNAME, getpid());

  //
  // Open a session with the PKSS for USER1.
  //

#ifdef TRACE
  (void) printf ("Entering sec_pvtkey_pkss_open for user %s", uname);
  (void) fflush (stdout);
#endif

  estatus = sec_pvtkey_pkss_open (uname,
				  &sec_pk_domain_dce_general,
				  &user1_psm_context);

#ifdef TRACE
  (void) printf ("Return status from sec_pvtkey_pkss_open = 0x%x", estatus);
  (void) fflush (stdout);
#endif

  if (estatus != 0)
  {
    #ifdef ENVIRONMENT_TET
	 { char text[256];                                                 
	   sprintf(text, "Return status from sec_pvtkey_pkss_open = 0x%x;\n",estatus );     
	   tet_infoline(text);
	   }
    #endif
      (void) printf ("Return status from sec_pvtkey_pkss_open = 0x%x;", estatus);
      (void) printf (" expected %d\n", 0);
      (void) fflush (stdout);
      goto EXIT;
      }

  //
  // Make an asymmetric key pair.
  //

  rand.len = 64;
  rand.data = (unsigned char *) malloc (rand.len);

  seed.len = rand.len;
  seed.data = (unsigned char *) malloc (seed.len);
  (void) memcpy (seed.data, &(seed.data), sizeof (seed.data));

#ifdef TRACE
  (void) printf ("Entering sec_bsafe_random_bytes\n");
  (void) fflush (stdout);
#endif

  estatus = sec_bsafe_random_bytes (&seed, &rand);

#ifdef TRACE
  (void) printf ("Return status from sec_bsafe_random_bytes = 0x%x\n", estatus);
  (void) fflush (stdout);
#endif

  if (estatus != 0)
  {
   #ifdef ENVIRONMENT_TET
	 { char text[256];
	   sprintf(text, "Return status from sec_bsafe_random_bytes = 0x%x;\n",estatus);
	   tet_infoline(text);
	  }
    #endif
     (void) printf ("Return status from sec_bsafe_random_bytes = 0x%x;",estatus);
     (void) printf (" expected %d", 0);
     (void) fflush (stdout);
     goto PVTKEY_CLOSE;
    }

#ifdef TRACE
  (void) printf ("Entering sec_bsafe_gen_pub_key\n");
  (void) printf ("  Key length (bits):  %d\n", pk_key_len);
  (void) fflush (stdout);
#endif

  estatus = sec_bsafe_gen_pub_key (pk_key_len, &rand, &kou, &kxu);

#ifdef TRACE
  (void) printf ("Return status from sec_bsafe_gen_pub_key = 0x%x", estatus);
  (void) fflush (stdout);
#endif

  if (estatus != 0)
    {
     #ifdef ENVIRONMENT_TET
	   { char text[256];
	     sprintf(text, "Return status from sec_bsafe_gen_pub_key = 0x%x;\n",estatus);
	     tet_infoline(text);
	      }

    #endif
      (void) printf ("Return status from sec_bsafe_gen_pub_key = 0x%x;", estatus);
      (void) printf (" expected %d\n", 0);
      (void) fflush (stdout);
      goto PVTKEY_CLOSE;
    }
  
  //
  // Add user for key pair generated above.
  //

  key_usages = sec_pk_usage_digitalSignature;

#ifdef TRACE
  (void) printf ("Entering sec_pvtkey_pkss_store.\n");
  (void) printf ("  Username:  \"%s\"\n", uname);
  (void) printf ("  Password:  \"%s\"\n", USER1_PASSWORD);
  (void) printf ("  Key usage flags:  %d\n", key_usages);
  (void) printf ("  Key version number:  %d\n", key_vno);

  if (kxu.len != 0)
  {
    (void) printf ("kxu.len:  %d\n", kxu.len);
    interpret_character_vector (kxu.len,
                                (char *)kxu.data,
                                &size,
                                i_val,
                                h_val);
    cds_ieu_emit ("kxu",
                  (const char *)i_val,
                  (const char *)h_val);
  }
  (void) memset (i_val, 0, sizeof (i_val));
  (void) memset (h_val, 0, sizeof (h_val));
  if (kou.len != 0)
  {
    (void) printf ("kou.len:  %d\n", kou.len);
    interpret_character_vector (kou.len,
                                (char *)kou.data,
                                &size,
                                i_val,
                                h_val);
    cds_ieu_emit ("kou", (const char *)i_val, (const char *)h_val);
  }
  (void) memset (i_val, 0, sizeof (i_val));
  (void) memset (h_val, 0, sizeof (h_val));
  (void) fflush (stdout);
#endif

  estatus = sec_pvtkey_pkss_store (user1_psm_context,
			      (unsigned char *)USER1_PASSWORD,
			      key_usages,
			      key_vno, // key version number
			      &kxu,
			      &kou);

#ifdef TRACE
  (void) printf ("Return status from sec_pvtkey_pkss_store = 0x%x\n", estatus);
  (void) fflush (stdout);
#endif

  if (estatus != 0)
  {
  #ifdef ENVIRONMENT_TET
          {
           char text[256];
	   sprintf(text, "Return status from sec_pvtkey_pkss_store = 0x%x;\n",estatus);
	   tet_infoline(text);
  
  		}
  #endif
    (void) printf ("Return status from sec_pvtkey_pkss_store = 0x%x;",
		    estatus);
    (void) printf (" expected %d\n", 0);
    (void) fflush (stdout);
    goto FREE_KXU_KOU;
  }

  //
  // Obtain asymmetric key pair for user added above.
  //

  ret_key_vno = 0;

#ifdef TRACE
  (void) printf ("Entering sec_pvtkey_pkss_get; ask for latest key version\n");
  (void) fflush (stdout);
#endif

  estatus = sec_pvtkey_pkss_get (user1_psm_context,
			    (unsigned char *)USER1_PASSWORD,
			    key_usages,
			    &ret_key_vno, // key version number
                            &ret_kxu,
			    &ret_kou);

#ifdef TRACE
  (void) printf ("Return status from sec_pvtkey_pkss_get = 0x%x\n", estatus);
  (void) fflush (stdout);
#endif

  if (estatus != 0)
  {
   #ifdef ENVIRONMENT_TET 
     {
       char text[256];
       sprintf(text, "Return status from sec_pvtkey_pkss_get = 0x%x;\n",estatus);
       tet_infoline(text);
      }
   #endif
    (void) printf ("Return status from sec_pvtkey_pkss_get = 0x%x;",
		    estatus);
    (void) printf (" expected %d\n", 0);
    (void) fflush (stdout);
    goto PVTKEY_DELETE;
   }

  if (ret_key_vno != key_vno)
  {
    (void) printf ("Returned key version number = %d; expected %d\n",
		   ret_key_vno, key_vno);
    (void) fflush (stdout);
    goto PVTKEY_DELETE;
  }

  //
  // Compare the stored and retrieved private key components.
  //

  if ((kxu.len != ret_kxu.len) ||
      (memcmp (kxu.data, ret_kxu.data, kxu.len)))
  {
    (void) printf ("Private key components differ\n");
   if (kxu.len != 0)
   {
     (void) printf ("kxu.len:  %d\n", kxu.len);
     interpret_character_vector (kxu.len,
                                 (char *)kxu.data,
                                 &size,
                                 i_val,
                                 h_val);
     cds_ieu_emit ("kxu",
                   (const char *)i_val,
                   (const char *)h_val);
   }
   (void) memset (i_val, 0, sizeof (i_val));
   (void) memset (h_val, 0, sizeof (h_val));
   if (ret_kxu.len != 0)
   {
     (void) printf ("ret_kxu.len:  %d\n", ret_kxu.len);
     interpret_character_vector (ret_kxu.len,
                                 (char *)ret_kxu.data,
                                 &size,
                                 i_val,
                                 h_val);
     cds_ieu_emit ("ret_kxu",
                   (const char *)i_val,
                   (const char *)h_val);
   }
   (void) memset (i_val, 0, sizeof (i_val));
   (void) memset (h_val, 0, sizeof (h_val));
   (void) fflush (stdout);
  }

  //
  // Compare the stored and retrieved public key components.
  //

  if ((kou.len != ret_kou.len) ||
      (memcmp (kou.data, ret_kou.data, kou.len)))
  {
    (void) printf ("Public key components differ\n");
   if (kou.len != 0)
   {
     (void) printf ("kou.len:  %d\n", kou.len);
     interpret_character_vector (kou.len,
                                 (char *)kou.data,
                                 &size,
                                 i_val,
                                 h_val);
     cds_ieu_emit ("kou",
                   (const char *)i_val,
                   (const char *)h_val);
   }
   (void) memset (i_val, 0, sizeof (i_val));
   (void) memset (h_val, 0, sizeof (h_val));
   (void) printf ("ret_kou.len:  %d\n", ret_kou.len);
   if (ret_kou.len != 0)
   {
     interpret_character_vector (ret_kou.len,
                                 (char *)ret_kou.data,
                                 &size,
                                 i_val,
                                 h_val);
     cds_ieu_emit ("ret_kou",
                   (const char *)i_val,
                   (const char *)h_val);
   }
   (void) memset (i_val, 0, sizeof (i_val));
   (void) memset (h_val, 0, sizeof (h_val));
    (void) fflush (stdout);
  }

FREE_RET_KXU_KOU:

  free (ret_kxu.data);
  free (ret_kou.data);

PVTKEY_DELETE:

#ifdef TRACE
  (void) printf ("Entering sec_pvtkey_pkss_delete.\n");
  (void) printf ("  Password:  \"%s\"\n", USER1_PASSWORD);
  (void) printf ("  Key usage flags:  %d\n", key_usages);
  (void) printf ("  Key version number:  %d\n", key_vno);
  (void) fflush (stdout);
#endif

  pstatus = sec_pvtkey_pkss_delete (user1_psm_context,
				    (unsigned char *)USER1_PASSWORD,
				    key_usages,
				    key_vno);

#ifdef TRACE
  (void) printf ("Return status from sec_pvtkey_pkss_delete = 0x%x\n", pstatus);
  (void) fflush (stdout);
#endif

  if (pstatus)
  {
  #ifdef ENVIRONMENT_TET
    {
          char text[256];
          sprintf(text, "Return status from sec_pvtkey_pkss_delete = 0x%x;\n",pstatus);
	  tet_infoline(text);
    }
  #endif 
   (void) printf ("Return status from sec_pvtkey_pkss_delete = 0x%x;",pstatus);
   (void) printf (" expected %d\n", 0);
   (void) fflush (stdout);
   estatus = pstatus;
  }
FREE_KXU_KOU:

  free (kxu.data);
  free (kou.data);

PVTKEY_CLOSE:

  (void) memset (rand.data, 0, rand.len);
  free (rand.data);
  rand.len = 0;

  (void) memset (seed.data, 0, seed.len);
  free (seed.data);
  seed.len = 0;

#ifdef TRACE
  (void) printf ("Entering sec_pvtkey_pkss_close\n");
  (void) fflush (stdout);
#endif

  pstatus = sec_pvtkey_pkss_close (user1_psm_context);

#ifdef TRACE
  (void) printf ("Return status from sec_pvtkey_pkss_close = 0x%x\n", pstatus);
  (void) fflush (stdout);
#endif

  if (pstatus)
   {
   #ifdef ENVIRONMENT_TET 
    {
      char text[256];
      sprintf(text, "Return status from sec_pvtkey_pkss_close = 0x%x;\n",pstatus);
      tet_infoline(text);
     }
   #endif
    estatus = pstatus;
    (void) printf ("Return status from sec_pvtkey_pkss_close = 0x%x;", pstatus);
    (void) printf (" expected %d\n", 0);
    (void) fflush (stdout);
  }

EXIT:

  #ifdef ENVIRONMENT_TET
     { char text[256];
       sprintf(text, "Exiting test_pkss_1; estatus = 0x%x\n", estatus);
       tet_infoline(text);
       }
  #endif

  (void) printf ("Exiting test_pkss_1; estatus = 0x%x\n\n", estatus);
  (void) fflush (stdout);
  return (estatus);

} // End main

// 
// JC - Aug 20, 1996
// These are empty place holder routines for startup and
// cleanup tasks that may be associated with the TET testing
//
#ifdef ENVIRONMENT_TET

static void startup(void) {
}

static void cleanup(void) {
}

#endif // End of ifdef ENVIRONMENT_TET

//
// JC - Aug 20, 1996
// Need this routine for the TET tests
//
#ifdef ENVIRONMENT_TET
static void tp(void) {
    char *argv[128];
    int argc;
    char * progname = "test_pkss_1";
    int result;

    argc = 1;
    argv[0] = progname;

    tet_infoline("Invoking test_pkss_1 program");
    result = loc_main(argc, argv);
    tet_infoline("Returned from test_pkss_1 program");

    if (result) {
       tet_infoline("Tests failed");
       tet_result(TET_FAIL);
    } else {
       tet_infoline("Tests passed");
       tet_result(TET_PASS);
     }
     return; 
}
#endif  // End of ifdef ENVIRONMENT_TET 



