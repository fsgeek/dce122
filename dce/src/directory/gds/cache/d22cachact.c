/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: d22cachact.c,v $
 * Revision 1.1.10.2  1996/02/18  19:43:25  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  18:24:21  marty]
 *
 * Revision 1.1.10.1  1995/12/08  15:26:15  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  14:54:11  root]
 * 
 * Revision 1.1.8.3  1994/09/06  12:24:38  keutel
 * 	line 1 directive removed: OT 11971
 * 	[1994/09/06  11:12:26  keutel]
 * 
 * Revision 1.1.8.2  1994/05/10  15:50:52  marrek
 * 	April 1994 code submission.
 * 	[1994/04/27  12:16:19  marrek]
 * 
 * Revision 1.1.8.1  1994/02/22  17:52:19  marrek
 * 	Code drop for dce1.1.
 * 	[1994/02/08  09:50:44  marrek]
 * 
 * Revision 1.1.6.2  1993/08/11  07:17:07  marrek
 * 	July 1993 code drop.
 * 	[1993/08/02  12:10:57  marrek]
 * 
 * Revision 1.1.4.2  1992/12/31  18:39:46  bbelch
 * 	Embedding copyright notice
 * 	[1992/12/31  13:12:31  bbelch]
 * 
 * Revision 1.1.2.2  1992/06/01  20:12:47  melman
 * 	New GDS merged drop
 * 	[1992/05/28  21:05:21  melman]
 * 
 * $EndLog$
 */
#if !defined(lint) && defined(GDS_RCS_ID)
static char rcsid[] = "@(#)$RCSfile: d22cachact.c,v $ $Revision: 1.1.10.2 $ $Date: 1996/02/18 19:43:25 $";
#endif

/****************************************************************************
*                                                                           *
*         COPYRIGHT  (C)  SIEMENS NIXDORF INFORMATIONSSYSTEME AG 1991       *
*                                ALL RIGHTS RESERVED                        *
*                                                                           *
****************************************************************************/

/*daton	***************************************************************/
/*								      */
/* TYPE         : MODUL                                               */
/*								      */
/* NAME         : d22cacheact.c                                       */
/*								      */
/* AUTHOR       : R. Horn, D AP 11                                    */
/* DATE         : 10.05.88                                            */
/*								      */
/* COMPONENT    : DS                                                  */
/*								      */
/* DOC.-NR.     : Directory-Design-Specification                      */
/*			.					      */
/*			.					      */
/*								      */
/* PRD#/VERS.   :                                                     */
/*								      */
/* DESCRIPTION  :                                                     */
/*								      */
/* SYSTEM DEPENDENCIES: COMMON                                        */
/*								      */
/* HISTORY      :                                                     */
/*								      */
/* Vers.Nr. |  Date   |  Updates                       | KZ | CR# FM# */
/*          |         |                                |    |         */
/*datoff **************************************************************/

/*exon ***********************************************************************/
/*                                                                           */
/*  FUNCTION:  d22_activate_cache ()                                         */
/*                                                                           */
/*  SHORT DESCRIPTION:                                                       */
/*      The function activates the DUA-cache which is specified by an        */
/*      Identifier. If there exists an active DUA-cache, this cache is       */
/*      deactivated before the specified DUA-cache is activated. Thus, the   */
/*      function can also be used to switch from one DUA-cache to another.   */
/*      If the specified DUA-cache doesn't exist (no cache file exists), it  */
/*      is generated by using the given default values.                      */
/*                                                                           */
/*  INPUT-PARAMETER:                                                         */
/*      cache_id    = No. of the DUA-cache which should be activated.        */
/*      admptr      = Pointer to a structure where all informations about    */
/*                    the activated DUA-cache should be stored. The          */
/*                    structure element 'act_cache_id' must contain the      */
/*                    identifier of the former activated DUA-cache or        */
/*                    'NONE', if this is the first activation of a cache.    */
/*                                                                           */
/*  OUTPUT-PARAMETER:                                                        */
/*      admptr      = The referenced DUA-administration table contains       */
/*                    informations about the actual state of the             */
/*                    activated DUA-cache (including references to the       */
/*                    DUA-cache description table, the DUA-cache hash table  */
/*                    and further allocated memory areas -> see also         */
/*                    description of the data type 'D22_admin_tab').         */
/*                                                                           */
/*  RETURN-VALUE:                                                            */
/*      D22_OK      = The function has been performed successfully.          */
/*      D22_ERROR   = An system error or an internal error is occurred       */
/*                    during operation ('d22_errno' contains an error no.)   */
/*                                                                           */
/* ------------------------------------------------------------------------- */
/*  AUTHOR: R.Horn                                        DATE: 23.11.87     */
/*exoff **********************************************************************/

#include <gds.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <fcntl.h>
#include <string.h>
#include <dce/d2dir.h>
#include <d23apdu.h>
#include <d23ipc.h>
#include <d22cache.h>

/* -------------------- declaration of global data ------------------------- */

extern signed32	d22_errno ;	/* error variable */

/* ------------------ declaration of local data ---------------------------- */

				/* DUA-cache data base version no. */
static char cavers[] = { D22_RELEASE } ;
static char		*c_fnames[] =
			{ D22_DESCFILE, D22_HASHFILE, D22_ATTRFILE, D22_REORGFILE } ;
 
/* ------------------------------------------------------------------------- */

signed32 d22_activate_cache (signed16 cache_id, D22_admin_tab *admptr) {

    D22_iobj_entry	*p ;
    signed32		i, cnt ;
    int			*p1 ;
    D22_hash_entry	*p2 ;
    char		cname[D27_LFILE_NAME] ;

    /* --- deactivate former DUA-cache --- */

    if (admptr->d22_act_cache_id != D22_NONE) {
	/* close DUA-cache files */
	d22_cfclose (admptr->d22_desc_fd) ;
	d22_cfclose (admptr->d22_hsh_fd) ;
	d22_cfclose (admptr->d22_attr_fd) ;
	d22_cfclose (admptr->d22_rorg_fd) ;

	/* free allocated memory areas */
	free (admptr->d22_hshtab) ;
	for (i = 0, p = admptr->d22_iobjtab;
			    i < admptr->d22_desctab->d22_imax_entries; i++, p++)
	    if (p->d22_ilreftime != D22_IZERO)
		free (p->d22_iattrptr) ;
	free (admptr->d22_iobjtab) ;
	free (admptr->d22_rorgtab) ;
        free (admptr->d22_desctab) ;
	DCE_SVC_LOG ((DCE_SVC (gds_svc_handle, "%d"), GDS_S_GENERAL,
		svc_c_debug1, GDS_S_CACHE_INACTIVE, admptr->d22_act_cache_id)) ;
	admptr->d22_act_cache_id = D22_NONE ;
    }

    /* --- activate new DUA-cache --- */

    /* open DUA-cache files */  	
    for (i = 0, p1 = &admptr->d22_desc_fd; p1 <= &admptr->d22_rorg_fd;
								    p1++, i++) {
	sprintf (cname, "%s%s%d%s", admptr->d22_conftab->d22_base_path,
					  D22_CACHEDIR, cache_id, c_fnames[i]) ;
	if ((*p1 = d22_cfopen (cname, O_RDWR | O_SYNC | O_CREAT,
						    D22_FILEMODE)) == D22_ERROR)
	    return (D22_ERROR) ;
    }

    /* --- initialize DUA-cache memory areas --- */

    if (admptr->d22_act_cache_id == D22_NONE) {
	/* allocate memory for DUA-cache description table */
	if ((admptr->d22_desctab = (D22_desc_tab *) malloc ((size_t) sizeof
				    (D22_desc_tab))) == (D22_desc_tab *) NULL) {
	    d22_errno = D22_NOMEM_ERR ;
	    dce_svc_printf (DCE_SVC (gds_svc_handle, "%d"), GDS_S_GENERAL,
		     svc_c_sev_warning, GDS_S_NOMEMORY, sizeof (D22_desc_tab)) ;
	    return (D22_ERROR) ;
	}
    }

    /* set active DUA-cache identifier temporary to a restart state */
    admptr->d22_act_cache_id = D22_RESTART ;

    if ((cnt = d22_cfread (admptr->d22_desc_fd, (void *) admptr->d22_desctab,
				 (size_t) sizeof (D22_desc_tab), (off_t) 0)) == D22_ERROR)
	return (D22_ERROR) ;
    if (cnt == 0) {
	/* DUA-cache description table not available -> generate one */
	/* by using the valid default values */
	strcpy (admptr->d22_desctab->d22_version, cavers) ;
	admptr->d22_desctab->d22_cdate_time = time ((time_t) 0) ;
	admptr->d22_desctab->d22_cache_state = D22_COPERABLE ;
	admptr->d22_desctab->d22_tst_pattern = D22_TST_PATTERN ;
	admptr->d22_desctab->d22_hmax_entries = admptr->d22_conftab->d22_hsh_max ;
	admptr->d22_desctab->d22_imax_entries = admptr->d22_conftab->d22_int_max ;
	admptr->d22_desctab->d22_rmax_entries = admptr->d22_conftab->d22_res_max ;
	admptr->d22_desctab->d22_ract_entries = 0 ;
	admptr->d22_desctab->d22_rdel_entries = admptr->d22_conftab->d22_rdel_no ;
	admptr->d22_desctab->d22_pmax_entries = admptr->d22_conftab->d22_priv_max ;
	admptr->d22_desctab->d22_pact_entries = 0 ;
	admptr->d22_desctab->d22_pdel_entries = admptr->d22_conftab->d22_pdel_no ;
	admptr->d22_desctab->d22_nmax_entries = admptr->d22_conftab->d22_norm_max ;
	admptr->d22_desctab->d22_nact_entries = 0 ;
	admptr->d22_desctab->d22_ndel_entries = admptr->d22_conftab->d22_ndel_no ;
	admptr->d22_desctab->d22_fmax_memsize = admptr->d22_conftab->d22_mem_max ;
	admptr->d22_desctab->d22_fact_memsize = 0 ;
	admptr->d22_desctab->d22_amax_areas   = admptr->d22_conftab->d22_mem_no ;
	admptr->d22_desctab->d22_aact_areas   = 0 ;
	/* store DUA-cache description table in cache file */
	if (d22_cfwrite (admptr->d22_desc_fd, (void *) admptr->d22_desctab,
				  (size_t) sizeof (D22_desc_tab), (off_t) 0) == D22_ERROR)
	    return (D22_ERROR) ;
    } else {
	if (cnt != sizeof (D22_desc_tab)) {
	    /* error -> wrong size of DUA-cache description table */
	    d22_errno = D22_FLSIZE_ERR ;
	    dce_svc_printf (DCE_SVC (gds_svc_handle, "%d%d"), GDS_S_GENERAL,
				svc_c_sev_fatal, GDS_S_CACHE_DESCR_SZ_ERR, cnt,
				sizeof (D22_desc_tab)) ;
	    return (D22_ERROR) ;
	} else {
	    if (admptr->d22_desctab->d22_cache_state == D22_CINOPERABLE ||
		admptr->d22_desctab->d22_tst_pattern != D22_TST_PATTERN) {
		/* error -> inconsistent DUA-cache */
		/* NOTE: Usually this results from the transfer of cache data files */
		/* (save/restore) between different (little/big endian) platforms */
		d22_errno = D22_INOPERABLE_ERR ;
		dce_svc_printf (DCE_SVC (gds_svc_handle, ""), GDS_S_GENERAL,
				      svc_c_sev_fatal, GDS_S_CACHE_INCONS_ERR) ;
		return (D22_ERROR) ;
	    }
	    if (strcmp (admptr->d22_desctab->d22_version, cavers) != 0) {
		/* error -> wrong version number of cache data */
		d22_errno = D22_VERSION_ERR ;
		dce_svc_printf (DCE_SVC (gds_svc_handle, "%s%s"), GDS_S_GENERAL,
				svc_c_sev_fatal, GDS_S_CACHE_VERSION_ERR,
				admptr->d22_desctab->d22_version, cavers) ;
		return (D22_ERROR) ;
	    }
	}
    }

    /* allocate memory for DUAc-cache hash table */
    if ((admptr->d22_hshtab = (D22_hash_entry *) calloc
	((size_t) admptr->d22_desctab->d22_hmax_entries,
		(size_t) sizeof (D22_hash_entry))) == (D22_hash_entry *) NULL) {
	d22_errno = D22_NOMEM_ERR ;
	dce_svc_printf (DCE_SVC (gds_svc_handle, "%d"), GDS_S_GENERAL,
	      svc_c_sev_warning, GDS_S_NOMEMORY,
	      admptr->d22_desctab->d22_hmax_entries * sizeof (D22_hash_entry)) ;
	return (D22_ERROR) ;
    }
    if ((cnt = d22_cfread (admptr->d22_hsh_fd, (void *) admptr->d22_hshtab,
	(size_t) (admptr->d22_desctab->d22_hmax_entries *
			     sizeof (D22_hash_entry)), (off_t) 0)) == D22_ERROR)
	return (D22_ERROR) ;
    if (cnt == 0) {
	/* DUA-cache hash table not available -> generate one */
	if (d22_cfwrite (admptr->d22_hsh_fd, (void *) admptr->d22_hshtab,
	    (size_t) (admptr->d22_desctab->d22_hmax_entries *
			      sizeof (D22_hash_entry)), (off_t) 0) == D22_ERROR)
	    return (D22_ERROR) ;
    } else {
	if (cnt !=  admptr->d22_desctab->d22_hmax_entries *
						      sizeof (D22_hash_entry)) {
	    /* error -> wrong size of DUA-cache hash table */
	    d22_errno = D22_FLSIZE_ERR ;
	    dce_svc_printf (DCE_SVC (gds_svc_handle, "%d%d"), GDS_S_GENERAL,
	      svc_c_sev_fatal, GDS_S_CACHE_HASH_SZ_ERR, cnt,
	      admptr->d22_desctab->d22_hmax_entries * sizeof (D22_hash_entry)) ;
	    return (D22_ERROR) ;
	} else {
	    /* remove existing 'stored in 1st level cache' flags */
	    for (i = 0, p2 = admptr->d22_hshtab;
			   i < admptr->d22_desctab->d22_hmax_entries; i++, p2++)
		p2->d22_state &= ~(D22_INSTORED | D22_IINDEXMASK) ;
	}
    }
    /* allocate memory for '1st level cache'-table */
    if ((admptr->d22_iobjtab = (D22_iobj_entry *) calloc
	((size_t) admptr->d22_desctab->d22_imax_entries,
		(size_t) sizeof (D22_iobj_entry))) == (D22_iobj_entry *) NULL) {
	d22_errno = D22_NOMEM_ERR ;
	dce_svc_printf (DCE_SVC (gds_svc_handle, "%d"), GDS_S_GENERAL,
	      svc_c_sev_warning, GDS_S_NOMEMORY,
	      admptr->d22_desctab->d22_imax_entries * sizeof (D22_iobj_entry)) ;
	return (D22_ERROR) ;
    }
    admptr->d22_iobjcnt = 0 ;

    /* allocate memory for DUA-cache reorganization work table */
    /* (one additional element is allocated for testing the right size */
    /* of the DUA-cache reorganization file on reading) */
    if ((admptr->d22_rorgtab = (D22_fmem_area *) malloc
	((size_t) (admptr->d22_desctab->d22_amax_areas + 1) *
			   sizeof (D22_fmem_area))) == (D22_fmem_area *) NULL) {
	d22_errno = D22_NOMEM_ERR ;
	dce_svc_printf (DCE_SVC (gds_svc_handle, "%d"), GDS_S_GENERAL,
	   svc_c_sev_warning, GDS_S_NOMEMORY,
	   (admptr->d22_desctab->d22_amax_areas + 1) * sizeof (D22_fmem_area)) ;
	return (D22_ERROR) ;
    }

    DCE_SVC_LOG ((DCE_SVC (gds_svc_handle, "%d%d%d%d%d"), GDS_S_GENERAL,
		  			svc_c_debug6, GDS_S_CACHE_CONTENT,
					admptr->d22_desctab->d22_nact_entries,
					admptr->d22_desctab->d22_pact_entries,
					admptr->d22_desctab->d22_ract_entries,
					admptr->d22_desctab->d22_fact_memsize,
					admptr->d22_desctab->d22_aact_areas)) ;

    /* set new active DUA-cache identifier */
    admptr->d22_act_cache_id = cache_id ;
    DCE_SVC_LOG ((DCE_SVC (gds_svc_handle, "%d"), GDS_S_GENERAL,
		  svc_c_debug1, GDS_S_CACHE_ACTIVE, admptr->d22_act_cache_id)) ;
    return (D22_OK) ;
}				
