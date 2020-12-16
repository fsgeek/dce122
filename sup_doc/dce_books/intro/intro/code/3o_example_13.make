...\"
...\" @OSF_COPYRIGHT@
...\" COPYRIGHT NOTICE
...\" Copyright (c) 1990, 1991, 1992, 1993 Open Software Foundation, Inc.
...\" ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
...\" src directory for the full copyright text.
...\"
...\"
...\" HISTORY
...\" $Log: 3o_example_13.make,v $
...\" Revision 1.1.4.3  1993/01/29  17:19:43  cjd
...\" 	Embedded copyright notice
...\" 	[1993/01/29  17:03:42  cjd]
...\"
...\" Revision 1.1.4.2  1992/09/01  16:32:18  weir
...\" 	Moved
...\" 	[1992/09/01  16:24:07  weir]
...\" 
...\" Revision 1.1.2.2  1992/03/06  16:34:16  steiner
...\" 	replaced comment leader
...\" 	[1992/03/06  16:09:56  steiner]
...\" 
...\" Revision 1.1  1992/01/29  15:41:11  damon
...\" 	Initial revision
...\" 
...\" $EndLog$
...\"
# Makefile for DCE Program Example Using DFS


all:	dfs_greet_client dfs_greet_server

dfs_greet_client:	dfs_greet.h dfs_greet_client.c
	cc -o dfs_greet_client dfs_greet_client.c

dfs_greet_server: dfs_greet.h dfs_greet_server.c
	cc -o dfs_greet_server dfs_greet_server.c
