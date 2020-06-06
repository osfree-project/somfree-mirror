#!/bin/sh
#
#  Copyright 2008, Roger Brown
#
#  This file is part of Roger Brown's Toolkit.
#
#  This program is free software: you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by the
#  Free Software Foundation, either version 3 of the License, or (at your
#  option) any later version.
# 
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>
#
# $Id$
#

X11CONTENDERS="/usr/X11R6 /opt/X11R6 /usr/X11R7 /opt/X11R7"

. ../../toolbox/findlibs.sh

if test "$SOCKLIBS" != ""
then
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS SOCKLIBS"
fi

if test "$UUIDLIBS" != ""
then
	HAVE_LIBUUID=true
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS UUIDLIBS"
fi

if test "$THREADLIBS" != ""
then
	CONFIG_LIBS="$THREADLIBS $CONFIG_LIBS"
fi

if test "$DLLIBS" != ""
then
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS DLLIBS"
fi

if test "$HAVE_LIBUUID" = ""
then
	HAVE_LIBUUID=false
fi

MAKEDEFS_DEFS="$MAKEDEFS_DEFS HAVE_LIBUUID"
