# INI-Manager
Library for QB64 for reading from/writing to INI configuration files.

## .ini format
INI files are used to store data required for a program's operation. Modern Windows apps use the Registry to store and retrieve information. However, the .ini method works across platforms and is easy to mantain, besides being human-readable.

### Sample file
Sections are defined by enclosing the section title in [brackets]. Keys are assigned values using the equal sign (Key1=Value1). Quotation marks are allowed to delimit text, but not required. Comments can be added in the beginning of lines or after values, and are started by a semicolon. BASIC-style comments are also allowed, marked with an apostrophe (') if you set IniAllowBasicComments to true (-1):

    ; last modified 1 April 2001 by John Doe
    [owner]
    name="John Doe"
    organization=Acme Widgets Inc. 'we may need to change this later

    [database]
    ; use IP address in case network name resolution is not working
    server=192.0.2.62     
    port=143 ; change responsibly, be careful with conflicts
    file="payroll.dat"


More info at https://en.wikipedia.org/wiki/INI_file

## Library methods

### Writing

        WriteSetting file$, section$, key$, value$

Writes a new setting to a file or updates an existing one.

* file$ = the file name to write to. Can handle multiple .ini files at once. To work with a single file, you only need to pass file$ in the first write operation.
* section$ = the [section] in the ini file where the new key$ will be added.
* key$ = the unique identifier of the value you wish to store (multiple identical keys can exist across different sections).
* value$ = the value to be stored. Numeric values must be converted to strings with STR$() first.

### Reading

        result$ = ReadSetting$(file$, section$, key$)

Reads settings from a file.

* result$ = the variable where the value$ obtained from the file$ will be stored.
* file$ = the file name to be parsed. To work with a single file, you only need to pass file$ in the first read operation.
* section$ = the [section] in the ini file where the key$ will be read from.
* key$ = the key in the file whose value you want to read.

By passing an empty section$ and an empty key$ ("") you can fetch all keys in the file sequentially. To fetch all keys in a given section, leave only the key$ parameter empty.

### Deleting

        IniDeleteSection file$, section$

Deletes a whole section from a file.

        IniDeleteKey file$, section$, key$

Deletes a key from the specified section in a file.

### Other methods

		IniSortSection file$, section$
		
Sorts keys alphabetically in the specified section.

		IniMoveKey file$, section$, key$, newSection$
		
Moves key$ from section$ to newSection$.

		result$ = IniINFO$

Returns the description of the IniCODE from the last operation. After a read or write operation, IniCODE will be 0 if operation successful. When not 0, IniINFO$ returns a human-readable description of the error.

Check the sample programs provided for more usage examples.
