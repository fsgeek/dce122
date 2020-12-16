/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 * All Rights Reserved
 */
/*
 * HISTORY
 * $Log: ktdefname.c,v $
 * Revision 1.1.2.1  1996/06/05  21:17:08  arvind
 * 	DCE1.2.2 Drop 2 to OSF
 * 	[1996/06/05  20:07:17  arvind]
 *
 * $EndLog$
 */
/*
** Copyright (c) Hewlett-Packard Company 1996
** Unpublished work. All Rights Reserved.
**
*/
/*
 * lib/krb5/os/ktdefname.c
 *
 * Copyright 1990 by the Massachusetts Institute of Technology.
 * All Rights Reserved.
 *
 * Export of this software from the United States of America may
 *   require a specific license from the United States Government.
 *   It is the responsibility of any person or organization contemplating
 *   export to obtain such a license before exporting.
 * 
 * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
 * distribute this software and its documentation for any purpose and
 * without fee is hereby granted, provided that the above copyright
 * notice appear in all copies and that both that copyright notice and
 * this permission notice appear in supporting documentation, and that
 * the name of M.I.T. not be used in advertising or publicity pertaining
 * to distribution of the software without specific, written prior
 * permission.  M.I.T. makes no representations about the suitability of
 * this software for any purpose.  It is provided "as is" without express
 * or implied warranty.
 * 
 *
 * Return default keytab file name.
 */

#include "k5-int.h"

extern char *krb5_defkeyname;

krb5_error_code
krb5_kt_default_name(context, name, namesize)
    krb5_context context;
    char *name;
    int namesize;
{
    strncpy(name, krb5_defkeyname, namesize);
    if ((size_t) namesize < strlen(krb5_defkeyname))
	return KRB5_CONFIG_NOTENUFSPACE;
    else
	return 0;
}
    
