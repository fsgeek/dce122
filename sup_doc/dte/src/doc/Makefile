#
# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.5  1994/06/24  15:14:27  fred
# 	free copyright
# 	[1994/06/23  19:58:47  fred]
#
# Revision 1.1.2.4  1994/06/23  18:38:18  fred
# 	free copyright
# 	[1994/06/22  18:41:48  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:10:26  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:09:43  bowe]
# 
# Revision 1.1.2.2  1992/07/15  14:34:35  bowe
# 	Initial rev.
# 	[1992/07/15  14:33:03  bowe]
# 
# $EndLog$
# 
# $Header: /u1/rcs/dte/doc/Makefile,v 1.1.2.5 1994/06/24 15:14:27 fred Exp $

MAKE		= make
SHELL		= /bin/sh
CP		= cp -f
TOP		= /tmp/DTE
BINDIR		= $(TOP)/bin
LIBDIR		= $(TOP)/libdata
MANDIR		= $(TOP)/man
ALL_ARGS	= TOP=$(TOP) BINDIR=$(BINDIR) LIBDIR=$(LIBDIR) MANDIR=$(MANDIR)\
		CP="$(CP)"

SUBDIRS		= style.gd user.gd

all: force
	@for dir in $(SUBDIRS); \
	    do (echo ""; echo "--- $(MAKE) $@ in doc/$$dir ---"; date; \
		cd $$dir; $(MAKE) $(ALL_ARGS) $@ ) \
	    done

install: force
	@for dir in $(SUBDIRS); \
	    do (echo ""; echo "--- $(MAKE) $@ in doc/$$dir ---"; date; \
		cd $$dir; $(MAKE) $(ALL_ARGS) $@ ) \
	    done

# dependency hack
force:

clean:
	@for dir in $(SUBDIRS); \
	    do ( echo "--- $(MAKE) $@ in doc/$$dir ---"; cd $$dir; \
		$(MAKE) $@ ) ; done

clobber:
	@for dir in $(SUBDIRS); \
	    do ( echo "--- $(MAKE) $@ in doc/$$dir ---"; cd $$dir; \
		$(MAKE) $@ ) ; done

