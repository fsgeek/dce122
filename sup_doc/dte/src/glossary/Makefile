# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.4  1994/06/24  17:56:34  fred
# 	free copyright
# 	[1994/06/24  17:56:09  fred]
#
# Revision 1.1.2.3  1993/04/10  00:02:37  bowe
# 	Add OSF copyright.
# 	[1993/04/09  23:54:45  bowe]
# 
# Revision 1.1.2.2  1992/07/15  14:34:54  bowe
# 	Initial rev.
# 	[1992/07/15  14:33:15  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/glossary/Makefile,v 1.1.2.4 1994/06/24 17:56:34 fred Exp $

SHELL		= /bin/sh
CP		= cp
TOP		= /tmp/DTE
LIBDIR		= $(TOP)/libdata
IDIR		= $(LIBDIR)/glossary

DATAFILES	= gloss@ \
	glossA glossB glossC glossD glossE glossF glossG glossH glossI \
	glossJ glossK glossL glossM glossN glossO glossP glossQ glossR \
	glossS glossT glossU glossV glossW glossX glossY glossZ

ILIST		= $(DATAFILES)

#  no action for all
all:

install:
	-( if [ -d $(IDIR) ]; then true; else mkdir $(IDIR); fi )
	-( cd $(IDIR) ; rm -f $(ILIST) )
	$(CP) $(ILIST) $(IDIR)

clean:
	-rm -f *.o core a.out *~

clobber: clean

