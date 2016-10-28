# PortaDOOM #

A self-contained, portable [DOOM](https://en.wikipedia.org/wiki/Doom_(1993_video_game)) launcher and [WAD](https://en.wikipedia.org/wiki/Doom_WAD) collection presented as an early '90s [diskzine](https://en.wikipedia.org/wiki/Disk_magazine).

It's intended as a single download that people can unzip and play on any computer, targeted at people who have either never played DOOM or anything beyond the official iD canon and the thought of downloading, configuring and launching several different engines with all kinds of weird WAD files is putting them off trying stuff out.

**WARNING: The GitHub repository does not contain the game content (besides [FreeDOOM](https://en.wikipedia.org/wiki/Freedoom)); the repository is the source base for building a redistributable package. These might be made available elsewhere at a later date.**

PortaDOOM is about having a single executable where you press a few keys and hey-presto! you're playing DOOM WADs in the correct engine with the correct settings.

The viewer is written in [QB64](http://www.qb64.net/); a modern remake of Microsoft's classic [QuickBASIC](https://en.wikipedia.org/wiki/QuickBASIC) for that DOS look and feel, but you do not need to be able to code to contribute: all the diskzine pages are just text-files that anybody can create and edit.

You can contribute the following ways:
*   Write pages yourself using the handy guide below
*   File GitHub Issues for suggestions and fixes
*   E-mail me: <kroc+doom@camendesign.com>

_NOTE: please do not send me direct links to WAD/pk3 files; point me to the project page / forum thread etc. so that I can keep track of where things comes from, who they belong to, and keep an eye on updates._

## How to Write Pages ##

The pages displayed by the PortaDOOM viewer (internally "DOSmag") reside in the `pages` folder.
Each page is simply a txt file, but with the extension ".dosmag". This is so that you can set custom encoding/font options for this file-type in your text editor.

> _Pro Tip:_ Make sure files are always saved in ANSI encoding, not UTF-8! DOSmag displays text using [code page 437](https://en.wikipedia.org/wiki/Code_page_437). Open [CharMap](https://en.wikipedia.org/wiki/Character_Map_(Windows)) and set the font to Terminal to access the extra symbols. 

Pages can be grouped into sets. Such sets share the same file name, but are prefixed by the page number e.g. "`#04`". The number *must* be two digits long to be recognised. This ensures that the files appear ordered correctly on your drive.

Long lines will be word-wrapped for you, so it is best to just write each paragraph as a single continuous line and set your text-editor to word-wrap.

### Control Codes ###

Within a page file, these are the conventions you may use:

```
^C
```

A line that begins with `^C` will be centred. If the line is too long for the screen, it will wrap and all such lines will be centred too. The centre control code *must* appear as the first thing on a line, no other control code can preceed it.

```
^:
```

A heading. This effect continues for the rest of the line. (the colon is not printed)

```
^*...^*
```

A "bold" effect. The bold control code turns the effect on and then off each time it is encountered, however it automatically turns off at the end of a line. For example:

```
^*This text will be bold
^*And so will this!
```

This is why, in general, you should not manually word-wrap your text.

```
^/...^/
```

An "italic" effect. Behaves in the same manner as the bold control code.

```
^-
^=
```

These draw lines across the screen. These can only appear at the beginning of a line (they cannot co-exist with the centre control code), and everything after the first dash / equals is ignored. For example:

```
^:Heading 1
^----------
^:Heading 2
^==========
```

> Pro Tip: You can press F5 in PortaDOOM to reload the current page!

```
^( ... )
```

Parentheses can be highlighted this way. The effect will stop at the first closing parenthesis that follows. The control code will output the opening parenthesis for you.

```
^[...]
```

This is intended to markup navigation keys, such as "`[D]`". The opening square bracket will be displayed and the effect will continue until the next closing square bracket. There must not be any spaces between the square brackets.

NOTE: This does not actually bind the key to any action, it's purely a visual indicator. See below for how to bind keys to actions.

### Key Bindings ###

To make a key navigate to another page, place a key binding instruction at the top of your page. For example:

```
$KEY:D=GOTO:Name of a Page #01
```

The `$KEY:` text indicates a key binding. There must be no whitespace before it and these should appear on the first lines of your page. The next letter is the key to bind, 'A' - 'Z', '0' - '9'; must be capital.

After the equals sign, the word "GOTO:" indicates the action to take, i.e. navigate to a page. Give the name of the page set to load, and the page number, if the page set has more than one.

To make a key launch a DOOM game, we use the `SHELL:` action.

```
$KEY:D=SHELL:doom.bat gzdoom DOOM2
```

`SHELL:` executes a DOS command. The 'current directory' is set to the `files` folder.
Within that is "doom.bat", a command-line DOOM launcher. The instructions for that are as follows:

```
 "doom.bat" is a command-line launcher for DOOM-based games.
 It makes it easier to create shortcuts to run a particular
 source-port with a particular WAD and particular mods etc.

Usage:

    doom.bat [<engine>] [<IWAD> [<PWAD>] [<options>] [ -- <files>...]]

Example:

    doom.bat gzdoom DOOM2 -- brutalv20b.pk3

Engines:

    gzdoom              : Stable version of GZDoom
    zdoom               : ZDoom
    zandronum           : Zandronum current (2.x)
    zandronum-dev       : Zandronum in development (3.0)
    prboom              : PRBoom+ (software renderer)
    glboom              : PRBoom+ (OpenGL renderer)
    choco-doom          : ChocolateDOOM (very vanilla, 320x200)
    choco-doom-setup    : Displays ChocolateDOOM's configuration program first
    choco-heretic       : As with choco-doom, but for Heretic WADs
    choco-heretic-setup : As above, but displays configuration first
    choco-hexen         : As with choco-doom, but for Hexen WADs
    choco-hexen-setup   : As above, but displays configuration first
    choco-strife        : As with choco-doom, but for Strife WADs
    choco-strife-setup  : As above, but displays configuration first

IWAD:

    The IWAD (internal WAD) is the base WAD to use. This will be one of the
    original game's WAD files which maps, mods and total conversions extend.
    If uncertain, use "DOOM2", it's the most common one used for community
    content. The ".WAD" / ".PK3" extension can be ommitted.

    IWADs are located in the "iwads" folder.

PWAD:

    The PWAD (patch-WAD) is the community map / megawad you want to play.
    These are assumed to be in the "pwads" folder, not "iwads".
    E.g.

           doom.bat gzdoom DOOM2 wolfendoom.pk3

    If you just want to play an original game (e.g. DOOM, Hexen)
    then the PWAD is not required.

Options:

    You can include any command line parameters here and they will be
    passed on to the engine. Example:

           doom.bat choco-doom DOOM2 -warp 21

    Note that what parameters are supported will vary between engines.

Files:

    A list of additional files to include (from the "pwads" directory).
    Unlike when creating Windows shortcuts, the "pwads" folder is assumed,
    so that you don't need to include the base path on each file added.

    NOTE: The "--" is required to separate the options from the list of files.

    DeHackEd extensions (".deh" / ".bex") can be included in the files list,
    and will be loaded using the correct "-deh" or "-bex" engine parameter.

    Config files (".cfg" / ".ini") will likewise be loaded using the
    correct engine parameter ("-config").

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