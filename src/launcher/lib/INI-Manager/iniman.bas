'iniman - command line utility to edit/view .ini files
'based on INI Manager - Fellippe Heitor, 2017-2019
'fellippe@qb64.org - @FellippeHeitor
OPTION _EXPLICIT

$CONSOLE:ONLY
_DEST _CONSOLE

'$include:'ini.bi'

IF _COMMANDCOUNT = 0 OR COMMAND$(1) = "/?" OR COMMAND$(1) = "-?" OR LCASE$(COMMAND$(1)) = "-help" OR LCASE$(COMMAND$(1)) = "/help" THEN
    Usage
END IF

DIM file$, a$
file$ = COMMAND$(1)

SELECT CASE LCASE$(COMMAND$(2))
    CASE "", "-read", "read", "-r", "r"
        checkFile

        IF _COMMANDCOUNT = 4 THEN
            PRINT ReadSetting(file$, COMMAND$(3), COMMAND$(4))
        ELSE
            DO
                a$ = ReadSetting$(file$, COMMAND$(3), "")

                IF LEFT$(IniINFO$, 6) = "ERROR:" THEN EXIT DO
                IF IniCODE = 10 THEN EXIT DO 'No more keys

                PRINT IniLastSection$; " "; IniLastKey$; "="; a$
            LOOP
        END IF
    CASE "-write", "write", "-w", "w"
        IF LCASE$(RIGHT$(file$, 4)) <> ".ini" THEN file$ = file$ + ".ini"
        IF _COMMANDCOUNT >= 4 THEN
            WriteSetting file$, COMMAND$(3), COMMAND$(4), COMMAND$(5)
            PRINT ReadSetting(file$, COMMAND$(3), COMMAND$(4))
        ELSE
            Usage
        END IF
    CASE "-delete", "delete", "-d", "d"
        checkFile

        IF _COMMANDCOUNT = 3 THEN
            IniDeleteSection file$, COMMAND$(3)
        ELSEIF _COMMANDCOUNT = 4 THEN
            IniDeleteKey file$, COMMAND$(3), COMMAND$(4)
        ELSE
            Usage
        END IF
    CASE "-sort", "sort", "-s", "s"
        checkFile

        IF _COMMANDCOUNT = 3 THEN
            IniSortSection file$, COMMAND$(3)
        ELSE
            Usage
        END IF
    CASE "-move", "move", "-m", "m"
        checkFile

        IF _COMMANDCOUNT = 5 THEN
            IniMoveKey file$, COMMAND$(3), COMMAND$(4), COMMAND$(5)
        ELSE
            Usage
        END IF
    CASE "-sections", "sections", "-se", "se"
        checkFile

        IF _COMMANDCOUNT = 2 THEN
            DO
                PRINT IniNextSection$(file$)
                IF IniCODE = 24 THEN EXIT DO
            LOOP
        ELSE
            Usage
        END IF
    CASE ELSE
        Usage
END SELECT

IF IniCODE > 0 THEN PRINT IniINFO$
SYSTEM IniCODE

SUB Usage
    PRINT "iniman - INI manager"
    PRINT "by Fellippe Heitor, 2017-2019"
    PRINT
    PRINT "Usage:"
    PRINT
    PRINT "    iniman file.ini -read      [section [key]]"
    PRINT "                    -write     section key value"
    PRINT "                    -move      source_section key destination_section"
    PRINT "                    -delete    section [key]"
    PRINT "                    -sort      section"
    PRINT "                    -sections"
    PRINT
    PRINT "If a section or key name contains spaces, enclose it in quotation marks."
    SYSTEM
END SUB

SUB checkFile
    SHARED file$
    IF NOT _FILEEXISTS(file$) THEN
        IF NOT _FILEEXISTS(file$ + ".ini") THEN
            PRINT "File not found."
            SYSTEM
        ELSE
            file$ = file$ + ".ini"
        END IF
    END IF
END SUB

'$include:'ini.bm'
