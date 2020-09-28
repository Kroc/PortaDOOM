'INI Manager - demo 3
'
'syntax: var$ = ReadSetting(file$, key$)
'
'An empty result can mean that the key wasn't found
'or that it was empty, as in the example:
'
'    [section]
'    key1=value1
'    key2=
'
'To know what exactly happened, read the global variable IniCODE.
'For a description of the status code, call IniINFO$
'----------------------------------------------------------------

file$ = "test.ini"
IF _FILEEXISTS(COMMAND$) THEN file$ = COMMAND$ 'passing an .ini will load it instead of test.ini

PRINT "Analyzing file "; file$
DO
    'display bottom status bar
    r = CSRLIN: c = POS(1)
    LOCATE 25, 1: COLOR 14, 6: PRINT SPACE$(80);: LOCATE 25, 2: PRINT "(no input to quit; = to list all key/value pairs";: COLOR 7, 0
    LOCATE r, c

    'read user input
    INPUT ; "Enter section/key to read: ", key$
    IF INSTR(key$, "/") THEN
        section$ = LEFT$(key$, INSTR(key$, "/") - 1)
        key$ = MID$(key$, INSTR(key$, "/") + 1)
    ELSE
        section$ = ""
    END IF

    IF key$ = "=" OR (section$ > "" AND key$ = "") THEN
        'list all key/value pairs
        CLS
        DO
            a$ = ReadSetting$(file$, section$, "")

            IF IniCODE = 1 OR IniCODE = 17 THEN PRINT IniINFO$: EXIT DO 'IniCODE = 1 -> File not found, 17 = empty file
            IF IniCODE = 14 OR IniCODE = 10 THEN PRINT IniINFO$: EXIT DO 'IniCODE = 10 -> No more keys found

            COLOR 7
            PRINT IniLastSection$;
            COLOR 15: PRINT IniLastKey$;
            COLOR 4: PRINT "=";
            COLOR 2: PRINT a$
        LOOP
        PRINT "End of file."
    ELSEIF LEN(LTRIM$(RTRIM$(key$))) > 0 THEN
        'read the key from the file
        a$ = ReadSetting$(file$, section$, key$)
        IF IniCODE THEN
            PRINT
            COLOR 15, 4
            PRINT "RETURN CODE: "; IniCODE, IniINFO$
            COLOR 7, 0
        ELSE
            PRINT " = ";
            COLOR 0, 2: PRINT a$;: COLOR 7, 0: PRINT
        END IF
    ELSE
        PRINT "No input."
        END
    END IF
    PRINT
LOOP

'$include:'ini.bm'
