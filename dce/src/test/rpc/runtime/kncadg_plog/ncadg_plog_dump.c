/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: ncadg_plog_dump.c,v $
 * Revision 1.1.6.2  1996/02/17  23:23:23  marty
 * 	Update OSF copyright year
 * 	[1996/02/17  22:41:53  marty]
 *
 * Revision 1.1.6.1  1995/12/11  20:14:12  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/11  19:47:01  root]
 * 
 * Revision 1.1.4.2  1993/01/13  19:53:25  bbelch
 * 	Embedding copyright notice
 * 	[1993/01/06  18:20:57  bbelch]
 * 
 * Revision 1.1.2.2  1992/05/01  15:51:34  rsalz
 * 	Edited as part of rpc6 drop.
 * 	[1992/05/01  00:58:01  rsalz]
 * 
 * Revision 1.1  1992/01/19  03:43:03  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
*/
/*
 * ncadg_plog_dump [<format>]
 *  <format> n|w (narrow or wide)
 *  stdin  - output from ncadg_plogd
 *  stdout - formatted log
 *
 * e.g. ncadg_plog_dump /vmunix </dev/kmem | ncadg_plog_dump >plog.fmt
 *
 * Dump out the (formatted) contents of a ncadg pkt log file
 * (generated by ncadg_plogd)
 */

#include <stdio.h>
#include <sys/file.h>
#include <ncadg_plog.h>

pktlog_elt_p_t  prev_pkt_log;
pktlog_elt_p_t  pkt_log;
unsigned32      pkt_log_size;

#define log_date_stamp_prefix   "=+=+=+=+=+=+=+=+= \n"
#define log_date_stamp          "Mon Jun  3 15:50:56 EDT 1991\n"

int narrow_format = 0;

main(argc, argv)
int argc;
char *argv[];
{
    int rc, plog_bytes;
    char tmpbuf[80];

    if (argc == 2)
        narrow_format = argv[1][0] == 'n';

    /*
     * process the next snapshot of the log file from stdin
     */

    while ((rc = read(0, &tmpbuf[0], sizeof(log_date_stamp_prefix) - 1)) != 0)
    {
        /*
         * Check for legal format (and get the snapshot's date).
         */
        if (rc != sizeof(log_date_stamp_prefix) - 1) {
            fprintf(stderr, "couldn't read log_date_stamp_prefix (got %d)\n", rc);
            if (rc == -1)
                perror("");
            exit(1);
        }
        if (strncmp(tmpbuf, log_date_stamp_prefix) != 0) {
            fprintf(stderr, "bogus log_date_stamp_prefix\n");
            exit(1);
        }

        rc = read(0, &tmpbuf[0], sizeof(log_date_stamp) - 1);
        if (rc != sizeof(log_date_stamp) - 1) {
            fprintf(stderr, "couldn't read log_date_stamp (got %d)\n", rc);
            if (rc == -1)
                perror("");
            exit(1);
        }
        tmpbuf[rc] = 0;

        printf("ncadg pkt log dump from %s", tmpbuf);

        /*
         * Determine the number of bytes in the log, alloc space for
         * and read in the log.
         */
        rc = read(0, &plog_bytes, sizeof(plog_bytes));
        if (rc != sizeof(plog_bytes)) {
            fprintf(stderr, "couldn't read plog_bytes\n");
            if (rc == -1)
                perror("");
            exit(1);
        }

        pkt_log_size = plog_bytes / sizeof(pktlog_elt_t);
        pkt_log = (pktlog_elt_p_t) malloc(plog_bytes);

        rc = read(0, pkt_log, plog_bytes);
        if (rc != plog_bytes) {
            fprintf(stderr, "couldn't read %d bytes (got %d)\n", 
                plog_bytes, rc);
            if (rc == -1)
                perror("");
            exit(1);
        }

        if (plog_bytes % sizeof(pktlog_elt_t) != 0) {
            printf("!!! potential pkt log pgm / kernel mismatch !!!\n");
        }

        if (cmp_logs(pkt_log, prev_pkt_log) == 0) {
            printf("... no change in log ...\n");
            free(pkt_log);
            continue;
        }

        /*
         * Generate a formatted dump.
         */
        rpc__dg_plog_dump();

        if (prev_pkt_log != NULL)
            free(prev_pkt_log);
        prev_pkt_log = pkt_log;

    }
    exit(0);
}

cmp_logs(l1, l2)
char *l1, *l2;
{
    int i;

    for (i=0; i<pkt_log_size; i++)
        if (*l1++ != *l2++)
            return 1;
    return 0;
}

rpc__dg_plog_dump()
{
    unsigned16 i;
    unsigned32 st;

    if (! narrow_format) {
        printf("tstamp   ver ptyp f1 f2     seq/fnum/sn    ihnt ahnt  len              interface/ver/op                            activity                  sboot                    object              drep   at\n");
        printf("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n");
    } else {
        printf("tstamp   ver ptyp f1 f2     seq/fnum/sn    ihnt ahnt  len   sboot   drep   at\n");
        printf("                                                 interface/ver/op\n");
        printf("                                                 activity\n");
        printf("                                                 object\n");
        printf("-------------------------------------------------------------------------------\n");
    }

    for (i = 0; i < pkt_log_size; i++)
    {
        pktlog_elt_p_t p = &pkt_log[i];
        unsigned_char_p_t obj, iface, act;

        if (p->timestamp == 0)
            break;

        uuid_to_string(&p->hdr.object, &obj, &st);
        uuid_to_string(&p->hdr.if_id, &iface, &st);
        uuid_to_string(&p->hdr.actuid, &act, &st);

        if (! narrow_format)
            printf("%08x %c%c%1u %-4.4s %02x %02x %08x/%04x/%04x %04x %04x %4d %s/%02u/%03u %s %9u %s %02x%02x%02x %02x\n",
                p->timestamp,
                (p->hdr._rpc_vers & 0x80) ? 'R' : ' ',
                ' ',
                p->hdr._rpc_vers & 0x7f, 
                rpc__dg_pkt_name(RPC_DG_HDR_INQ_PTYPE(&p->hdr)),
                p->hdr.flags, p->hdr.flags2,
                p->hdr.seq, p->hdr.fragnum,
                p->hdr.serial_hi << 8 | p->hdr.serial_lo,
                p->hdr.ihint, p->hdr.ahint,
                p->hdr.len, 
                iface, p->hdr.if_vers, p->hdr.opnum, act, 
                p->hdr.server_boot, obj, 
                p->hdr.drep[0], p->hdr.drep[1], p->hdr.drep[2], 
                p->hdr.auth_proto);

        else {
            printf("%08x %c%c%1u %-4.4s %02x %02x %08x/%04x/%04x %04x %04x %4d %9u %02x%02x%02x %02x\n",
                p->timestamp,
                (p->hdr._rpc_vers & 0x80) ? 'R' : ' ',
                ' ',
                p->hdr._rpc_vers & 0x7f, 
                rpc__dg_pkt_name(RPC_DG_HDR_INQ_PTYPE(&p->hdr)),
                p->hdr.flags, p->hdr.flags2,
                p->hdr.seq, p->hdr.fragnum,
                p->hdr.serial_hi << 8 | p->hdr.serial_lo,
                p->hdr.ihint, p->hdr.ahint,
                p->hdr.len, 
                p->hdr.server_boot,
                p->hdr.drep[0], p->hdr.drep[1], p->hdr.drep[2], 
                p->hdr.auth_proto);
            printf("                                     %s/%02u/%03u\n",
                iface, p->hdr.if_vers, p->hdr.opnum);
            printf("                                     %s\n", act);
            printf("                                     %s\n", obj);
        }

        rpc_string_free(&obj, &st);
        rpc_string_free(&act, &st);
        rpc_string_free(&iface, &st);
    }
}

char *rpc__dg_pkt_name(ptype)
unsigned32 ptype;
{
    static char *names[rpc_c_dg_pt_max_type + 1] = {
        "request",
        "ping",
        "response",
        "fault",
        "working",
        "nocall",
        "reject",
        "ack",
        "quit",
        "fack",
        "quack"
    };

    return((int) ptype > rpc_c_dg_pt_max_type ? "BOGUS PACKET TYPE" : names[(int) ptype]);
}

#define NO_RPC_RUNTIME
#ifdef NO_RPC_RUNTIME

#define uuid_c_uuid_string_max          37

void uuid_to_string (uuid, uuid_string, status)
uuid_p_t                uuid;
unsigned_char_p_t       *uuid_string;
unsigned32              *status;
{
    *uuid_string = (unsigned_char_p_t) malloc(uuid_c_uuid_string_max);

    sprintf(
        (char *) *uuid_string,
        "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        uuid->time_low, uuid->time_mid, uuid->time_hi_and_version,
        uuid->clock_seq_hi_and_reserved, uuid->clock_seq_low,
        (unsigned8) uuid->node[0], (unsigned8) uuid->node[1],
        (unsigned8) uuid->node[2], (unsigned8) uuid->node[3],
        (unsigned8) uuid->node[4], (unsigned8) uuid->node[5]);

    *status = uuid_s_ok;
}

void rpc_string_free(p)
unsigned char *p;
{
    free(p);
}
#endif

