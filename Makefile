TARGETNAME=caffeine
TARGETNAME_C=main
TARGETNAME_R=resources
OUTDIR=.\Release
MANIFEST=manifest.xml

LINK32=link.exe
MT=mt.exe

ALL : "$(OUTDIR)\$(TARGETNAME).exe"

"$(OUTDIR)" :
    @if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CFLAGS=\
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
    /ERRORREPORT:PROMPT kernel32.lib\
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
        libucrt.lib

LINK32_OBJS= \
    "$(OUTDIR)\$(TARGETNAME_C).obj"\
    "$(OUTDIR)\$(TARGETNAME_R).res"

RFLAGS=\
    /nologo\
    /d "_UNICODE" /d "UNICODE"\
    /fo"$(OUTDIR)\$(TARGETNAME_R).res"

MT_FLAGS=\
    -nologo\
    -outputresource:"$(OUTDIR)\$(TARGETNAME).exe"\
    -manifest ".\$(MANIFEST)"

clean:
    @del /F /Q $(OUTDIR)

"$(OUTDIR)\$(TARGETNAME).exe" : "$(OUTDIR)" $(LINK32_OBJS)
    $(LINK32) $(LINK32_FLAGS) $(LINK32_OBJS)
    $(MT) $(MT_FLAGS)

.c{$(OUTDIR)}.obj:
    $(CPP) $(CFLAGS) $<

.cpp{$(OUTDIR)}.obj:
    $(CPP) $(CPPFLAGS) $<

.rc{$(OUTDIR)}.res:
    $(RC) $(RFLAGS) $<

