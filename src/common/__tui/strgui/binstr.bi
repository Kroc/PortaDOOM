'copyright (C) Kroc Camen 2018-2020, BSD 2-clause

'$INCLUDE: 'ascii.bi'

'binary string format:
'-----------------------------------------------------------------------------

'escape marker: indicates a command to follow
CONST BINSTR_ESC = &HFF

'command: set the foreground and background colour
CONST BINSTR_COLOR = &H15

'a data byte follows:
'- bits 1-4 = foreground colour (0-15)
'- bit 5 = foreground blink enable (i.e. 16-31)
'- bits 6-8 = background colour

'command: set foreground colour only,
'data byte format is the same as above
CONST BINSTR_FORE = &H1
'command: set background colour only,
'data byte format is the same as above
CONST BINSTR_BACK = &H2

'command: restore previous foreground colour
CONST BINSTR_RFORE = &H9
'command: restore previous background colour
CONST BINSTR_RBACK = &H10

'command: move cursor to specific row relative to starting print position
CONST BINSTR_SETY = &H12
'command: move cursor to specific column relative to starting print position
CONST BINSTR_SETX = &H1D

'command: move cursor vertically
'data byte is a signed-offset
CONST BINSTR_MOVY = &H19

'command: move cursor horizontally
'data byte is a signed-offset
CONST BINSTR_MOVX = &H1A

'command: move cursor vertically and horizontally
'two data bytes follow, Y & X, both are signed-offsets
CONST BINSTR_MOVE = &H1C

'commands: save X and/or Y cursor location
CONST BINSTR_SAVEX = &H81
CONST BINSTR_SAVEY = &H82
CONST BINSTR_SVPOS = &H83

'commands: load X and/or Y cursor location
CONST BINSTR_LOADX = &H91
CONST BINSTR_LOADY = &H92
CONST BINSTR_LDPOS = &H93

CONST BINSTR_SAVEL = &H84
CONST BINSTR_LOADL = &H94

'command: new-line. cursor down and returns to left-margin
CONST BINSTR_NLINE = &HD

'command: reprint character under cursor
'data byte follows with number of characters to reprint
CONST BINSTR_ECHO = &HB1
