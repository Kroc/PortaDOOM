'INI Manager - demo 2
'
'syntax: var$ = ReadSetting(file$, "", "")
'
'You can read all keys/values from an .ini file by calling
'ReadSetting with empty section$ and key$ values.
'----------------------------------------------------------------

COLOR 9
PRINT "Fetch every key/value pair in the file:"
DO
    a$ = ReadSetting$("test.ini", "", "")

    IF IniCODE = 1 THEN PRINT IniINFO$: END 'IniCODE = 1 -> File not found
    IF IniCODE = 10 THEN EXIT DO 'IniCODE = 10 -> No more keys found

    COLOR 7
    PRINT IniLastSection$;
    COLOR 15: PRINT IniLastKey$;
    COLOR 4: PRINT "=";
    COLOR 2: PRINT a$
LOOP
COLOR 9
PRINT "End of file."

'----------------------------------------------------------------
'syntax: var$ = ReadSetting(file$, "[section]", "")
'
'You can read all keys/values from a specific section by calling
'ReadSetting with an empty key$ value.
'----------------------------------------------------------------
PRINT
COLOR 9
PRINT "Fetch only section [contact]:"
DO
    a$ = ReadSetting$("test.ini", "contact", "")

    IF IniCODE = 1 THEN PRINT IniINFO$: END 'IniCODE = 1 -> File not found
    IF IniCODE = 10 THEN EXIT DO 'IniCODE = 10 -> No more keys found
    IF IniCODE = 14 THEN PRINT IniINFO$: END 'IniCODE = 14 -> Section not found

    COLOR 7
    PRINT IniLastSection$;
    COLOR 15: PRINT IniLastKey$;
    COLOR 4: PRINT "=";
    COLOR 2: PRINT a$
LOOP
COLOR 9
PRINT "End of section."


'$include:'ini.bm'
