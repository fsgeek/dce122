/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 */
/*
 * HISTORY
 * $Log: osi_trace_init.c,v $
 * Revision 1.1.5.1  1996/10/02  18:11:50  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:45:13  damon]
 *
 * $EndLog$
 */
/*
 *      Copyright (C) 1992 Transarc Corporation
 *      All rights reserved.
 */

/* osi_trace_init.c 
 * 
 * Support to create ICL log for entry/exit tracing 
 */

/* DO NOT 
 * move the sole function defined in this file to any other file.
 * 
 * Why? 
 * Its creates the ICL log necessary for entry/exit trace preprocessing,
 * and needs special make processing to prevent this function being
 * traced itself.
 */

#include <dcedfs/param.h>
#include <dcedfs/stds.h>

#ifdef KERNEL
#include <dcedfs/icl.h>
#endif

#ifdef KERNEL
struct icl_set *traceIclSetP = 0;
#endif


int osi_trace_init()
{
#ifdef KERNEL
    long code;
    struct icl_log *traceIclLogP;    

    /* Create a trace log */
    printf("Creating ICL trace log\n");
    code = icl_CreateLog("trace", 0 /* default size */, &traceIclLogP);
    if (code == 0) {
	code = icl_CreateSet("trace", traceIclLogP, (struct icl_log *)NULL,
			     &traceIclSetP);
    }
    if (code) {
	printf("warning: can't init icl for tracing, code %d\n", code);
    }
    return code;
#else 
    return 0
#endif
}

