/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: tsh_util.h,v $
 * Revision 1.1.4.2  1996/02/18  23:06:54  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  22:27:32  marty]
 *
 * Revision 1.1.4.1  1995/12/11  20:12:22  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/11  19:46:01  root]
 * 
 * Revision 1.1.2.3  1993/01/25  19:29:53  bbelch
 * 	Fix duplicate log
 * 	[1993/01/25  17:46:53  bbelch]
 * 
 * Revision 1.1.2.2  1993/01/13  19:49:36  bbelch
 * 	Embedding copyright notice
 * 	[1993/01/06  18:16:21  bbelch]
 * 
 * Revision 1.1  1992/01/19  03:37:56  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
#
#
# Copyright (c) 1991 by
#    Hewlett-Packard Company, Palo Alto, Ca.
#
# Permission to use, copy, modify, and distribute this
# software and its documentation for any purpose and without
# fee is hereby granted, provided that the above copyright
# notice appear in all copies and that both that copyright
# notice and this permission notice appear in supporting
# documentation, and that the name of Hewlett-Packard Company not
# be used in advertising or publicity pertaining to distribution
# of the software without specific, written prior permission.
# Hewlett-Packard Company makes no representations about the
# suitability of this software for any purpose.  It is provided
# "as is" without express or implied warranty.
#
#
# DCE API Test
#
*/



#include <dce/rpc.h>
#include <tsh_common.h>

/* %*START*% Start the body of code that will get translated into the FILE.tshrc */

#define STRCVT                0

/* %*STOP*%  Stop translating for FILE.tshrc  */


#define tsh_c_char_max_size 256
 
#define SETUP_TEST_TABLE(table) { \
                                int i; \
                                for(i=0; i< tsh_c_char_max_size; i++) \
                                    table[i] = i; \
                                }

unsigned_char_t tsh_c_ascii_table[] = 
    {
    0x00, 0x01, 0x02, 0x03, 0x37, 0x2D, 0x2E, 0x2F,
    0x16, 0x05, 0x25, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
    0x10, 0x11, 0x12, 0x13, 0x3C, 0x3D, 0x32, 0x26,
    0x18, 0x19, 0x3F, 0x27, 0x1C, 0x1D, 0x1E, 0x1F,
    0x40, 0x5A, 0x7F, 0x7B, 0x5B, 0x6C, 0x50, 0x7D,
    0x4D, 0x5D, 0x5C, 0x4E, 0x6B, 0x60, 0x4B, 0x61,
    0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7,
    0xF8, 0xF9, 0x7A, 0x5E, 0x4C, 0x7E, 0x6E, 0x6F,
    0x7C, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7,
    0xC8, 0xC9, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6,
    0xD7, 0xD8, 0xD9, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6,
    0xE7, 0xE8, 0xE9, 0xAD, 0xE0, 0xBD, 0x5F, 0x6D,
    0x79, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
    0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,
    0x97, 0x98, 0x99, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6,
    0xA7, 0xA8, 0xA9, 0xC0, 0x4F, 0xD0, 0xA1, 0x07
    };

unsigned_char_t tsh_c_ebcdic_table[] = 
    {
    0x20, 0x01, 0x02, 0x03, 0x3F, 0x09, 0x3F, 0x10,
    0x3F, 0x3F, 0x3F, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
    0x10, 0x11, 0x12, 0x13, 0x3F, 0x3F, 0x08, 0x3F,
    0x18, 0x19, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x3F, 0x1C, 0x3F, 0x3F, 0x3F, 0x17, 0x1B,
    0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x05, 0x06, 0x07,
    0x00, 0x00, 0x16, 0x00, 0x3F, 0x1E, 0x3F, 0x04,
    0x3F, 0x3F, 0x3F, 0x3F, 0x14, 0x15, 0x00, 0x1A,
    0x20, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x3F, 0x3F, 0x2E, 0x3C, 0x28, 0x2B, 0x7C,
    0x26, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x3F, 0x21, 0x24, 0x2A, 0x29, 0x3B, 0x5E,
    0x2D, 0x2F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x3F, 0x3F, 0x2C, 0x25, 0x5F, 0x3E, 0x3F,
    0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x60, 0x3A, 0x23, 0x40, 0x27, 0x3D, 0x22,
    0x3F, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
    0x68, 0x69, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
    0x71, 0x72, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x7E, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
    0x79, 0x7A, 0x3F, 0x3F, 0x3F, 0x5B, 0x3F, 0x3F,
    0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x5D, 0x3F, 0x3F,
    0x7B, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
    0x48, 0x49, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x7D, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50,
    0x51, 0x52, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x5C, 0x3F, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
    0x59, 0x5A, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
    0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
    0x38, 0x39, 0x7C, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F
    };
