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

    doom.bat [/USE <engine>] [/WAIT] [/CONSOLE] [/SW] [/32] [/DEFAULT]
             [/IWAD <file>] [/PWAD <file>] [/DEH <file>] [/BEX <file>]
             [/DEMO <file>] [/WARP <map-number>] [/SKILL <skill-level>]
             [/CMPLVL <complevel>] [/EXEC <file>]
             [-- <files>...]

 Example:

    doom.bat /USE gzdoom /IWAD DOOM2 /PWAD crumpets.wad

 ---------------------------------------------------------------------------------

 /USE <engine>

    Which engine to use. Can be any of the following:

      choco-doom          : Chocolate Doom (very vanilla, 320x200)
      choco-doom-setup    : Displays Chocolate Doom's configuration program first
      choco-heretic       : As with choco-doom, but for Heretic WADs
      choco-heretic-setup : As above, but displays configuration first
      choco-hexen         : As with choco-doom, but for Hexen WADs
      choco-hexen-setup   : As above, but displays configuration first
      choco-strife        : As with choco-doom, but for Strife WADs
      choco-strife-setup  : As above, but displays configuration first
      crispy-doom         : Fork of Chocolate Doom; 640x400, limits removed
      crispy-doom-setup   : As above, but displays configuration first
      doomretro           : Similar to Crispy Doom, but supports boom extensions
      prboom              : PRBoom+ defaults to OpenGL. Use `/SW` for software
      gzdoom              : GZDoom current. Use `/SW` for software rendering
      gzdoom-??           : Where ?? is a version number (see below)
      zandronum           : Zandronum current (2.x)
      zandronum-?         : Where ? is a version number, "2" or "3"
      doom64ex            : DOOM 64 EX, specifically for DOOM 64
      zdoom               : deprecated. use gzdoom with software `/SW` instead

    For GZDoom, specific versions can be invoked with the following:

      gzdoom-09           : GZDoom v0.9.28 (AUG-2005+)
      gzdoom-10           : GZDoom v1.0.32 (FEB-2006+)
      gzdoom-11           : GZDoom v1.1.06 (FEB-2008+)
      gzdoom-12           : GZDoom v1.2.01 (MAR-2009+)
      gzdoom-13           : GZDoom v1.3.17 (OCT-2009+)
      gzdoom-14           : GZDoom v1.4.08 (JAN-2010+)
      gzdoom-15           : GZDoom v1.5.06 (AUG-2010+)
      gzdoom-16           : GZDoom v1.6.00 (JUL-2012+)
      gzdoom-17           : GZDoom v1.7.01 (DEC-2012+)
      gzdoom-18           : GZDoom v1.8.10 (JUN-2013+)
      gzdoom-19           : GZDoom v1.9.1  (FEB-2016+)
      gzdoom-20           : GZDoom v2.0.05 (SEP-2014+)
      gzdoom-21           : GZDoom v2.1.1  (FEB-2016+)
      gzdoom-22           : GZDoom v2.2.0  (SEP-2016+)
      gzdoom-23           : GZDoom v2.3.0  (JAN-2017+)
      gzdoom-24           : GZDoom v2.4.0  (MAR-2017+)
      gzdoom-32           : GZDoom v3.2.4  (OCT-2017+);
                            versions 3.0 (APR-2017+), 3.1 (JUN-2017+) and 3.2.0
                            (OCT-2017+) are excluded due to a security concern

    NOTE: Additional engine resource files will be included automatically, that is
          "brightmaps.pk3" & "lights.pk3" for GZDoom versions 1.0 and above, or
          "skulltag_actors.pk3" & "skulltag_data.pk3" for Zandronum

 /WAIT

    Causes doom.bat to not immediately return once the engine is launched.
    Script execution will continue only once the engine has quit.

 /CONSOLE

    Causes the output of the engine to be echoed to the console.
    This implies `/WAIT`. Works only with Z-based engines:
    GZDoom, ZDoom and Zandronum.

 /SW

    Force software rendering. By default hardware rendering is used in
    GZDoom and PRBoom+ ("glboom-plus").

 /32

    Always use 32-bit binaries, even on a 64-bit system.

 /DEFAULT

    Loads the engine with the default config file instead of the current user
    config file. Any changes you make to the engine's settings will be saved
    in the default configuration file.

 /IWAD <file>

    The IWAD (Internal WAD) is the base WAD to use. This will be one of the
    original game's WAD files which maps, mods and total conversions extend.

    IWADs are located in the "wads" folder.

    If this option is ommitted the default IWAD will be based on the selected
    engine. Some engines support only a certain game, i.e.

        chocolate-heretic[-setup] : HERETIC.WAD
        chocolate-hexen[-setup]   : HEXEN.WAD
        chocolate-strife[-setup]  : STRIFE1.WAD
        doom64ex                  : DOOM64.WAD

    All other engines default to DOOM2.WAD as this is the most common one used
    for community content.

    Steam & GOG:

    If the given IWAD cannot be found in the "wads" folder, doom.bat will
    try to locate them automatically for you in any relevant Steam or GOG
    installations:

            Steam : The Ultimate DOOM     - DOOM.WAD
            Steam : DOOM II               - DOOM2.WAD
            Steam : Final DOOM            - TNT.WAD & PLUTONIA.WAD
            Steam : DOOM Classic Complete - (all of the above)
      GOG / Steam : DOOM 3 BFG Edition    - DOOM.WAD & DOOM2.WAD
              GOG : The Ultimate DOOM     - DOOM.WAD
              GOG : DOOM II + Final DOOM  - DOOM2.WAD, TNT.WAD & PLUTONIA.WAD
            Steam : Heretic               - HERETIC.WAD
            Steam : Hexen                 - HEXEN.WAD

    Shareware:

    If the given IWAD cannot be found and no PWAD is specified (see below),
    i.e. you are trying to play an original game rather than a user-map/mod,
    then the equivalent shareware will be used instead, e.g.

        DOOM    : DOOM.WAD    > DOOM1.WAD    (episode 1 only)
        Heretic : HERETIC.WAD > HERETIC1.WAD (episode 1 only)
        Hexen   : HEXEN.WAD   > HEXEN.WAD    (shareware version)
        Strife  : STRIFE1.WAD > STRIFE0.WAD  (shareware version)

    NOTE: There was no shareware release for DOOM II.

 /PWAD <file>

    The PWAD (patch-WAD) is the community map / mod you want to play.
    These are assumed to be in the "wads" folder. E.g.

           doom.bat /USE gzdoom /IWAD DOOM2 /PWAD wolfendoom.pk3

    If you just want to play an original game (e.g. DOOM, Hexen) then the PWAD
    is not required.

    Steam & GOG:

    If "NERVE.WAD" or any of the "Master Levels for DOOM II" are specified as
    the PWAD and cannot be found in the "wads" folder, doom.bat will try to
    locate them for you in any relevant Steam or GOG installations:

      GOG / Steam : DOOM 3 BFG Edition    - NERVE.WAD
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

 /DEH <file>
 /BEX <file>

    Early DOOM modifications were done by way of a live patching system known as
    DeHackEd. These ".deh" files are common, even today, as the lowest-common-
    denominator of DOOM modding.

    Boom, a highly-influential early source-port, enhanced this format further
    with "Boom-EXtended" DeHackEd files.

    These parameters specify a DEH or BEX file to load alongside any WADs.

 /DEMO <file>

    DOOM play sessions can be recorded and played back later. These are often
    distributed as ".lmp" files. The /DEMO option specifies the file to play.

    Unlike the -playdemo engine parameter that requires the path to be valid,
    doom.bat will look for the demo file in the 'current' directory from which
    doom.bat has been called, the "wads" directory, and if a PWAD is given,
    in its directory too.

 /WARP <map-number>

    Warp to the given map number. For games with episodes, such as DOOM and
    Heretic, this is in the format "e.m" where "e" is the Episode number and
    "m" is the Map number, e.g. "/WARP 2.4". For games without episodes like
    DOOM II, it's just a single number e.g. "/WARP 21"

 /SKILL <skill-level>

    Set skill (difficulty) level. This is a number nominally 1 to 5, but this
    may vary with mods. A value of 0 disables monsters on some engines, but this
    can sometimes prevent a level from being compleatable.

 /CMPLVL <complevel>

    Specifies the compatibility level, a feature provided by PrBoom+ to emulate
    the behaviour of different versions of the DOOM executable. The complevel
    can be:

        0     = Doom v1.2
        1     = Doom v1.666
        2     = Doom v1.9
        3     = Ultimate Doom & Doom95
        4     = Final Doom
        5     = DOSDoom
        6     = TASDOOM
        7     = Boom's inaccurate vanilla compatibility mode
        8     = Boom v2.01
        9     = Boom v2.02
        10    = LxDoom
        11    = MBF
        12-16 = PrBoom (old versions)
        17    = Current PrBoom

 /EXEC <file>

    Execute the script file.

 -- <files>...

    NOTE: The "--" is required to separate the parameters from the list
    of files.

    A list of additional files to include (from the "wads" directory).
    Unlike when creating Windows shortcuts, the "wads" folder is assumed,
    so that you don't need to include the base path on each file added.

    If a PWAD has been given, that file's folder will also be checked so that
    you do not have to give the path for both the PWAD, and any files within
    the same folder. E.g.

           doom.bat /PWAD doomrl_arsenal\doomrl_arsenal.wad
                                      -- doomrl_arsenal_hud.wad

    After one file is included, the same folder will be checked for the
    next file. This is handy for including multiple WADs located in the
    same folder, e.g.

           doom.bat -- BrutalDoom\Brutalv20b.pk3 ExtraTextures.wad

    Where "ExtraTextures.wad" is in the "BrutalDoom" folder, and if it isn't
    the base "wads" folder will be checked and then the engine's folder.

 Config File:

    For portability doom.bat has default configuration files for each engine
    which will be copied to the save folder for that engine when one does not
    exist. doom.bat automatically launches the engine with this portable config
    file so that your settings are used regardless of which machine you use.

 Savegames:

    Savegames are not saved alongside the engine as is default, but rather
    in a "saves" folder. To prevent incompatibilites and potential data-loss
    between engines, savegames are first separated by engine ("gzdoom" /
    "zandronum" etc.) and then by the PWAD name (or IWAD name if no PWAD
    is specified). I.e. for the command:

           doom.bat /USE gzdoom /IWAD DOOM2 /PWAD breach.wad

    the savegames will be located in "saves\gzdoom\breach\".
```

Have fun and DOOM on!