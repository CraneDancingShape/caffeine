TARGETNAME=caffeine
TARGETNAME_C=main
TARGETNAME_R=resources
OUTDIR=.\Release
LINK32=link.exe

ALL : "$(OUTDIR)\$(TARGETNAME).exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPPFLAGS=\
    /O2 /Oi /GL\
    /nologo\
    /MT\
    /W3\
    /Fo"$(OUTDIR)\\"\
    /Fd"$(OUTDIR)\\"\
    /c\
    /Zi\
    /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "UNICODE"\
    /FD\
    /EHsc\
    /MT\
    /Gy\

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
        odbccp32.lib

LINK32_OBJS= \
    "$(OUTDIR)\$(TARGETNAME_C).obj"\
    "$(OUTDIR)\$(TARGETNAME_R).res"


RFLAGS=\
    /d "_UNICODE" /d "UNICODE"\
    /fo"$(OUTDIR)\$(TARGETNAME_R).res"

"$(OUTDIR)\$(TARGETNAME).exe" : "$(OUTDIR)" $(LINK32_OBJS)
    $(LINK32) $(LINK32_FLAGS) $(LINK32_OBJS)

.c{$(OUTDIR)}.obj:
    $(CPP) $(CPPFLAGS) $<

.cpp{$(OUTDIR)}.obj:
    $(CPP) $(CPPFLAGS) $<

.rc{$(OUTDIR)}.res:
    $(RC) $(RFLAGS) $<

