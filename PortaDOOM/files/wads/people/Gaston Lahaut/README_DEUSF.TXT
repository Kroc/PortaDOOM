MORDETH FEB'97 DEUSF-Compatible version
=======================================

This archive contains the same episode of Mordeth as does the
normal Mordeth Feb'97 archive ("mordeth.zip"), but its sprites 
& flats wad has been made DeuSF compatible. With NWT, Macintosh 
users couldn't extract all sprites and flats to the new Mordeth 
sprites/flats file, because of NWT's incompatability with the
Mac operating system.

To give Mac users one less reason to buy a REAL computer <grin>
I have replaced the Mordeth S&P file "morgrap0.wad" with the
DeuSF-version "mdeugrap.wad".

In this zip, I have provided ONLY these files neccessary to
install and play Mordeth. I have NOT written an installation
front-end program for the Mac, for the simple reason I do not
know this OS. Mac users should read the instructions for the
DOS installation below, and deduct their Mac equivalent.

Included in zip:

        MORDETH.WAD  (contains levels, textures, sounds, music)
        MDEUGRAP.WAD (contains new sprites/flats)
        MORDETH.DEH  (.exe patch for Mordeth)
        DEUSF.EXE    (tool for installation of Mordeth)
        DEHACKED.EXE (tool for installation of Mordeth)
        MORDETH.TXT  (about Mordeth)
        README.TXT   (this text file)

Installation for DOS
--------------------

Remember, since I have no experience with Macintosh, you must
deduct the Mac equivalent of these dos commands. I really can
not help you there.

! GOOD INSTALLATION IS REQUIRED TO PLAY MORDETH !

1) Unzip the archive in your doom2 v1.9 directory
2) To make a functional S&P file, enter the following commands:
        a) DEUSF -AS MDEUGRAP.WAD
        b) DEUSF -AF MDEUGRAP.WAD
   That last command will generate a lot of error messages 
   concerning the old sprites, but just IGNORE these... I tested
   the WAD afterwards and everything works just fine.
3) To make an alternative exe, do the following:
        a) Make a copy of your doom2.exe and rename it to "doomhack.exe"
        b) Enter the command: DEHACKED -LOAD MORDETH.DEH
        c) Rename doomhack.exe to mord.exe
4) To play Mordeth, enter the following command:
        MORD -FILE MORDETH.WAD MDEUGRAP.WAD



Have fun!

Gaston Lahaut
Author of Mordeth
E-Mail: g.lahaut@stud.warande.ruu.nl
Mordeth Home Page: http://www.warande.ruu.nl/~glahaut/mordeth.htm
