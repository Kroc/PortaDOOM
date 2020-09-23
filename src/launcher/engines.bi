'copyright (C) Kroc Camen 2018-2019, BSD 2-clause
'engines.bi : definitions for Engines (source-ports to play DOOM)

'structure to store the details of an engine:
TYPE Engine
    'ID of the engine as a whole, rather than a specific version
    'e.g. "gzdoom" instead of "gzdoom-35". this is used to group
    'together all versions of an engine under one name
    engine AS STRING
    
    'the directory name the engine is in
    dir AS STRING
    
    'ID of the particular engine instance,
    'e.g. a specific version or binary such as x86/x64
    id AS STRING
    
    title AS STRING 'on-screen "friendly name"
    desc AS STRING '.short description of the engine
    
    'a comma-separated list of which DOOM-engines are supported by the engine.
    'these can be any of DOOM, CHEX, DOOM2, HERETIC, HEXEN, STRIFE, DOOM64
    'or HARM1
    type AS INTEGER
    
    tier AS INTEGER '"high", "medium" or "low" tier
    rank AS INTEGER
    exe AS STRING '..executable file-name
    ver AS VerNum '..engine's version number
    bit AS _BYTE '...executable architecture: 32 or 64 (bit)
    vid AS _BYTE '...renderer colour-depth, i.e. 8, 24, 32
    kin AS _BYTE '...a marker to indicate the engine's genealogy
    cfg AS STRING '..slug to use in the config file-name
    save AS STRING '.save-folder name to use
    tags AS STRING '.comma-separated tags list the engine supports
    auto AS STRING '.semi-colon separated list of WADs to always include
    cmd AS STRING '..additional command-line parameters to use when launching
END TYPE

CONST TIER_ULTRA = 3 '"high" tier engine, ideal for discrete GPUs
CONST TIER_FAST = 2 '."medium" tier engine, ideal for integrated graphics
CONST TIER_RETRO = 1 '"low" tier engines that retain the classic DOOM style

CONST KIN_X = 1 'kex engine; i.e. DOOM64. *NOT* vanilla
CONST KIN_V = 2 '"vanilla" engine; i.e. Chocolate-Doom, Crispy-Doom
CONST KIN_B = 3 '"Boom" engine; i.e. PrBoom+, DOOM-Retro
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

DIM SHARED Engines_SelectedUltra AS LONG
DIM SHARED Engines_SelectedFast AS LONG
DIM SHARED Engines_SelectedRetro AS LONG

