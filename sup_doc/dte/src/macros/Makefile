# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
#
# HISTORY
# $Log: Makefile,v $
# Revision 1.1.2.5  1994/06/24  15:47:49  fred
# 	free copyright
# 	[1994/06/24  15:37:33  fred]
#
# Revision 1.1.2.4  1994/06/23  18:40:57  fred
# 	free copyright
# 	[1994/06/22  20:06:33  fred]
# 
# Revision 1.1.2.3  1993/04/10  00:37:24  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:32:01  bowe]
# 
# Revision 1.1.2.2  1992/07/15  14:35:04  bowe
# 	Initial rev.
# 	[1992/07/15  14:33:24  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/macros/Makefile,v 1.1.2.5 1994/06/24 15:47:49 fred Exp $
#

SHELL		= /bin/sh
CP		= cp
TOP		= /tmp/DTE
LIBDIR		= $(TOP)/libdata
IDIR		= $(LIBDIR)/macros

DATAFILES	= appendix.mac bookdefs.mac copyright.mm \
	draft.mac draft-an+.man draft-hdr.man draft-hdr.mm draft-mmt+.mm \
	header.all nroff-hdr.mm \
	sgref.mm unnumbered.mm front.mac glossary.mm glosshead.mm \
	index-post.mm index-pre.mm \
	preface.mac ps.mm ptx.mm \
	sync-post.man sync-post.mm sync-pre.man sync-pre.mm \
	toc-middle.mm toc-post1.mm toc-post2.mm toc-pre.mm \
	sml gpsml rsml \
	chappart.sml headfoot.mm osfhead.rsml parts.sml nonbook.mm nonbook.man \
	pub-an+.man pub-hdr.man pub-hdr.mm pub-mmt+.mm

ILIST	= $(DATAFILES)

# local or proprietary macros - not shipped on tapes.  (we install if present)
ILIST_LOCAL	= an mmt
ILIST_SEC	= tmac.sw

all:

install:
	-( if [ -d $(IDIR) ]; then true; else mkdir $(IDIR); fi )
	-( cd $(IDIR) ; rm -f $(ILIST) $(ILIST_LOCAL) $(ILIST_SEC) )
	$(CP) $(ILIST) $(IDIR)
	@sh -c 'for m in $(ILIST_LOCAL) ; \
	    do ( if [ -f $$m ]; then $(CP) $$m $(IDIR); else true; fi ); done'
	@sh -c 'for m in $(ILIST_SEC) ; \
	    do ( if [ -f $$m ]; then $(CP) $$m $(IDIR); else true; fi ); done'

clean:
	-rm -f *.o core a.out *~

clobber: clean

