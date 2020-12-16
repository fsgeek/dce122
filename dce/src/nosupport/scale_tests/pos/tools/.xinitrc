#!/bin/ksh
# @(#)58	1.31  com/XTOP/aixclients/xinit/xinitrc, xclients, gos320, 9144320 10/25/91 15:39:01
#
# COMPONENT_NAME: X11 xinit
#
# FUNCTIONS: .xinitrc 
#
# ORIGINS: 27
#
# (C) COPYRIGHT International Business Machines Corp. 1990
# All Rights Reserved
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
#

# This script is invoked by /usr/lpp/X11/bin/xinit

#****************************************************************
#								*
#     Set the X server's keyboard keysyms to the match the	*
#     engravings of the user's keyboard.			*
#								*
#****************************************************************

KBD=""
XDIR=/usr/lpp/X11/defaults/xmodmap

#*****************************************************************
#
#   - Querying odm (querykbd) to get keyboard id (e.g. En_US).
#
#   - If querykbd returns NULL or there is no keyboard file found,
#  then the environment variable $LANG is used for the keymap.
#
#*****************************************************************


if [ -r $HOME/.Xkeyboard ]
then
    KBD=$HOME/.Xkeyboard
else
    KBD_LANG=`/usr/lpp/X11/bin/querykbd`
    if [ $KBD_LANG = "NULL" ]
    then
	dspmsg $MSG/xinit.cat 1 '1356-801 xinit: Failed to query omd for keyboard id'
    fi

    if [ "$KBD_LANG" != "En_US" ]
    then
        if [ -r $IMKEYMAPPATH/$KBD_LANG/keyboard ]
        then
             KBD=$IMKEYMAPPATH/$KBD_LANG/keyboard
        else
            if [ "$IMKEYMAPPATH" = "/usr/lib/nls/im.alt"     	\
                -a -r $XDIR/$KBD_LANG/keyboard.alt ]
            then
                KBD=$XDIR/$KBD_LANG/keyboard.alt
            else
                if [ -r $XDIR/$KBD_LANG/keyboard ]
                then
                    KBD=$XDIR/$KBD_LANG/keyboard
                fi
            fi
        fi
    fi
fi


###
# sleep 1 to make sure xclock can get started.
###

if [ "$KBD" != "" ]
then
    /u/pos/tools/dclock -seconds -date "%d %m %Y" &
    sleep 1
    xmodmap $KBD
else
    if [ -r $XDIR/$LANG/keyboard ]
    then
    /u/pos/tools/dclock -seconds -date "%d %m %Y" &
        sleep 1
	xmodmap $XDIR/$LANG/keyboard
    fi
fi


#****************************************************************
#								*
#  Start the X clients.  Change the following lines to		*
#  whatever command(s) you desire!				*
#								*
#  The default clients are an analog clock (xclock), an hft 	*
#  terminal emulator (aixterm), the X Desktop Manager (xdt), 	*
#  and the Motif Window Manager (mwm).				*
#								*
#****************************************************************


aixterm =80x25+0-0 -fg Wheat -bg MidnightBlue &

/u/pos/tools/newwin "Primary Server"
/u/pos/tools/newwin "Price secondary Server"
/u/pos/tools/newwin "Customer secondary Server"
/u/pos/tools/newwin "Standalone Server"
exec mwm
