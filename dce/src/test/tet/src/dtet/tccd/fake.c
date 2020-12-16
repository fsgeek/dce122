/*
 *      SCCS:  @(#)fake.c	1.2 (92/09/30) 
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1992 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 *
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifndef lint
static char sccsid[] = "@(#)fake.c	1.2 (92/09/30) DTET release 1.0b";
#endif

/************************************************************************

SCCS:   	@(#)fake.c	1.2 92/09/30
NAME:		fake.c
PRODUCT:	DTET (Distributed Test Environment Toolkit) release 1.0b
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	fake server-specific functions for tccd

MODIFICATIONS:

************************************************************************/

#include <sys/types.h>
#include "dtmsg.h"
#include "ptab.h"
#include "tccd.h"

/*
**	ss_timeout() - server-specific timeout processing
**
**	tccd does not set timeouts
*/

/* ARGSUSED */
void ss_timeout(pp)
struct ptab *pp;
{
	/* nothing */

	/* this bit just to keep lint happy - it has to go somewhere! */
#ifdef lint
	ti_lintstuff();
#endif
}

/*
**	ss_procrun() - server-specific end-procrun processing
*/

void ss_procrun()
{
	/* nothing */
}

