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
#  $Id$

!include $(MAKEDEFS)

OUTDIR=$(OUTDIR_BIN)
INTDIR=$(BUILDTYPE)

DLLNAME=somcdr

TARGET_DLL=$(OUTDIR)\$(DLLNAME).dll
TARGET_PDB=$(OUTDIR)\$(DLLNAME).pdb
TARGET_DEF=..\$(PLATFORM_DEF)\$(DLLNAME).def

PARTOPTS=	$(STDOPT)								\
			/DWIN32_LEAN_AND_MEAN 					\
			/DBUILD_SOMCDR							\
			/DHAVE_CONFIG_H							\
			/I$(INTDIR)								\
			/I..\include							\
			/I..\..\include\$(PLATFORM)				\
			/I..\..\include\$(PLATFORM_DEF)			\
			/I..\..\include							\
			/I..\..\somidl\$(PLATFORM)				\
			/I..\..\rhbmtut\include					\
			/I..\..\somkpub\include					\
			/I..\..\somtk\include					\
			$(CC_OUT_PDB)$(TARGET_PDB)	

OBJS=	$(INTDIR)\rhbsomut.obj	\
		$(INTDIR)\rhbsomkd.obj	\
		$(INTDIR)\rhbsomue.obj	\
		$(INTDIR)\somcdr.obj	\
		$(INTDIR)\link386.obj

all: $(TARGET_DLL)

clean:
	$(CLEAN)	$(TARGET_DLL)				\
				$(TARGET_PDB)				\
				$(OBJS)						\
				$(OUTDIR)\$(DLLNAME).exp	\
				$(OUTDIR)\$(DLLNAME).lib	\
				$(INTDIR)\$(DLLNAME).res
	
$(TARGET_DLL): $(OBJS) $(OUTDIR) $(TARGET_DEF) $(INTDIR)\$(DLLNAME).res
	$(CC) $(CC_OUT_DLL)$@ $(OBJS)		\
			$(CC_OUT_PDB)$(TARGET_PDB)	\
			$(CC_LINK)					\
			$(LDFLAGS)					\
			$(LD_DEF)$(TARGET_DEF)		\
			$(INTDIR)\$(DLLNAME).res
	$(POSTLINK_DLL) $@

$(INTDIR)\rhbsomut.obj: ..\src\rhbsomut.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomut.c

$(INTDIR)\rhbsomkd.obj: ..\src\rhbsomkd.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomkd.c

$(INTDIR)\rhbsomue.obj: ..\src\rhbsomue.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomue.c

$(INTDIR)\rhbsomuk.obj: ..\src\rhbsomuk.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomuk.c

$(INTDIR)\rhbsomup.obj: ..\src\rhbsomup.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomup.c

$(INTDIR)\somcdr.obj: ..\src\somcdr.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somcdr.c

$(INTDIR)\link386.obj: ..\win32\link386.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\link386.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(DLLNAME).res: ..\win32\$(DLLNAME).rc
	rc /nologo /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(DLLNAME).rc

dist:




test:
