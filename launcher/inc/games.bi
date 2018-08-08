'copyright (C) Kroc Camen 2018, BSD 2-clause

TYPE Game
    id AS LONG
    title AS LONG
    iwad AS LONG '..........IWAD, i.e. DOOM, DOOM2, HERETIC, HEXEN etc.
    pwad AS LONG '..........optional PWAD to play
	files AS LONG '.........list of additional files to include
    cmplvl AS _BYTE '.......can be negative to specify "not given"
    deh AS LONG '...........optional DeHackEd script to load
    bex AS LONG '...........optional Boom-EXtended DeHackEd script to load
    tags AS LONG '..........comma-separated tags list the game requires
    vid AS _UNSIGNED _BYTE 'required renderer colour bit-depth
END TYPE

'array that holds all the games defined
REDIM SHARED Games(1) AS Game
DIM SHARED Games_Count AS LONG

'currently selected game index
DIM SHARED Games_Current AS LONG

'when a game is selected, this struct is populated to save the indirect
'lookup of game details via `Games(Games_Current)...` every time
DIM SHARED Games_Selected AS Game