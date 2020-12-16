/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: com_locks.h,v $
 * Revision 1.1.56.1  1996/10/02  17:52:56  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:41:20  damon]
 *
 * $EndLog$
 */
/*
 * Copyright (C) 1994, 1990 Transarc Corporation
 * All rights reserved.
 */

/*			    Episode File System
		   Data structures used in record locking
 */

/* $Header: /u0/rcs_trees/dce/rcs/file/kutils/com_locks.h,v 1.1.56.1 1996/10/02 17:52:56 damon Exp $ */

#ifndef TRANSARC_COM_LOCKS_H
#define TRANSARC_COM_LOCKS_H

#include <dcedfs/lock.h>
#include <dcedfs/queue.h>
#include <fcntl.h>

struct record_lock {
    struct squeue links;		/* must be first field */
    struct flock data;			/* locking process and record */
    union {
	struct record_lock *blocker;	/* if waiting, points to blocker */
	int blocking;			/* if not waiting, true if blocking */
    } un;
};

/*
   The following field definition is cheating:  the end of the record is
   more useful to us than the length, so we overwrite the length field of
   the flock in the record lock with an end field.
*/

#define data_end data.l_len

/*
   The following definitions depend on the links being the first field.
*/

#define QTORL(q)	((struct record_lock *) (q))
#define RLTOQ(r)	((struct squeue *) (r))

/* Exported functions */

extern int vnl_init(int nrlocks);
extern void vnl_idset(struct flock *flock);
extern void vnl_ridset(struct flock *flock);	/* remote version */
extern int vnl_blocked(
    struct flock *flock,
    int end,
    struct squeue *rllist,
    struct record_lock **blockerP,
    struct squeue **markerP);
extern int vnl_adjust(
    struct flock *flock,
    int *end,
    struct squeue *oldmarker,
    struct squeue *rllist,
    struct squeue **markerP
);
extern int vnl_alloc(
    struct flock *flock,
    int end,
    struct record_lock **rlockP
);
extern void vnl_cleanup(struct squeue *rllist);
extern int vnl_sleep(
    struct flock *flock,
    int end,
    struct record_lock *blocker,
    osi_dlock_t *vnlock
);

#endif /* TRANSARC_COM_LOCKS_H */
