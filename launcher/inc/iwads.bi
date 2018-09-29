'copyright (C) Kroc Camen 2018, BSD 2-clause

'the DOOM engine was enhanced over time. not all modern source ports support
'these enhancements so the IWAD has to specify which original DOOM-engine it
'was intended for

CONST TYPE_DOOM = 1'....DOOM uses episodes
CONST TYPE_CHEX = 2 '...a lightly modified DOOM engine
CONST TYPE_DOOM2 = 4 '..DOOM2 does not use episodes
CONST TYPE_HERETIC = 8 'HERETIC added an inventory
CONST TYPE_HEXEN = 16 '.HEXEN added ACS scripting and classes
CONST TYPE_STRIFE = 32 'STRIFE adds a conversation system and more
CONST TYPE_DOOM64 = 64 'DOOM64 uses coloured lighting

TYPE IWAD
    id AS LONG '.....unique identifier, short, no spaces
    name AS LONG '...a short name, e.g. "DOOM2"
    type AS INTEGER 'one of the above TYPE_* constants
    title AS LONG '..a more complete name, e.g. "DOOM II: Hell On Earth"
    path AS LONG '...path of the WAD file
    deh AS LONG '....DeHackEd file for the IWAD! CHEX.DEH for example
    tags AS LONG '...comma-separated list of required feature-tags
    skill1 AS LONG '.description of skill-level 1, e.g. "I'm Too Young To Die"
    skill2 AS LONG '.description of skill-level 2, e.g. "Hey, Not Too Rough"
    skill3 AS LONG '.description of skill-level 3, e.g. "Hurt Me Plenty"
    skill4 AS LONG '.description of skill-level 4, e.g. "Ultra-Violence"
    skill5 AS LONG '.description of skill-level 5, e.g. "Nightmare"
    skill6 AS LONG '.description of skill-level 6 (if present)
    skill7 AS LONG '.description of skill-level 7 (if present)
    skill8 AS LONG '.description of skill-level 8 (if present)
    skill9 AS LONG '.description of skill-level 9 (if present)
END TYPE

REDIM SHARED IWADs(1) AS IWAD
DIM SHARED IWADs_Count AS LONG

DIM SHARED IWADs_Selected AS IWAD
'currently selected IWAD index
DIM SHARED IWADs_Current AS LONG