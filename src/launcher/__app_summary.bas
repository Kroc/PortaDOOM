'copyright (C) Kroc Camen 2018-2021, BSD 2-clause

'=============================================================================
'cache the summary screen base UI
'(i.e. draw the UI and fill in the unique data afterwards)
DIM uiSummaryWindow AS STRING

DIM X AS _UNSIGNED _BYTE
DIM Y AS _UNSIGNED _BYTE 
DIM W AS _UNSIGNED _BYTE
DIM H AS _UNSIGNED _BYTE

LET Y = 3: LET X = 3
LET W = 75: LET H = 25

'prepare our window decorations (custom drawing)
CALL STRGUI_Begin
STRGUI_SetVar "w", W
STRGUI_SetVar "h", H

'title divider:
STRGUI_Add "^{X2,Y2,L}"
STRGUI_Add "^{X0,Y3,&C6,&CD,R@w-2,&B5}"
'footer divider:
STRGUI_Add "^{X0,Y@h-2,&C6,&CD,R@w-2,&B5,N}"

'right-hand column:
'define the width of the column
DIM CW AS _UNSIGNED _BYTE: LET CW = 22
STRGUI_SetVar "c", CW

'draw the border down the screen
STRGUI_Add "^{Y3,X@w-@c-1}"
STRGUI_Add "^{L,&D1,N}"
'walk down the screen drawing the vertical line
'TODO: need a vertical drawing mode to make this easier
FOR i = 1 to H - 6: STRGUI_Add "^{&B3,N}": NEXT i
STRGUI_Add "^{&CF,L-}"

'engine:
'return to the top of the window
STRGUI_Add "^{X3,Y6}"

STRGUI_SetVar "e", W - CW - 6
STRGUI_Add "^{Fk,Bw,&20,R@e,Bb,&DC,B-,N}"
STRGUI_Add "^{B-,&20,&DF,R@w-@c-6,F-,N}"

STRGUI_Add "^{FW,&7F,F-,FW} ^{L}"
STRGUI_Add "An exact recreation of the original DOOM as it^{N}"
STRGUI_Add "was in 1993. Renders at 320 x 200 resolution,^{N}"
STRGUI_Add "regardless of desktop resolution."
STRGUI_Add "^{F-,L-,N,N}"

'mods:
STRGUI_Add "^{X0,&C3,&C4,R@w-@c-3,&B4,N}"
STRGUI_Add "^{N,N}"
STRGUI_Add "^{FW}No selected mods.^{F-,N,N}"

DIM temp$
LET temp$ = STRGUI$

DIM ui_dontcare AS _UNSIGNED _BYTE

DIM ui_summary_window AS _UNSIGNED _BYTE
LET ui_summary_window = UI.Windows.Add(X, Y, W, H, BLUE, AQUA, 1, temp$)

DIM ui_summary_title AS _UNSIGNED _BYTE
LET ui_summary_title = UI.Labels.Add ( _
    X + 2, Y + 1, WHITE, STRGET$(Games(Games_Current).title) _
)

DIM ui_summary_selectedengine AS _UNSIGNED _BYTE
LET ui_summary_selectedengine = UI.Labels.Add ( _
    X + 2, Y + 3, AQUA, _
    "Selected Engine: ^{Fw}(press ^{FY}F2^{F-} to change)")
''LET ui_dontcare = UI.Labels.Add ( _
''    X, Y + 4, W, AQUA, BLUE, "^{&C3,&C4,R@w-@c-3,&C5}")

DIM ui_summary_selectedmods AS _UNSIGNED _BYTE
LET ui_summary_selectedmods = UI.Labels.Add ( _
    X + 2, Y + 12, AQUA, _
    "Selected Mods: ^{Fw}(Press ^{FY}F3^{F-} to manage mods)")

DIM XR AS _UNSIGNED _BYTE
LET XR = X + (W - CW)

LET ui_dontcare = UI.Labels.Add (XR, Y + 3, AQUA, "Config:")
LET ui_dontcare = UI.Labels.Add (X + W - 4, Y + 3, YELLOW, "F4")
LET ui_dontcare = UI.Labels.Add (XR - 2, Y + 4, AQUA, "^{&C3,&C4,R22,&B4}")

LET ui_dontcare = UI.Labels.Add (XR, Y + 5, LTGREY, "  IWAD: ^{&FA,R12}")
LET ui_dontcare = UI.Labels.Add (XR, Y + 6, LTGREY, "  PWAD: ^{&FA,R12}")
LET ui_dontcare = UI.Labels.Add (XR, Y + 7, LTGREY, "CMPLVL: ^{&FA,R12}")

DIM ui_summary_iwad AS _UNSIGNED _BYTE
LET ui_summary_iwad = UI.Labels.Add ( _
    XR + 8, Y + 5, LIME, TRUNCATE$(STRGET$(Games(Games_Current).iwad), 12))
DIM ui_summary_pwad AS _UNSIGNED _BYTE
LET ui_summary_pwad = UI.Labels.Add ( _
    XR + 8, Y + 6, LIME, TRUNCATE$(STRGET$(Games(Games_Current).pwad), 12))
DIM ui_summary_cmplvl AS _UNSIGNED _BYTE
IF Games(Games_Current).cmplvl > -1 THEN
    LET ui_summary_cmplvl = UI.Labels.Add ( _
        XR + 8, Y + 7, LIME, STRINT$(Games(Games_Current).cmplvl))
ELSE
    LET ui_summary_cmplvl = UI.Labels.Add ( _
        XR + 8, Y + 7, LTGREY, "default")
END IF

LET ui_dontcare = UI.Labels.Add (XR, Y + 9, LTGREY, "   DEH: ^{&FA,R12}")
LET ui_dontcare = UI.Labels.Add (XR, Y + 10, LTGREY, "   BEX: ^{&FA,R12}")
LET ui_dontcare = UI.Labels.Add (XR, Y + 11, LTGREY, "  EXEC: ^{&FA,R12}")

LET ui_dontcare = UI.Labels.Add (XR, Y + 13, LTGREY, "  WARP: ^{&FA,R12}")
LET ui_dontcare = UI.Labels.Add (XR, Y + 14, LTGREY, " SKILL: ^{&FA,R12}")

LET ui_dontcare = UI.Labels.Add (XR, Y + 16, AQUA, "Screen:")
LET ui_dontcare = UI.Labels.Add (X + W - 4, Y + 16, YELLOW, "F5")
LET ui_dontcare = UI.Labels.Add (XR - 2, Y + 17, AQUA, "^{&C3,&C4,R22,&B4}")

DIM ui_summary_pressenter AS _UNSIGNED _BYTE
LET ui_summary_pressenter = UI.Labels.Add ( _
    X + W - 22 - 2, Y + H - 2, WHITE, _
    "^{FG!,&FE,F-} Press ^{FY}ENTER^{F-} to play!" _
)

SummaryWindow:
'-----------------------------------------------------------------------------
CALL UI.DesktopBars.Update( _
    ui_statusbar, _
    "F1=HELP", "F11=FULLSCREEN  ESC=EXIT" _
)
CALL UI.Render

'input loop
DO
    _LIMIT 30
    
    DIM key$: LET key$ = UCASE$(INKEY$)
    IF key$ <> "" THEN
        'get that as a key-code
        DIM key_code%: LET key_code% = ASC(key$)
        
        SELECT CASE key_code%
            'ESC - quit instantly
            CASE ASC_ESC: SYSTEM
            CASE ASC_ENTER
                ''GOTO launch
        END SELECT
    END IF
    
    'clear keyboard buffer
    DO WHILE INKEY$ <> "": LOOP
LOOP
