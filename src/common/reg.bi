'copyright (C) Kroc Camen 2018-2021, BSD 2-clause

'this code adapted from the example at:
'http://www.qb64.org/wiki/Windows_Registry_Access

DECLARE DYNAMIC LIBRARY "advapi32"

'http://msdn.microsoft.com/en-us/library/ms724897(v=VS.85).aspx
FUNCTION RegOpenKeyExA& ( _
    BYVAL hKey AS _OFFSET, BYVAL lpSubKey AS _OFFSET, _
    BYVAL ulOptions AS _UNSIGNED LONG, BYVAL samDesired AS _UNSIGNED LONG, _
    BYVAL phkResult AS _OFFSET _
)

'http://msdn.microsoft.com/en-us/library/ms724911(v=VS.85).aspx
FUNCTION RegQueryValueExA& ( _
    BYVAL hKey AS _OFFSET, BYVAL lpValueName AS _OFFSET, _
    BYVAL lpReserved AS _OFFSET, BYVAL lpType AS _OFFSET, _
    BYVAL lpData AS _OFFSET, BYVAL lpcbData AS _OFFSET _
)

'http://msdn.microsoft.com/en-us/library/ms724837(v=VS.85).aspx
FUNCTION RegCloseKey& (BYVAL hKey AS _OFFSET) 

END DECLARE

CONST HKEY_CLASSES_ROOT = &H80000000~&
CONST HKEY_CURRENT_USER = &H80000001~&
CONST HKEY_LOCAL_MACHINE = &H80000002~&

CONST KEY_READ = &H20019&

'"Access a 64-bit key from either a 32-bit or 64-bit application"
CONST KEY_WOW64_32KEY = &H0200&
'"Access a 32-bit key from either a 32-bit or 64-bit application"
CONST KEY_WOW64_64KEY = &H0100&

'winerror.h
'http://msdn.microsoft.com/en-us/library/ms681382(v=VS.85).aspx
CONST ERROR_SUCCESS = 0
CONST ERROR_FILE_NOT_FOUND = &H2&
CONST ERROR_INVALID_HANDLE = &H6&
CONST ERROR_MORE_DATA = &HEA&
CONST ERROR_NO_MORE_ITEMS = &H103&
