'DOSmag : a DOS-like portable front-end for hyperlinked textual content.
'         copyright (C) Kroc Camen, 2016; MIT license (see LICENSE.TXT)
'=============================================================================
'WARNING: THIS IS A QB64.NET SOURCE FILE, ENCODED AS ANSI CODE-PAGE 437
'         (SOMETIMES REFERRED TO AS "DOS" OR "OEM-US" ENCODING).
'         DO NOT OPEN AND SAVE THIS FILE AS UNICODE / UTF-8!
'=============================================================================

CONST TRUE = -1
CONST FALSE = 0

'------------------------------------------------------------------------------

'the default size (in char cols/rows) of the text-mode screen (`SCREEN 0`)
CONST SCREEN_WIDTH = 80
CONST SCREEN_HEIGHT = 25

'------------------------------------------------------------------------------

CONST BLACK = 0 'COLOR code for black
CONST BLUE = 1 'COLOR code for dark blue
CONST GREEN = 2 'COLOR code for dark green
CONST CYAN = 3 'COLOR code for dark-cyan
CONST RED = 4 'COLOR code for dark-red
CONST PURPLE = 5 'COLOR code for purple
CONST ORANGE = 6 'COLOR code for brown / orange
CONST LTGREY = 7 'COLOR code for "white" (light grey)
CONST DKGREY = 8 'COLOR code for "bright black" (dark grey), foreground ONLY
CONST LTBLUE = 9 'COLOR code for "bright blue", foreground ONLY
CONST LIME = 10 'COLOR code for "bright green", foreground ONLY
CONST AQUA = 11 'COLOR code for "bright cyan", foreground ONLY
CONST ROSE = 12 'COLOR code for "bright red" (peach), foreground ONLY
CONST PINK = 13 'COLOR code for "bright purple" (fuscia), foreground ONLY
CONST YELLOW = 14 'COLOR code for "bright orange" (yellow), foreground ONLY
CONST WHITE = 15 'COLOR code for "bright white", foreground ONLY

'------------------------------------------------------------------------------

CONST ASC_NULL = 0

CONST ASC_BKSP = 8
CONST ASC_TAB = 9

CONST ASC_ESC = 27 '      escape key

CONST ASC_SPC = 32 '      space
CONST ASC_EXCL = 33 '     !
CONST ASC_HASH = 35 '     #
CONST ASC_APOS = 39 '     '
CONST ASC_LPAREN = 40 '   (
CONST ASC_RPAREN = 41 '   )
CONST ASC_ASTERISK = 42 ' *
CONST ASC_COMMA = 44 '    ,
CONST ASC_DASH = 45 '     - (hyphen / minus)
CONST ASC_PERIOD = 46 '   . (fullstop)
CONST ASC_FSLASH = 47 '   / (forward-slash)
CONST ASC_COLON = 58 '    :
CONST ASC_SEMICOLON = 59 ';
CONST ASC_EQUALS = 61 '   =
CONST ASC_QMARK = 63 '    ?

CONST ASC_A = 65
CONST ASC_B = 66
CONST ASC_C = 67
CONST ASC_D = 68
CONST ASC_E = 69
CONST ASC_F = 70
CONST ASC_G = 71
CONST ASC_H = 72
CONST ASC_I = 73
CONST ASC_J = 74
CONST ASC_K = 75
CONST ASC_L = 76
CONST ASC_M = 77
CONST ASC_N = 78
CONST ASC_O = 79
CONST ASC_P = 80
CONST ASC_Q = 81
CONST ASC_R = 82
CONST ASC_S = 83
CONST ASC_T = 84
CONST ASC_U = 85
CONST ASC_V = 86
CONST ASC_W = 87
CONST ASC_X = 88
CONST ASC_Y = 89
CONST ASC_Z = 90

CONST ASC_LSQB = 91 '   [
CONST ASC_BSLASH = 92 ' \
CONST ASC_RSQB = 93 '   ]
CONST ASC_CARET = 94 '  ^
CONST ASC_USCORE = 95 ' _
CONST ASC_BAR = 124 '   |

'when the result of INKEY$ begins with a NULL,
'then the second byte is the following:
CONST ASC_F1 = 59
CONST ASC_F2 = 60
CONST ASC_F3 = 61
CONST ASC_F4 = 62
CONST ASC_F5 = 63
CONST ASC_F6 = 64
CONST ASC_F7 = 65
CONST ASC_F8 = 66
CONST ASC_F9 = 67
CONST ASC_F10 = 68
CONST ASC_F11 = 133
CONST ASC_F12 = 134

CONST ASC_UP = 72
CONST ASC_DOWN = 80
CONST ASC_LEFT = 75
CONST ASC_RIGHT = 77

CONST ASC_HOME = 71
CONST ASC_PGUP = 73
CONST ASC_PGDN = 81
CONST ASC_END = 79
