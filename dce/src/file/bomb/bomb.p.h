/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: bomb.p.h,v $
 * Revision 1.1.39.1  1996/10/02  17:03:14  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:04:39  damon]
 *
 * Revision 1.1.33.2  1994/06/09  13:51:43  annie
 * 	fixed copyright in src/file
 * 	[1994/06/08  21:25:16  annie]
 * 
 * Revision 1.1.33.1  1994/02/04  20:05:58  devsrc
 * 	Merged from 1.0.3a to 1.1
 * 	[1994/02/04  15:06:30  devsrc]
 * 
 * Revision 1.1.31.1  1993/12/07  17:12:41  jaffe
 * 	1.0.3a update from Transarc
 * 	[1993/12/06  13:33:18  jaffe]
 * 
 * $EndLog$
 */

/*
 * Copyright (C) 1993 Transarc Corporation - All rights reserved
 *
 * $Header: /u0/rcs_trees/dce/rcs/file/bomb/bomb.p.h,v 1.1.39.1 1996/10/02 17:03:14 damon Exp $
 */

#ifndef _TRANSARC_DFS_BOMB_H
#define _TRANSARC_DFS_BOMB_H

#include <dcedfs/stds.h>
#ifndef KERNEL
#include <dce/exc_handling.h>		/* get exc_int_t */
#endif

#if defined(AFS_DEBUG) && !defined(DFS_BOMB)
#define DFS_BOMB			/* Turn on bomb points if debugging */
#endif


/******************************************************************************
 * Constants
 *****************************************************************************/

/* Generic constants */
#define BOMB_ENV_VAR_NAME	"DFS_BOMB_POINTS"
#define BOMB_MAX_NAME		64

/* Bomb syscall opcode values */
#define BOMB_OP_SET	1
#define BOMB_OP_UNSET	2
#define BOMB_OP_TEST	99

/******************************************************************************
 * Types
 *****************************************************************************/
typedef enum bomb_explosionType {
    BOMB_EXP_TYPE_ABORT		= 0x00000001,
    BOMB_EXP_TYPE_DELAY		= 0x00000002,
    BOMB_EXP_TYPE_ERROR		= 0x00000004,
    BOMB_EXP_TYPE_IF		= 0x00000008,
    BOMB_EXP_TYPE_RETURN	= 0x00000010,
    BOMB_EXP_TYPE_WAIT		= 0x00000020

#ifndef KERNEL
    ,
    /* These are only valid outside the kernel */
    BOMB_EXP_TYPE_ERRNO		= 0x40000000,
    BOMB_EXP_TYPE_EXCEPTION	= 0x20000000,
    BOMB_EXP_TYPE_EXIT		= 0x10000000,
    BOMB_EXP_TYPE_SIGNAL	= 0x08000000
#endif
} bomb_explosionType_t;

#ifdef KERNEL
#define BOMB_EXP_TYPE_ALL	  0x0000003f
#else
#define BOMB_EXP_TYPE_ALL	  0x7800003f
#endif

typedef enum bomb_triggerType {
    BOMB_TRIG_TYPE_COUNTDOWN,
    BOMB_TRIG_TYPE_RANDOM,
    BOMB_TRIG_TYPE_TIMER
} bomb_triggerType_t;

typedef struct bombPoint {
    bomb_explosionType_t	bp_explosionType;
    union {
	/* 		none */		/* BOMB_EXP_TYPE_ABORT */
	unsigned long	bpev_delay;	/* BOMB_EXP_TYPE_DELAY */
	long		bpev_errorCode;	/* BOMB_EXP_TYPE_ERROR */
	/*		none */		/* BOMB_EXP_TYPE_IF */
	long		bpev_returnVal;	/* BOMB_EXP_TYPE_RETURN */
	/*		none */		/* BOMB_EXP_TYPE_WAIT */
#ifndef KERNEL
	unsigned char	bpev_errno;	/* BOMB_EXP_TYPE_ERRNO */
	exc_int_t	bpev_excVal;	/* BOMB_EXP_TYPE_EXCEPTION */
	int		bpev_exitVal;	/* BOMB_EXP_TYPE_EXIT */
	int		bpev_signal;	/* BOMB_EXP_TYPE_SIGNAL */
#endif	/* KERNEL */
    }				bp_explosionValue;
#define bp_delay	bp_explosionValue.bpev_delay
#define bp_errorCode	bp_explosionValue.bpev_errorCode
#define bp_returnVal	bp_explosionValue.bpev_returnVal
#ifndef KERNEL
#define bp_errno	bp_explosionValue.bpev_errno
#define bp_excVal	bp_explosionValue.bpev_excVal
#define bp_exitVal	bp_explosionValue.bpev_exitVal
#define bp_signal	bp_explosionValue.bpev_signal
#endif	/* KERNEL */
    
    bomb_triggerType_t		bp_triggerType;
    union {
	long		bptv_count;	/* BOMB_TRIG_TYPE_COUNTDOWN */
	unsigned long	bptv_random;	/* BOMB_TRIG_TYPE_RANDOM */
	struct timeval	bptv_timer;	/* BOMB_TRIG_TYPE_TIMER */
    }				bp_triggerValue;
#define bp_count	bp_triggerValue.bptv_count
#define bp_random	bp_triggerValue.bptv_random
#define bp_timer	bp_triggerValue.bptv_timer

    union {
	long		bptrv_count;	/* BOMB_TRIG_TYPE_COUNTDOWN */
	unsigned long	bptrv_random;	/* BOMB_TRIG_TYPE_RANDOM */
	struct timeval	bptrv_timer;	/* BOMB_TRIG_TYPE_TIMER */
    }				bp_triggerRefreshValue;
#define bp_refreshCount	 bp_triggerRefreshValue.bptrv_count
#define bp_refreshRandom bp_triggerRefreshValue.bptrv_random
#define bp_refreshTimer	 bp_triggerRefreshValue.bptrv_timer
}	bombPoint_t;

/******************************************************************************
 * Function prototypes
 *****************************************************************************/
extern long	bomb_Set(char*, bombPoint_t*);
extern long	bomb_Unset(char*);

#ifndef KERNEL

extern long	bomb_ParseDesc(char*, char*, bombPoint_t*);
extern long	bomb_SetDesc(char*);

extern long	bomb_Syscall(long opcode, long p1, long p2, long p3, long p4);

extern long	bomb_KernelSet(char*, bombPoint_t*);
extern long	bomb_KernelSetDesc(char*);
extern long	bomb_KernelUnset(char*);

#define BOMB_KERNEL_SET(bpName, bpP)	bomb_KernelSet((bpName), (bpP))
#define BOMB_KERNEL_SET_DESC(bpDesc)	bomb_KernelSetDesc(bpDesc)
#define BOMB_KERNEL_UNSET(bpName)	bomb_KernelUnset(bpName)
#define BOMB_KERNEL_TEST()		\
    bomb_Syscall(BOMB_OP_TEST, 0, 0, 0, 0)

#endif	/* KERNEL */

/******************************************************************************
 * Conditionally compiled declarations/macros
 *****************************************************************************/
#ifdef DFS_BOMB
/*
 * Bomb points are being compiled in.  The following macros produce live bombs!
 */

extern long	_bomb_Explode(char*, unsigned);
extern int	_bomb_ShouldExplode(char*, char*, int);

extern unsigned long	_bomb_active;	/* Count of active bomb points */

#define _BOMB(bpn, allowedExpTypes, defaultAction)			     \
    (_bomb_active && _bomb_ShouldExplode((bpn), __FILE__, __LINE__) ? 	     \
         _bomb_Explode((bpn), (allowedExpTypes))			     \
     	 : defaultAction)

#define BOMB_ELSE		else

#define BOMB_RETURN(bpn)						     \
    MACRO_BEGIN								     \
	if (_bomb_active && _bomb_ShouldExplode((bpn), __FILE__, __LINE__))  \
    	    return _bomb_Explode((bpn), BOMB_EXP_TYPE_RETURN);		     \
    MACRO_END

#define BOMB_SET(bpName, bpP)	bomb_Set((bpName), (bpP))
#define BOMB_UNSET(bpName)	bomb_Unset((bpName))
#ifndef KERNEL
#define BOMB_SET_DESC(bpDesc)	bomb_SetDesc((bpDesc))
#endif

#else	/* DFS_BOMB */
/*
 * Bomb points are being compiled out.  The following macros are duds.
 */

/* Just execute the default action */
#define _BOMB(bpn, allowedExpTypes, defaultAction)  defaultAction

#define BOMB_ELSE		else if (0)	/* Never execute */
#define BOMB_RETURN(bpn)			/* Do nothing */

#define BOMB_SET(bpName, bpP)			/* Do nothing */
#define BOMB_UNSET(bpName)			/* Do nothing */
#ifndef KERNEL
#define BOMB_SET_DESC(bpDesc)			/* Do nothing */
#endif

#endif	/* DFS_BOMB */

/******************************************************************************
 * Bomb point macros
 *****************************************************************************/
/*
 * The condidional definitions above do the hard work, so the macros below
 * do the right thing regardless of whether bomb points are being compiled in
 * or not.
 */

#ifdef KERNEL
/*
 * Define these just to avoid even more "#ifdef KERNEL" ugliness where
 * defining the `allowedExpTypes' masks below.
 */
#define BOMB_EXP_TYPE_ERRNO	0
#define BOMB_EXP_TYPE_EXCEPTION	0
#define BOMB_EXP_TYPE_EXIT	0
#define BOMB_EXP_TYPE_SIGNAL	0
#endif

#define BOMB_EXEC(bpn, expr)						     \
    _BOMB(bpn,								     \
	  BOMB_EXP_TYPE_ALL & ~(BOMB_EXP_TYPE_DELAY|BOMB_EXP_TYPE_IF	     \
				|BOMB_EXP_TYPE_RETURN|BOMB_EXP_TYPE_WAIT),   \
	  (expr))

#define BOMB_IF(bpn)							     \
    if (_BOMB(bpn,							     \
	      BOMB_EXP_TYPE_ABORT|BOMB_EXP_TYPE_EXCEPTION|BOMB_EXP_TYPE_EXIT \
	      |BOMB_EXP_TYPE_IF|BOMB_EXP_TYPE_SIGNAL,			     \
	      0))

#define BOMB_POINT(bpn)							     \
     _BOMB(bpn,								     \
	   BOMB_EXP_TYPE_ALL & ~(BOMB_EXP_TYPE_ERRNO|BOMB_EXP_TYPE_ERROR     \
				 |BOMB_EXP_TYPE_IF|BOMB_EXP_TYPE_RETURN),    \
	   0)


#endif	/* _TRANSARC_DFS_BOMB_H */
