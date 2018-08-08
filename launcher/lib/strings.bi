'copyright (C) Kroc Camen 2018, BSD 2-clause

'since QB64 doesn't support variable-length strings in User-Defined-Types,
'it's more flexible to use a string pool than impose limits on every string
REDIM SHARED Strings(0) AS STRING
