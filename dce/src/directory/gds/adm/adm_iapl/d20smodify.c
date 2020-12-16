/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: d20smodify.c,v $
 * Revision 1.1.10.2  1996/02/18  19:39:01  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  18:19:59  marty]
 *
 * Revision 1.1.10.1  1995/12/08  15:12:30  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  14:50:11  root]
 * 
 * Revision 1.1.8.2  1994/03/23  15:03:09  keutel
 * 	March 1994 code drop
 * 	[1994/03/21  16:02:57  keutel]
 * 
 * Revision 1.1.8.1  1994/02/22  15:56:39  marrek
 * 	Code drop for dce1.1.
 * 	[1994/02/08  09:16:12  marrek]
 * 
 * Revision 1.1.6.2  1993/08/10  08:51:38  marrek
 * 	July 1993 code drop.
 * 	[1993/07/30  08:11:42  marrek]
 * 
 * Revision 1.1.4.4  1992/12/31  17:46:12  bbelch
 * 	Embedding copyright notice
 * 	[1992/12/31  12:59:31  bbelch]
 * 
 * Revision 1.1.4.3  1992/11/27  13:40:55  marrek
 * 	November 1992 code drop
 * 	[1992/11/26  09:02:38  marrek]
 * 
 * Revision 1.1.4.2  1992/09/23  09:52:17  marrek
 * 	Alignment for ((D23_av_value *)attr_val1)->d23_avoff = D2_ALIGN(len1);
 * 	and ((D23_av_value *)attr_val2)->d23_avoff = D2_ALIGN(len2);
 * 	[1992/09/23  09:51:02  marrek]
 * 
 * Revision 1.1.2.2  1992/06/01  21:35:38  zeliff
 * 	New version of file from GDS drop
 * 	[1992/05/28  19:08:54  zeliff]
 * 
 * $EndLog$
 */
#if !defined(lint) && defined(GDS_RCS_ID)
static char rcsid[] = "@(#)$RCSfile: d20smodify.c,v $ $Revision: 1.1.10.2 $ $Date: 1996/02/18 19:39:01 $";
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
/* NAME         : d20smodify.c                                        */
/*								      */
/* AUTHOR       : Volpers, D AP 11                                    */
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
/*  FUNCTION:  d20_insert_modify ()                                          */
/*                                                                           */
/*  SHORT DESCRIPTION:                                                       */
/*      The function converts one or more attributes, which will be modified */
/*      and which are given in a format used by the  administration, into a  */
/*      'queue'-format used at the IAPL-interface of the directory system V2.*/
/*      The caller is able to control the way in which the conversion is     */
/*      done by a special parameter.                                         */
/*                                                                           */
/*  INPUT-PARAMETER:                                                         */
/*      opmode      = Operation mode:                                        */
/*                    The operation mode is controlled by a 'bit field'-     */
/*                    mask, where a specific mask can be generated by ORing  */
/*                    the following 'bit field'-values:                      */
/*                    D20__BEGIN    = initialize attribute output queue.     */
/*                    D20__CONTINUE = insert given attribute informations to */
/*                                  attribute output queue.                  */
/*                    D20__END    = terminate attribute output queue.        */
/*                                                                           */
/*      type1       = pointer to attribute type    old value for replace     */
/*      len1        = attribute length                       and delete)     */
/*      rep1        = attribute value representation                         */
/*      val1        = pointer to attribute value                             */
/*                                                                           */
/*      type2       = pointer to attribute type    new value, for replace    */
/*      len2        = attribute length                        and add)       */
/*      rep2        = attribute value representation                         */
/*      val2        = pointer to attribute value                             */
/*                                                                           */
/*                                                                           */
/*                    The following modification modes are allowed:          */
/*                       D2_REP_AV = replace attribute value.                */
/*                       D2_ADD_AV = add attribute value.                    */
/*                       D2_DEL_AV = delete attribute value.                 */
/*                       D2_ADDATT = add attribute                           */
/*                       D2_DELATT = delete attribute                        */
/*                    Note: Two continuous attribute entries correspond al-  */
/*                    ways to a convertible attribute, where the first con-  */
/*                    tains information about the old attribute value and    */
/*                    the second contains information about the new attri-   */
/*                    bute value.                                            */
/* 	at_val_area = area to store attribute values. This is used by the    */
/*		      function which generates D2_a_value structure from val.*/
/*		      string.						     */
/*                                                                           */
/*                                                                           */
/*  OUTPUT-PARAMETER:                                                        */
/*      info        = Converted 'modify' attribute(s).                       */
/*                                                                           */
/*  RETURN-VALUE:                                                            */
/*	D2_NOERROR	no error in allocating memory.			     */
/*	D2_ERROR	error in allocating memory.			     */
/*                                                                           */
/* ------------------------------------------------------------------------- */
/*  AUTHOR: H.Volpers                                     DATE: 4.5.88       */
/*exoff **********************************************************************/

#include <gds.h>
#include <stdio.h>
#include <stdlib.h>

#include <dce/d2dir.h>
#include <d2info.h>
#include <d2dump.h>
#include <d23apdu.h>
#include <d21dua.h>
#include <d20proto.h>

extern Ds_v2_info 	info ;	/* common IAPL-interface parameter block */

/* ------------------------------------------------------------------------- */


 d2_ret_val d20_insert_modify (
   signed16       optype,
   signed16       opmode,
   D2_a_type     *type1,
   signed16       len1,
   unsigned16     rep1,
   Octet_string   val1,
   D2_a_type     *type2,
   signed16       len2,
   unsigned16     rep2,
   Octet_string   val2,
   char	        **at_val_area)

{
	static D2_a_modinf	*d20_miptr ;
	static D2_a_value	*d20_avptr ;
	char		      *attr_val1,*sav_attr_val1;
	char		      *attr_val2,*sav_attr_val2;

/* generate attribute value1 in the format as in the APDU.	*/
if ((attr_val1 = (char *)malloc(len1 + D23_S_ATV)) == (char *)NULL)
	return(D2_ERROR);

sav_attr_val1 = attr_val1;

((D23_av_value *)attr_val1)->d23_avlen = len1;
((D23_av_value *)attr_val1)->d23_avoff = D2_ALIGN(len1);
((D23_av_value *)attr_val1)->d23_avrep = rep1;
memcpy(attr_val1 + D23_S_ATV, val1, len1);

/* generate attribute value2 in the format as in the APDU.	*/
if ((attr_val2 = (char *)malloc(len2 + D23_S_ATV)) == (char *)NULL)
	return(D2_ERROR);

sav_attr_val2 = attr_val2;

((D23_av_value *)attr_val2)->d23_avlen = len2;
((D23_av_value *)attr_val2)->d23_avoff = D2_ALIGN(len2);
((D23_av_value *)attr_val2)->d23_avrep = rep2;
memcpy(attr_val2 + D23_S_ATV, val2, len2);

	if ((optype & D20__BEGIN) == D20__BEGIN) {
		/* initialize modify attribute entry queue */
		d20_miptr = info.modinfo ;
		d20_avptr = info.avalinfo ;
	}

	if ((optype & D20__CONTINUE) == D20__CONTINUE) {
		/* insert attribute information into modify attribute entry queue */
		d20_miptr->d2_m_next = d20_miptr + 1 ;

		d20_miptr->d2_m_attr.d2_a_no_val = 1;
		d20_miptr->d2_m_mod = opmode ;
		d20_miptr->d2_m_attr.d2_a_type.d2_type = type1->d2_type;
		d20_miptr->d2_m_attr.d2_a_type.d2_typ_len = type1->d2_typ_len;

		if (opmode != D2_DELATT)
			{
			d20_miptr->d2_m_attr.d2_a_val = d20_avptr ;
     			d21_ca_aval_iput(d20_avptr,&attr_val1,at_val_area);
			d20_avptr++;

			if (opmode == D2_REP_AV)
				{
				if (rep2 == D2_INT_LIST)
					{
		        		d20_miptr->d2_m_mod = D2_DELATT;
					d20_miptr->d2_m_attr.d2_a_no_val = 0;

					d20_miptr++;
					
					d20_miptr->d2_m_next = d20_miptr + 1 ;

					d20_miptr->d2_m_mod = D2_ADDATT;
					d20_miptr->d2_m_attr.d2_a_next = 
							(D2_a_info *)NULL;
					d20_miptr->d2_m_attr.d2_a_type.d2_type =
					type2->d2_type ;
					d20_miptr->d2_m_attr.d2_a_type.
					d2_typ_len = type2->d2_typ_len ;

					d20_miptr->d2_m_attr.d2_a_no_val = 1;
					d20_miptr->d2_m_attr.d2_a_val = 
								d20_avptr;
					d21_ca_aval_iput(d20_avptr,&attr_val2,
							at_val_area);
					d20_avptr++;
					}
				else
					{
					d20_miptr->d2_m_attr.d2_a_no_val = 2;
					d21_ca_aval_iput(d20_avptr,&attr_val2,
							at_val_area);
					d20_avptr++;
					}
				}	
			}
		else
		    {
		     d20_miptr->d2_m_attr.d2_a_no_val = 0;
		     d20_miptr->d2_m_attr.d2_a_val = NULL;
		    }

		  d20_miptr++;
	}

	if ((optype & D20__END) == D20__END)
		/* terminate modify attribute entry list */
		(d20_miptr - 1)->d2_m_next = (D2_a_modinf *) NULL ;

free(sav_attr_val1);
free(sav_attr_val2);
return(D2_NOERROR);

}