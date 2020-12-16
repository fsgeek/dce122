...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.11dsex.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:14:50  fred
.\" 	free copyright
.\" 	[1994/06/23  20:20:43  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:38:42  fred
.\" 	free copyright
.\" 	[1994/06/22  19:07:14  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:22  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:01:47  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:28  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:21  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:03:44  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:56:38  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
...\"
.TH mbuf "4" "" "" "" 
.iX "mbuf" 
.SH NAME 
.B mbuf 
- Defines a socket message buffer 
.iX "mbuf"
.iX "m_hdr" 
.iX "m_pkthdr" 
.iX "m_ext" 
.SH SYNOPSIS 
.P 
.B "#include <sys/mbuf.h>" 
.br 
.br 
.B struct 
.BR mbuf { 
.br 
.in +.5i 
.B struct mbuf
.IR *m_next ;
.br
.B struct mbuf 
.IR *m_nextpkt ;
.br
.B long
.IR m_len ;
.br
.B caddr_t 
.IR m_data ;
.br
.B short 
.IR m_type ;
.br
.B short 
.IR m_flags ;
.br
.B struct m_pkthdr 
.IR m_pkthdr ;
.br
.B struct m_ext 
.IR m_ext ;
.br
.B char 
.IR m_dat [XXX];
.in -.5i 
};
.SH FIELDS 
.P 
.TP .5i 
.I m_next 
A pointer to the next mbuf in the message.
.TP
.I m_nextpkt
A pointer to the next mbuf in the chain of mbufs.
.TP
.I m_len 
The length of data in this mbuf.
.TP
.I m_data 
A pointer to the mbuf data.
.TP
.I m_type
The type of mbuf.  Some possible values are:
.RS 
.TP 1i
MT_HEADER
The mbuf contains a packet header.
.TP
MT_DATA
The mbuf contains data.
.TP
MT_OOBDATA
The mbuf contains out-of-band (urgent) data.
.RE
.TP .5i
.I m_flags
The mbuf flags. Some possible values are:
.RS 
.TP 1i
M_PKTHDR
The mbuf contains the optional
.I m_pkthdr 
field, indicating that the mbuf is the first mbuf 
in a packet.
.TP
M_EXT
The mbuf contains the optional
.I m_ext 
field, which references external storage.
.TP
M_BCAST
The mbuf is being used for a sent or received link-level broadcast
message.
.RE
.TP .5i
.I m_pkthdr 
The 
.B m_pkthdr 
structure that describes the packet header, in the first mbuf
in the first mbuf chain.  If the M_PKTHDR bit is not set in 
.IR m_flags , 
this field is NULL and the 
.B m_pkthdr 
structure is not included.
.TP
.I m_ext 
The 
.B m_ext 
structure that describes external storage mapped into the mbuf.  
If the M_EXT is not set in 
.IR m_flags , 
this field is NULL and the 
.B m_ext 
structure is not included.
.TP
.I m_dat 
The mbuf's internal storage.  The size of the 
.B m_pkthdr 
structure (if M_PKTHDR bit is set in 
.IR m_flags ) 
or the size of the 
.B m_ext 
structure (if M_EXT bit is set in 
.IR m_flags ) 
is subtracted from the total available size of the mbuf's 
internal storage.
.P 
.SH DESCRIPTION 
.P 
The 
.B mbuf 
structure defines a socket message buffer.  Mbufs implement the 
memory management scheme used by
the socket-based networking subsystems.
.P
All mbufs have a length of MSIZE (defined in \fImachine\fB/machparam.h\fR), 
which includes overhead.  
The data portion of a message is stored in the internal data area
of the mbuf or in external storage.  An mbuf can add a single unit of
external storage with no additional
overhead.  A standard external buffer of size MCLBYTES (defined in
\fImachine\fB/machparam.h\fR) can be added to an mbuf using the MCLGET
macro.
.P
The 
.I m_type 
field is used primarily to distinguish the components of a message
contained in an mbuf chain.  The socket layer uses these distinctions
when processing the messages in a socket's receive queue.
.P
If the mbuf is the first mbuf in the first mbuf chain, it is the
packet header.  In this case, the M_PKTHDR bit is set in 
.I m_flags .  
The optional 
.I m_pkthdr 
field is also set and the 
.B m_pkthdr 
structure is included in the mbuf's internal data area.  The 
.B m_pkthdr 
structure is defined (in \fBsys/mbuf.h\fR) as follows:
.P
.oS
struct m_pkthdr {
       long         len;
       struct ifnet *rcvif;
}
.oE
.P
The 
.B m_pkthdr 
fields are defined as follows:
.RS
.TP .5i 
.I len
The total length of the message to which the mbuf belongs
(\fIm_next\fR field).
.TP
.I rcvif
A pointer to the interface that received the message.
.RE
.P
If the mbuf references external storage, the M_EXT bit is set in 
.I m_flags .  
The optional 
.I m_ext 
field is also set and the 
.B m_ext 
structure is included in the mbuf's internal data area.  The 
.B m_ext
structure is defined (in \fBsys/mbuf.h\fR) as follows:
.P
.oS
struct m_ext {
       caddr_t ext_buf;
       void    (*ext_free)();
       u_long  ext_size;
       caddr_t ext_arg;
       struct  ext_refq {
               struct ext_refq *forw;
               struct ext_refq *back;
       } ext_ref;
}
.oE
.P
The 
.B m_ext 
fields are defined as follows:
.RS
.TP .5i 
.I ext_buf
A pointer to the external buffer.
.TP
.I ext_free 
A pointer to the routine to be used to free the external buffer.
.TP
.I ext_size
The size of the external buffer, in bytes.
.TP
.I ext_arg
An additional argument to be passed to the 
.I ext_free
routine.
.TP
.I ext_ref
The doubly-linked list of external references that includes this
external buffer.
.RE
.P
.SH NOTES
.P
The structure shown here is a schematized representation.  The actual 
.B mbuf 
structure is a composite of fields from the three following structures:
.TP .3i
\(bu
.B m_hdr 
\- Defines the mbuf header information and carries pointers to the
next mbuf in the message and the next mbuf in the chain of mbufs.
The mbuf structure
includes all of the fields from this structure.
.TP
\(bu
.B m_pkthdr 
\- Defines the mbuf packet header information and carries a pointer to
the 
.B ifnet 
structure that identifies the receiving network interface.  The mbuf structure
includes the 
.B m_pkthdr 
structure only if the mbuf is the first mbuf in a packet.
.TP
\(bu
.B m_ext
\- Defines external storage mapped into the mbuf.  The mbuf structure
includes the 
.B m_ext 
structure only if the mbuf references external storage.
.P
.SH FILES
.P
.B sys/mbuf.h
.P
.B bsd/uipc_mbuf.c
.SH RELATED INFORMATION
Interfaces: 
.BR mblk_to_mbuf(2) ,
.BR mbuf_to_mblk(2)
