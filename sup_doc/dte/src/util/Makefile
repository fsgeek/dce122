# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.6  1994/06/24  15:49:13  fred
# 	free copyright
# 	[1994/06/24  15:43:39  fred]
#
# Revision 1.1.2.5  1994/06/23  18:42:25  fred
# 	free copyright
# 	[1994/06/22  20:17:23  fred]
# 
# Revision 1.1.2.4  1993/04/10  00:17:51  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:15:23  bowe]
# 
# Revision 1.1.2.3  1992/12/03  15:14:00  bowe
# 	Added ix-density.
# 	[1992/12/03  15:10:36  bowe]
# 
# Revision 1.1.2.2  1992/07/15  14:35:08  bowe
# 	Initial rev.
# 	[1992/07/15  14:33:28  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/util/Makefile,v 1.1.2.6 1994/06/24 15:49:13 fred Exp $

SHELL		= /bin/sh
CP		= cp
TOP		= /tmp/DTE
BINDIR		= $(TOP)/bin
IDIR		= $(BINDIR)

SCRIPTS		= add-cutmark print-eps \
		check-iX check-lists check-oSoE check-xref ix-density
PROGRAMS	= check-gloss

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

