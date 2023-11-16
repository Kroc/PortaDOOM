'copyright (C) Kroc Camen 2016-2023, BSD 2-clause

'our text-formatting control codes
'-----------------------------------------------------------------------------
CONST CTL_ESCAPE = ASC_CARET '     ^
CONST CTL_CENTER = ASC_C '         ^C - centre alignment
CONST CTL_RIGHT = ASC_R '          ^R - right alignment
CONST CTL_HEADING = ASC_COLON '    :
CONST CTL_BULLET = ASC_DASH '      - (bullet point)
CONST CTL_BOLD = ASC_ASTERISK '    *...*
CONST CTL_TERM = ASC_USCORE '      _..._
CONST CTL_CITE = ASC_BTICK '       `...`
CONST CTL_LINE1 = ASC_EQUALS '     =
CONST CTL_LINE2 = ASC_DASH '       -
CONST CTL_NAME_ON = ASC_LT '       <
CONST CTL_NAME_OFF = ASC_GT '      >
CONST CTL_KEY_ON = ASC_LSQB '      [
CONST CTL_KEY_OFF = ASC_RSQB '     ]
CONST CTL_INDENT = ASC_BAR '       |
CONST CTL_BREAK = ASC_BSLASH '     \\ (manual line-break)
CONST CTL_WARNING = ASC_EXCL '     !

'number of spaces between tab-stops
CONST TAB_SIZE = 4

'format constants
CONST FORMAT_LEFT = 0 '..left-align text
CONST FORMAT_CENTER = 1 'center-align text
CONST FORMAT_RIGHT = 2 '.right-align text