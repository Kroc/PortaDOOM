'copyright (C) Kroc Camen 2018, BSD 2-clause

'get CPU type for the system (32 / 64-bit)
DIM SHARED CPU_BIT AS _UNSIGNED LONG
'default to 32-bit as this will always work
LET CPU_BIT = 32
'check the environment variables for CPU type:
'this one would only be true if we are a 64-bit executable also
IF ENVIRON$("PROCESSOR_ARCHITECTURE") = "AMD64" THEN LET CPU_BIT = 64
'detect 64-bit system from a 32-bit executable (WOW64)
IF ENVIRON$("PROCESSOR_ARCHITEW6432") = "AMD64" THEN LET CPU_BIT = 64

'directory of this executable
'(regardless of where it was called from)
DIM SHARED DIR_EXE$
LET DIR_EXE$ = Paths_AddSlash$(_CWD$)

'the 'current directory' (where this executable was called *from*).
'double-clicking on the EXE will mean that this path is the same as DIR_EXE$
'but a shortcut or batch script may be calling from a different path
DIM SHARED DIR_CUR$
LET DIR_CUR$ = Paths_AddSlash$(_STARTDIR$)

DIM SHARED glVersion$