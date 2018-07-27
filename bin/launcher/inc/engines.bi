'copyright (C) Kroc Camen 2018, BSD 2-clause

'structure to store the details of an engine:
TYPE Engine
    'ids can be the same between multiple engines!
    'for example, when there's 32-bit and 64-bit versions
    id AS STRING * 32
    folder AS STRING * 32 'the folder name the engine is in
    
    'these are specifically named after the INI-file param names:
    name AS STRING * 32 '..simple name, for grouping versions together
    rank AS INTEGER
    title AS STRING * 64 '.on-screen "friendly name"
    exe AS STRING * 32 '...executable file-name
    ver AS INTEGER '.......engine's version number
    bit AS _BYTE '.........executable architecture: 32 or 64 (bit)
    vid AS _BYTE '.........renderer colour-depth, i.e. 8, 24, 32
    kin AS _BYTE '.........a marker to indicate the engine's genealogy
    cfg AS STRING * 32 '...config file ID to use
    save AS STRING * 32 '..save-folder name to use
    tags AS STRING * 128 '.comma-separated tags list the engine supports
    iwads AS STRING * 128 'semi-colon separated list of allowed IWADs
    pwads AS STRING * 128 'semi-colon separated list of PWAD file-types
END TYPE

CONST KIN_X = 1 'kex engine; i.e. DOOM64. *NOT* vanilla
CONST KIN_V = 2 '"vanilla" engine; i.e. Chocolate-Doom, Crispy-Doom
CONST KIN_B = 3 '"Boom" engine; i.e. PrBoom+, DoomRetro
CONST KIN_Z = 4 '"ZDoom" engine; i.e. ZDoom
CONST KIN_G = 5 '"GZDoom" engine; i.e. GZDoom, QZDoom

'array that holds all the engines detected, including 'duplicates' that
'share the same engine-id, but differ in version / CPU-type / renderer
REDIM SHARED Engines(1 TO 1) AS Engine
'count of all defined engines (prior to filtering)
DIM SHARED Engines_Count AS LONG

'list of compatible engines for the selected game
REDIM SHARED Engines_List(1 TO 1) AS INTEGER
DIM SHARED Engines_ListCount AS LONG

'currently selected engine index
DIM SHARED Engines_Current AS LONG

'when an engine is selected, this struct is populated to save the indirect
'lookup of engine details via `Engines(Engines_Current)...` every time
DIM SHARED Engines_Selected AS Engine
