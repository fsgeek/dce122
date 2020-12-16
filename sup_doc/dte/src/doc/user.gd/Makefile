# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
#
# @OSF_FREE_COPYRIGHT@
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.5  1994/06/24  15:15:59  fred
# 	free copyright
# 	[1994/06/23  20:14:57  fred]
#
# Revision 1.1.2.4  1994/06/23  18:39:56  fred
# 	free copyright
# 	[1994/06/22  19:33:49  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:22:34  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:20:13  bowe]
# 
# Revision 1.1.2.2  1992/07/15  14:34:48  bowe
# 	Initial rev.
# 	[1992/07/15  14:33:11  bowe]
# 
# $EndLog$
# 
# $Header: /u1/rcs/dte/doc/user.gd/Makefile,v 1.1.2.5 1994/06/24 15:15:59 fred Exp $

SHELL		= /bin/sh
CP		= cp -f
TOP		= /tmp/DTE
BINDIR		= $(TOP)/bin
LIBDIR		= $(TOP)/libdata
MANDIR		= $(TOP)/man

IDIR_MAN1	= $(MANDIR)/man1
IDIR_MAN4	= $(MANDIR)/man4
DATAFILES1	= book-format.1 dman.1 dmm.1
DATAFILES4	= description.4 glossary.4
DATAFILES	= $(DATAFILES1) $(DATAFILES4)

all:
	echo "No action for $@"

install:
	-@( if [ -d $(MANDIR) ];  then true; else mkdir $(MANDIR); fi )
	-@( if [ -d $(IDIR_MAN1) ]; then true; else mkdir $(IDIR_MAN1); fi )
	-@( if [ -d $(IDIR_MAN4) ]; then true; else mkdir $(IDIR_MAN4); fi )
	-@(cd $(IDIR_MAN1) ; rm -f $(DATAFILES1) )
	-@(cd $(IDIR_MAN4) ; rm -f $(DATAFILES4) )
	$(CP) $(DATAFILES1) $(IDIR_MAN1)
	$(CP) $(DATAFILES4) $(IDIR_MAN4)

ps:
	book-format -all

clean:
clobber:

