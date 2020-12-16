# ======================================================================= #
#                                                                         #
# TBOES 4-5-94: makefile for POS rpc performance benchmark                 #
#                                                                         #
# ======================================================================= #

COMMONDIR = ../common

SALOBJS = pos_sal.o ptq_sal.o pos_idl_sstub.o posutil.o \
catstub.o cmr_sal.o

PRIOBJS = pos_pri.o ptq_pri.o cmr_pri.o pos_idl_sstub.o posutil.o \
catstub.o ptq_idl_cstub.o cmr_idl_cstub.o

SECOBJS = pos_sec.o ptq_sec.o posutil.o \
catstub.o cmr_sec.o ptq_idl_sstub.o cmr_idl_sstub.o

CLIOBJS = mom.o pos.o pos_idl_cstub.o randum.o expran.o

STTOBJS = posstart.o pos_idl_cstub.o 


MV= /usr/bin/mv
CP= /usr/bin/cp
RM= /usr/bin/rm

#CC=/usr/bin/cc_r
CR=/usr/bin/cc_r



SALFLAG = -DPOS_STANDALONE
PRIFLAG = -DPOS_PRIMARY
SECFLAG = -DPOS_SECONDARY

CFLAGS	= -I. -I$(COMMONDIR) -I/usr/include/dce -g -c  -DAIX_PROD  -DNODBM # -DDEBUGIT
#CFLAGS	= -I. -I$(COMMONDIR) -I/usr/include/dce -g -c  -DAIX_PROD  -DNODBM  -DDEBUGIT

LIBS	= -ldce -lpthreads -lbsd -lcur -lm

#NIDL	= /opt/dcelocal/bin/idl -no_cpp -cc_opt -O #-keep c_source 
NIDL	= /opt/dcelocal/bin/idl -no_cpp -cc_opt -O -keep c_source 

NIDLFLAGS = -I /usr/include/dce  -I . 

.c.o:
	$(CC) $(CFLAGS) $<


all:	nidl pos_pri pos_sec pos_sal  pos_req  customer  price

#all:	nidl pos_pri pos_sec pos_sal  posstart   pos_req


nidl:
	$(CP) $(COMMONDIR)/*.idl .
	-$(NIDL) pos_def.idl $(NIDLFLAGS)
	-$(NIDL) pos_idl.idl $(NIDLFLAGS)
	-$(NIDL) cmr_idl.idl $(NIDLFLAGS)
	-$(NIDL) ptq_idl.idl $(NIDLFLAGS)


clean:
	$(RM) *.o 
	$(CP) $(COMMONDIR)/catstub.c .
	$(CP) $(COMMONDIR)/expran.c .
	$(CP) $(COMMONDIR)/posstart.c .
	$(CP) $(COMMONDIR)/posutil.c .
	$(CP) $(COMMONDIR)/randum.c .
	$(RM) cmr_pri.c cmr_sal.c cmr_sec.c 
	$(RM) pos_pri.c pos_sal.c pos_sec.c 
	$(RM) ptq_pri.c ptq_sal.c ptq_sec.c 


pos_pri: $(PRIOBJS)
	$(CC) -o ../primary_srv/pos_pri $(PRIOBJS) $(LIBS)

pos_pri.o:
	$(CP) $(COMMONDIR)/pos_srv.c pos_pri.c
	$(CC) $(CFLAGS) $(PRIFLAG) pos_pri.c

ptq_pri.o:
	$(CP) $(COMMONDIR)/ptqstub.c ptq_pri.c
	$(CC) $(CFLAGS) $(PRIFLAG) ptq_pri.c

cmr_pri.o:
	$(CP) $(COMMONDIR)/cmrstub.c cmr_pri.c
	$(CC) $(CFLAGS) $(PRIFLAG) cmr_pri.c


pos_sal: $(SALOBJS)
	$(CC) -o ../primary_srv/pos_sal $(SALOBJS) $(LIBS)

pos_sal.o:
	$(CP) $(COMMONDIR)/pos_srv.c pos_sal.c
	$(CC) $(CFLAGS) $(SALFLAG) pos_sal.c

ptq_sal.o:
	$(CP) $(COMMONDIR)/ptqstub.c ptq_sal.c
	$(CC) $(CFLAGS) $(SALFLAG) ptq_sal.c

cmr_sal.o:
	$(CP) $(COMMONDIR)/cmrstub.c cmr_sal.c
	$(CC) $(CFLAGS) $(SALFLAG) cmr_sal.c


pos_sec: $(SECOBJS)
	$(CC) -o ../price_srv/pos_sec $(SECOBJS) $(LIBS)
	$(CP) ../price_srv/pos_sec ../customer_srv 

pos_sec.o:
	$(CP) $(COMMONDIR)/pos_srv.c pos_sec.c
	$(CC) $(CFLAGS) $(SECFLAG) pos_sec.c

ptq_sec.o:
	$(CP) $(COMMONDIR)/ptqstub.c ptq_sec.c
	$(CC) $(CFLAGS) $(SECFLAG) ptq_sec.c

cmr_sec.o:
	$(CP) $(COMMONDIR)/cmrstub.c cmr_sec.c
	$(CC) $(CFLAGS) $(SECFLAG) cmr_sec.c



pos_req: $(CLIOBJS)
	$(CC) -o ../client/pos_req $(CLIOBJS) $(LIBS)

posstart: $(STTOBJS)
	$(CC) -o ../client/posstart $(STTOBJS) $(LIBS)

posstart.c:
	$(CP) $(COMMONDIR)/posstart.c .

posutil.c:
	$(CP) $(COMMONDIR)/posutil.c .

catstub.c:
	$(CP) $(COMMONDIR)/catstub.c .

randum.c:
	$(CP) $(COMMONDIR)/randum.c .

expran.c:
	$(CP) $(COMMONDIR)/expran.c .


customer: customer.o
	$(CC) -o customer customer.o $(LIBS)

price: price.o
	$(CC) -o price price.o $(LIBS)

calcpos: calcpos.o
	$(CC) -o calcpos calcpos.o $(LIBS)

testit2: testit2.o
	$(CC) -o testit2 testit2.o $(LIBS)

dcemsg: dcemsg.o
	$(CC) -o dcemsg dcemsg.o $(LIBS)



