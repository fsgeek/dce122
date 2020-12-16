//
// @OSF_COPYRIGHT@
// COPYRIGHT NOTICE
// Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
// ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
// the full copyright text.
// All Rights Reserved
//
// HISTORY
// $Log: sec_pkss_mgmt_api.h,v $
// Revision 1.1.2.1  1996/10/04  14:24:39  arvind
// 	OSF DCE 1.2.2 Drop 4
// 	[1996/10/04  13:48:43  arvind]
//
// Revision /main/DCE_1.2.2/1  1996/09/09  21:30 UTC  arvind
// 	PKSS drop (2) from DEC (DCE1.2.2)
// 	[1996/09/04  14:33 UTC  arvind  /main/arvind_pkss/2]
// 
// $EndLog$
//
// (c) Copyright 1996,
// Digital Equipment Corporation, Maynard, Massachusetts, USA
// All Rights Reserved
//
// PKSS management client API prototypes
//

#ifndef SEC_PKSS_MGMT_API_H
#define SEC_PKSS_MGMT_API_H

extern "C"
{
#include <dce/nbase.h>
#include <dce/sec_pk_base.h>
}
#include "sec_pkss_clt_util.h"


//
// Add a new user (client generates asymmetric key pair).
//
// Input
//
//    pkss_svc_profile_name_p: Pointer to entry name in namespace where the
//			       search for compatible binding handles will
//			       begin.
//    name_p: Pointer to the user's canonical name within the
//            specified domain.
//    domain_id: The application domain this key belongs to.
//    key_usages: The usage(s) permitted of this keypair.
//    key_vno: The key version number. (0 may be specified to
//             indicate that the routine should select the next
//             appropriate or newest key version number).
//             (In the reference implementation, key_vno starts with
//             1, then monotonically increase 1 for each update.)
//    pvt_key_p:  a pointer to a buffer containing the private key component of
//		the new asymmetric key pair.
//    pub_key_p:  a pointer to a buffer containing the public key component of
//		the new asymmetric key pair.
//    pwd_p:  Pointer to the new user's password.  It is the
//	      caller's responsibility to provide the storage to
//	      contain the password.
//
// Output
//
//    new_key_vno_p:  Pointer to the actual key version number of
//		      the new key.  It is the caller's responsibility
//		      to provide the storage to contain the actual key
//		      version number.
//
// Calls: 	sec_pkss_mgmt_diffhell
//		sec_pkss_mgmt_add_user_clt
//

#if __cplusplus
extern "C"
#endif
 error_status_t sec_pkss_mgmt_user_add_clt
 (
   const char *pkss_svc_profile_name_p,
   const char *name_p,
   sec_pk_domain_t domain_id,
   sec_pk_usage_flags_t key_usages,
   unsigned32 key_vno,
   sec_pk_pvtkey_t *pvt_key_p,
   sec_pk_pubkey_t *pub_key_p,
   const char *pwd_p,
   unsigned32 *new_key_vno_p
 );

//
// Add a new user (server generates asymmetric key pair).
//
// Input
//
//    pkss_svc_profile_name_p: Pointer to entry name in namespace where the
//			       search for compatible binding handles will
//			       begin.
//    name_p: Pointer to the user's canonical name within the
//            specified domain.
//    domain_id: The application domain this key belongs to.
//    key_usages: The usage(s) permitted of this keypair.
//    key_vno: The key version number. (0 may be specified to
//             indicate that the routine should select the next
//             appropriate or newest key version number).
//             (In the reference implementation, key_vno starts with
//             1, then monotonically increase 1 for each update.)
//    pwd_p:  Pointer to the new user's password.  It is the
//	      caller's responsibility to provide the storage to
//	      contain the password.
//    alg_id_p:  A pointer to a public key algorithm identifier.
//    key_len:  Bit-length of new public key to be generated by PKSS.
//
// Output
//
//    new_pub_key_p:  Pointer to a buffer to contain the public key
//		      component of the user's asymmetric key pair.  It is
//		      the caller's responsibility to to provice the storage
//		      to contain the key.
//
//    new_key_vno_p:  Pointer to the actual key version number of
//		      the new key.  It is the caller's responsibility
//		      to provice the storage to contain the actual key
//		      version number.
//
// Calls: 	sec_pkss_mgmt_diffhell
//		sec_pkss_mgmt_add_user_svr
//

#if __cplusplus
extern "C"
#endif
 error_status_t sec_pkss_mgmt_user_add_svr
 (
   const char *pkss_svc_profile_name_p,
   const char *name_p,
   sec_pk_domain_t domain_id,
   sec_pk_usage_flags_t key_usages,
   unsigned32 key_vno,
   const char *pwd_p,
   sec_pk_algorithm_id_t *alg_id_p,
   unsigned32 key_len,
   sec_pk_pubkey_t *new_pub_key_p,
   unsigned32 *new_key_vno_p
 );

//
// Delete a user
//
// Input
//
//    pkss_svc_profile_name_p: Pointer to entry name in namespace where the
//			       search for compatible binding handles will
//			       begin.
//    name_p: Pointer to the user's canonical name within the
//            specified domain.
//    domain_id: The application domain this key belongs to.
//    key_usages: The usage(s) permitted of this keypair.
//    key_vno: The key version number. (0 may be specified to
//             indicate that the routine should select the next
//             appropriate or newest key version number).
//             (In the reference implementation, key_vno starts with
//             1, then monotonically increase 1 for each update.)
// Output
//
//    none
//
// Calls: 	sec_pkss_mgmt_diffhell
//		sec_pkss_mgmt_del_user
//

#if __cplusplus
extern "C"
#endif
 error_status_t sec_pkss_mgmt_user_del
 (
   const char *pkss_svc_profile_name_p,
   const char *name_p,
   sec_pk_domain_t domain_id,
   sec_pk_usage_flags_t key_usages,
   unsigned32 key_vno
 );

//
// Modify a user record (client generates asymmetric key pair).
//
// Input
//
//    pkss_svc_profile_name_p: Pointer to entry name in namespace where the
//			       search for compatible binding handles will
//			       begin.
//    name_p: Pointer to the user's canonical name within the
//            specified domain.
//    domain_id: The application domain this key belongs to.
//    key_usages: The usage(s) permitted of this keypair.
//    key_vno: The key version number. (0 may be specified to
//             indicate that the routine should select the next
//             appropriate or newest key version number).
//             (In the reference implementation, key_vno starts with
//             1, then monotonically increase 1 for each update.)
//    pvt_key_p:  a pointer to a buffer containing the private key component of
//		    the new asymmetric key pair.
//    pub_key_p:  a pointer to a buffer containing the public key component of
//		    the new asymmetric key pair.
//    pwd_p:  Pointer to the new user's password.  It is the
//	      caller's responsibility to provide the storage to
//	      contain the password.
//
// Output
//
//    new_key_vno_p:  Pointer to the actual key version number of
//		      the new key.  It is the caller's responsibility
//		      to provide the storage to contain the actual key
//		      version number.
//
// Calls: 	sec_pkss_mgmt_diffhell
//		sec_pkss_mgmt_mod_user_clt
//

#if __cplusplus
extern "C"
#endif
 error_status_t sec_pkss_mgmt_user_mod_clt
 (
   const char *pkss_svc_profile_name_p,
   const char *name_p,
   sec_pk_domain_t domain_id,
   sec_pk_usage_flags_t key_usages,
   unsigned32 key_vno,
   sec_pk_pvtkey_t *pvt_key_p,
   sec_pk_pubkey_t *pub_key_p,
   const char *pwd_p,
   unsigned32 *new_key_vno_p
 );

//
// Modify a user record (server generates asymmetric key pair).
//
// Input
//
//    pkss_svc_profile_name_p: Pointer to entry name in namespace where the
//			       search for compatible binding handles will
//			       begin.
//    name_p: Pointer to the user's canonical name within the
//            specified domain.
//    domain_id: The application domain this key belongs to.
//    key_usages: The usage(s) permitted of this keypair.
//    key_vno: The key version number. (0 may be specified to
//             indicate that the routine should select the next
//             appropriate or newest key version number).
//             (In the reference implementation, key_vno starts with
//             1, then monotonically increase 1 for each update.)
//    pwd_p:  Pointer to the new user's password.  It is the
//	      caller's responsibility to provide the storage to
//	      contain the password.
//    alg_id_p:  A pointer to a public key algorithm identifier.
//    key_len:  Bit-length of new public key to be generated by PKSS.
//
// Output
//
//    new_pub_key_p:  Pointer to a buffer to contain the public key
//		      component of the user's asymmetric key pair.  It is
//		      the caller's responsibility to provide the storage
//		      to contain the key.
//
//    new_key_vno_p:  Pointer to the actual key version number of
//		      the new key.  It is the caller's responsibility
//		      to provide the storage to contain the actual key
//		      version number.
//
// Calls: 	sec_pkss_mgmt_diffhell
//		sec_pkss_mgmt_mod_user_svr
//

#if __cplusplus
extern "C"
#endif
 error_status_t sec_pkss_mgmt_user_mod_svr
 (
   const char *pkss_svc_profile_name_p,
   const char *name_p,
   sec_pk_domain_t domain_id,
   sec_pk_usage_flags_t key_usages,
   unsigned32 key_vno,
   const char *pwd_p,
   sec_pk_algorithm_id_t *alg_id_p,
   unsigned32 key_len,
   sec_pk_pubkey_t *new_pub_key_p,
   unsigned32 *new_key_vno_p
 );

#endif /* SEC_PKSS_MGMT_API_H */
