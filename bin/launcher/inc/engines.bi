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
    kin AS STRING * 1 '....a marker to indicate the engine's genealogy
    cfg AS STRING * 32 '...config file ID to use
    save AS STRING * 32 '..save-folder name to use
    tags AS STRING * 128 '.comma-separated tags list the engine supports
    iwads AS STRING * 128 'semi-colon separated list of allowed IWADs
    pwads AS STRING * 128 'semi-colon separated list of PWAD file-types
END TYPE

'array that holds all the engines detected, including 'duplicates' that
'share the same engine-id, but differ in version / CPU-type / renderer
REDIM SHARED Engines(1 TO 1) AS Engine
'count of all defined engines (prior to filtering)
DIM SHARED EngineCount%

'list of compatible engines for the selected game
REDIM SHARED EngineList(1 TO 1) AS INTEGER
DIM SHARED EngineListCount%

'loop-counter for engines and later 'currently selected' engine
DIM SHARED engine%

'a two-dimensional array of engine > tag-indicies; that is, the 1st dimension
'is for each engine and the second dimension covers each tag. a value of 1
'indicates that the engine uses that tag. the zeroth tag index is used to
'shortlist engines by marking them as compatible (=1) or not (=0)
REDIM SHARED EngineTags(0, 0) AS _BYTE