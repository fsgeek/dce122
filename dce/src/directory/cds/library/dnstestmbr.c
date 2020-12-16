/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: dnstestmbr.c,v $
 * Revision 1.1.6.2  1996/02/18  19:34:49  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  18:14:53  marty]
 *
 * Revision 1.1.6.1  1995/12/08  15:26:29  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  14:47:00  root]
 * 
 * Revision 1.1.4.4  1994/06/30  19:17:41  mccann
 * 	sams cleanup drop2
 * 	[1994/06/30  19:03:18  mccann]
 * 
 * Revision 1.1.4.3  1994/06/09  18:42:20  devsrc
 * 	cr10871 - expand copyright
 * 	[1994/06/09  18:14:30  devsrc]
 * 
 * Revision 1.1.4.2  1994/04/29  15:55:12  peckham
 * 	Remove unnecessary conditionals.
 * 	Rename dns*() -> cds*().
 * 	[1994/04/29  14:28:04  peckham]
 * 
 * Revision 1.1.4.1  1994/03/12  22:07:59  peckham
 * 	DEC serviceability and i18n drop
 * 	[1994/03/12  14:33:19  peckham]
 * 
 * Revision 1.1.2.2  1992/12/30  14:16:16  zeliff
 * 	Embedding copyright notices
 * 	[1992/12/29  23:15:38  zeliff]
 * 
 * Revision 1.1  1992/01/19  15:18:31  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/* MODULE dnstestmbr.c
 *
 * COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1990-1994. ALL RIGHTS RESERVED.
 *
 * THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND  COPIED
 * ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH  LICENSE AND WITH THE
 * INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR  ANY  OTHER
 * COPIES  THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
 * OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF  THE  SOFTWARE  IS  HEREBY
 * TRANSFERRED.
 *
 * THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE  WITHOUT  NOTICE
 * AND  SHOULD  NOT  BE  CONSTRUED  AS  A COMMITMENT BY DIGITAL EQUIPMENT
 * CORPORATION.
 *
 * DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR  RELIABILITY  OF  ITS
 * SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.
 *
 */
  
#include <dce/dce.h>
#include <dce/cdsclerk.h>
#include <dcecdssvc.h>
#include <uc_parse.h>
#include <uc_clerk.h>     

/* ----------------------------------------------------------------------
 *  Check if group/member is a member of a group
 * ----------------------------------------------------------------------
 */
int 
cdsTestMbr (cds_full_name_t     *GroupName_p,
            cds_full_name_t     *MemberName_p,
            int                 *Direct_p,
            cds_timeout_t       *Timeout_p,
            cds_id_t            *LoopDetect_p,
            cdsFlagStat_t       *Flags_p)
{
    DEB_ASCII_BUF_dns_status(statusBuf)
    cds_full_name_t name;
    cds_full_name_t member;
    cds_id_t loop;
    cds_id_t *inLoopDetect_p = &loop;
    int Direct = BL_true;
    int status;

    DCE_SVC_DEBUG((
	cds__svc_handle,
	cds_svc_library,
	svc_c_debug3,
	" >cdsTestMbr()"));

    if (dns_validate_NameType(Flags_p->fsNameType) == cdsStrDCE) {
	if ((GroupName_p = cds_fulltoopq(GroupName_p, &name,
					 Flags_p)) == NULL) {
	    status = CDS_ERROR;
	    goto leave_cdsTestMbr;
	}
	if ((MemberName_p = cds_fulltoopq(MemberName_p, &member,
					  Flags_p)) == NULL) {
	    status = CDS_ERROR;
	    goto leave_cdsTestMbr;
	}
    }

    ZERO_ObjUID(&loop);

    if (Direct_p)
	if (!*Direct_p)
	     Direct = BL_false;

    if (LoopDetect_p)
	inLoopDetect_p = LoopDetect_p;

    PRM_build(OP_TestGroup, Flags_p);
      PRM_IN_FullName(GroupName_p);
      PRM_IN_FullName(MemberName_p);
      PRM_INOUT_BOOLEAN(Direct, Direct_p);
      PRM_OUT_Timeout(Timeout_p);
      PRM_INOUT_ObjUID(inLoopDetect_p, LoopDetect_p);
      PRM_RET_BOOLEAN(0);
    PRM_send(status);

leave_cdsTestMbr:

    DCE_SVC_DEBUG((
	cds__svc_handle,
	cds_svc_library,
	svc_c_debug3,
	" <cdsTestMbr() return(%s)",
	deb_ascii_dns_status(statusBuf,status)));

    return(status);
}
