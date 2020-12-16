##############################################################################
# [22.VI.94]                                                                 #
#                                                                            #
# Makefile: A generic makefile suitable for building the context             #
#           application.                                                     #
#                                                                            #
#                               -77 cols-                                    #
##############################################################################
#
# 
# library and include paths...

DCEROOT		= /opt/dcelocal

CC		= /bin/cc

IDLC		= /bin/idl

LIBDIRS		= -L$(DCEROOT)/usr/lib

LIBS		= -ldce

LIBALL		= $(LIBDIRS) $(LIBS)

INC		= -I. -I$(DCEROOT)/share/include -I$(DCEROOT)/usr/include

#
# NOTE: The following four lines are needed on HPUX...
# 
#
# LDFLAGS =-Wl,-Bimmediate,-Bnonfatal
# IDLCOPT=-cc_opt -D_HPUX_SOURCE
# CDEFS = -D_HPUX_SOURCE
# CC = c89
#


# CC flags

CFLAGS = -g $(CDEFS) $(INC)

# IDL compiler flags

IFLAGS = -v $(INC) -cc_cmd "$(CC) $(CFLAGS) -c" -keep all $(IDLCOPT)

# Interface name 

IF = context

# TARGETS 

# executables

CLIENT = $(IF)_client
SERVER = $(IF)_server

# objects

CLIENTO = $(IF)_client.o
SERVERO = $(IF)_server.o
MGRO = $(IF)_manager.o
CLIENTSO = $(IF)_cstub.o
SERVERSO = $(IF)_sstub.o

# IDL generated

HDR = $(IF).h
CLIENTSC = $(IF)_cstub.c
SERVERSC = $(IF)_sstub.c
FROMIDL = $(HDR) $(CLIENTSC) $(SERVERSC)

# DEPENDENCIES

all: $(CLIENT) $(SERVER)

# Executables (.o dependencies)

$(SERVER):	$(SERVERSO) $(SERVERO) $(MGRO)
		$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SERVERSO) $(SERVERO) $(MGRO) $(LIBALL)

$(CLIENT):	$(CLIENTSO) $(CLIENTO)
		$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(CLIENTSO) $(CLIENTO) $(LIBALL)

# Object files (.c and .h dependencies)

$(SERVERSO):	$(SERVERSC) $(HDR) 

$(CLIENTSO):	$(CLIENTSC) $(HDR)

$(SERVERO):	$(IF)_server.c $(HDR) 

$(CLIENTO):	$(IF)_client.c	$(HDR) 

$(MGRO):	$(IF)_manager.c $(HDR)


# IDL generated files (.idl and .acf dependencies)

$(FROMIDL):	$(IF).idl $(IF).acf
	$(IDLC) $(IF).idl $(IFLAGS)

clean:
	rm -f $(FROMIDL) $(SERVERSO) $(SERVERO) $(MGRO) $(CLIENTSO) $(CLIENTO)

rmtarget:
	rm -f $(CLIENT) $(SERVER) core

clobber: clean rmtarget

# 
# 
# 
# 
