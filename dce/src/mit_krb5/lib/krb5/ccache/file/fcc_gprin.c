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
 * $Log: fcc_gprin.c,v $
 * Revision 1.1.2.1  1996/06/05  20:39:12  arvind
 * 	DCE1.2.2 Drop 2 to OSF
 * 	[1996/06/05  19:41:46  arvind]
 *
 * $EndLog$
 */
/*
** Copyright (c) Hewlett-Packard Company 1996
** Unpublished work. All Rights Reserved.
**
*/
/*
 * lib/krb5/ccache/file/fcc_gprin.c
 *
 * Copyright 1990,1991 by the Massachusetts Institute of Technology.
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
 * This file contains the source code for krb5_fcc_get_principal.
 */


#include "fcc.h"

/*
 * Modifies:
 * id, princ
 *
 * Effects:
 * Retrieves the primary principal from id, as set with
 * krb5_fcc_initialize.  The principal is returned is allocated
 * storage that must be freed by the caller via krb5_free_principal.
 *
 * Errors:
 * system errors
 * KRB5_CC_NOMEM
 */
krb5_error_code INTERFACE
krb5_fcc_get_principal(context, id, princ)
   krb5_context context;
   krb5_ccache id;
   krb5_principal *princ;
{
     krb5_error_code kret = KRB5_OK;

     MAYBE_OPEN(context, id, FCC_OPEN_RDONLY);
     /* make sure we're beyond the vno */
     lseek(((krb5_fcc_data *) id->data)->fd, sizeof(krb5_int16), SEEK_SET);

     kret = krb5_fcc_read_principal(context, id, princ);

     MAYBE_CLOSE(context, id, kret);
     return kret;
}

     
