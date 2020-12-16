/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: xcred.p.h,v $
 * Revision 1.1.489.1  1996/10/02  19:03:12  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:51:42  damon]
 *
 * $EndLog$
 */
/*
 * (C) Copyright 1995, 1990 Transarc Corporation
 * Licensed Materials - Property of Transarc
 * All Rights Reserved.
 *
 * $Header: /u0/rcs_trees/dce/rcs/file/xcred/xcred.p.h,v 1.1.489.1 1996/10/02 19:03:12 damon Exp $
 *
 * xcred.p.h
 *	Definitions/interface for the extended credential package.
 *	These functions allow interpretation of credential structures
 *	in a more general fashion.  In particular, an xcred structure
 *	containing various forms of authentication information may be
 *	associated with a standard Unix credential.
 */

#ifndef TRANSARC_XCRED_H
#define TRANSARC_XCRED_H 1

#include <dcedfs/param.h>		/* AFS system definitions */
#include <dcedfs/sysincludes.h>		/* Set of system include files */
#include <dcedfs/basicincludes.h>	/* Set basic afs include files */
#include <dcedfs/lock.h>		/* Locking package */
#include <dcedfs/stds.h>		/* Coding standards defs */
#include <dcedfs/osi_cred.h>		/* ucred definition */
/* * --------------------- Exported definitions --------------------- */
/* property list flags */
#define XCRED_PLISTFLAGS_DELETED	1
/* Deleted plist entry */
/*
 * Property list entry.
 *
 * This structure is used to build a list of all attribute-value pairs
 * for an xcred, including derivation relationships.
 */
typedef struct xcred_PListEntry {
    struct xcred_PListEntry *nextP;		/* Next entry in linear plist */
    struct xcred_PListEntry *prevP;		/* Prev entry in linear plist */
    long attrBytes;				/* Size of attr (incl. null) */
    char *attributeP;				/* Ptr to attr. component */
    long valueBytes;				/* Size of value component */
    char *valueP;				/* Ptr to value component */
    long flags;					/* Internal flags */
} xcred_PListEntry_t;


/* xcred flags */
#define XCRED_FLAGS_DELETED		1	/* xcred deleted */

/* xcred "user"-defined flags */
#define XCRED_UFLAGS_RESET		1	/* reset access cache */
#define XCRED_UFLAGS_HASNFS		2	/* has NFS property */

/*
 * Xcred structure.
 *
 * This refcounted and lockable structure contains all the extended
 * credential info associated with a given user, stored in a property
 * list.  Also stored are a list of GC handler routines and information
 * on the Unix cred with which this structure is associated.  Thrown in
 * is a generation number, incremented each time someone changes the
 * property list.
 */
typedef struct xcred {
    struct squeue lruq;				/* LRU queue */
    struct lock_data lock;			/* Structure lock */
    long refcount;				/* Reference count */
    long changeCount;				/* # times plist changed */
    long flags;					/* Flags described above */
    long uflags;				/* More user-defined flags */
    xcred_PListEntry_t *propListP;		/* Property list */
    osi_cred_t *assocUCredP;			/* Assoc Unix cred struct */
    long assocPag;				/* Unique identifier in ucred */
} xcred_t;


/*
 * osi_cred_t *xcred_XCredToUCred(credp).  Field doesn't change once
 * entry is in hash table.  Caller also doesn't access xcred until
 * properly initialized.
 */
#define xcred_XCredToUCred(credp)	(osi_cred_t *)((credp)->assocUCredP)


/*
 * ---------------------- Exported functions ----------------------
 */

extern long xcred_Init(void);

    /*
     * Summary:
     *    Initialize the xcred module.  Will only perform the
     *	  initialization at the first call; subsequent calls will
     *	  be no-ops.
     *
     * Args:
     *	  None.
     *
     * Returns:
     *	  0			if everything went well.
     *	  XCRED_EC_ALLOC_FAILED if there was a memory allocation
     *				failure.
     */

extern long xcred_Create(/* OUT */ xcred_t **anewXCredPP);

    /*
     * Summary:
     *    Create a new, empty xcred structure.
     *
     * Args:
     *	  newXCredPP : Address of xcred ptr to fill.
     *
     * Returns:
     *	  0			if everything went well,
     *	  XCRED_EC_ALLOC_FAILED if the allocation failed.
     */

extern long xcred_Hold(/* IN */ xcred_t *axcredP);

    /*
     * Summary:
     *    Increment the reference count on the given xcred.
     *
     * Args:
     *	  axcredP : Pointer to the xcred to bump.
     *
     * Returns:
     *	  0			if everything went well,
     *	  XCRED_EC_INVAL_PARAM  if the xcred was invalid.
     *	  XCRED_EC_BAD_REFCOUNT if the refcount was already <= 0.
     */

extern long xcred_Release(/* IN */ xcred_t *axcredP);

    /*
     * Summary:
     *    Decrement the reference count on the given xcred structure,
     *	  freeing it should the count drop to zero.
     *
     * Args:
     *	  axcredP : Pointer to the xcred to decrement.
     *
     * Returns:
     *	  0			if everything went well,
     *	  XCRED_EC_INVAL_PARAM  if the xcred was invalid.
     *	  XCRED_EC_BAD_REFCOUNT if the refcount was already <= 0.
     */

extern long xcred_AssociateCreds(
    /* IN */ xcred_t *axcredP,
    /* IN */ osi_cred_t *aucredP,
    /* IN */ u_long pag);

    /*
     * Summary:
     *	  Associate the given xcred and Unix ucred.
     *
     * Args:
     *	  axcredP : Pointer to the xcred for the association.
     *	  aucredP : Pointer to the related Unix credential structure.
     *
     * Returns:
     *	  0			if everything went well,
     *	  XCRED_EC_INVAL_PARAM  if an invalid structure address was passed in.
     *	  XCRED_EC_BAD_REFCOUNT if the refcount on the xcred was <= 0.
     *	  XCRED_EC_CRED_FULL	if the Unix cred can't handle additional xcreds.
     */

extern long xcred_UCredToXCred(
    /* IN */ osi_cred_t *aucredP,
    /* OUT */ xcred_t **axcredPP);

    /*
     * Summary:
     *	  Obtain the corresponding xcred from the given Unix cred.
     *
     * Args:
     *	  aucredP  : The Unix cred to examine.
     *	  axcredPP : Set to point to the address of the associated xcred.
     *
     * Returns:
     *	  0			if everything went well.
     *	  XCRED_EC_INVAL_PARAM  if an invalid structure address was passed in.
     *	  XCRED_EC_BAD_REFCOUNT if the refcount on the xcred was already <= 0.
     *	  XCRED_EC_NO_ENTRY     if the given Unix cred had no associated xcred.
     *
     * Environment:
     *	  If a valid xcred is returned, its refcount has been bumped.
     */

extern long xcred_PutProp(
    /* IN */ xcred_t *axcredP,
    /* IN */ char *aattributeP,
    /* IN */ long aattributeLength,
    /* IN */ char *avalueP,
    /* IN */ long alength,
    /* IN */ char *abaseAttrP,
    /* IN */ long abaseAttrLength);

    /*
     * Summary:
     *	  Enter the given attribute-value pair into the given xcred's
     *	  property list.  If the value portion is null, remove the entry
     *	  in the property list matching the given attribute (if any), as
     *	  well as all plist entries derived from this one.
     *
     * Args:
     *	  axcredP     : Pointer to the xcred to modify.
     *	  aattributeP : String name of the property list entry attribute.
     *    aattributeLength: Length of above.
     *	  avalueP     : Counted array of bytes comprising the value portion
     *			of the property list entry.
     *	  alength     : The length in bytes of the value field.
     *	  aflags      : Various flags.
     *	  abaseAttrP  : Name of the attribute from which this plist entry
     *			is derived (if any).
     *    abaseAttrLength: Length of above in bytes.
     *
     * Returns:
     *	  0			     if everything went well.
     *	  XCRED_EC_INVAL_PARAM	     if a parameter is invalid.
     *	  XCRED_EC_BAD_REFCOUNT	     if the xcred's refcount was <= 0.
     *	  XCRED_EC_NO_BASE_ATTRIBUTE if the base attribute specified doesn't
     *				     exist.
     */

extern long xcred_GetProp(
    /* IN */ xcred_t *axcredP,
    /* IN */ char *aattributeP,
    /* IN */ long aattributeLength,
    /* OUT */ char **avaluePP,
    /* OUT */ long *arealLengthP);

    /*
     * Summary:
     *	  Retrieve the value for the attribute entry in the given xcred's
     *	  property list.
     *
     * Args:
     *	  axcredP      : Pointer to the xcred to examine.
     *	  aattributeP  : Attribute field naming the property to retrieve.
     *	  aatributeLength: length of aatributeP.
     *	  amaxLength   : Actual length of the buffer represented by the
     *			 value parameter, which may be zero.
     *	  **avaluePP   : Pointer to the address of the buffer in which to
     *			 store the retrieved value, if any (may be null).
     *	  arealLengthP : Set to the number of bytes placed into *avaluePP.
     *
     * Returns:
     *	  0			   if everything went well,
     *	  XCRED_EC_BAD_REFCOUNT    if the refcount on the xcred was <= 0.
     *	  XCRED_EC_NO_ENTRY	   if there was no entry named attribute
     *				   associated with the xcred.
     *	  XCRED_EC_NOT_ENOUGH_ROOM if there wasn't enough room in the caller's
     *				   buffer to copy out the value component.
     *	  XCRED_EC_ALLOC_FAILED    if a memory allocation failed.
     */

extern xcred_t *xcred_FindByPag(/* IN */ long apag);

extern long xcred_DeleteEntry(
    /* IN */ xcred_t *axp,
    /* IN */ xcred_PListEntry_t *aplp);

extern long xcred_Delete(/* IN */ xcred_t *axp);

extern long xcred_EnumerateProp(
    /* IN */ xcred_t *axcredP,
    /* IN */ long (*aproc)(char *, xcred_t *, xcred_PListEntry_t *),
    /* IN */ char *arock);

    /*
     * Summary:
     *	  Apply the given function to all elements of the given xcred's
     *	  property list.
     *
     * Args:
     *	  axcredP : Pointer to the xcred to deal with.
     *	  aprocP  : Ptr to function to call on each member of the
     *		    xcred's property list.
     *	  arockP  : The first parameter passed to *aprocP.  The given
     *		    routine is actually given three parameters, the
     *		    second being axcredP and the third a pointer to
     *		    the plist entry currently being operated upon.
     *
     * Environment & Locks:
     *	  The xcred is read-locked for the duration of the call.  This
     *	  means the function to be applied had better not try to lock
     *	  the xcred itself!
     *
     * Returns:
     *	  0			if everything went fine.
     *	  XCRED_EC_INVAL_PARAM  if a parameter was illegal.
     *	  XCRED_EC_BAD_REFCOUNT if the xcred's refcount was <= 0.
     */

extern long xcred_GetUFlags(/* IN */ xcred_t *axp);

extern long xcred_SetUFlags(
    /* IN */ xcred_t *axp,
    /* IN */ long orflags,
    /* IN */ long andflags);

#endif /* TRANSARC_XCRED_H */
