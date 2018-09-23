'copyright (C) Kroc Camen 2018, BSD 2-clause

CONST TYPE_DOOM = 1
CONST TYPE_DOOM2 = 2
CONST TYPE_HERETIC = 4
CONST TYPE_HEXEN = 8
CONST TYPE_STRIFE = 16
CONST TYPE_DOOM64 = 32

TYPE IWAD
	id AS LONG '....unique identifier, short, no spaces
	name AS LONG '..a short name, e.g. "DOOM2"
	type AS INTEGER '"DOOM", "DOOM2", "HERETIC", "HEXEN", "STRIFE" or "DOOM64"
	title AS LONG '.a more complete name, e.g. "DOOM II: Hell On Earth"
	path AS LONG '..path of the WAD file
	tags AS LONG '..comma-separated list of required feature-tags
	skill1 AS LONG 'description of skill-level 1, e.g. "I'm Too Young To Die"
	skill2 AS LONG 'description of skill-level 2, e.g. "Hey, Not Too Rough"
	skill3 AS LONG 'description of skill-level 3, e.g. "Hurt Me Plenty"
	skill4 AS LONG 'description of skill-level 4, e.g. "Ultra-Violence"
	skill5 AS LONG 'description of skill-level 5, e.g. "Nightmare"
	skill6 AS LONG 'description of skill-level 6 (if present)
	skill7 AS LONG 'description of skill-level 7 (if present)
	skill8 AS LONG 'description of skill-level 8 (if present)
	skill9 AS LONG 'description of skill-level 9 (if present)
END TYPE

REDIM SHARED IWADs(1) AS IWAD
DIM SHARED IWADs_Count AS LONG
