'copyright (C) Kroc Camen 2018, BSD 2-clause

TYPE IWAD
	id AS LONG
	name AS LONG
	title AS LONG
	path AS LONG
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
