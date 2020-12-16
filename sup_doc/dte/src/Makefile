# Copyright 1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.5  1994/06/23  19:25:00  fred
# 	free copyright
# 	[1994/06/23  19:24:50  fred]
#
# Revision 1.1.2.4  1994/06/23  18:37:08  fred
# 	free copyright
# 	[1994/06/22  14:21:00  fred]
# 
# Revision 1.1.2.3  1993/04/09  21:23:18  bowe
# 	Added copyright statement.
# 	[1993/04/09  21:21:38  bowe]
# 
# Revision 1.1.2.2  1992/07/15  14:34:25  bowe
# 	Initial rev.
# 	[1992/07/15  14:32:53  bowe]
# 
# $EndLog$
# 
# $Header: /u1/rcs/dte/Makefile,v 1.1.2.5 1994/06/23 19:25:00 fred Exp $

#____________________________________________________________________________

MAKE		= make
SHELL		= /bin/sh
CP		= cp -f
TOP		= /tmp/DTE
BINDIR		= $(TOP)/bin
LIBDIR		= $(TOP)/libdata
MANDIR		= $(TOP)/man
ALL_ARGS	= TOP=$(TOP) BINDIR=$(BINDIR) LIBDIR=$(LIBDIR) MANDIR=$(MANDIR)\
		CC=$(CC) MAKE="$(MAKE)" CP="$(CP)"

SUBDIRS_PROG	= book-format util installref
SUBDIRS_DATA	= macros glossary doc
SUBDIRS		= $(SUBDIRS_PROG) $(SUBDIRS_DATA)

all: Force
	@for dir in $(SUBDIRS); \
	    do (echo ""; echo "--- $(MAKE) $@ in $$dir ---"; date; cd $$dir; \
		$(MAKE) $(ALL_ARGS) $@ ) \
	    done

install: Force
	@sh -c 'if [ -d $(TOP)    ]; then true; else mkdir $(TOP);    fi'
	@sh -c 'if [ -d $(BINDIR) ]; then true; else mkdir $(BINDIR); fi'
	@sh -c 'if [ -d $(LIBDIR) ]; then true; else mkdir $(LIBDIR); fi'
	@sh -c 'if [ -d $(MANDIR) ]; then true; else mkdir $(MANDIR); fi'
	@for dir in $(SUBDIRS); \
	    do ( echo ""; echo "--- $(MAKE) $@ in $$dir ---"; date; cd $$dir; \
		$(MAKE) $(ALL_ARGS) $@ ) \
	    done

# for installing programs, but not data files.
install-progs: Force
	@sh -c 'if [ -d $(BINDIR) ]; then true; else mkdir $(BINDIR); fi'
	@for dir in $(SUBDIRS_PROG); \
	    do ( echo ""; echo "--- $(MAKE) $@ in $$dir ---"; date; cd $$dir; \
		$(MAKE) $(ALL_ARGS) install ) \
	    done

# dependency hack
Force:

clean:
	@for dir in $(SUBDIRS); \
	    do ( echo "--- $(MAKE) $@ in $$dir ---"; cd $$dir; \
		$(MAKE) $@ ) ; done

clobber:
	@for dir in $(SUBDIRS); \
	    do ( echo "--- $(MAKE) $@ in $$dir ---"; cd $$dir; \
		$(MAKE) $@ ) ; done

