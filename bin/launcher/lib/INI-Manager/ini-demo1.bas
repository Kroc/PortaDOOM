'INI Manager - demo 1
'
'syntax: WriteSetting file$, section$, key$, value$

'write a new key/value pair to an .ini file or update an existing
'if the file doesn't exist, it'll be created.
'----------------------------------------------------------------

'(brackets in section names are optional; will be added automatically anyway)
WriteSetting "test.ini", "[general]", "version", "Beta 4"
GOSUB Status

'subsequent calls don't need to mention the file again
WriteSetting "", "general", "date", DATE$
GOSUB Status

WriteSetting "", "general", "time", TIME$
GOSUB Status

WriteSetting "", "credits", "author", "Fellippe Heitor"
GOSUB Status

WriteSetting "", "contact", "email", "fellippe@qb64.org"
GOSUB Status

WriteSetting "", "contact", "twitter", "@FellippeHeitor"
GOSUB Status

PRINT "File created/updated. I'll wait for you to check it with your editor of choice."
PRINT "Hit any key to continue..."
PRINT
a$ = INPUT$(1)

WriteSetting "", "general", "version", "Beta 4 - check the repo"
GOSUB Status

PRINT "File updated again. Go check it if you will."
END

Status:
COLOR 7: PRINT IniINFO
COLOR 15: PRINT IniLastSection$; IniLastKey$: PRINT
RETURN

'$include:'ini.bm'
