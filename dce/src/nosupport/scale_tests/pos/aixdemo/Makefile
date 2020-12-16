# ======================================================================= #
#                                                                         #
# TBOES 8-5-94: makefile for POS rpc performance benchmark                 #
#                                                                         #
# ======================================================================= #

COMMONDIR = .

SALOBJS = pos_sal.o pos_idl_sstub.o 

PRIOBJS = pos_pri.o pos_idl_sstub.o cmr_idl_cstub.o

SECOBJS = pos_sec.o cmr_idl_sstub.o

CLIOBJS = mom.o pos_idl_cstub.o

MV= /usr/bin/mv
CP= /usr/bin/cp
RM= /usr/bin/rm

#CC=/usr/bin/cc_r
CR=/usr/bin/cc_r



SALFLAG = -DSTANDALONE
PRIFLAG = -DPRIMARY
SECFLAG = -DSECONDARY

CFLAGS	= -I. -I$(COMMONDIR) -I/usr/include/dce -g -c  -DAIX_PROD # -DDEBUGIT
#CFLAGS	= -I. -I$(COMMONDIR) -I/usr/include/dce -g -c  -DAIX_PROD  -DDEBUGIT

LIBS	= -ldce -lpthreads -lbsd -lcur -lm

#NIDL	= /opt/dcelocal/bin/idl -no_cpp -cc_opt -O #-keep c_source 
NIDL	= /opt/dcelocal/bin/idl -no_cpp -cc_opt -O -keep c_source 

NIDLFLAGS = -I /usr/include/dce  -I . 

.c.o:
	$(CC) $(CFLAGS) $<


all:	nidl mess_pri mess_sec mess_sal  mess_req


nidl:
	-$(NIDL) pos_def.idl $(NIDLFLAGS)
	-$(NIDL) pos_idl.idl $(NIDLFLAGS)
	-$(NIDL) cmr_idl.idl $(NIDLFLAGS)


clean:
	$(RM) *.o 
#	$(RM) mess_pri mess_sec mess_sal mess_req
	$(RM) pos_pri.c pos_sec.c pos_sal.c 


mess_pri: $(PRIOBJS)
	$(CC) -o mess_pri $(PRIOBJS) $(LIBS)

pos_pri.o:
	$(CP) $(COMMONDIR)/pos_srv.c pos_pri.c
	$(CC) $(CFLAGS) $(PRIFLAG) pos_pri.c


mess_sal: $(SALOBJS)
	$(CC) -o mess_sal $(SALOBJS) $(LIBS)

pos_sal.o:
	$(CP) $(COMMONDIR)/pos_srv.c pos_sal.c
	$(CC) $(CFLAGS) $(SALFLAG) pos_sal.c

mess_sec: $(SECOBJS)
	$(CC) -o mess_sec $(SECOBJS) $(LIBS)

pos_sec.o:
	$(CP) $(COMMONDIR)/pos_srv.c pos_sec.c
	$(CC) $(CFLAGS) $(SECFLAG) pos_sec.c


mess_req: $(CLIOBJS)
	$(CC) -o mess_req $(CLIOBJS) $(LIBS)



