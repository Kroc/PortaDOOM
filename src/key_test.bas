
get_key:
_LIMIT 15

DIM I$
DO: LET I$ = INKEY$: LOOP UNTIL I$ <> ""

IF LEN(I$) > 1 THEN
    PRINT STR$(ASC(I$, 1)), STR$(ASC(I$, 2))
ELSEIF LEN(I$) = 1 THEN
    PRINT STR$(ASC(I$))
END IF
PRINT

GOTO get_key

