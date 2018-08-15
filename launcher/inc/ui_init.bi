'copyright (C) Kroc Camen 2018, BSD 2-clause
'ui.bi : define and initialise the user-interface

$EXEICON:'.\icon\launcher.ico'

'''the default size (in char cols/rows) of the screen
''CONST SCREEN_MODE = 0 '...text mode
''CONST SCREEN_WIDTH = 80 '.640 width
''CONST SCREEN_HEIGHT = 30 '480 height

'-----------------------------------------------------------------------------

$CONSOLE:ONLY
_DEST _CONSOLE
''_CONSOLE OFF

'hide the main window until we have something rendered on it first
''$SCREENHIDE

'disallow resizing of the window. this adds a great deal of complexity for
'very little gain right now and there isn't an easy way to restore a window
'to its 1:1 size
''$RESIZE:OFF

'set ALT+ENTER to switch to 4:3 aspect ratio, with anti-aliasing;
'many thanks Fellippe Heitor for implementing this!
''_ALLOWFULLSCREEN _SQUAREPIXELS, _SMOOTH

'put a name on this thing
_TITLE "PortaDOOM Launcher"

'''set graphics mode, screen size, colour and clear screen
''SCREEN SCREEN_MODE, , 0, 0: WIDTH SCREEN_WIDTH, SCREEN_HEIGHT
''_SCREENSHOW
