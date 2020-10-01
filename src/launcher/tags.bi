'copyright (C) Kroc Camen 2018-2020, BSD 2-clause
'tags.bi : definitions for engine/game feature tags

DIM SHARED tag$, tag%

'an array of all known feature-tags
'(value is an index into the string pool)
REDIM SHARED Tags(0) AS STRING

'a two-dimensional array of game/engine -> tag-indicies; that is, the 1st
'dimension is for each game/engine and the second dimension covers each tag
'-- a value of 1 indicates that the game/engine requires that tag.
'
'the zeroth tag index is used to shortlist engines
'by marking them as compatible (=1) or not (=0)
'
REDIM SHARED GameTags(0, 0) AS LONG
REDIM SHARED EngineTags(0, 0) AS LONG
