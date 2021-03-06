#!/usr/bin/dcecp
# @OSF_COPYRIGHT@
# COPYRIGHT NOTICE
# Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
# ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
# the full copyright text.
#
#
# HISTORY
# $Log: rpcgroup_create_P.tcl,v $
# Revision 1.1.2.2  1996/03/11  02:25:28  marty
# 	Update OSF copyright years
# 	[1996/03/10  19:35:33  marty]
#
# Revision 1.1.2.1  1995/12/11  15:14:31  root
# 	Submit
# 	[1995/12/11  14:31:40  root]
# 
# 	Submit OSF/DCE 1.2.1
# 
# 	HP revision /main/HPDCE02/1  1995/06/12  12:55 UTC  truitt
# 	Initial HPDCE02 branch.
# 
# 	HP revision /main/truitt_dcecp_chfts34/1  1995/06/12  12:54 UTC  truitt
# 	New test.
# 	[1995/12/08  23:16:26  root]
# 
# $EndLog$

if {([catch {set TET_ROOT $env(TET_ROOT)}]) || 
    ([string length $env(TET_ROOT)] == 0)} {
    puts stderr "$argv0: TET_ROOT is not defined."
    exit
}

## DCECP test case setup
source $TET_ROOT/functional/admin/dcecp/lib/test_setup.tcl

# Test purpose common routines
source $TET_ROOT/functional/admin/dcecp/lib/test_common.tcl


## Test purposes
proc rpcgroup_create_startup {} {
    global DCP_CLIENT DCP_CLIENT_PW
    if {[dcp_wrap {login $DCP_CLIENT -p $DCP_CLIENT_PW}] != 0} {return;}
}

proc rpcgroup_create_cleanup {} {
    if {[dcp_wrap {logout}] != 0} {return;}
}

proc rpcgroup_create_1_P {} {
    # Identify the test
    tet_infoline rpcgroup_create_1_P: Check to see if we can create an empty RPC group.

    # Setup steps

    # Run the test
    test {rpcgroup create /.:/rpcgroup_create1
        catch {rpcgroup list /.:/rpcgroup_create1} msg
    } compare_strings {0}

    # Cleanup steps
    if {[dcp_wrap {object delete /.:/rpcgroup_create1}] != 0} {return;}
}

proc rpcgroup_create_2_P {} {
    # Identify the test
    tet_infoline rpcgroup_create_2_P: Check to see if we can create a list of empty RPC groups.

    # Setup steps

    # Run the test
    test {rpcgroup create {/.:/rpcgroup_create2a /.:/rpcgroup_create2b}
        catch {rpcgroup list {/.:/rpcgroup_create2a /.:/rpcgroup_create2b}} msg
    } compare_strings {0}

    # Cleanup steps
    if {[dcp_wrap {object delete {/.:/rpcgroup_create2a /.:/rpcgroup_create2b}}] != 0} {return;}
}


set iclist "ic1 ic2 "
set ic1 "rpcgroup_create_1_P"
set ic2 "rpcgroup_create_2_P"
set tet_startup rpcgroup_create_startup
set tet_cleanup rpcgroup_create_cleanup

# Source the TET main script into our script. The TET main
# script is what will do the actual function calling.
source $TET_ROOT/lib/tcl/tcm.tcl
