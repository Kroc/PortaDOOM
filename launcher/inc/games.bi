'copyright (C) Kroc Camen 2018, BSD 2-clause

TYPE Game
    id AS LONG
    title AS LONG
    iwad AS LONG '.............IWAD, i.e. DOOM, DOOM2, HERETIC, HEXEN etc.
	type AS _BYTE '............IWAD type
    pwad AS LONG '.............PWAD to play
	files AS LONG '............list of additional files to include
    cmplvl AS _BYTE '..........can be negative to specify "not given"
    deh AS LONG '..............DeHackEd script to load
    bex AS LONG '..............Boom-EXtended DeHackEd script to load
    tags AS LONG '.............comma-separated tags list the game requires
    vid AS _UNSIGNED _BYTE '...renderer colour-depth required
	warp_e AS _BYTE '..........warp to given episode number
	warp_m AS _BYTE '..........warp to given map number
	skill AS _BYTE '...........preset skill level
END TYPE

'array that holds all the games defined
REDIM SHARED Games(1) AS Game
DIM SHARED Games_Count AS LONG

'currently selected game index
DIM SHARED Games_Current AS LONG

'when a game is selected, this struct is populated to save the indirect
'lookup of game details via `Games(Games_Current)...` every time
DIM SHARED Games_Selected AS Game