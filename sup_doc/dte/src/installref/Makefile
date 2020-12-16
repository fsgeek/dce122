# Copyright 1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.5  1994/06/24  15:47:42  fred
# 	free copyright
# 	[1994/06/24  15:28:07  fred]
#
# Revision 1.1.2.4  1994/06/23  18:40:50  fred
# 	free copyright
# 	[1994/06/22  19:41:55  fred]
# 
# Revision 1.1.2.3  1993/04/09  21:30:19  bowe
# 	Add copyright statement.
# 	[1993/04/09  21:28:01  bowe]
# 
# Revision 1.1.2.2  1992/07/15  14:34:59  bowe
# 	Initial rev.
# 	[1992/07/15  14:33:20  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/installref/Makefile,v 1.1.2.5 1994/06/24 15:47:42 fred Exp $

SHELL		= /bin/sh
CP		= cp
TOP		= /tmp/DTE
BINDIR		= $(TOP)/bin
IDIR		= $(BINDIR)

SCRIPTS		= install-ref
PROGRAMS	=

ILIST		= $(SCRIPTS) $(PROGRAMS)

_N_A_S_F_=THIS IS NOT A SOURCE FILE - DO NOT EDIT

.SUFFIXES: .sh

.sh:
	rm -f $@
	sed -n 1p $< > $@
	echo "#" >> $@
	echo "# $(_N_A_S_F_)" >> $@
	echo "#" >> $@
	sed 1d $< >> $@
	chmod +x $@

all: $(ILIST)

scripts: $(SCRIPTS)

install: all
	-( if [ -d $(IDIR) ]; then true; else mkdir $(IDIR); fi )
	( cd $(IDIR) ; rm -f $(PROGRAMS) $(SCRIPTS) )
	$(CP) $(PROGRAMS) $(SCRIPTS) $(IDIR)

clean:
	-rm -f *.o core a.out *~

clobber: clean
	-rm -f $(ILIST)

