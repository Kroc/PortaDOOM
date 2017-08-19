# PortaDOOM #

A self-contained, portable [DOOM](https://en.wikipedia.org/wiki/Doom_(1993_video_game)) launcher and [WAD](https://en.wikipedia.org/wiki/Doom_WAD) collection presented as an early '90s [diskzine](https://en.wikipedia.org/wiki/Disk_magazine).

![PortaDOOM Screenshot](screenshot.png)

It's intended as a single download that people can unzip and play on any computer, targeted at people who have either never played DOOM or anything beyond the official iD canon and the thought of downloading, configuring and launching several different engines with all kinds of weird WAD files is putting them off trying stuff out.

PortaDOOM is about having a single executable where you press a few keys and hey-presto! you're playing DOOM WADs in the correct engine with the correct settings.

The viewer is written in [QB64](http://www.qb64.net/); a modern remake of Microsoft's classic [QuickBASIC](https://en.wikipedia.org/wiki/QuickBASIC) for that DOS look and feel, but you do not need to be able to code to contribute: all the diskzine pages are just text-files that anybody can create and edit.

You can contribute the following ways:
*   Write pages yourself using [this handy guide](DOSmag/README.md#how-to-write-pages)
*   File GitHub Issues for suggestions and fixes
*   E-mail me: <kroc@camendesign.com>

_NOTE: please do not send me direct links to WAD/pk3 files; point me to the project page / forum thread etc. so that I can keep track of where things comes from, who they belong to, and keep an eye on updates._

## doom.bat ##

Within the "`files`" folder is "doom.bat", a command-line DOOM launcher. Use the "`SHELL:`" action of DOSmag to launch doom wads via doom.bat; the instructions for doom.bat are as follows:

```
 "doom.bat" is a command-line launcher for DOOM-based games.
 It makes it easier to create shortcuts to run a particular
 source-port with a particular WAD and particular mods etc.

Usage:

    doom.bat [options] [engine] [IWAD [PWAD] [params] [ -- files...]]

Example:

    doom.bat gzdoom DOOM2 -- brutalv20b.pk3

Options:

   /WAIT                : Causes doom.bat to not immediately return once the
                          engine is launched. Script execution will continue
                          only once the engine has quit

   /CONSOLE             : Causes the output of the engine to be echoed to the
                          console. This implies /WAIT. Works only with Z-based
                          engines: QZDoom, GZDoom, ZDoom and Zandronum

   /DEFAULT             : Loads the engine with the default config file instead
                          of the current user config file. Any changes you make
                          to the engine's settings will be saved in the default
                          configuration file

   /32                  : Always use 32-bit binaries, even on a 64-bit system

Engines:

    choco-doom          : ChocolateDOOM (very vanilla, 320x200)
    choco-doom-setup    : Displays ChocolateDOOM's configuration program first
    choco-heretic       : As with choco-doom, but for Heretic WADs
    choco-heretic-setup : As above, but displays configuration first
    choco-hexen         : As with choco-doom, but for Hexen WADs
    choco-hexen-setup   : As above, but displays configuration first
    choco-strife        : As with choco-doom, but for Strife WADs
    choco-strife-setup  : As above, but displays configuration first
    doom64ex            : DOOM 64 EX, specifically for DOOM 64
    glboom              : PRBoom+ (OpenGL renderer)
    gzdoom              : GZDoom current
    gzdoom-??           : Where ?? is "22", "23", "24" or "31"
    prboom              : PRBoom+ (software renderer)
    zdoom               : ZDoom
    zandronum           : Zandronum current (2.x)
    zandronum-?         : Where ? is "2" or "3"

IWAD:

    The IWAD (internal WAD) is the base WAD to use. This will be one of the
    original game's WAD files which maps, mods and total conversions extend.
    If uncertain, use "DOOM2", it's the most common one used for community
    content. The ".WAD" / ".PK3" extension can be ommitted.

    IWADs are located in the "iwads" folder.

    Steam & GOG:

    If "DOOM.WAD", "DOOM2.WAD", "TNT.WAD" or "PLUTONIA.WAD" are specified but
    cannot be found in the "iwads" folder, doom.bat will try to locate them
    automatically for you in any relevant Steam or GOG installations:

        Steam : DOOM 3 BFG Edition    - DOOM.WAD & DOOM2.WAD
        Steam : The Ultimate DOOM     - DOOM.WAD
        Steam : DOOM II               - DOOM2.WAD
        Steam : Final DOOM            - TNT.WAD & PLUTONIA.WAD
        (note that "DOOM Classic Complete" contains all of the above)
          GOG : The Ultimate DOOM     - DOOM.WAD
          GOG : DOOM II + Final DOOM  - DOOM2.WAD, TNT.WAD & PLUTONIA.WAD

    Shareware:

    If the IWAD is "DOOM" and no PWAD is specified (see below), i.e. you are
    trying to play the the original DOOM rather than a user-map, and "DOOM.WAD"
    cannot be found (inclduing in Steam or GOG, above) then the DOOM shareware
    will be used instead which is limited to the first episode.

PWAD:

    The PWAD (patch-WAD) is the community map / megawad you want to play.
    These are assumed to be in the "pwads" folder, not "iwads".
    E.g.

           doom.bat gzdoom DOOM2 wolfendoom.pk3

    If you just want to play an original game (e.g. DOOM, Hexen) then the PWAD
    is not required. The ".PK3" / ".PK7" / ".WAD" extension can be omitted but
    if two files exist with the same name but different extensions then the
    first file will be chosen using the order of extensions just mentioned.

    Steam & GOG:

    If "NERVE.WAD" or any of the "Master Levels for DOOM II" ("MASTER\*.WAD")
    are specified as the PWAD and cannot be found in the "pwads" folder,
    doom.bat will try to locate them for you in any relevant Steam or GOG
    installations:

        Steam : DOOM 3 BFG Edition    - NERVE.WAD
        Steam : DOOM Classic Complete - Master Levels for DOOM II
          GOG : DOOM II + Final DOOM  - Master Levels for DOOM II

    FreeDOOM:

    When using a PWAD, if an IWAD of "DOOM" or "DOOM2" is specified, but these
    WAD files are not present, FreeDOOM will be used instead, though a warning
    will be presented.

    Whilst DOOM gameplay mods and maps work off of DOOM.WAD or DOOM2.WAD,
    FreeDOOM is intended as a drop-in replacement, maintaining compatibility
    with DOOM.WAD & DOOM2.WAD allowing you to play most community content
    without having to actually purchase DOOM.

Params:

    You can include any command line parameters here and they will be
    passed on to the engine. Example:

           doom.bat choco-doom DOOM2 -warp 21

    Note that what parameters are supported will vary between engines.

Files:

    NOTE: The "--" is required to separate the parameters from the list
    of files.

    A list of additional files to include (from the "pwads" directory).
    Unlike when creating Windows shortcuts, the "pwads" folder is assumed,
    so that you don't need to include the base path on each file added.

    If a PWAD has been given, the PWAD's folder will also be checked so that
    you do not have to give the path for both the PWAD, and any files within
    the same folder. E.g.

        doom.bat zdoom DOOM2 doomrl_arsenal\doomrl_arsenal.wad
                                         -- doomrl_arsenal_hud.wad

    The ".PK3" / ".PK7" / ".WAD" extension can be omitted but if two files
    exist with the same name but different extensions then the first file
    will be chosen using the order of extensions just mentioned.

    After one file is included, the same folder will be checked for the
    next file. This is handy for including multiple WADs located in the
    same folder, e.g.

        doom.bat gzdoom DOOM2 -- BrutalDoom\Brutalv20b.pk3 ExtraTextures.wad

    Where "ExtraTextures.wad" is in the "BrutalDoom" folder, and if it isn't
    the base "pwads" folder will be checked and then the engine's folder.

    DeHackEd extensions (".deh" / ".bex") can be included in the files list,
    and will be loaded using the correct "-deh" or "-bex" engine parameter.

Config File:

    For portability doom.bat has default configuration files for each engine
    which will be copied to the save folder for that engine when one does not
    exist. doom.bat automatically launches the engine with this portable config
    file so that your settings are used regardless of which machine you use.

    if a -config parameter has already been given then that config file will
    be used as intended and doom.bat will not supply its own.

Savegames:

    Savegames are not saved alongside the engine as is default, but rather
    in a "saves" folder. To prevent incompatibilites and potential data-loss
    between engines, savegames are first separated by engine ("gzdoom" /
    "zandronum" etc.) and then by the PWAD name (or IWAD name if no PWAD
    is specified). I.e. for the command:

           doom.bat zdoom DOOM2 breach.wad

    the savegames will be located in "saves\zdoom\breach\".
```

Have fun and DOOM on!