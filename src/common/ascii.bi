'copyright (C) Kroc Camen 2018-2020, BSD 2-clause

'ASCII Codes:
'=============================================================================

CONST ASC_NUL = 0 '   null
CONST ASC_SOH = 1 '   start of heading
CONST ASC_STX = 2 '   start of text
CONST ASC_ETX = 3 '   end of text
CONST ASC_EOT = 4 '   end of transmission
CONST ASC_ENQ = 5 '   enquiry
CONST ASC_ACK = 6 '   acknowledge
CONST ASC_BEL = 7 '   bell
CONST ASC_BS = 8 '    backspace
CONST ASC_HT = 9 '    horizontal tab
CONST ASC_LF = 10 '   line feed
CONST ASC_VT = 11 '   vertical tab
CONST ASC_FF = 12 '   form feed
CONST ASC_CR = 13 '   carriage return
CONST ASC_S0 = 14 '   shift out
CONST ASC_SI = 15 '   shift in
CONST ASC_DLE = 16 '  data link escape
CONST ASC_DC1 = 17 '  device control 1
CONST ASC_DC2 = 18 '  device control 2
CONST ASC_DC3 = 19 '  device control 3
CONST ASC_DC4 = 20 '  device control 4
CONST ASC_NAK = 21 '  negative acknowledge
CONST ASC_SYN = 22 '  synchronous idle
CONST ASC_ETB = 23 '  end of transmission block
CONST ASC_CAN = 24 '  cancel
CONST ASC_EM = 25 '   end of medium
CONST ASC_SUB = 26 '  substitute
CONST ASC_ESC = 27 '  escape
CONST ASC_FS = 28 '   file separator
CONST ASC_GS = 29 '   group separator
CONST ASC_RS = 30 '   record separator
CONST ASC_US = 31 '   unit separator
CONST ASC_DEL = 127 ' delete
CONST ASC_NBSP = 255 '"non-breaking space"

'friendlier names for these C0 codes
CONST ASC_BKSP = 8
CONST ASC_TAB = 9
CONST ASC_ENTER = 13

'punctuation:
CONST ASC_SPC = 32 '      space
CONST ASC_EXCL = 33 '     !
CONST ASC_SMARK = 34 '    "
CONST ASC_HASH = 35 '     #
CONST ASC_DOLLAR = 36 '   $
CONST ASC_PCENT = 37 '    %
CONST ASC_AMP = 38 '      &
CONST ASC_APOS = 39 '     '
CONST ASC_LPAREN = 40 '   (
CONST ASC_RPAREN = 41 '   )
CONST ASC_ASTERISK = 42 ' *
CONST ASC_PLUS = 43 '     +
CONST ASC_COMMA = 44 '    ,
CONST ASC_DASH = 45 '     - (hyphen / minus)
CONST ASC_PERIOD = 46 '   . (fullstop)
CONST ASC_FSLASH = 47 '   / (forward-slash)
CONST ASC_COLON = 58 '    :
CONST ASC_SEMICOLON = 59 ';
CONST ASC_LT = 60 '       <
CONST ASC_EQUALS = 61 '   =
CONST ASC_GT = 62 '       >
CONST ASC_QMARK = 63 '    ?
CONST ASC_AT = 64 '       @
CONST ASC_LSQB = 91 '     [
CONST ASC_BSLASH = 92 '   \
CONST ASC_RSQB = 93 '     ]
CONST ASC_CARET = 94 '    ^
CONST ASC_USCORE = 95 '   _
CONST ASC_BTICK = 96 '    `
CONST ASC_LCBR = 123 '    {
CONST ASC_BAR = 124 '     |
CONST ASC_RCBR = 125 '    }
CONST ASC_TILDE = 126 '   ~

'numerals:
CONST ASC_0 = 48
CONST ASC_1 = 49
CONST ASC_2 = 50
CONST ASC_3 = 51
CONST ASC_4 = 52
CONST ASC_5 = 53
CONST ASC_6 = 54
CONST ASC_7 = 55
CONST ASC_8 = 56
CONST ASC_9 = 57

'add this to the letters below to get the lowercase versions
CONST ASC_LCASE = 32

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

'control character symbols:
'-----------------------------------------------------------------------------
'additional symbols occupy the control-codes.
'use `_CONTROLCHR OFF` to be able to print these symbols

CONST ASC_SMILEO = &H01 '......smiley (open - outline)
CONST ASC_SMILEC = &H02 '......smiley (closed - filled)

CONST ASC_HEART = &H03 '.......heart (playing cards suit)
CONST ASC_DIAMOND = &H04 '.....diamond (playing cards suit)
CONST ASC_CLUBS = &H05 '.......clubs (playing cards suit)
CONST ASC_SPADES = &H06 '......spades (playing cards suit)

CONST ASC_BULL = &H07 '........bullet
CONST ASC_BULLINV = &H08 '.....inverse bullet
CONST ASC_BULLO = &H09 '.......bullet (open - outline)
CONST ASC_BULLOINV = &H0A '....inverse open bullet

CONST ASC_MALE = &H0B '........male gender symbol "Mars"
CONST ASC_FEMALE = &H0C '......female gender symbol "Venus"

CONST ASC_NOTE = &H0D '........musical note (eight / quaver)
CONST ASC_DBLNOTE = &H0E '.....double music note

CONST ASC_SUN = &H0F '.........Sun / solar symbol

CONST ASC_DBLEXCL = &H13 '.....double exclamation mark
CONST ASC_PILCROW = &H14 '.....paragraph mark
CONST ASC_SECTION = &H15 '.....section mark

CONST ASC_RECT = &H16 '........"black rectangle"; for form filling?

CONST ASC_ARR_UP = &H18 '......up-arrow
CONST ASC_ARR_DN = &H19 '......down-arrow
CONST ASC_ARR_RT = &H1A '......right-arrow
CONST ASC_ARR_LT = &H1B '......left-arrow

CONST ASC_ARR_UPDN = &H12 '....combined up & down arrow
CONST ASC_ARR_UPDNB = &H17 '...combined up & down arrow with base
CONST ASC_ARR_LTRT = &H1D '....combined left & right arrow

CONST ASC_RTANG = &H1C '.......right-angle

CONST ASC_TRI_UP = &H1E '......upward-pointing triangle
CONST ASC_TRI_DN = &H1F '......downward-pointing triangle
CONST ASC_TRI_RT = &H10 '......rightward-pointing triangle
CONST ASC_TRI_LT = &H11 '......leftward-pointing triangle

CONST ASC_HOUSE = &H7F '.......a house-like symbol

CONST ASC_LGLLMT = &HAE '......left guillemot, i.e. double angle-bracket
CONST ASC_RGLLMT = &HAF '......right guillemot

CONST ASC_BOX_H = &HC4 '.......horizontal line
CONST ASC_BOX_V = &HB3 '.......vertical line
CONST ASC_BOX_TL = &HDA '......top-left corner
CONST ASC_BOX_TR = &HBF '......top-right corner
CONST ASC_BOX_BL = &HC0 '......bottom-left corner
CONST ASC_BOX_BR = &HD9 '......bottom-right corner

CONST ASC_BOX_VR = &HC3 '......vertical line, with right-hand horizontal join
CONST ASC_BOX_VL = &HB4 '......vertical line, with left-hand horizontal join
CONST ASC_BOX_HB = &HC2 '......horizontal line, with bottom vertical join
CONST ASC_BOX_HT = &HC1 '......horizontal line, with top vertical join

CONST ASC_BOX_DBL_H = &HCD '...horizontal double-line
CONST ASC_BOX_DBL_V = &HBA '...vertical double-line
CONST ASC_BOX_DBL_TL = &HC9 '..top-left double-line corner
CONST ASC_BOX_DBL_TR = &HBB '..top-right double-line corner
CONST ASC_BOX_DBL_BL = &HC8 '..bottom-left double-line corner
CONST ASC_BOX_DBL_BR = &HBC '..bottom-left double-line corner

CONST ASC_BOX_BL_DBL_B = &HD4 'bottom-left corner, with double-line on bottom
CONST ASC_BOX_BR_DBL_B = &HBE 'bottom-right corner, double-line on bottom

CONST ASC_BLOCK_LT = &HB0 '....light shade block
CONST ASC_BLOCK_MD = &HB1 '....medium shade block
CONST ASC_BLOCK_DK = &HB2 '....dark shade block
CONST ASC_BLOCK = &HDB '.......full block

CONST ASC_SQUARE = &HFE '......centered square (not a full block)


'when the result of `INKEY$` begins with a `NUL`,
'then the second byte is the following:
'=============================================================================
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

