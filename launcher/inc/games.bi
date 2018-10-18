'copyright (C) Kroc Camen 2018, BSD 2-clause

TYPE Game
    id AS LONG
    
    title AS LONG
    desc AS LONG '..........brief description
    
    'this is an index into the `IWADs` array where the meta-data is stored
    iwad AS _BYTE
    
    type AS INTEGER '.......IWAD type
    pwad AS LONG '..........PWAD to play
    pre AS LONG '...........list of files to load *before* the PWAD
    files AS LONG '.........list of additional files to include
    cmplvl AS _BYTE '.......can be negative to specify "not given"
    deh AS LONG '...........DeHackEd script to load
    bex AS LONG '...........Boom-EXtended DeHackEd script to load
    tags AS LONG '..........comma-separated tags list the game requires
    vid AS _UNSIGNED _BYTE 'renderer colour-depth required
    warp_e AS _BYTE '.......warp to given episode number
    warp_m AS _BYTE '.......warp to given map number
    skill AS _BYTE '........preset skill level
    
    skill1 AS LONG '........replacement skill level 1 name
    skill2 AS LONG '........replacement skill level 2 name
    skill3 AS LONG '........replacement skill level 3 name
    skill4 AS LONG '........replacement skill level 4 name
    skill5 AS LONG '........replacement skill level 5 name
    skill6 AS LONG '........replacement skill level 6 name
    skill7 AS LONG '........replacement skill level 7 name
    skill8 AS LONG '........replacement skill level 8 name
    skill9 AS LONG '........replacement skill level 9 name
END TYPE

'array that holds all the games defined
REDIM SHARED Games(1) AS Game
DIM SHARED Games_Count AS LONG

'when a game is selected, this struct is populated to save the indirect
'lookup of game details via `Games(Games_Current)...` every time
DIM SHARED Games_Selected AS Game
'currently selected game index
DIM SHARED Games_Current AS LONG