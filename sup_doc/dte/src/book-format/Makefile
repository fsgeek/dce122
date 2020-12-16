#
# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
#
# @OSF_FREE_COPYRIGHT@
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.6  1994/06/23  19:48:18  fred
# 	free copyright
# 	[1994/06/23  19:38:48  fred]
#
# Revision 1.1.2.5  1994/06/23  18:37:10  fred
# 	free copyright
# 	[1994/06/22  15:25:43  fred]
# 
# Revision 1.1.2.4  1993/04/10  01:02:53  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:59:52  bowe]
# 
# Revision 1.1.2.3  1992/12/10  18:37:42  fred
# 	various changes to implement the new master index.
# 	[1992/12/10  18:35:12  fred]
# 
# Revision 1.1.2.2  1992/07/15  14:34:30  bowe
# 	Initial rev.
# 	[1992/07/15  14:32:58  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/book-format/Makefile,v 1.1.2.6 1994/06/23 19:48:18 fred Exp $

SHELL		= /bin/sh
CP		= cp -f
TOP		= /tmp/DTE
BINDIR		= $(TOP)/bin
IDIR		= $(BINDIR)

PROGRAMS	= roff-cmd elimso fixVertMot indpostsort indpresort \
		query_gloss rmifdef fmt-index-trim

SCRIPTS		= book-format dman dmm dsml fix-man \
		fmt-gloss fmt-index fmt-piece fmt-toc \
		includePS make-ptx rmPic rmboxes show-ifdefs \
		sync-h1-man sync-h1-mm syncGen

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

