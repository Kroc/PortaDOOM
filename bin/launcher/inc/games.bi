'copyright (C) Kroc Camen 2018, BSD 2-clause

TYPE Game
    id AS STRING * 32
    title AS STRING * 64
    iwad AS STRING * 32 '...IWAD, i.e. DOOM, DOOM2, HERETIC, HEXEN etc.
    pwad AS STRING * 32 '...optional PWAD to play
    cmplvl AS _BYTE '.......can be negative to specify "not given"
    deh AS STRING * 32 '....optional DeHackEd script to load
    bex AS STRING * 32 '....optional Boom-EXtended DeHackEd script to load
    tags AS STRING * 128 '..comma-separated tags list the game requires
    vid AS _UNSIGNED _BYTE 'required renderer colour bit-depth
END TYPE

'array that holds all the games defined
REDIM SHARED Games(1) AS Game
DIM SHARED Games_Count AS LONG

'currently selected game
DIM SHARED Games_Current AS LONG
