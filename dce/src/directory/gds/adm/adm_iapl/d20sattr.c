/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: d20sattr.c,v $
 * Revision 1.1.10.2  1996/02/18  19:38:58  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  18:19:56  marty]
 *
 * Revision 1.1.10.1  1995/12/08  15:12:20  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  14:50:08  root]
 * 
 * Revision 1.1.8.2  1994/03/23  15:03:07  keutel
 * 	March 1994 code drop
 * 	[1994/03/21  16:02:48  keutel]
 * 
 * Revision 1.1.8.1  1994/02/22  15:56:36  marrek
 * 	Code drop for dce1.1.
 * 	[1994/02/08  09:16:02  marrek]
 * 
 * Revision 1.1.6.2  1993/08/10  08:49:14  marrek
 * 	July 1993 code drop.
 * 	[1993/07/30  08:11:10  marrek]
 * 
 * Revision 1.1.4.4  1992/12/31  17:46:06  bbelch
 * 	Embedding copyright notice
 * 	[1992/12/31  12:59:23  bbelch]
 * 
 * Revision 1.1.4.3  1992/11/27  13:40:20  marrek
 * 	November 1992 code drop
 * 	[1992/11/26  09:02:27  marrek]
 * 
 * Revision 1.1.4.2  1992/09/23  09:46:14  marrek
 * 	Align d23_avoff = D2_ALIGN(len); .
 * 	[1992/09/23  09:42:47  marrek]
 * 
 * Revision 1.1.2.2  1992/06/01  21:35:14  zeliff
 * 	New version of file from GDS drop
 * 	[1992/05/28  19:08:42  zeliff]
 * 
 * $EndLog$
 */
#if !defined(lint) && defined(GDS_RCS_ID)
static char rcsid[] = "@(#)$RCSfile: d20sattr.c,v $ $Revision: 1.1.10.2 $ $Date: 1996/02/18 19:38:58 $";
#endif

/****************************************************************************
*                                                                           *
*         COPYRIGHT  (C)  SIEMENS NIXDORF INFORMATIONSSYSTEME AG 1991       *
*                                ALL RIGHTS RESERVED                        *
*                                                                           *
****************************************************************************/

/*daton **********************************************************************/
/*                                                                           */
/*  FUNCTION:  d20_insert_attr()                                             */
/*                                                                           */
/*  SHORT DESCRIPTION:                                                       */
/*      The function converts one attribute into the queue-format            */
/*      used at the IAPL-interface of the directory system V2. The caller    */
/*      is able to control the way in which the conversion is done by a      */
/*      special parameter.                                                   */
/*                                                                           */
/*  INPUT-PARAMETER:                                                         */
/*      optype      = Operation mode:                                        */
/*                    The operation mode is controlled by a 'bit field'-     */
/*                    mask, where a specific mask can be generated by ORing  */
/*                    the following 'bit field'-values:                      */
/*                    D20__BEGIN     = Initialize attribute output queue     */
/*                                     resp. attribute output list.          */
/*                    D20__CONTINUE  = Insert given attribute informations   */
/*                                     into attribute output queue resp.     */
/*                                     attribute output list.                */
/*                    D20__END       = Terminate attribute output queue.     */
/*                                                                           */
/*                    Typical function call sequences are:                   */
/*                    *  D20__BEGIN | D20__CONTINUE | D20__END               */
/*                       (conversion is done by using only one function call)*/
/*                                                                           */
/*                    *  D20__BEGIN | D20__CONTINUE                          */
/*                       ... D20_BEGIN ...                                   */
/*                       D20__CONTINUE | D20__END                            */
/*                       (conversion is done by using several function calls)*/
/*                                                                           */
/*      type        = pointer to attribute type                              */
/*      len         = attribute length                                       */
/*      rep         = attribute representation                               */
/*      val         = pointer to attribute value                             */
/*                                                                           */
/*                    Note: An attribute is converted as a recurring attri-  */
/*                    bute, if continuous entries in the array contain the   */
/*                    same attribute type (means, the information of each    */
/*                    of this entries corresponds to one attribute value     */
/*                    of the recurring attribute).                           */
/*	at_val_area = area where attribute values are stored by function     */
/*		      which generates D2_a_value structure from val. string  */
/*                                                                           */
/*  OUTPUT-PARAMETER:                                                        */
/*      info        = Converted attribute(s).                                */
/*                                                                           */
/*  RETURN-VALUE:                                                            */
/*                    D2_NOERROR no error in allocating memory		     */
/*                    D2_ERROR	 error in allocating memory		     */
/*                                                                           */
/* ------------------------------------------------------------------------- */
/*  AUTHOR: W.Schmid                                      DATE: 4.5.88       */
/*datoff *********************************************************************/

#include <gds.h>
#include <stdlib.h>

#include <dce/d2dir.h>
#include <dce/d27util.h>
#include <d2info.h>
#include <d2dump.h>
#include <d23apdu.h>
#include <d21dua.h>
#include <d20proto.h>

/* -------------------- declaration of global data ------------------------- */

extern Ds_v2_info	info ;	/* common IAPL-interface parameter block */

/* ------------------------------------------------------------------------- */


 d2_ret_val d20_insert_attr (
   signed16     optype,
   D2_a_type   *type,
   signed16     len,
   unsigned16   rep,
   char        *val,
   char       **at_val_area)
{
static Bool             first_entry ;
static D2_a_info       *d20_aiptr ;
static D2_a_value      *d20_avptr ;
static D2_a_type        last_type ;
char		      *attr_val, *sav_attr_val;

/* generate attribute value in the format as in the APDU.	*/
if ((attr_val = (char *)malloc(len + D23_S_ATV)) == (char *)NULL)
	return(D2_ERROR);

sav_attr_val = attr_val;

((D23_av_value *)attr_val)->d23_avlen = len;
((D23_av_value *)attr_val)->d23_avoff = D2_ALIGN(len);
((D23_av_value *)attr_val)->d23_avrep = rep;
memcpy(attr_val + D23_S_ATV, val, len);

if ((optype & D20__BEGIN) == D20__BEGIN)
   {                    /* initialize attribute entry queue */
     d20_aiptr = info.attrinfo ;
     d20_avptr = info.avalinfo ;
     first_entry = TRUE ;
   }

if ((optype & D20__CONTINUE) == D20__CONTINUE)
   {                    /* insert information into attribute entry queue */
     if ((!first_entry) && (D27_ATTCMP(type,&last_type)!=0))
	{               /* new attribute -> go to next attribute entry */
	  d20_aiptr->d2_a_next = d20_aiptr + 1 ;
	  d20_aiptr++ ;
	}

     if ((!first_entry) && (D27_ATTCMP(type,&last_type)==0))
	{               /* increment recurring attribute counter */
	  d20_aiptr->d2_a_no_val++ ;
	}
     else
	{               /* insert attribute information */
	  d20_aiptr->d2_a_type.d2_type = last_type.d2_type = type->d2_type ;
	  d20_aiptr->d2_a_type.d2_typ_len = last_type.d2_typ_len = 
					    type->d2_typ_len;
	  d20_aiptr->d2_a_no_val = 1 ;
	  d20_aiptr->d2_a_val = d20_avptr ;
	  first_entry = FALSE ;
	}
			/* insert attribute value information */
     d21_ca_aval_iput(d20_avptr,&attr_val,at_val_area);
     d20_avptr++;
   }

if ((optype & D20__END) == D20__END)
   {                    /* terminate attribute entry queue */
     if (first_entry)
			/* mark empty attribute queue */
	d20_aiptr->d2_a_val = (D2_a_value *) NULL ;
     else
	d20_aiptr->d2_a_next = (D2_a_info *) NULL ;
   }

free(sav_attr_val);
return(D2_NOERROR);

}
