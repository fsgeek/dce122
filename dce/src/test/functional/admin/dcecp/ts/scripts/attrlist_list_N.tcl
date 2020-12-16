#!/usr/bin/dcecp
# @OSF_COPYRIGHT@
# COPYRIGHT NOTICE
# Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
# ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
# the full copyright text.
#
#
# HISTORY
# $Log: attrlist_list_N.tcl,v $
# Revision 1.1.4.2  1996/03/11  02:26:43  marty
# 	Update OSF copyright years
# 	[1996/03/10  19:35:57  marty]
#
# Revision 1.1.4.1  1995/12/11  15:15:26  root
# 	Submit
# 	[1995/12/11  14:32:03  root]
# 
# 	Submit OSF/DCE 1.2.1
# 	[1995/12/08  23:16:58  root]
# 
# Revision 1.1.2.1  1994/09/28  21:45:53  melman
# 	moved admin tests to test/functional
# 	[1994/09/28  21:14:02  melman]
# 
# Revision 1.1.2.1  1994/06/27  22:18:06  coren
# 	Initial version.
# 	[1994/06/27  20:02:29  coren]
# 
# $EndLog$

if {([catch {set TET_ROOT $env(TET_ROOT)}]) || 
    ([string length $env(TET_ROOT)] == 0)} {
    puts stderr "$argv0: TET_ROOT is not defined."
    exit
}

# Test purpose common routines
source $TET_ROOT/functional/admin/dcecp/lib/test_common.tcl


proc attrlist_list_startup {} {
    global DCP_CLIENT DCP_CLIENT_PW
    if {[dcp_wrap {login $DCP_CLIENT -p $DCP_CLIENT_PW}] != 0} {return;}
}

proc attrlist_list_cleanup {} {
    if {[dcp_wrap {logout}] != 0} {return;}
}

## Test purposes
proc attrlist_list_1_N {} {
    # Identify the test
    tet_infoline attrlist_list_1_N: Check handling of no arguments.

    # Setup steps

    # Run the test
    test {
        list [catch {attrlist list} msg] $msg
    } compare_strings {1 {No input attribute list.}}

    # Cleanup steps
}


set iclist "ic1 "
set ic1 "attrlist_list_1_N"
set tet_startup attrlist_list_startup
set tet_cleanup attrlist_list_cleanup

# Source the TET main script into our script. The TET main
# script is what will do the actual function calling.
source $TET_ROOT/lib/tcl/tcm.tcl
