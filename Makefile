TARGETNAME=caffeine
TARGETNAME_C=main
TARGETNAME_R1=common
TARGETNAME_R2=MSG00411
OUTDIR=.\Release
MANIFEST=manifest.xml

# CPP=ccache.exe cl.exe
LINK32=link.exe
MT=mt.exe

ALL : "$(OUTDIR)\$(TARGETNAME).exe"

"$(OUTDIR)" :
    @if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)" mkdir "$(OUTDIR)\ja-JP"

# CFLAGS=\
#     /O2 /Oi /Ot\
#     /GL /GF /Gy /GA\
#     /arch:AVX\
#     /nologo\
#     /MT\
#     /W4\
#     /analyze\
#     /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "UNICODE"\
#     /Fo"$(OUTDIR)\\"\
#     /Fd"$(OUTDIR)\\"\
#     /c\
#     /Zi\
#     /Zf\
#     /MP\
#     /EHsc\
#     /FD\
#     /std:c17
#
# ccache is ignore: /analyze /Zi
CFLAGS=\
    /O2 /Oi /Ot\
    /GL /GF /Gy /GA\
    /arch:AVX\
    /nologo\
    /MT\
    /W4\
    /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "UNICODE"\
    /Fo"$(OUTDIR)\\"\
    /Fd"$(OUTDIR)\\"\
    /c\
    /Z7\
    /Zf\
    /MP\
    /EHsc\
    /FD\
    /std:c17

CPPFLAGS=\
    /O2 /Oi /Ot\
    /GL /GF /Gy /GA\
    /arch:AVX\
    /nologo\
    /MT\
    /W4\
    /analyze\
    /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "UNICODE"\
    /Fo"$(OUTDIR)\\"\
    /Fd"$(OUTDIR)\\"\
    /c\
    /Zi\
    /Zf\
    /MP\
    /EHsc\
    /FD\
    /std:c++20\
    /await

LINK32_FLAGS=\
    /out:"$(OUTDIR)\$(TARGETNAME).exe"\
    /INCREMENTAL:NO\
    /NOLOGO\
    /MANIFEST\
    /MANIFESTFILE:"$(OUTDIR)\$(TARGETNAME).exe.intermediate.manifest"\
    /MANIFESTUAC:"level='asInvoker' uiAccess='false'"\
    /DEBUG\
    /pdb:"$(OUTDIR)\$(TARGETNAME).pdb"\
    /SUBSYSTEM:WINDOWS\
    /OPT:REF\
    /OPT:ICF\
    /LTCG\
    /STACK:4194304,4096\
    /DYNAMICBASE\
    /NXCOMPAT\
    /MACHINE:X64\
    /ERRORREPORT:PROMPT\
        kernel32.lib\
        user32.lib\
        gdi32.lib\
        winspool.lib\
        comdlg32.lib\
        advapi32.lib\
        shell32.lib\
        ole32.lib\
        oleaut32.lib\
        uuid.lib\
        odbc32.lib\
        odbccp32.lib\
        muiload.lib\
        libcmt.lib\
        libvcruntime.lib\
        libucrt.lib\
        dwmapi.lib

# LINK32_OBJS= \
#     "$(OUTDIR)\$(TARGETNAME_C).obj"

LINK32_OBJS= \
    "$(OUTDIR)\$(TARGETNAME_C).obj"\
    "$(OUTDIR)\$(TARGETNAME_R1).res"

# RCFLAGS=\
#     /nologo\
#     /d "_UNICODE" /d "UNICODE"\
#     /fo"$(OUTDIR)\$(TARGETNAME_R1).res"\
#     /fm"$(OUTDIR)\$(TARGETNAME_R2).res"\
#     /q common.rcconfig

# RCFLAGS=\
#     /nologo\
#     /d "_UNICODE" /d "UNICODE"\
#     /fo"$(OUTDIR)\$(TARGETNAME_R1).res"

#rc /fo common.res /fm MSG0409.res /q Sample.rcconfig Sample.rc

# RCFLAGS=\
#     /nologo\
#     /d "_UNICODE" /d "UNICODE"\
#     /fo"$(OUTDIR)\$(TARGETNAME_R1).res"\
#     /fm"$(OUTDIR)\$(TARGETNAME_R2).res"\
#     /q sample.rcconfig

MTFLAGS=\
    -nologo\
    -outputresource:"$(OUTDIR)\$(TARGETNAME).exe"\
    -manifest ".\$(MANIFEST)"


clean:
    @del /F /Q $(OUTDIR)

"$(OUTDIR)\$(TARGETNAME).exe" : "$(OUTDIR)" $(LINK32_OBJS)
    $(LINK32) $(LINK32_FLAGS) $(LINK32_OBJS)
    @rem link /out:.\Release\ja-JP\i18n.exe.mui /nodefaultlib /nologo /noentry /dynamicbase /nxcompat /machine:X64 /dll .\Release\lang-ja-JP.res
    @rem muirct -c .\Release\caffeine.exe -e .\Release\ja-JP\i18n.exe.mui
    @rem $(MT) $(MTFLAGS)


.c{$(OUTDIR)}.obj:
    $(CPP) $(CFLAGS) $<

.cpp{$(OUTDIR)}.obj:
    $(CPP) $(CPPFLAGS) $<

.rc{$(OUTDIR)}.res:
    $(RC) $(RCFLAGS) /fo$@ $<

# .rc{$(OUTDIR)}.res:
#     $(RC) $(RCFLAGS) sample.rc
#     $(RC) $(RCFLAGS) $<
