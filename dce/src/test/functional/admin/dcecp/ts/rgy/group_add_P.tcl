#!/usr/bin/dcecp
# @OSF_COPYRIGHT@
# COPYRIGHT NOTICE
# Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
# ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
# the full copyright text.
#
#
# HISTORY
# $Log: group_add_P.tcl,v $
# Revision 1.1.4.3  1996/03/11  02:18:58  marty
# 	Update OSF copyright years
# 	[1996/03/10  19:33:06  marty]
#
# Revision 1.1.4.2  1995/12/13  15:27:20  root
# 	Submit OSF/DCE 1.2.1
# 	[1995/12/11  15:54:18  root]
# 
# Revision 1.1.2.1  1994/09/28  21:41:41  melman
# 	moved admin tests to test/functional
# 	[1994/09/28  21:10:53  melman]
# 
# Revision 1.1.2.5  1994/09/01  17:49:26  kevins
# 	OT Fixed messages and some tests.
# 	[1994/09/01  16:06:41  kevins]
# 
# Revision 1.1.2.4  1994/06/10  20:14:31  devsrc
# 	cr10872 - fixed copyright
# 	[1994/06/10  16:55:16  devsrc]
# 
# Revision 1.1.2.3  1994/05/11  19:38:57  rousseau
# 	Changed to new install paths.
# 	[1994/05/11  19:23:51  rousseau]
# 
# Revision 1.1.2.2  1994/05/06  17:15:41  melman
# 	updating to new API path
# 	[1994/05/06  17:14:09  melman]
# 
# Revision 1.1.2.1  1994/03/09  19:21:32  kevins
# 	Initial test drop.
# 	[1994/03/09  19:18:06  kevins]
# 
# $EndLog$

if {([catch {set TET_ROOT $env(TET_ROOT)}]) || 
    ([string length $env(TET_ROOT)] == 0)} {
    puts stderr "$argv0: TET_ROOT is not defined."
    exit
}

## DCECP test case setup
source $TET_ROOT/functional/admin/dcecp/lib/test_common.tcl

## Test purposes
proc group_add_5_P {} {
    global TET_ROOT DCP_CLIENT DCP_CLIENT_PW

    # Identify the test
    tet_infoline group_add_5_P: Check to see that we can add a member to a group

    # Setup steps
        # Must be running as cell administrator. 
        # The group foo must exist and the principal kevin must exist.
    if {[dcp_wrap {login $DCP_CLIENT -password $DCP_CLIENT_PW}] != 0} {return;}
    if {[dcp_wrap {principal create kevin}] != 0} {return;}
    if {[dcp_wrap {group create foo}] != 0} {return;}

    # Run the test
        test { group add foo -member kevin
               dcp_found [group list foo -simplename ] kevin 
             } compare_strings found

    # Cleanup steps
        # The member must be removed from the group.
    if {[dcp_wrap {principal delete kevin }] != 0} {return;}
    if {[dcp_wrap {group delete foo}] != 0} {return;}
    if {[dcp_wrap {logout}] != 0} {return;}
}

proc group_add_6_P {} {
    global TET_ROOT DCP_CLIENT DCP_CLIENT_PW

    # Identify the test
    tet_infoline group_add_6_P: Check to see that we can add a list of members to a group

    # Setup steps
        # Must be running as cell administrator. 
        # The groups foo and foo_bar must exist and the principals 
        # kevin and howard must exist. 
    if {[dcp_wrap {login $DCP_CLIENT -password $DCP_CLIENT_PW}] != 0} {return;}
    if {[dcp_wrap {principal create {kevin howard}}] != 0} {return;}
    if {[dcp_wrap {group create {foo foo_bar}}] != 0} {return;}

    # Run the test
    test { group add {foo foo_bar} -member {kevin howard}
           dcp_found [group list {foo foo_bar} -simplename ] {kevin howard} 
          } compare_strings found 

    # Cleanup steps
        # The members must be removed from the groups. 
    if {[dcp_wrap {principal delete {kevin howard} }] != 0} {return;}
    if {[dcp_wrap {group delete {foo foo_bar}}] != 0} {return;}
    if {[dcp_wrap {logout}] != 0} {return;}
}


set iclist "ic1 ic2 "
set ic1 "group_add_5_P"
set ic2 "group_add_6_P"

# Source the TET main script into our script. The TET main
# script is what will do the actual function calling.
source $TET_ROOT/lib/tcl/tcm.tcl
