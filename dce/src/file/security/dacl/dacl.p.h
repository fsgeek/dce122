/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: dacl.p.h,v $
 * Revision 1.1.735.1  1996/10/02  18:15:11  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:46:24  damon]
 *
 * $EndLog$
 */
/*
 *	dacl.p.h -- DACL header file
 *
 * Copyright (C) 1995, 1991 Transarc Corporation
 * All rights reserved.
 */
/* $Header: /u0/rcs_trees/dce/rcs/file/security/dacl/dacl.p.h,v 1.1.735.1 1996/10/02 18:15:11 damon Exp $ */

#ifndef TRANSARC_DACL_H
#define TRANSARC_DACL_H 1

#include <dce/dfs_dce_acl.h>
#include <dcedfs/param.h>
#include <dcedfs/common_data.h>
#include <dcedfs/stds.h>
#include <dcedfs/osi.h>
#include <dcedfs/osi_cred.h>
#include <dcedfs/fshs_deleg.h>

#ifndef BUFSIZ
#define BUFSIZ	1024
#endif /* BUFSIZ */

#include <dcedfs/epi_id.h>
#include <dcedfs/dacl_mgruuids.h>

/* Also define a few "_r" prefixed functions to identify those safe to call
 * without holding preemption lock */

#define DACL_SUCCESS	0

/* this is what sits on the disk */
typedef struct epi_prinicpal_id_foreign {
  epi_principal_id_t	id;
  epi_uuid_t		realm;
} epi_principal_id_foreign_t;

/* this is what we manipulate internally */
typedef struct epi_uuid_foreign {
  epi_uuid_t	id;
  epi_uuid_t	realm;
} epi_uuid_foreign_t;

/* these are the things we need to be able to read the lists of sec_id_t's */
/* we only need these to avoid copying the uuids out of the lists in the pacs */
typedef struct epi_sec_id {
  epi_uuid_t	uuid;
  char *	name;
} epi_sec_id_t;

typedef struct epi_sec_id_foreign {
  epi_sec_id_t	id;
  epi_sec_id_t	realm;
} epi_sec_id_foreign_t;



/* the permission sets stored in an acl */
typedef u_int32 dacl_permset_t;

/* the various permissions that may be stored in such a set */
/* first the POSIX ones */
#define dacl_perm_read		0x01
#define dacl_perm_write		0x02
#define dacl_perm_execute	0x04
#define dacl_perm_control	0x08
#define dacl_perm_insert	0x10
#define dacl_perm_delete	0x20

#define DACL_PERM_RWX (dacl_perm_read | dacl_perm_write | dacl_perm_execute)

/* the application definable ones (epi only) */
#define dacl_perm_user0	0x80000000	/* "A" bit */
#define dacl_perm_user1	0x40000000	/* "B" bit */
#define dacl_perm_user2	0x20000000	/* "C" bit */
#define dacl_perm_user3	0x10000000	/* "D" bit */
#define dacl_perm_user4	0x08000000	/* "E" bit */
#define dacl_perm_user5	0x04000000	/* "F" bit */
#define dacl_perm_user6	0x02000000	/* "G" bit */
#define dacl_perm_user7	0x01000000	/* "H" bit */

#define DACL_USERLIST_PERMS	(dacl_perm_read | dacl_perm_write | dacl_perm_control)
#define DACL_USERLIST_PERMSTRING	"rwc"

#define ntoh_dacl_entry_permset_t(permsetP)	*entryTypeP = ntohl(*permsetP)
#define hton_dacl_entry_permset_t(permsetP)	*entryTypeP = htonl(*permsetP)

typedef struct dacl_format_label {
  u_int16	miscShorts[3];
  char		charField;
} dacl_format_label_t;

typedef struct dacl_extended_info {
  epi_uuid_t	extensionType;
  dacl_format_label_t	formatLabel;
  u_int32		numberBytes;
  char *		infoP;
} dacl_extended_info_t;


typedef u_int32 dacl_entry_type_t;
#define dacl_entry_type_user_obj	0
#define dacl_entry_type_group_obj	1
#define dacl_entry_type_other_obj	2
#define dacl_entry_type_user		3
#define dacl_entry_type_group		4
#define dacl_entry_type_mask_obj	5
/*
#define dacl_entry_type_class_group	5
#define dacl_entry_type_class_owner	6
#define dacl_entry_type_class_other	7
*/
#define dacl_entry_type_foreign_user	8
#define dacl_entry_type_foreign_group	9
#define dacl_entry_type_foreign_other	10
#define dacl_entry_type_unauth		11
#define dacl_entry_type_extended	12
#define dacl_entry_type_anyother	13

#define dacl_entry_type_user_obj_delegate  14
#define dacl_entry_type_group_obj_delegate 15
#define dacl_entry_type_other_obj_delegate 16
#define dacl_entry_type_user_delegate      17
#define dacl_entry_type_group_delegate     18
#define dacl_entry_type_foreign_other_delegate     19
#define dacl_entry_type_foreign_user_delegate      20
#define dacl_entry_type_foreign_group_delegate     21
#define dacl_entry_type_any_other_delegate         22


#define ntoh_dacl_entry_type_t(entryTypeP)	*entryTypeP = ntohl(*entryTypeP)
#define hton_dacl_entry_type_t(entryTypeP)	*entryTypeP = htonl(*entryTypeP)

typedef struct dacl_entry {
  dacl_permset_t	perms;

  dacl_entry_type_t	entry_type;
  union {
    epi_uuid_t		id;		/* for locally keyed entries */
    epi_uuid_foreign_t	foreign_id;	/* for foreign keyed entries */
    dacl_extended_info_t	extended_info;	/* for uninterpreted data */
  } entry_info;
} dacl_entry_t;

typedef struct dacl_simple_entry {
  u_int32		is_entry_good;
  dacl_permset_t	perms;
} dacl_simple_entry_t;

/* the following enumerated type is used only in memory */
typedef enum dacl_simple_entry_type {
  dacl_simple_entry_type_userobj,
  dacl_simple_entry_type_groupobj,
  dacl_simple_entry_type_otherobj,
  dacl_simple_entry_type_maskobj,
  dacl_simple_entry_type_anyother,
  dacl_simple_entry_type_userobj_delegate,
  dacl_simple_entry_type_groupobj_delegate,
  dacl_simple_entry_type_otherobj_delegate,
  dacl_simple_entry_type_anyother_delegate,
  dacl_simple_entry_type_unauthmask	/* this must remain as the last of the enums */
} dacl_simple_entry_type_t;

/* user, group entries include both foreign and local entries */

typedef enum dacl_complex_entry_type {
  dacl_complex_entry_type_user,
  dacl_complex_entry_type_group,
  dacl_complex_entry_type_user_delegate,
  dacl_complex_entry_type_group_delegate,
  dacl_complex_entry_type_for_other_delegate,  
  /* the complex_entry_type other includes both foreign other & extended entries */
  dacl_complex_entry_type_other		/* must remain as the last of the enums */
} dacl_complex_entry_type_t;

/* the following structure holds entries that have data assoc with them */
typedef struct dacl_complex_entry {
  u_int32		num_entries;
  u_int32		entries_allocated;
  dacl_entry_t *	complex_entries;
} dacl_complex_entry_t;

#define DACL_DELEGATE_ENTRY 0x1
typedef struct dacl {
  epi_uuid_t		mgr_type_tag;
  epi_uuid_t		default_realm;
  u_int32		num_entries;	/* the total number of entries stored on disk */
  dacl_simple_entry_t	simple_entries[((int)dacl_simple_entry_type_unauthmask) + 1];
  dacl_complex_entry_t	complex_entries[((int)dacl_complex_entry_type_other) + 1];
  int 			flags;
} dacl_t;

/*
 * exported routines for dealing with ACLs
 */

#define DACL_HAS_DELEGATE_ENTRY(daclP) ((daclP)->flags & DACL_DELEGATE_ENTRY)

/* we include both versions here to allow users to use type-checking, if they wish */
extern long dacl_CheckAccessId(
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    epi_uuid_t *		realmIdP,
    epi_uuid_t *		userIdP,
    epi_uuid_t *		groupIdP,
    epi_sec_id_t *		groupIdListP,
    unsigned int		numGroups,
    epi_sec_id_foreign_t *	foreignGroupIdListP,
    unsigned int		numForeignGroups,
    epi_principal_id_t *	userObjP,
    epi_principal_id_t *	groupObjP,
    int				isAuthn
);

extern long dacl_epi_CheckAccessId(
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    epi_uuid_t *		realmIdP,
    epi_uuid_t *		userIdP,
    epi_uuid_t *		groupIdP,
    epi_sec_id_t *		groupIdListP,
    unsigned int		numGroups,
    epi_sec_id_foreign_t *	foreignGroupIdListP,
    unsigned int		numForeignGroups,
    epi_principal_id_t *	userObjP,
    epi_principal_id_t *	groupObjP,
    int				isAuthn
);

extern long dacl_DetermineAccessAllowed(
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    epi_uuid_t *		realmIdP,
    epi_uuid_t *		userIdP,
    epi_uuid_t *		groupIdP,
    epi_sec_id_t *		groupIdListP,
    unsigned int		numGroups,
    epi_sec_id_foreign_t *	foreignGroupIdListP,
    unsigned int		numForeignGroups,
    epi_principal_id_t *	userObjP,
    epi_principal_id_t *	groupObjP,
    int				isAuthn,
    dacl_permset_t *		accessAllowedP
);

extern long dacl_epi_DetermineAccessAllowed(
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    epi_uuid_t *		realmIdP,
    epi_uuid_t *		userIdP,
    epi_uuid_t *		groupIdP,
    epi_sec_id_t *		groupIdListP,
    unsigned int		numGroups,
    sec_id_foreign_groupset_t * foreignGroupSetP,
    unsigned16                  numForeignGrpSets,
    epi_principal_id_t *	userObjP, 
    epi_principal_id_t *	groupObjP,
    int				isAuthn,
    int				do_dlg,
    dacl_permset_t *		accessAllowedP
);

extern long dacl_ChmodAcl(dacl_t *daclP, u_int32 permBits, int forDirectory);

#ifdef sec_id_base_v0_0_included
/* again, both versions allow type checking */
extern long dacl_CheckAccessPac (
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    sec_id_pac_t  *		pacP,
    epi_principal_id_t *	userObjP,
    epi_principal_id_t *	groupObjP
);

extern long dacl_CheckAccessAllowedPac(
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    sec_id_pac_t *              pacP,
    epi_principal_id_t *	userObjP,
    epi_principal_id_t *	groupObjP,
    dacl_permset_t *		accessAllowedP
);

#endif /* sec_id_base_v0_0_included */

extern long dacl_ParseAclDiskOption(
    char *		fileBufferP,
    int			bytesInBuffer,
    dacl_t *		aclBufferP,
    epi_uuid_t *	mgrUuidP,
    int			parseFromDisk
);

extern long dacl_ParseSyscallAcl(
    char *		fileBufferP,
    int			bytesInBuffer,
    dacl_t *		aclBufferP,
    epi_uuid_t *	mgrUuidP
);

extern long dacl_ParseAcl(
    char *		fileBufferP,
    int			bytesInBuffer,
    dacl_t *		aclBufferP,
    epi_uuid_t *	mgrUuidP
);

#if !defined(KERNEL)
extern long dacl_PrintAclEntry(
    FILE *		stream,
    dacl_entry_t *	aclEntryP,
    epi_uuid_t *	defaultRealmUuidP,
    int			local
);

extern long dacl_PrintAcl(FILE *stream, dacl_t *aclP, int local);

extern long dacl_WriteToDisk(dacl_t *aclP, char *filenameP);
#endif /* !defined(KERNEL) */

/*
 * the following routine should never be used inside Episode, so it uses all
 * full uuids
 */
extern long dacl_CreateAclOnDisk(
    char *			filenameP,
    epi_uuid_t *		mgrUuidP,
    epi_uuid_t *		defaultRealmUuidP,
    dacl_permset_t *		userObjPermsP,
    dacl_permset_t *		groupObjPermsP,
    dacl_permset_t *		otherObjPermsP,
    int				useEpisodeFile,
    long			epiSyscallFlags
);

extern long dacl_ReadFromDisk(
    dacl_t *		aclP,
    char *		filenameP,
    epi_uuid_t *	mgrUuidP
);

extern long dacl_AddEntryToAcl(
    dacl_t *		aclP,
    char *		typeStringP,
    char *		nameStringP,
    char *		permStringP,
    char *		dataStringP,
    epi_uuid_t *	mgrUuidP,
    int		local
);

extern long dacl_ModifyAclEntry(
    dacl_t *		aclP,
    char *		typeStringP,
    char *		nameStringP,
    char *		permStringP,
    char *		dataStringP,
    int			local
);

extern long dacl_DeleteAclEntry(
    dacl_t *		aclP,
    char *		typeStringP,
    char *		nameStringP,
    epi_uuid_t *	mgrUuidP,
    int			local
);

extern long dacl_DeleteAllEntries(dacl_t *aclP);

#if defined(sec_acl_base_v0_0_included)
extern long sec_acl_FlattenAcl(
    sec_acl_t *		secAclP,
    char **		byteBufferPP,
    unsigned int *	bytesInBufferP
);
#endif /* defined(sec_acl_base_v0_0_included) */

#if !defined(KERNEL)
extern long dacl_InitAclEntryFromStrings(
    dacl_entry_t *	aclEntryP,
    epi_uuid_t *	defaultRealmUuidP,
    char *		typeStringP,
    char *		nameStringP,
    char *		permStringP,
    char *		dataStringP,
    epi_uuid_t *	mgrUuidP,
    int			local
);

#ifdef rgynbase_v0_0_included
extern long dacl_NameAndTypeStringsFromEntry(
    dacl_entry_t *	aclEntryP,
    epi_uuid_t *	defaultRealmUuidP,
    char **		typeStringPP,
    sec_rgy_name_t	globalName,
    int		local
);
#endif /* rgynbase_v0_0_included */

#endif /* !defined(KERNEL) */

/* from dacl_typestrings.c: */
extern char *dacl_EntryType_ToString(dacl_entry_type_t probeType);

extern long dacl_EntryType_FromString(
    dacl_entry_type_t *	probeTypeP,
    char *		probeString
);

extern void dacl_Permset_FromString(
    dacl_permset_t *	thePermSetP,
    char *		permStringP
);

extern void dacl_Permset_ToString(
    dacl_permset_t *	thePermSetP,
    char *		stringBufferP
);

/* Flags for dacl_ValidateBuffer and dacl_epi_ValidateBuffer */
#define DACL_VB_MAKE_MINOR_REPAIRS 0x1
#define DACL_VB_REMOVE_UNAUTH_MASK 0x2
#define DACL_VB_FIND_UNAUTH_MASK 0x4

extern long dacl_ValidateBuffer(
    char *		byteBufferP,
    unsigned int *	bytesInBufferP,
    epi_uuid_t *	mgrUuidP,
    int			flags,
    dacl_t **		daclPP
);

/*
 * Kernel symbols exported outside the DFS core module:
 */
extern void dacl_SetSysAdminGroupID(afsUUID *sysAdminGroupID);
#define dacl_SetSysAdminGroupID_r(a) dacl_SetSysAdminGroupID(a)
extern void dacl_GetSysAdminGroupID(afsUUID *group_ID);
#define dacl_GetSysAdminGroupID_r(a) dacl_GetSysAdminGroupID(a)
extern void dacl_SetLocalCellID(afsUUID *localCellID);
extern void dacl_GetLocalCellID(afsUUID *localCellID);
#define dacl_GetLocalCellID_r(a) dacl_GetLocalCellID(a)
extern void dacl_GetNetworkRootID(afsUUID *networkRootID);
#define dacl_GetNetworkRootID_r(a) dacl_GetNetworkRootID(a)

#ifdef sec_id_base_v0_0_included
extern long dacl_epi_CheckAccessAllowedPac(
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    pac_list_t *                pacListP,
    epi_principal_id_t *	userObjP,
    epi_principal_id_t *	groupObjP,
    int				networkRootCheck,
    dacl_permset_t *		accessAllowedP
);
#define dacl_epi_CheckAccessAllowedPac_r(a,b,c,d,e,f,g,h) \
    dacl_epi_CheckAccessAllowedPac(a,b,c,d,e,f,g,h)

extern long dacl_epi_CheckAccessPac(
    dacl_t *			aclP,
    u_int32 *			permBitsP,
    dacl_permset_t *		accessRequestedP,
    pac_list_t *		pacListP,
    epi_principal_id_t *	userObjP,
    epi_principal_id_t *	groupObjP,
    int				networkRootCheck
);
#define dacl_epi_CheckAccessPac_r(a,b,c,d,e,f,g) \
    dacl_epi_CheckAccessPac(a,b,c,d,e,f,g)

extern void dacl_PacFromUcred(sec_id_pac_t *pacP, osi_cred_t *ucredP);
extern void dacl_PacListFromUcred(pac_list_t **pacListPP, osi_cred_t *ucredP);
#endif /* sec_id_base_v0_0_included */

extern void dacl_ChmodOnePermset(
    u_int32 permBits,
    dacl_permset_t * thePermsetP,
    int forDirectory
);
#define dacl_ChmodOnePermset_r(a,b,c) dacl_ChmodOnePermset(a,b,c)

extern void dacl_AddPermBitsToOnePermset(
    u_int32 permBits,
    dacl_permset_t *thePermsetP
);
#define dacl_AddPermBitsToOnePermset_r(a,b) dacl_AddPermBitsToOnePermset(a,b)

extern void dacl_OnePermsetToPermBits(
    dacl_permset_t thePermset,
    u_int32  *permBitsP
);

extern long dacl_epi_FlattenAcl(
    dacl_t *		aclP,
    char **		fileBufferPP,
    unsigned int *	bytesInBufferP,
    u_int32		modeBits
);

extern long dacl_FlattenAcl(
    dacl_t *		aclP,
    char **		fileBufferPP,
    unsigned int *	bytesInBufferP
);

extern long dacl_FlattenAclWithModeBits(
    dacl_t *		aclP,
    char **		fileBufferPP,
    unsigned int *	bytesInBufferP,
    u_int32		modeBits,
    int			useModeBits,
    int			flattenForDisk
);

/* Accepts same flags as dacl_ValidateBuffer */
extern long dacl_epi_ValidateBuffer(
    char *		byteBufferP,
    unsigned int *	bytesInBufferP,
    int			flags,
    dacl_t **		daclPP);

extern long dacl_ExtractPermBits(dacl_t *daclP, u_int32 *permBitsP);
#define dacl_ExtractPermBits_r(a,b) dacl_ExtractPermBits(a,b)

extern void dacl_ExtractMinimumPermSet(
    dacl_t *daclP,
    dacl_permset_t *permsetP);
#define dacl_ExtractMinimumPermSet_r(a,b) dacl_ExtractMinimumPermSet(a,b)

extern long dacl_FreeAclEntries(dacl_t *theAclP);

extern long dacl_InitEpiAcl(
    dacl_t *	theAclP,
    u_int32 *	modeP,
    int		forDirectory,
    epi_uuid_t * aclRealmP
);
#define dacl_InitEpiAcl_r(a,b,c,d) dacl_InitEpiAcl(a,b,c,d)

extern void dacl_GetDefaultRealm(
    dacl_t *     theAclP,
    epi_uuid_t * realmP
);
#define dacl_GetDefaultRealm_r(a,b) dacl_GetDefaultRealm(a,b)

extern long dacl_ChangeRealm(
    dacl_t *		daclP,
    epi_uuid_t *	ownerRealmUuidP
);
#define dacl_ChangeRealm_r(a,b) dacl_ChangeRealm(a,b)

extern void dacl_ChangeUnauthMask(
    dacl_t *		daclP,
    dacl_permset_t	permBits
);
#define dacl_ChangeUnauthMask_r(a,b) dacl_ChangeUnauthMask(a,b)

extern epi_uuid_t dacl_localCellID;

#if defined(DACL2ACL)
#define dacl_Alloc malloc
#define dacl_Free(ptrP, size) free((ptrP))
#else /* defined(DACL2ACL) */
#define dacl_Alloc osi_Alloc
#define dacl_Free(ptrP, size) osi_Free((ptrP), (size))
#endif /* defined(DACL2ACL) */

#endif /* TRANSARC_DACL_H */
