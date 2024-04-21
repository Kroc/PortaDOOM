--------------------------------------------------------------------
RUNNING SIGIL II v1.0 (Jimmy MIDI Edition)
Instructions for Windows and Mac OS
--------------------------------------------------------------------

First, important notes:

Hello, and welcome to SIGIL II, the unofficial episode 6 mod. The version
you've acquired has the MIDI soundtrack by James Paddock. If you want to play the version
with the MP3 soundtrack, it can be purchased from our site at http://si6il.com.

SIGIL II comes as a download with these files:

SIGIL_II_README_V1_0.txt
SIGIL_II_V1_0.WAD
SIGIL_II_V1_0.txt

To play SIGIL II, you must copy these files into a folder on your computer
that is running a DOOM source port such as GZDoom. More information about
installing GZDoom below.

You need an installed version of DOOM to run SIGIL II. To play SIGIL II,
you need the DOOM.WAD file from the original DOOM or from The Ultimate
DOOM. If one of these are installed, please note their location. You can
get The Ultimate DOOM from Steam or GOG.com.

SIGIL II merch is available here: https://www.romero.com

You can send any bugs you find to info@romero.com.

****
**** If you purchased SIGIL II v1.0 and want to update it, please visit
**** http://si6il.com for information about how to do it.
****

--------------------------------------------------------------------

Why DOOM 1 and not DOOM 2?

SIGIL II is a 30th anniversary celebration of the 1993 DOOM release. It was designed
to fit the design patterns and look of the original DOOM. I did not want to deviate
from the original much so this unofficial episode six uses the original texture
set for the levels, and adds a new sky like SIGIL did (episode 5).

--------------------------------------------------------------------

INSTALLING GZDOOM

Download GZDoom from https://zdoom.org. Scroll to the bottom
of the page and click "Get ZDoom". On the next page, find the latest GZDoom and
click the download link that corresponds to your operating system under
"Download (Modern, OpenGL 3.3 and higher)". Put GZDoom in its own directory.


WINDOWS ONLY:

Copy your DOOM.WAD file into the GZDoom directory. Drag and drop SIGIL_II_V1_0.WAD
onto GZDoom.exe to run it.

MAC OS ONLY:

You will need to copy your DOOM.WAD file into a special directory
for GZDoom to find it. Run the Finder, bring up a New Finder Window, press
Shift-Command-G, type ~/Library and go to the "Application Support" directory, then the "gzdoom"
directory. Copy your DOOM.WAD file here.

1) Run GZDoom

2) Choose DOOM as the game

3) In the "Additional Parameters" section, click "Browse..." and choose the
SIGIL_II_V1_0.WAD file from the location where you installed SIGIL II (hopefully the same
directory as GZDoom).

4) Click OK


When you're in DOOM, select NEW GAME, the SIGIL II episode, then the skill level.

Have fun!

--------------------------------------------------------------------

GOING ONLINE

The Doom community also provides a variety of options to play games online using
client/server architecture ports. These services provide the work for you and host servers
which you can easily join to play SIGIL II. Depending on your preferences, you should pick one
of the main online c/s ports:

ZDaemon: https://www.zdaemon.org/
Zandronum: https://zandronum.com/
Odamex: https://odamex.net/

To comfortably browse the offered servers, check one of the server browsers, most popularly:
Doomseeker: https://doomseeker.drdteam.org/ (warning, won't work with ZDaemon)
Doom Explorer: http://doomutils.ucoz.com/

Using a combination of these will allow you to search for and join other online players
looking for a game of SIGIL II!

MORE HELP

You can find more information about running WAD files here:

https://doomwiki.org/wiki/How_to_play_or_start_wads

--------------------------------------------------------------------

MULTIPLAYER COOPERATIVE MODE

DOOM is limited to 8-player multiplayer. I'll use GZDoom as an example:

To run GZDoom in co-op, one person will be the host and the other players will
connect to the host. Here are the instructions for running CO-OP MODE:


[[ WINDOWS PLAYERS ]]

To make it easier to run SIGIL II and multiplayer mode in general, you should
use ZDL, a GZDoom launcher. Go here to get it: https://zdoom.org/wiki/ZDL
You want the latest version (3-1.0 as of SIGIL II release). Put ZDL.exe in the
GZDoom directory.

CO-OP HOST INSTRUCTIONS:

1) Find out what your IP address is. Run CMD.EXE. Then run ipconfig.exe and
it'll show you the IP. It's usually 192.168.1.X. Tell the other players your IP.

2) Run ZDL.exe

3) Click the "General Settings" tab. On the left pane, click the + to add
a source port. Type GZDoom for the name, then click the ... and Select GZDoom.exe
from the directory where you installed it. In the right pane where it says
"IWADs", click the + and type DOOM, click the ... and select the DOOM.WAD
that's in the same directory as GZDoom.

4) In the "Launch Config" tab, in the left pane named "External Files" click
the + at the bottom and select the SIGIL_II_V1_0.WAD.

5) Above the "Launch" button you'll see the "Skill" pull-down menu. Select
the skill level.

6) To the left of the "Launch" button is a down triangle. Click it to expand it.

7) Select "Game Mode" as "Co-op"

8) Set the "Frag Limit". We usually use 20.

9) Select the number of players total with the "Players" pull-down menu.

10) You might want to save this setup with CTRL+S

11) Click the HOST button


OTHER CO-OP PLAYERS:

1) Run ZDL.exe

2) Do the same setup as the host numbers (3) and (4)

3) To the left of the "Launch" button is a down triangle. Click it to expand it.

4) Select "Game Mode" as "Co-op"

5) To the right of that field is the "Hostname/IP" field. Type the IP address of
the HOST in there.

6) Select the "Players" pull-down option "Joining"

7) On the right side click the "JOIN" button to start

----------------------

[[ MAC OS PLAYERS ]]

1) Find out what your IP address is. Go to System Preferences > Network and
it'll show your IP. Tell the other players your IP address.

2) Run GZDoom.app

3) In the "Additional Parameters" box, go to the end and type:
-skill 4 -warp 6 1 -host X

X is the total number of players you want in the game. If it's just two of you, use 2.

4) Click OK. As other players connect to you, you will eventually see the game run.

CO-OP PLAYERS:

1) Run GZDoom.app

2) In the "Additional Parameters" box, go to the end and type:
-join X

X is the IP number of the host.

3) Click OK


Your game should start when all players have clicked OK.


--------------------------------------------------------------------

DEATHMATCH MODE

The setup is the same as the COOPERATIVE MODE setup for both HOST and the
other players, but the HOST needs to add some parameters to the
"Additional Parameters" box (MAC OS) or "Extra command line arguments" (WINDOWS):

-nomonsters -deathmatch

It does make things interesting when you leave monsters in the game
and allow the deathmatch arenas to open into the single-player areas!

--------------------------------------------------------------------

EXITMATCH

I designed this game mode idea decades ago but never programmed it into
a game. It was invented for DOOM, DOOM II, Heretic, Hexen, etc. Basically
any game with level progression where you can kill your buddies. It's
most fun when there are 3 or 4 players.

The rules: You play COOPERATIVE mode as usual. You are all killing the
monsters to get to the exit. If you kill each other, that doesn't matter
since you end up at the start of the level anyway and have to catch up to
the other players.

But the only way to score the EXITMATCH point is to flip the exit switch.

There is only one point possible per level and that point goes to the player
who flips the exit switch! Watch as everyone start the level cooperating,
but as soon as the end of the level is in sight, all kinds of problems
start happening.

Before you start, you decide how many levels, or points, are possible
in the match. That's how many levels you'll play, and the winner is the
player who flipped the exit switch the most times. You have to keep track
of the score manually.

It's quite possibly the most fun I've had playing DOOM.

--------------------------------------------------------------------

MORE HELP

You can find more information about running WADS here:
https://doomwiki.org/wiki/How_to_play_or_start_wads

--------------------------------------------------------------------

COMPATIBLE VERSIONS

There are some players who would like to use a more strict, old-school port
of DOOM like PRBOOM+ or CRISPY DOOM, or the Eternity Engine. SIGIL II was not
made for strict vanilla-compatible DOOM ports, but it may work with some
of them. I tried to be as compatible as I could without creating an entirely
new WAD. Some of these source ports may be updated to work with SIGIL II.


I hope you enjoy SIGIL II! If you want to drop me an email about it, I'm john@romero.com.

Cheers,

John Romero
Romero Games Ltd. (C) 2023



The SIGIL II WAD is a mod for the original DOOM® and is distributed as such. DOOM® and
DOOM II® are registered trademarks of ZeniMax Media Inc. in the US and/or other countries.
Id Software® is a registered trademark of ZeniMax Media Inc. in the US and/or other
countries. The SIGIL II WAD is in no way affiliated with ZeniMax Media Inc. or
id Software LLC and is not approved by ZeniMax Media Inc. or id Software.
