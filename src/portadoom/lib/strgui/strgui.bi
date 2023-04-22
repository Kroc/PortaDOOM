'copyright (C) Kroc Camen 2018-2023, BSD 2-clause

'$INCLUDE: 'binstr.bi'

DIM SHARED STRGUI$

CONST STRGUI_ESC = ASC_CARET '      ^
CONST STRGUI_CMDBEGIN = ASC_LCBR '  {
CONST STRGUI_CMDEND = ASC_RCBR '    ,
CONST STRGUI_CMDSEP = ASC_COMMA '   }

CONST STRGUI.F_OFF$ = "^{F-}"
CONST STRGUI.B_OFF$ = "^{B-}"

DIM SHARED STRGUI.Vars(0 TO 255) AS INTEGER
