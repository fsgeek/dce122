/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: ubik.p.h,v $
 * Revision 1.1.23.1  1996/10/02  17:56:00  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:42:47  damon]
 *
 * $EndLog$
 */

#ifndef UBIK_H_
#define UBIK_H_ 1

#ifndef	KERNEL
#if !defined(lint) && !defined(LOCORE) && defined(RCS_HDRS)
static char *rcsidlock = "$Header: /u0/rcs_trees/dce/rcs/file/ncsubik/ubik.p.h,v 1.1.23.1 1996/10/02 17:56:00 damon Exp $";
#endif

/*
 * P_R_P_Q_# (C) COPYRIGHT IBM CORPORATION 1987, 1989
 * LICENSED MATERIALS - PROPERTY OF IBM
 * REFER TO COPYRIGHT INSTRUCTIONS FORM NUMBER G120-2083
 */

#include <dce/rpc.h>
#include <dce/rgybase.h>
#include <dcedfs/osi.h>
#include <dcedfs/lock.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <dcedfs/ubik_data.h>

/* ubik_trans types */
#define	UBIK_READTRANS	    0
#define	UBIK_WRITETRANS	    1

/* ubik_lock types */
#define	LOCKREAD	    1
#define	LOCKWRITE	    2

#define	UBIK_MAGIC	0x354545
/* flags for ubik_Call */
#define UF_SINGLESERVER         1       /* begin single server operation */
#define UF_END_SINGLESERVER     2       /* terminate single server operation */
					/* not used in new ubik call */
#define UF_SYNC_SITE		4	/* send request to sync site */

/* Ubik Object type UUID
 * For every distinct Ubik database, there is an object type UUID
 */
extern uuid_t Budb_UbikObjectTypeUuid;
extern uuid_t Fldb_UbikObjectTypeUuid;

/* global ubik parameters */
#define	UBIK_MAXSERVERS		20	/* max number of servers */
#define	UBIK_MAXBINDINGS	60	/* must be >= MAXSERVERS */
#define UBIK_MAXADDRS		4	/* network interfaces handled */
#define UBIK_MAXBULK		64	/* default max entries in bulk update */
#define UBIK_PROVIDER_VERSION	2	/* this server's provider version */

/* version comparison macro */
#define vcmp(a,b) ((a).epoch == (b).epoch? ((a).counter - (b).counter) : ((a).epoch - (b).epoch))

/* ubik_client state bits */
#define	CFLastFailed	    1		/* last call failed to this guy */
					/* (to detect down hosts) */
#define CFAuthBinding       2           /* Server has a valid binding */
#define CFAuthDone          4           /* Server has been authenticated */
/*
 * ubik binding state bits
 */

#define BFAuthPass	    1		/* binding has been authenticated */
#define BFAuthFail	    2		/* binding authentication failed   */

/* per-client structure for ubik
 * The actual principal name for authentication is constructed by concatenating
 * three components:
 *	1) the cellName string, e.g. /.../cellname
 *	2) the string in the principals array, e.g. hosts/<hostname>
 *	2) the invariant string "/dfs-server"
 */

struct ubik_client {
    short states[UBIK_MAXSERVERS];	/* state bits */
    char *cellName;			/* prefix for principals */
    long nServers;			/* for principals & conns */
    long nAuthHosts;			/* count hosts whose bindings have */
					/* all been tried so we know when we */
					/* are done authenticating bindings */
    char *secGroup;			/* security group name */
    char *principals[UBIK_MAXSERVERS];	/* host names for conns */
    char *fullname[UBIK_MAXSERVERS];	/* full name of principals for conns */
    uuid_t realmUuid[UBIK_MAXSERVERS];	/* server realm UUID */
    uuid_t princUuid[UBIK_MAXSERVERS];	/* server principal UUID */
    rpc_binding_handle_t conns[UBIK_MAXSERVERS][UBIK_MAXADDRS];
					/* binding handles for servers */
    unsigned long addrs[UBIK_MAXSERVERS][UBIK_MAXADDRS];
					/* IP addresses for servers */
    char authflag[UBIK_MAXSERVERS][UBIK_MAXADDRS];
					/* set when binding is authenticated */
    sec_rgy_handle_t rgyHandle;		/* registry server context handle */
    long rgyValid;			/* set if rgyHandle is valid */
    long pver[UBIK_MAXSERVERS];		/* server provider version level */
    long flags;				/* client state flags */
    long selectedServer;		/* server selected for RPC calls */
    long syncSite;			/* last known sync site server */
};

#define	ubik_GetRPCConn(astr,aindex)	((aindex) >= UBIK_MAXSERVERS? 0 : (astr)->conns[aindex])
#define	ubik_GetRPCHost(astr,aindex)	((aindex) >= UBIK_MAXSERVERS? 0 : (astr)->hosts[aindex])

/* ubik transaction id representation */
struct ubik_tid {
    long epoch;	    /* time this server started */
    long counter;   /* counter within epoch of transactions */
};

/* ubik version representation */
struct ubik_version {
    long epoch;	    /* time this server started */
    long counter;   /* counter within epoch of transactions */
};

/* ubik header file structure */
struct ubik_hdr {
    long magic;		    /* magic number */
    short pad1;		    /* some 0-initd padding */
    short size;		    /* header allocation size */
    struct ubik_version	version;    /* the version for this file */
};

/* representation of a ubik transaction */
struct ubik_trans {
    long allocsize;		    /* memory allocated for transaction */
    struct ubik_dbase *dbase;	    /* corresponding database */
    struct ubik_trans *next;	    /* in the list */
    struct ubik_lock *activeLocks;
    struct ubik_trunc *activeTruncs;/* queued truncates */
    struct ubik_tid tid;	    /* transaction id of this trans (if write trans.) */
    long minCommitTime;		    /* time before which this trans can't commit */
    long seekFile;		    /* seek ptr: file number */
    long seekPos;		    /* seek ptr: offset therein */
    short flags;		    /* trans flag bits */
    char type;			    /* type of trans */
    /* we use two write vectors for Async RPC */
    ubik_bulk_update *bulk;	    /* current transaction write vector */
    long nbulk;			    /* number entries in current write vector */
    ubik_bulk_update *rpc_bulk;	    /* rpc transaction write vector */
    long rpc_nbulk;		    /* number entries in rpc write vector */
    int RpcRunning;		    /* set while async RPC in progrss */
    int RpcFlag;		    /* set when remote hosts begin trans */
};

/* representation of a truncation operation */
struct ubik_trunc {
    struct ubik_trunc *next;
    long file;			    /* file to truncate */
    long length;		    /* new size */
};

/* representation of ubik byte-range lock */
struct ubik_lock {
    struct ubik_lock *next;	/* next lock same trans */
    long start;			/* byte range */
    long length;
    char type;			/* read or write lock */
    char flags;			/* useful flags */
};

struct ubik_stat {
    long size;
    long mtime;
};

/* 
 * representation of a ubik database.  Contains info on low-level disk access 
 * routines for use by disk transaction module.
 *
 * The tidCounter field holds the counter part of the transaction ID of the 
 * last transaction on this server. This gets bumped by 2 for any read or
 * write transaction. The writeTidCounter field holds the tid of the last
 * write transaction. The writeTidCounter is shipped across beacons and is used
 * in deleting old and obsolete write transactions still pending on a non-sync
 * site.
 */
struct ubik_dbase {
    char *pathName;		    /* root name for dbase */
    struct ubik_trans *activeTrans; /* active transaction list */
    struct ubik_version	version;    /* version number */
    osi_dlock_t versionLock;  	    /* lock on version number */
    long tidCounter;		    /* last RW or RO trans tid counter */
    long writeTidCounter;	    /* last write trans tid counter */
    long flags;			    /* flags */
    int	(*read)();		    /* physio procedures */
    int (*write)();
    int (*truncate)();
    int (*sync)();
    int (*stat)();
    int (*open)();
    int	(*setlabel)();		    /* set the version label */
    int	(*getlabel)();		    /* retrieve the version label */
    int	(*getnfiles)();		    /* find out number of files */
    short readers;		    /* number of current read transactions */
    struct ubik_version	cachedVersion; /* version of caller's cached data */
};

/*
 * The ubik_binding_vector_t structure holds binding handles to ubik servers.
 * It can handle cases where there could be multiple binding handles to a given
 * ubik server. This structure is returned after looking through the CDS name
 * space and can then be used to construct the ubik_client and ubik_server
 * structures.
 */
typedef struct ubik_binding_vector_t {
  long count;				  	/* count of ubik servers */
  struct ubik_bv_server_t {			/* struct per ubik server */
    long count;					/* count of handles / server */
    rpc_binding_handle_t binding_h[UBIK_MAXADDRS]; /* binding handles/server */
  } *s;
} ubik_binding_vector_t;


/****************EXPORTED INTERFACES ****************/

extern int register_ubik_dfs_server _TAKES((rpc_if_handle_t, rpc_mgr_epv_t,
					   uuid_t *, uuid_t *, char *, 
					   unsigned32 *));
extern int ubik_ServerInit _TAKES((struct sockaddr_in *, rpc_if_handle_t, 
				   rpc_mgr_epv_t, unsigned_char_t *, 
				   unsigned_char_t *, unsigned_char_t *, 
				   uuid_t *, uuid_t *, unsigned32, char *, 
				   char *, struct ubik_dbase **));
extern int ubik_BeginTrans _TAKES((struct ubik_dbase *, long, 
				   struct ubik_trans **));
extern int ubik_BeginTransReadAny _TAKES((struct ubik_dbase *, long, 
					  struct ubik_trans **));
extern int ubik_AbortTrans _TAKES((struct ubik_trans *));
extern int ubik_EndTrans _TAKES((struct ubik_trans *));
extern int ubik_Read _TAKES((struct ubik_trans *, char *, long));
extern int ubik_Write _TAKES((struct ubik_trans *, char *, long));
extern int ubik_Seek _TAKES((struct ubik_trans *, long, long));
extern int ubik_Tell _TAKES((struct ubik_trans *, long *, long *));
extern int ubik_Truncate _TAKES((struct ubik_trans *, long));
extern int ubik_SetLock _TAKES((struct ubik_trans *, long, long, int));
extern int ubik_CacheUpdate _TAKES((struct ubik_trans *));
extern int ubik_ClientInit _TAKES((rpc_if_handle_t, unsigned_char_t *, 
				   unsigned_char_t *, int, int, int,
				   struct ubik_client **));
extern long ubik_ClientCleanup _TAKES(());
extern int ubik_ParseClientList _TAKES((int, char **, struct sockaddr_in *,
					long *));

/****************INTERNALS BELOW ****************/

#ifdef UBIK_INTERNALS

/* name service entry syntax */
#define DFS_ENTRY_SYNTAX        rpc_c_ns_syntax_dce

/*
 * The following two macros are to placed around each outgoing RPC call in the
 * ubik server. These macros have two purposes. One is to catch ticket 
 * expirations, and refresh local auth context before retrying the RPC. The
 * ubik server runs under the dfs-server principal identity and uses a locally
 * stored auth context. This context has a certain life time, and should be
 * refreshed as soon as it expires to be able to use it. This failure should
 * be hidden from servers that use the ubik functionality. 
 * The second purpose of this macro is to catch any exceptions generated by the
 * rpc runtime and directed at this client thread making the RPC. This would
 * prevent unanticipated thread cancellations that could leave ubik resources
 * in an unstable state. 
*/

#define UBIK_RPC_PREWRAP {			\
    int rpc_attempts, retry_rpc, dfsauthRtn; 	\
    rpc_attempts = dfsauthRtn = 0; 		\
    retry_rpc = 1; 				\
    while (retry_rpc) { 			\
      retry_rpc = 0; 				\
      rpc_attempts++;				\


#define UBIK_RPC_POSTWRAP(error_status)					\
          if (error_status == rpc_s_auth_tkt_expired)  {       		\
            if (rpc_attempts == 1) { 					\
              dfsauthRtn = dfsauth_client_RefreshLocalAuthContext(); 	\
              if (!dfsauthRtn) retry_rpc = 1; 				\
              else {							\
	         retry_rpc = 0;				  		\
		 error_status = dfsauthRtn;				\
	      }								\
            }								\
          }								\
      }} /*while*/							\


/* some ubik parameters */
#define	UBIK_PAGESIZE	    	1024	/* fits in current r packet */
#define	UBIK_LOGPAGESIZE    	10	/* base 2 log thereof */
#define	UBIK_NBUFFERS	    	20	/* number of 1K buffers */
#define	UBIK_HDRSIZE	    	64	/* bytes of header per dbfile */
#define UBIK_THREAD_POOL_SIZE	10	/* 10 threads for ubik */
#define UBIK_TRYLOCK_MAXTRIES	10	/* tries to obtain ubik lock */

/* define time (in seconds) a beacon thread can sleep before it is reaped */
#define UBIK_THREADENNUI	5*60
/* define time (in seconds) tpq can delay executing the element in parset */
#define UBIK_VOTE_GRACEPERIOD	0 	/* tight constraints on execution */
#define UBIK_PROBE_GRACEPERIOD  5
#define UBIK_DISK_RPC_GRACEPERIOD 0	/* performance counts */


/* ubik_dbase flags */
#define	DBWRITING	    	1	/* are any write trans. in progress */

/* ubik trans flags */
#define	TRDONE		    	1	/* commit or abort done */
#define	TRABORT		    	2	/* if TRDONE, tells if aborted */
#define TRREADANY	    	4	/* read any data available in trans */

/* ubik_lock flags */
#define	LWANT		    1

/* ubik system database numbers */
#define	LOGFILE		    (-1)

/* define log opcodes */
#define	LOGNEW		    100	    /* start transaction */
#define	LOGEND		    101	    /* commit (good) end transaction */
#define	LOGABORT	    102	    /* abort (fail) transaction */
#define	LOGDATA		    103	    /* data */
#define	LOGTRUNCATE	    104	    /* truncate operation */

/* time constant for replication algorithms: the R time period is 20 seconds. 
   Both SMALLTIME and BIGTIME must be larger than 
   RPCTIMEOUT+max(RPCTIMEOUT,POLLTIME), so that timeouts do not prevent us 
   from getting through to our servers in time.

   We use multi-R to time out multiple down hosts concurrently.
   The only other restrictions:  BIGTIME > SMALLTIME and
   BIGTIME-SMALLTIME > MAXSKEW (the clock skew).
 */

/* these are bogus #s just to get us by the 36 second rpc timout period we 
   have now */
#define MAXSKEW	40
#define POLLTIME 15
#define RPCTIMEOUT 40
#define BIGTIME 140
#define SMALLTIME 90

#ifdef notdef
/* these are the #s we want, but right now, rpc timeouts don't work */
#define MAXSKEW	10
#define POLLTIME 15
#define RPCTIMEOUT 20
#define BIGTIME 75
#define SMALLTIME 60
#endif  /*notdef*/

/* ubik_pipeState contains the information shared with ubik when
 * dealing with pipes for transferring files.
 */
struct ubik_pipeState {
    long offset;			/* offset we're at now */
    long allocBytes;			/* bytes allocated in buffer */
    long xfrBytes;			/* bytes to transfer, when sending (pull) */
    struct ubik_dbase *dbase;		/* database to write with */
    long error;				/* store pipe errors */
};

#define UBIK_PIPESTATE_STARTLABEL	1	/* labelled at start */
#define UBIK_PIPESTATE_ENDLABEL		2	/* labelled at end */

/* the per-server state, used by the sync site to keep track of its charges */
struct ubik_server {
    struct ubik_server *next;		/* next ptr */
    unsigned long addr;			/* network order host addr */
    long lastVoteTime;			/* last time yes vote received */
    long lastBeaconSent;		/* last time beacon attempted */
    struct ubik_version	version;	/* version, only used during recovery*/
    long bindingCount;			/* count of bindings in arrays */
    rpc_binding_handle_t voteCid[UBIK_MAXADDRS];
    rpc_binding_handle_t diskCid[UBIK_MAXADDRS];	
    char lastVote;			/* true if last vote was yes */
    char up;				/* is it up? */
    char beaconSinceDown;		/* did beacon get through since last 
					   crash? */
    char currentDB;			/* is dbase up-to-date */
    char magic;				/* the one whose vote counts twice */
    char badhost;                       /* ignore this host, might be misconfigured */
    int  ProviderVers;			/* servers provider version number */
    uuid_t realm;			/* server's realm  */
    uuid_t principal;			/* server's principal */
};

/* urecovery state bits for sync site */
#define	UBIK_RECSYNCSITE	1	/* am sync site */
#define	UBIK_RECFOUNDDB		2	/* found acceptable dbase from quorum*/
#define	UBIK_RECHAVEDB		4	/* fetched best dbase */
#define	UBIK_RECLABELDB		8	/* relabelled dbase */
#define	UBIK_RECSENTDB		0x10	/* sent best db to *everyone* */
#define	UBIK_RECSBETTER		UBIK_RECLABELDB	/* last state */

extern struct ubik_server *ubik_servers;
extern long ubik_quorum;			/* min hosts in quorum */
extern struct ubik_dbase *ubik_dbase;		/* the database handled by this server */
extern struct ubik_server ubik_host;	/* this host addr, in net order */
extern int ubik_amSyncSite;	    /* sleep on this waiting to be sync site */
struct ubik_stats {		    		/* random stats */
    long escapes;
} ubik_stats;

extern long ubik_epochTime;		/* time when this site started */
extern long urecovery_state;		/* sync site recovery process state */
extern struct ubik_trans *ubik_currentTrans;	/* current trans */
extern struct ubik_version ubik_dbVersion;	/* sync site's dbase version */
extern long ubik_debugFlag;			/* ubik debug flag */

/* this extern gives the sync site's db version, with epoch of 0 if none yet */
extern void ubik_sleep();
extern void ubik_timedSleep();
extern int uphys_read();
extern int uphys_write();
extern int uphys_truncate();
extern int uphys_sync();
/*
 * Commented out because it's static.
 *
extern int uphys_open();
 */
extern int uphys_stat();
extern int uphys_getlabel();
extern int uphys_setlabel();
extern int uphys_getnfiles();
extern void ubeacon_Interact();
extern void urecovery_Interact();
extern void ubeacon_ClockSkewMonitor();
extern int sdisk_Interact();
extern int uvote_Interact();
extern int DISK_Abort();
extern int DISK_Begin();
extern int DISK_ReleaseLocks();
extern int DISK_Commit();
extern int DISK_Lock();
extern int DISK_Write();
extern int DISK_Truncate();
#endif /* UBIK_INTERNALS */

extern long ubik_nBuffers;
extern long ubik_amIMagic;
extern long ubik_nServers;

/* error recovery macros */
#define CHK_RPC_ERR(st)                 \
    MACRO_BEGIN				\
    if ( st != rpc_s_ok )               \
      goto exit;			\
    MACRO_END				\


/* return an error value */
#define	CHK_CODE_ERR(code)		\
    MACRO_BEGIN				\
    if ( code )				\
    {	*stP = code; goto exit; }	\
    MACRO_END				\

#endif	/* KERNEL */

#endif /* UBIK_H_ */
