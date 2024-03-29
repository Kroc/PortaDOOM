'copyright (C) Kroc Camen 2018-2023, BSD 2-clause

TYPE Game
    id AS STRING
    
    title AS STRING '.......game title; shared between all options
    blurb AS STRING '.......overall game description
    
    name AS STRING '........name of this particular game option
    desc AS STRING '........brief description of this option
    
    'this is an index into the `IWADs` array where the meta-data is stored
    iwad AS _BYTE
    
    type AS INTEGER '.......IWAD type
    pwad AS STRING '........PWAD to play
    pre AS STRING '.........list of files to load *before* the PWAD
    files AS STRING '.......list of additional files to include
    deh AS STRING '.........DeHackEd script(s) to load
    bex AS STRING '.........Boom-EXtended DeHackEd script(s) to load
    
    use AS STRING '.........an engine-id to use
    tags AS STRING '........comma-separated list of tags the game requires
    bit AS _BYTE '..........required binary type
    cmplvl AS _BYTE '.......can be negative to specify "not given"
    vid AS _BYTE '..........renderer colour-depth required
    gzdoom_id AS STRING '...if GZDoom is selected, what version to use
    
    map AS STRING '.........warp to a specific map name
    warp_e AS _BYTE '.......warp to given episode number
    warp_m AS _BYTE '.......warp to given map number
    skill AS _BYTE '........preset skill level
    
    skill1 AS STRING '......replacement skill level 1 name
    skill2 AS STRING '......replacement skill level 2 name
    skill3 AS STRING '......replacement skill level 3 name
    skill4 AS STRING '......replacement skill level 4 name
    skill5 AS STRING '......replacement skill level 5 name
    skill6 AS STRING '......replacement skill level 6 name
    skill7 AS STRING '......replacement skill level 7 name
    skill8 AS STRING '......replacement skill level 8 name
    skill9 AS STRING '......replacement skill level 9 name
    
    exec AS STRING '........script file to execute (ZDoom-based engines)
    cmd AS STRING '.........additional command-line parameters to add
END TYPE

'array that holds all the games defined
REDIM SHARED Games(1) AS Game
DIM SHARED Games_Count AS LONG

'when a game is selected, this struct is populated to save the indirect
'lookup of game details via `Games(Games_Current)...` every time
DIM SHARED Games_Selected AS Game
'currently selected game index
DIM SHARED Games_Current AS LONG
