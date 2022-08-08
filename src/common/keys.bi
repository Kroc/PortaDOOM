'copyright (C) Kroc Camen 2018-2021, BSD 2-clause

'the `KEY` and `ON KEY` functions take a built-in key identifier given below.
'for any other key, a `KEY_USER*` constant should be given
'
'example:
'
'   KEY 1 , "HELP"       'return "HELP" to `INKEY$` when F1 is pressed,
'   ON KEY(1), doF1      'call `doF1` SUB when F1 key is pressed
'   KEY 1 ON             '(has to be enabled once defined)
'
CONST KEY_F1 = 1
CONST KEY_F2 = 2
CONST KEY_F3 = 3
CONST KEY_F4 = 4
CONST KEY_F5 = 5
CONST KEY_F6 = 6
CONST KEY_F7 = 7
CONST KEY_F8 = 8
CONST KEY_F9 = 9
CONST KEY_F10 = 10
CONST KEY_F11 = 30
CONST KEY_F12 = 31

CONST KEY_NUM_UP = 11
CONST KEY_NUM_LEFT = 12
CONST KEY_NUM_RIGHT = 13
CONST KEY_NUM_DOWN = 14

'user defined keys:
'-----------------------------------------------------------------------------
'to set an `ON KEY` event for keys other than F1-F12 & NUMPAD arrows, define
'the custom key with the `KEY` function using one of these user key constants
'followed by two bytes; the first a `KEYFLAG_*` constant, and the second a
'`KEYCODE_*` constant
'
'example:
'
'   'define the custom key combination
'   KEY KEY_USER1, CHR$(KEYFLAG_NONE) + CHR$(KEYCODE_ESC)
'   'set the SUB to call when ESC is pressed, and enable it
'   ON KEY(KEY_USER1) doESC
'   KEY KEY_USER1 ON
'
CONST KEY_USER1 = 15
CONST KEY_USER2 = 16
CONST KEY_USER3 = 17
CONST KEY_USER4 = 18
CONST KEY_USER5 = 19
CONST KEY_USER6 = 20
CONST KEY_USER7 = 21
CONST KEY_USER8 = 22
CONST KEY_USER9 = 23
CONST KEY_USER10 = 24
CONST KEY_USER11 = 25
CONST KEY_USER12 = 26
CONST KEY_USER13 = 27
CONST KEY_USER14 = 28
CONST KEY_USER15 = 29

'these can be combined if you need CTRL+SHIFT modifiers &c.
'
CONST KEYFLAG_NONE = 0 '....no special keys held
CONST KEYFLAG_LSHFT = 1 '...left SHIFT key held
CONST KEYFLAG_RSHFT = 2 '...right SHIFT key held
CONST KEYFLAG_CTRL = 4 '....CTRL key held
CONST KEYFLAG_ALT = 8 '.....ALT key held
CONST KEYFLAG_NUMLK = 32 '..number lock on
CONST KEYFLAG_CAPSLK = 64 '.caps-lock on

'the extended keys on 101/102 key keyboards can only be accessed by
'first including this flag and then using the `KEYCODE_EX_*` constants
CONST KEYFLAG_EXTENDED = 128

'keyboard scan codes:
'-----------------------------------------------------------------------------
'keyboard scan code are based on the physical key position on the keyboard
'(i.e. Q, W, E, R, T, Y) rather than logical ordering
'
CONST KEYCODE_ESC = 1 '.........ESC key
CONST KEYCODE_1 = 2 '..........."1", SHIFT: "!"
CONST KEYCODE_2 = 3 '..........."2", SHIFT: "@" (US) /  "  (UK)
CONST KEYCODE_3 = 4 '..........."3", SHIFT: "#" (US) / "£" (UK)
CONST KEYCODE_4 = 5 '..........."4", SHIFT: "$"
CONST KEYCODE_5 = 6 '..........."5", SHIFT: "%"
CONST KEYCODE_6 = 7 '..........."6", SHIFT: "^"
CONST KEYCODE_7 = 8 '..........."7", SHIFT: "&"
CONST KEYCODE_8 = 9 '..........."8", SHIFT: "*"
CONST KEYCODE_9 = 10 '.........."9", SHIFT: "("
CONST KEYCODE_0 = 11 '.........."0", SHIFT: ")"
CONST KEYCODE_MINUS = 12 '......"-", SHIFT: "_"
CONST KEYCODE_EQUALS = 13 '....."=", SHIFT: "+"
CONST KEYCODE_BKSPC = 14 '......BKSPC key
CONST KEYCODE_TAB = 15 '........TAB key
CONST KEYCODE_Q = 16 '.........."q", SHIFT: "Q"
CONST KEYCODE_W = 17 '.........."w", SHIFT: "W"
CONST KEYCODE_E = 18 '.........."e", SHIFT: "E"
CONST KEYCODE_R = 19 '.........."r", SHIFT: "R"
CONST KEYCODE_T = 20 '.........."t", SHIFT: "T"
CONST KEYCODE_Y = 21 '.........."y", SHIFT: "Y"
CONST KEYCODE_U = 22 '.........."u", SHIFT: "U"
CONST KEYCODE_I = 23 '.........."i", SHIFT: "I"
CONST KEYCODE_O = 24 '.........."o", SHIFT: "O"
CONST KEYCODE_P = 25 '.........."p", SHIFT: "P"
CONST KEYCODE_LSQB = 26 '......."[", SHIFT: "{"
CONST KEYCODE_RSQB = 27 '......."]", SHIFT: "}"
CONST KEYCODE_RETURN = 28 '.....RETURN key
CONST KEYCODE_PAUSE = 29 '......PAUSE key, also left CTRL key?
CONST KEYCODE_A = 30 '.........."a", SHIFT: "A"
CONST KEYCODE_S = 31 '.........."s", SHIFT: "S"
CONST KEYCODE_D = 32 '.........."d", SHIFT: "D"
CONST KEYCODE_F = 33 '.........."f", SHIFT: "F"
CONST KEYCODE_G = 34 '.........."g", SHIFT: "G"
CONST KEYCODE_H = 35 '.........."h", SHIFT: "H"
CONST KEYCODE_J = 36 '.........."j", SHIFT: "J"
CONST KEYCODE_K = 37 '.........."k", SHIFT: "K"
CONST KEYCODE_L = 38 '.........."l", SHIFT: "L"
CONST KEYCODE_COLONS = 39 '.....";", SHIFT: ":"
CONST KEYCODE_APOS = 40 '......."'", SHIFT:  "  (US) / "@" (UK)
CONST KEYCODE_BKTCK = 41 '......"`", SHIFT: "~" (US) / "¬" (UK)
CONST KEYCODE_LSHIFT = 42 '.....left SHIFT key
CONST KEYCODE_BKSLSH = 43 '....."\", SHIFT: "|"
CONST KEYCODE_Z = 44 '.........."z", SHIFT: "Z"
CONST KEYCODE_X = 45 '.........."x", SHIFT: "X"
CONST KEYCODE_C = 46 '.........."c", SHIFT: "C"
CONST KEYCODE_V = 47 '.........."v", SHIFT: "V"
CONST KEYCODE_B = 48 '.........."b", SHIFT: "B"
CONST KEYCODE_N = 49 '.........."n", SHIFT: "N"
CONST KEYCODE_M = 50 '.........."m", SHIFT: "M"
CONST KEYCODE_COMMA = 51 '......",", SHIFT: "<"
CONST KEYCODE_PERIOD = 52 '.....".", SHIFT: ">"
CONST KEYCODE_FWSLSH = 53 '....."/", SHIFT: "?"
CONST KEYCODE_RSHIFT = 54 '.....right SHIFT key
CONST KEYCODE_NUM_ASTRSK = 55 '.numpad "*" key
CONST KEYCODE_ALT = 56 '........left ALT key
CONST KEYCODE_SPC = 57 '........SPACE BAR
CONST KEYCODE_CAPSLK = 58 '.....CAPS LOCK key
CONST KEYCODE_F1 = 59 '.........F1 key
CONST KEYCODE_F2 = 60 '.........F2 key
CONST KEYCODE_F3 = 61 '.........F3 key
CONST KEYCODE_F4 = 62 '.........F4 key
CONST KEYCODE_F5 = 63 '.........F5 key
CONST KEYCODE_F6 = 64 '.........F6 key
CONST KEYCODE_F7 = 65 '.........F7 key
CONST KEYCODE_F8 = 66 '.........F8 key
CONST KEYCODE_F9 = 67 '.........F9 key
CONST KEYCODE_F10 = 68 '........F10 key
CONST KEYCODE_NUMLK = 69 '......NUM LOCK key
CONST KEYCODE_SCRLLK = 70 '.....SCROLL LOCK key
CONST KEYCODE_NUM_7 = 71 '......numpad "7" key
CONST KEYCODE_NUM_8 = 72 '......numpad "8" key
CONST KEYCODE_NUM_9 = 73 '......numpad "9" key
CONST KEYCODE_NUM_MINUS = 74 '..numpad "-" key
CONST KEYCODE_NUM_4 = 75 '......numpad "4" key
CONST KEYCODE_NUM_5 = 76 '......numpad "5" key
CONST KEYCODE_NUM_6 = 77 '......numpad "6" key
CONST KEYCODE_NUM_PLUS = 78 '...numpad "7" key
CONST KEYCODE_NUM_1 = 79 '......numpad "1" key
CONST KEYCODE_NUM_2 = 80 '......numpad "2" key
CONST KEYCODE_NUM_3 = 81 '......numpad "3" key
CONST KEYCODE_NUM_0 = 82 '......numpad "0" key
CONST KEYCODE_NUM_PERIOD = 83 '.numpad "." key

CONST KEYCODE_F11 = 87 '........F11 key
CONST KEYCODE_F12 = 88 '........F12 key

CONST KEYCODE_LWIN = 91 '.......left WINDOWS key (QB64)
CONST KEYCODE_RWIN = 92 '.......right WINDOWS key (QB64)
CONST KEYCODE_MENU = 93 '.......context MENU key (QB64)

CONST KEYCODE_EX_ENTER = 28 '...numpad "ENTER" key
CONST KEYCODE_EX_RCTRL = 29 '...right CTRL key
CONST KEYCODE_EX_NUM_SLSH = 53 'numpad "/" key
CONST KEYCODE_EX_RALT = 56 '....right ALT / ALT GR key
CONST KEYCODE_EX_HOME = 71 '....HOME key
CONST KEYCODE_EX_ARRUP = 72 '...arrow UP key
CONST KEYCODE_EX_PGUP = 73 '....PgUp key
CONST KEYCODE_EX_ARRLT = 75 '...arrow LEFT key
CONST KEYCODE_EX_ARRRT = 77 '...arrow RIGHT key
CONST KEYCODE_EX_END = 79 '.....END key
CONST KEYCODE_EX_ARRDN = 80 '...arrow DOWN key
CONST KEYCODE_EX_PGDN = 81 '....PgDn key
CONST KEYCODE_EX_INS = 82 '.....INS key
CONST KEYCODE_EX_DEL = 83 '.....DEL key

'INKEY$:
'=============================================================================

CONST INKEY_BKSPC = 8 '...........BKSPC key

CONST INKEY_ESC = 27 '............ESC key

CONST INKEY_SPC = 32 '............space bar
CONST INKEY_EXCL = 33 '...........exclamation mark
CONST INKEY_SPMK = 34 '...........speech mark (US: SHIFT+' / UK: SHIFT+2)
CONST INKEY_HASH = 35 '...........hash (US: SHIFT+3)
CONST INKEY_DOLLAR = 36 '.........dollar "$"
CONST INKEY_PERCENT = 37 '........percent sign "%"
CONST INKEY_AMPERSAND = 38 '......ampersand "&"
CONST INKEY_APOS = 39 '...........apostrophe "'"
CONST INKEY_LPAREN = 40 '.........left parenthesis "("
CONST INKEY_RPAREN = 41 '.........right parenthesis ")"
CONST INKEY_ASTERISK = 42 '.......asterisk "*"
CONST INKEY_EQUALS = 43 '.........equals "="

CONST INKEY_MINUS = 45 '..........minus "-"

CONST INKEY_1 = 49 '..............numeral 1 key
CONST INKEY_2 = 50 '..............numeral 2 key
CONST INKEY_3 = 51 '..............numeral 3 key
CONST INKEY_4 = 52 '..............numeral 4 key
CONST INKEY_5 = 53 '..............numeral 5 key
CONST INKEY_6 = 54 '..............numeral 6 key
CONST INKEY_7 = 55 '..............numeral 7 key
CONST INKEY_8 = 56 '..............numeral 8 key
CONST INKEY_9 = 57 '..............numeral 9 key
CONST INKEY_0 = 48 '..............numeral 0 key

CONST INKEY_AT = 64 '.............at symbol (US: SHIFT+2 / UK: SHIFT+')

CONST INKEY_ACUTE = 94 '.........."^"
CONST INKEY_BKTCK = 96 '..........back-tick key

'some keys are returned as two bytes, the first always 0,
'and the second indicating the key, as follows:

CONST INKEY_NUL = 0 '.............first byte is always 0

CONST INKEY_NUL_F1 = 59 '.........F1 key
CONST INKEY_NUL_F2 = 60 '.........F2 key
CONST INKEY_NUL_F3 = 61 '.........F3 key
CONST INKEY_NUL_F4 = 62 '.........F4 key
CONST INKEY_NUL_F5 = 63 '.........F5 key
CONST INKEY_NUL_F6 = 64 '.........F6 key
CONST INKEY_NUL_F7 = 65 '.........F7 key
CONST INKEY_NUL_F8 = 66 '.........F8 key
CONST INKEY_NUL_F9 = 67 '.........F9 key
CONST INKEY_NUL_F10 = 68 '........F10 key
CONST INKEY_NUL_F11 = 133 '.......F11 key
CONST INKEY_NUL_F12 = 134 '.......F12 key

CONST INKEY_NUL_SHIFT_F1 = 84 '...SHIFT+F1
CONST INKEY_NUL_SHIFT_F2 = 85 '...SHIFT+F2
CONST INKEY_NUL_SHIFT_F3 = 86 '...SHIFT+F3
CONST INKEY_NUL_SHIFT_F4 = 87 '...SHIFT+F4
CONST INKEY_NUL_SHIFT_F5 = 88 '...SHIFT+F5
CONST INKEY_NUL_SHIFT_F6 = 89 '...SHIFT+F6
CONST INKEY_NUL_SHIFT_F7 = 90 '...SHIFT+F7
CONST INKEY_NUL_SHIFT_F8 = 91 '...SHIFT+F8
CONST INKEY_NUL_SHIFT_F9 = 92 '...SHIFT+F9
CONST INKEY_NUL_SHIFT_F10 = 93 '..SHIFT+F10
CONST INKEY_NUL_SHIFT_F11 = 135 '.SHIFT+F11
CONST INKEY_NUL_SHIFT_F12 = 136 '.SHIFT+F12

CONST INKEY_NUL_CTRL_F1 = 94 '....CTRL+F1
CONST INKEY_NUL_CTRL_F2 = 95 '....CTRL+F2
CONST INKEY_NUL_CTRL_F3 = 96 '....CTRL+F3
CONST INKEY_NUL_CTRL_F4 = 97 '....CTRL+F4
CONST INKEY_NUL_CTRL_F5 = 98 '....CTRL+F5
CONST INKEY_NUL_CTRL_F6 = 99 '....CTRL+F6
CONST INKEY_NUL_CTRL_F7 = 100 '...CTRL+F7
CONST INKEY_NUL_CTRL_F8 = 101 '...CTRL+F8
CONST INKEY_NUL_CTRL_F9 = 102 '...CTRL+F9
CONST INKEY_NUL_CTRL_F10 = 103 '..CTRL+F10
CONST INKEY_NUL_CTRL_F11 = 137 '..CTRL+F11
CONST INKEY_NUL_CTRL_F12 = 138 '..CTRL+F12

CONST INKEY_NUL_ALT_F1 = 104 '....ALT+F1
CONST INKEY_NUL_ALT_F2 = 105 '....ALT+F2
CONST INKEY_NUL_ALT_F3 = 106 '....ALT+F3
CONST INKEY_NUL_ALT_F4 = 107 '....ALT+F4
CONST INKEY_NUL_ALT_F5 = 108 '....ALT+F5
CONST INKEY_NUL_ALT_F6 = 109 '....ALT+F6
CONST INKEY_NUL_ALT_F7 = 110 '....ALT+F7
CONST INKEY_NUL_ALT_F8 = 111 '....ALT+F8
CONST INKEY_NUL_ALT_F9 = 112 '....ALT+F9
CONST INKEY_NUL_ALT_F10 = 113 '...ALT+F10
CONST INKEY_NUL_ALT_F11 = 139 '...ALT+F11
CONST INKEY_NUL_ALT_F12 = 140 '...ALT+F12

CONST INKEY_NUL_ALT_A = 30 '......ALT+A
CONST INKEY_NUL_ALT_B = 48 '......ALT+B
CONST INKEY_NUL_ALT_C = 46 '......ALT+C
CONST INKEY_NUL_ALT_D = 32 '......ALT+D
CONST INKEY_NUL_ALT_E = 18 '......ALT+E
CONST INKEY_NUL_ALT_F = 33 '......ALT+F
CONST INKEY_NUL_ALT_G = 34 '......ALT+G
CONST INKEY_NUL_ALT_H = 35 '......ALT+H
CONST INKEY_NUL_ALT_I = 23 '......ALT+I
CONST INKEY_NUL_ALT_J = 36 '......ALT+J
CONST INKEY_NUL_ALT_K = 37 '......ALT+K
CONST INKEY_NUL_ALT_L = 38 '......ALT+L
CONST INKEY_NUL_ALT_M = 50 '......ALT+M
CONST INKEY_NUL_ALT_N = 49 '......ALT+N
CONST INKEY_NUL_ALT_O = 24 '......ALT+O
CONST INKEY_NUL_ALT_P = 25 '......ALT+P
CONST INKEY_NUL_ALT_Q = 16 '......ALT+Q
CONST INKEY_NUL_ALT_R = 19 '......ALT+R
CONST INKEY_NUL_ALT_S = 31 '......ALT+S
CONST INKEY_NUL_ALT_T = 20 '......ALT+T
CONST INKEY_NUL_ALT_U = 22 '......ALT+U
CONST INKEY_NUL_ALT_V = 47 '......ALT+V
CONST INKEY_NUL_ALT_W = 17 '......ALT+W
CONST INKEY_NUL_ALT_X = 45 '......ALT+X
CONST INKEY_NUL_ALT_Y = 21 '......ALT+Y
CONST INKEY_NUL_ALT_Z = 44 '......ALT+Z

CONST INKEY_NUL_ALT_1 = 120 '.....ALT+1
CONST INKEY_NUL_ALT_2 = 121 '.....ALT+1
CONST INKEY_NUL_ALT_3 = 122 '.....ALT+1
CONST INKEY_NUL_ALT_4 = 123 '.....ALT+1
CONST INKEY_NUL_ALT_5 = 124 '.....ALT+1
CONST INKEY_NUL_ALT_6 = 125 '.....ALT+1
CONST INKEY_NUL_ALT_7 = 126 '.....ALT+1
CONST INKEY_NUL_ALT_8 = 127 '.....ALT+1
CONST INKEY_NUL_ALT_9 = 128 '.....ALT+1
CONST INKEY_NUL_ALT_0 = 129 '.....ALT+1

CONST INKEY_NUL_ALT_MINUS = 130 '.ALT+- (minus/underscore key)
CONST INKEY_NUL_ALT_EQUALS = 131 'ALT+= (equals/plus key)

CONST INKEY_NUL_ALT_BKSPC = 14 '..ALT+BKSPC
CONST INKEY_NUL_CTRL_BKSPC = 147 'CTRL+BKSPC

CONST INKEY_NUL_HOME = 71 '.......HOME key
CONST INKEY_NUL_END = 79 '........END key

CONST INKEY_NUL_PGUP = 73 '.......PgUp key
CONST INKEY_NUL_PGDN = 81 '.......PgDn key

CONST INKEY_NUL_ARRUP = 72 '......arrow UP key
CONST INKEY_NUL_ARRLT = 75 '......arrow LEFT key
CONST INKEY_NUL_NUM5 = 76 '.......numpad "5" key (numlock off)
CONST INKEY_NUL_ARRRT = 77 '......arrow RIGHT key
CONST INKEY_NUL_ARRDN = 80 '......arrow DOWN key

CONST INKEY_NUL_INS = 82 '........INS key
CONST INKEY_NUL_DEL = 83 '........DEL key
