'iniman - command line utility to edit/view .ini files
'based on INI Manager - Fellippe Heitor, 2017
'fellippe@qb64.org - @FellippeHeitor
OPTION _EXPLICIT

$CONSOLE:ONLY
_DEST _CONSOLE

'$include:'ini.bi'

IF _COMMANDCOUNT = 0 OR COMMAND$(1) = "/?" OR COMMAND$(1) = "-?" OR LCASE$(COMMAND$(1)) = "-help" OR LCASE$(COMMAND$(1)) = "/help" THEN
    Usage
END IF

IF NOT _FILEEXISTS(COMMAND$(1)) THEN
    PRINT "File not found."
    SYSTEM
END IF

DIM file$, a$
file$ = COMMAND$(1)

SELECT CASE LCASE$(COMMAND$(2))
    CASE "", "-read", "read", "-r", "r"
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
        IF _COMMANDCOUNT >= 4 THEN
            WriteSetting file$, COMMAND$(3), COMMAND$(4), COMMAND$(5)
            PRINT ReadSetting(file$, COMMAND$(3), COMMAND$(4))
        ELSE
            Usage
        END IF
    CASE "-delete", "delete", "-d", "d"
        IF _COMMANDCOUNT = 3 THEN
            IniDeleteSection file$, COMMAND$(3)
        ELSEIF _COMMANDCOUNT = 4 THEN
            IniDeleteKey file$, COMMAND$(3), COMMAND$(4)
        ELSE
            Usage
        END IF
    CASE "-sort", "sort", "-s", "s"
        IF _COMMANDCOUNT = 3 THEN
            IniSortSection file$, COMMAND$(3)
        ELSE
            Usage
        END IF
    CASE "-move", "move", "-m", "m"
        IF _COMMANDCOUNT = 5 THEN
            IniMoveKey file$, COMMAND$(3), COMMAND$(4), COMMAND$(5)
        ELSE
            Usage
        END IF
    CASE "-sections", "sections", "-se", "se"
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
    PRINT "by Fellippe Heitor, 2017"
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

'$include:'ini.bm'
