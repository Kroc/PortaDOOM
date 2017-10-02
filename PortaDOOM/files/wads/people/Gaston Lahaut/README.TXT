	===========================================================
	MORDETH -- An edited DOOM2 game by Gaston Lahaut
		   g.lahaut@stud.warande.ruu.nl
		   version FEB'97
	===========================================================

	This is the text file for "Mordeth", a multi-level TC 
	for Id Software's DOOM2. Please read the contents of this
	file with care, because it contains vital information about 
	the installation, running and use of Mordeth.

	More information can be obtained at the Mordeth Home Page at
	http://www.warande.ruu.nl/~glahaut/mordeth.htm .
	
	Contents:                                                                      
    
	(1)     What is Mordeth ?
	(2)     Credits & terms of agreement
	(3)     Installing & running Mordeth
		- requirements
		- location of files
		- starting Mordeth
		- starting Mordeth for the 1st time
			(building MORD.EXE and MORGRAPH.WAD)
		- the Mordeth FrontEnd
		- loading Mordeth manually, single-player
		- loading Mordeth manually, multi-player
		- handling of DSG files
		- after a crash?
		- altered cheat codes
		- problems while running Mordeth?
		- last but not least
	(4)     About the Author

	Note that the original commercial version of DOOM2 is
	required to run Mordeth. Tested with DOOM2 v1.666 and
	v1.9. NWT, a vital tool when installing Mordeth, DOES
	NOT work with DOOM2 v1.7a.
	   
	===========================================================                                                                                     
	(1) WHAT IS MORDETH ?  version FEB'97                               
	===========================================================

	This FEB'97 contains the first six levels of the Mordeth TC,
	including new monsters. The levels are large but RMB optimized,
	and everything is checked for level design bugs. All levels are
	playtested in single-player mode and faked multi-player mode.
	
	Constructed from scratch. Editors used: see section (2). Most
	new sprites are edited versions of sprites taken from HEXEN,
	by Id Software & Raven Software, Inc, from HERETIC by Raven
	Software for Id Software, or STRIFE.

	===========================================================
	(2) CREDITS AND TERMS OF AGREEMENT
	===========================================================

	DOOM2 is created by Id Software, Inc.
	HEXEN is created by Id Software and Raven Software.
	HERETIC is created by Raven Software for Id Software.
	
	Map editing was done using EDMAP v1.31 by Jeff Rabenhorst,
	araya@wam.umd.edu.

	Handling of DOOM2 graphics, sprites and WAD files was done
	with NewWadTool (NWT), v1.2 1/95, (c) Denis Moeller, TiC, 
	denis@doomsday.shnet.org.

	Editing of the DOOM2.EXE was done with DeHackEd v3.0a from
	Greg Lewis (Tree), gregl@umich.edu. Only DEHACKED.EXE is
	included here. For all files, please refer to the current
	DOOM FTP site (ftp.cdrom.com) in pub/idgames/utils/exe_edit
	or at Game Palace BBS, (305) 587-4258, or Wolverine BBS,
	(517) 695-9952. Or check the "links" section of the Mordeth
	Home Page.

	To actually edit graphics I used NeoPaint v3.2 by NeoSoft, Inc.

	To modify the endoom screen I used TED, v1.2 by Peter Monks,
	(pmonks@socs.uts.edu.au).

	PCXVIEW.EXE was found amidst the files of the shareware version
	of "DESCENT2". The documentation said one could freely use this
	file. It is used to view the PCX graphics in the Mordeth directory.

	Thanks to Patrick van der Wal for introducing me to the
	wonderfull world of editing Doom..!
	
	TERMS OF AGREEMENT:
	-------------------------------------------------------------
	This free software is distributed "as is" with no warranty 
	of any kind. The author is not liable for any damage, direct 
	or indirect, caused by the use of this software.
	-------------------------------------------------------------
	The PWADS/levels of Mordeth MAY NOT be used for creating 
	additional or modified levels. Mordeth MAY NOT be included in 
	any megawad/compilation. Mordeth MAY be distributed in any
	format as long as all files of the original archive are 
	included. Mordeth MAY NOT be sold on any commercial web/internet
	/public site, this to the judgement of the Author.
	-------------------------------------------------------------

	===========================================================
	(3) INSTALLING & RUNNING MORDETH
	===========================================================

	REQUIREMENTS: 

	First: an original commercial version of DOOM2 by Id Software, 
	Inc, version 1.666 or version 1.9 but not v1.7a (see below),
	installed functional on your HD. 
	Edited versions of the DOOM2.EXE or pirated versions may give 
	trouble. I've also noted that NWT, a vital tool when installing 
	Mordeth, DOES NOT recognise DOOM2 v1.7a. Please upgrade your 
	DOOM2 version. Or: use another tool to extract all sprites and 
	flats missing from MORGRAP0.WAD to this file from the original 
	DOOM2.WAD (like DEUSF, but DO NOT merge with IWAD).
	Secondly: enough disk space. About 9 Mb should do it. 

	MORDETH consist of the following files. Check if they are 
	all present: 

	============================================================
	File                      Description
	============================================================
	MORDETH.WAD               levels & graphics file
	MORGRAP0.WAD              unbuild sprites & flats file
	MORDETH.BAT               frontend for Mordeth, should be copied
				  into the doom2 directory.
	README.TXT                this text file
	MORDETH.TXT               small text file
	CNFRM.BAT                 (small batch file for DOS only)

	MORDETH.DEH               DeHackEd v3.0a and the DeHackEd
	DEHACKED.EXE              Mordeth patch file. Needed to
				  change a copy of DOOM2.EXE to
				  MORD.EXE. See credits.

	STORYA<00-04>.PCX         These PCX graphics are needed to
				  view "The Story". Viewing is done
	PCXVIEW.EXE               with PCXVIEW.EXE (see credits).

	NWT.EXE                   NewWadTool (see credits)
				  NWT is needed to build the
				  functional S&P file.

	*.RSP                     Response files for loading options
				  into the Mordeth command line. Not
				  required for normal gameplay.
	------------------------------------------------------------            
	*Present only after installment*:

	MORGRAPH.WAD             (functional S&P file)
	MORD.EXE                 (DeHackEd Mordeth version of the
				  DOOM2.EXE, present in Doom2 dir)
	============================================================
	Total size : +/- 9 MB

	LOCATION OF FILES

	In the following description, the DOOM2 directory is the 
	directory in which your DOOM2.WAD file is located and will 
	be indicated as "C:\DOOM2". If your DOOM2 directory differs 
	from the one here, just think your own path there instead of 
	the one given: 
	Make a directory within the DOOM2 directory called MORDETH, 
	eg. "C:\DOOM2\MORDETH". Unzip MORDETH.ZIP into this directory, 
	but place (only) the file MORDETH.BAT in the DOOM2 directory 
	("C:\DOOM2").

	STARTING MORDETH

	Mordeth is started by typing "MORDETH" at the DOOM2 DOS 
	prompt, having MORDETH.BAT in your DOOM2 directory
	and all other files in the MORDETH directory (see above).
	You are then presented with the Mordeth FrontEnd, from which
	you can start the game. If starting Mordeth for the first time,
	the game must be installed first: see below. Installing and
	playing can also be done manually: also, see below.

	STARTING MORDETH FOR THE FIRST TIME

	The very first time you start Mordeth, you do not have the
	functional sprites & flats file and the alternate .exe - yet. 
	After checking if all the neccessary files are present at 
	their correct location (that is, everything in "C:\DOOM2\MORDETH"
	except for the file MORDETH.BAT) you will be asked if you want 
	to proceed with building the functional S&P file MORGRAPH.WAD 
	from its predecessor MORGRAP0.WAD. After your confirmation, NWT 
	will build the S&P file using the commercial DOOM2.WAD as its 
	resource. It takes a while, but it has to be done only once. 
	The reason for not including a functional S&P file in Mordeth
	is simple: it is illegal to distribute such a file. After 
	that, the file MORD.EXE is build from MORDETH.DEH and a copy
	of DOOM2.EXE.

	You now have the Mordeth files MORD.EXE and MORDETH.BAT in
	your DOOM2 directory. Leave them there, and leave the rest
	in the MORDETH directory.

	WARNING: NWT CANNOT use DOOM2 v1.7a ! Also, NWT might refuse
	to build the S&P file when you have a hacked version of the
	DOOM2.EXE.

	After building MORGRAPH.WAD and MORD.EXE, you are can access 
	the normal Mordeth FrontEnd, from which you can play Mordeth.

	THE MORDETH FRONTEND

	Every time you start Mordeth this frontend will appear, 
	prompting you to make a choice between the following options:

	1)      To run Mordeth, single-player game

		This option adds the files MORDETH.WAD and MORGRAPH.WAD
		to DOOM2, and uses the hacked MORD.EXE instead of the 
		normal DOOM2.EXE. Now you can play Mordeth. Note: you
		will see a message appear that your original game has
		been modified. This is not true: nothing Mordeth does
		EVER changes a single byte of your original DOOM2.

	2)      To add/create RSP files for use with single-player game

		Use this option if you want to pass extra parameters to
		Mordeth, such as "-warp 03 -skill 4" if you want to jump
		directly to level 3. This is done by creating response files 
		("RSP files"), which can be created from within the frontend. 
		This RSP file can then be added to the normal command string. 
		Included with the Mordeth files is a RSP file that loads 
		Mordeth on level 2, with skill 2 and fast & respawning 
		monsters. You can create a set of five different RSP files, 
		called MORDSP1.RSP to MORDSP5.RSP. For an overview of the
		different parameters, see the DOOM2 readme file. Note that
		some parameters can only be used in combinations, such as
		-nomonsters and -warp xx.

	3)      To start a multi-player session from within the frontend.

		First things first: all players need a copy of the
		same DOOM2 version. If not, your machines probably can't
		connect. The same for the pirated version of DOOM2 (date: 
		25/8/94). Get the REAL one! Also, all players need the 
		same Mordeth version. If you have both the same version, 
		read on.
		You can create up to three RSP files from within the
		frontend to pass the parameters needed to play a multi-
		player Mordeth session. You can choose (depending on your
		connection) between ipxsetup and sersetup, and this RSP
		file containing the parameters. The frontend replaces the
		normal DOOM2.EXE with MORD.EXE for you and adds the two
		Mordeth PWADS to your setup.
		As AN example of a IPX LAN multi-player setup, see the file
		MORMPI1.RSP, which looks like this: 

		  -deathmatch -altdeath -skill 3 -nomonsters -warp 01

		So, when choosing this RSP file, you start a Mordeth
		2-player (default) IPX deathmatch session with respawning 
		items, no monsters and starting at level 1 on skill 
		setting 3. Don't add "ipxsetup" and "-file mordeth\mordeth.wad 
		etc" to the RSP file: this will already be done by the 
		frontend! Only thing you have to do is pass your personal 
		connection settings. Modem owners have to use the 
		"sersetup option" instead of its ipx counterpart, and add
		things like com en irq settings (-com;-irq). For an 
		overview of all available parameters, see the manual of
		DOOM2 (readme.txt or readme.exe). Modem user, if you don't 
		know your settings, you can't play a multi-player session, 
		not with DOOM2 and not with Mordeth. 

		If you use the DOOM2 setup to start your normal session, then the only thing you have to do is look what you used to
		select: "modem" or "serial game" means sersetup, "network"
		means ipxsetup; if you use a modem, do you "dial <number>"
		or do you "answer" ("-dial <number>" and "-answer", rsp).
		Etc. It's all so very simple.

		A very good rule: make sure you can play deathmatch or coop
		with regular DOOM2 before trying it with Mordeth.
		
	4)      To access the DOOM2 setup

		To change your DOOM2 setup. DO NOT use it to run a 
		multi-player Mordeth session. Choose the multi-player 
		game menu if you want this.

	5)      To view the DOOM2 Manual (readme.exe or readme.txt)

	6)      To view the "story behind Mordeth".

		This is done by using PCXVIEW.EXE (see credits) and give
		PCX graphics. The story? Trapped in Hell, you want to get 
		out, etc.
		
	7)      To view UNINSTALL.TXT

		You hate Mordeth, or are you just a big sissy fed up with
		becoming a stain on the wall for the Xth time ? Then read
		this text to see how to remove every trace of Mordeth from
		your HD.

	8)      To return to DOS
	
	INSTALLLING AND LOADING MORDETH MANUALLY

	Of course, you can also load Mordeth manually. The FIRST        
	TIME you run Mordeth, you have to build the functional
	sprites & flats file first. Assuming you have already placed 
	all files into their correct directories (see above, every file
	in a subdir of your Doom2 dir called Mordeth).
	
	1)  Put NWT.EXE in your DOOM2 directory. Make sure you
	    have NOT DOOM2 v1.7a. (Does not work with NWT).
	2)  Put MORGRAP0.WAD in your DOOM2 directory. Make a backup
	    of it, which you store someplace else (just in case).
	3)  At the DOS DOOM2 prompt, give the following command:
		 nwt -af morgrap0.wad
	    This may take a while (1-2 min).
	    After completion, you will read "Done. <number> resources 
	    processed". If you see an error message, check that error 
	    and try again.
	4)  At the DOS DOOM2 prompt, give the following command:
		 nwt -as morgrap0.wad
	    This may take a while (1-2 min). 
	    After completion, you will read "Done. <number> resources 
	    processed". If you see an error message, check that error 
	    and try again.
	5)  Rename MORGRAP0.WAD into MORGRAPH.WAD and place it into
	    the Mordeth directory.
	6)  Put MORDETH.DEH and DEHACKED.EXE in the DOOM2 
	    directory. If exists, remove DOOMHACK.EXE from your
	    Doom2 dir.
	7)  At the DOS DOOM2 prompt, give the following command:
		dehacked -load mordeth.deh
	    First, DeHackEd wants to make a copy of your DOOM2.EXE,
	    called DOOMHACK.EXE. Confirm this ("Y"). Note that Dehacked
	    starts complaining that it cannot find dehacked.ini, doom.wad
	    and doom.exe. Ignore those messages. You know you have a 
	    good copy when you read "patch file mordeth.deh read". If not,
	    check the error and try again.
	8)  Rename DOOMHACK.EXE into MORD.EXE.
	   
	9)  Put MORD.EXE in your DOOM2 directory and MORDETH.WAD   
	    and MORGRAPH.WAD somewhere else (directory "XXX", preferably
	    called 'mordeth').

	10) To run a single-player Mordeth session, start the
	    game by typing at the DOS DOOM2 prompt: 
	    
	    "mord -file xxx\mordeth.wad xxx\morgraph.wad"

	    with "xxx" representing the path to these two PWADS, like
	    mord -file mordeth\mordeth.wad mordeth\morgraph.wad if you
	    have placed these files in a subdir of your doom2 dir called
	    'mordeth'.

	LOADING MORDETH MANUALLY, multi-player

	First, install Mordeth as descriped in "installing and loading"
	and make sure it runs correctly. All players must have the same 
	Mordeth version (this is the FEB'97 version). Don't even start
	when you cannot play a normal deathmatch. To play Mordeth with or
	against other players, one must always add the files MORDETH.WAD
	and MORGRAPH.WAD to the command line string you normally use to
	play multi-player sessions on your system, AND you have to use
	MORD.EXE instead of DOOM2.EXE. SO, DON'T USE the DOOM2 SETUP to
	setup your game, since you cannot use the alternate EXE nor load 
	the extra PWADS. Adding the pwads is done by adding 
	"-file xxx/mordeth.wad xxx/morgraph.wad" to your normal command
	line string, with "xxx", representing the path to these PWADS.
	So, if they are stored in the directory MORDETH within the DOOM2
	directory ("C:\DOOM2"), type: -file c:\doom2\mordeth\mordeth.wad
	etc, or -file mordeth\mordeth.wad etc. for short. BUT you must
	also use MORD.EXE instead of DOOM2.EXE. This is done by temporarily
	renaming DOOM2.EXE into (eg.) DOOM2ORG.EXE and MORD.EXE into 
	DOOM2.EXE.

	Example: for a 2-player deathmatch on an IPX network type the 
	following command string at the DOS DOOM2 prompt:

	1) "ren doom2.exe doom2org.exe", enter
	2) "ren mord.exe doom2.exe", enter
	3) "ipxsetup -deathmatch -com2 -8250 -irq3 -port 0x2F8 -file
	    xxx\mordeth.wad xxx\morgraph.wad",enter (FOR EXAMPLE)
	4) (after playing:) "ren doom2.exe mord.exe",enter and "ren 
	   doom2org.exe doom2.exe",enter.

	Please place your own values here if your settings are 
	different. ALWAYS rename MORD.EXE into DOOM2.EXE (after
	backing up your original DOOM2.EXE !!!), and ALWAYS add the
	line "-file xxx\mordeth.wad xxx\morgraph.wad" with "xxx"
	representing the path to these two files.

	In above example, the default settings of two players,
	skill 3 / warp 01 and no-respawning-items are used. Add the 
	appropriate commands to change this (-nodes <1-4>;
	-warp <01-32>; -skill <0-5>; -altdeath <for items>; -fast and/or 
	-respawn <for monsters>). If you have a FrontEnd that will allow 
	you to play multi-player games with a different .EXE and with
	the addition of two PWADS, you can forego the above and just 
	load the three files needed. In you can load two PWADS but cannot
	use an alternate EXE, rename the EXE's before using that
	frontend. Don't forget to rename them after your session's over!

			   
	HANDLING OF DSG FILES

	Savegames are stored in a file DOOMSAV<0-5>.DSG. In order to prevent
	you from saving a Mordeth game over a regular game (thus losing
	this regular game), or from loading a regular game into Mordeth
	("different game version" crash), the following extra is added to
	the Mordeth FrontEnd:
	The regular *.DSG files are temporarily renamed *.XXX file and
	stored into your DOOM2 directory. Mordeth DSG files, which are
	always stored into the Mordeth directory while not playing Mordeth,
	are moved to the DOOM2 directory when entering the Mordeth FrontEnd.
	Thus, only Mordeth DSG files are available when playing Mordeth, and
	you cannot overwrite the regular savegames. When you quit the 
	FrontEnd, all (Mordeth) DSG files are moved to the Mordeth 
	directory and the extensions of the regular DSG files are restored.

	AFTER A CRASH...

	When you have a really bad day and the doom-engine bombs back to DOS,
	there is a thing or two you have to check. As said, the FrontEnd
	makes a difference between normal DSG files and DSG files created
	during a Mordeth session. After an "unnatural exit" from the FrontEnd,
	the normal (DOOM2) DSG files have the extension XXX, and the Mordeth
	DSG files the extension DSG. So, DON'T DELETE THOSE "XXX" FILES, or
	you'll lose your savegames. Before starting a new Mordeth session, do
	the following things:
	
	1. Put Mordeth DSG files from the DOOM2 into the Mordeth directory;
	2. Rename the extensions of your regular DSG files, located in your 
	   DOOM2 directory, from "XXX" into the normal "DSG".
	3. Remove the file CNFRM.BAT from your DOOM2 directory.

	After doing this, you're back in business. Don't worry, you
	won't forget this: The FrontEnd refuses to load Mordeth when it
	detects the Mordeth file CNFRM.BAT in your DOOM2 directory, 
	gives a warning message and exits to DOS.

	If you crash during a multi-player session or during its setup,
	you have to rename "DOOM2.EXE" (which is now not the original exe,
	but the renamed hacked MORD.EXE) back into MORD.EXE, and the
	backup of your original DOOM2.EXE, called DOOM2ORG.EXE, back into
	DOOM2.EXE. Plus you have to remove CNFRM.BAT from your DOOM2
	directory and restore your savegames are described above.

	I wanted players to do that themselves, instead of leaving it to
	the frontend, because of a potential risk of overwriting/losing 
	original files.

	CHEAT CODES

	All cheat codes have been disabled, except for the IDBEHOLD menu        
	(for those nasty moments you need some help, after *saving* your
	game instead of *loading* <g>) If you cannot handle the monsters,
	the choose a lower skill setting. Skill setting 1 is so very easy,
	you will probably fall asleep playing it. Don't be lame, just
	play! :)

	PROBLEMS WHILE RUNNING MORDETH
	
	Important
	---------
	It is IMPERATIVE that you use a build S&P file (=MORGRAPH.WAD)
	and a hacked version of DOOM2.EXE (=MORD.EXE). You won't last
	long otherwise, and the game WILL crash back to DOS. Don't come
	crying to me if you do.
	
	Speed, memory
	-------------
	If you already experience slow downs while playing DOOM2, you
	better expect them to occur with this baby! Yes, all levels
	are RMB optimized at default settings (so just "rmb <in> <out>")
	but they remain huge. You may experience with more strict RMB
	or REJECT settings, but I don't guarantee that the PWAD will
	function correctly after such a modification. DON'T YOU EVER
	distribute altered files!!! Only the original one, please.
	If you haven't already done so, you could free some memory 
	by unloading some TSR programs, like the pop-up screen for your
	DOS printer or a resident virus scanner. You could also take a
	look at your memory: is it configured (conv. mem. at least
	580-600 K)? To see how much conventional memory you have left,
	just type "mem" (latest DOS versions only). If that value is
	beneath 580 K, please run "memmaker" to optimize your computer's
	performance. You won't regret it. Just follow the guidelines
	MEMMAKER will give you.
	Disabling memory managers like EMM386 or QEMM, or disk caching 
	utillities like SMARTDRIVE is also a very good option. You can also 
	run Mordeth using only your keyboard, or with an disabled music 
	option. If nothing else works, you can also start from a bare boot 
	diskette. For more information, read that README file of DOOM2! 
	
	DOOM2 v1.7a
	-----------
	It is said before that Mordeth needs the original commercial 
	version of DOOM2. NWT, the tool that makes it possible to
	insert new sprites and flats into a DOOM2 game, DOES NOT
	work with DOOM2 v1.7a. You can get a free patch to upgrade 
	your version at ftp.cdrom.com/pub/doom2 or one of its mirrors, 
	under "idstuff" or "patches". Or on one of them commercial
	CD-ROMS, crammed with all those other PWADS. 
	You can see what version you have by looking at the top of your 
	screen while loading DOOM2.
	To my knowledge, other versions of DOOM2 work just fine with
	Mordeth. Played succesfully with v1.666 and v1.9.

	Demo's
	------
	If your game bombs back to DOS when DOOM2 tries to load a demo,
	it's probably a compatability problem ("demo is from a different
	game version"). Just start a game before the demo loads.
	The Mordeth demos are made with version 1.9, but there shouldn't
	be a problem when you have a different version, since you'll 
	use MORD.EXE to play the demos (and that patch is version 1.9).
	I said 'should not'. If you see the player act funny during the
	demo, like bumping into walls and shooting in wrong directions
	and the like, then this is also a compatability problem. This
	can be caused by applying RMB or REJECT after making the demo.

	PWAD loading
	------------
	The Mordeth FrontEnd checks for the presence of needed files at
	their correct locations, and warns you if this is not the case.
	But if you load Mordeth manually, and you encounter a message
	saying "COULDN'T ADD <xxx>.WAD", you haven't given the proper path
	to that WAD at the DOS prompt. Check where those files are, and
	enter the path correctly. If you load the game manually and you
	see the same level 1 of DOOM2, or the original sprites, you probably 
	haven't seen the above message, OR you have tried to load another,
	non-mordeth PWAD together with a Mordeth PWAD (common mistake is
	to load two S&P files together - you can't!). Don't load unbuild
	S&P files into DOOM2, ever.

	CNFRM.BAT
	---------
	When the FrontEnd gives the message that it thinks you have
	experienced a crash during the previous session, and when this
	is certainly not the case, you probably have a file named CNFRM.BAT
	in your DOOM2 directory. If you already had a file with that name
	in your DOOM2 directory before installing Mordeth, just delete, 
	rename or replace the offending file, and the FrontEnd will go into 
	menu mode.

	LAST BUT NOT LEAST

	Have you read section (2), "Credits & Terms of Agreement" ?
	If you have, you know that you're allowed and encouraged to
	give Mordeth to anyone you can think of, as long as all 
	original files are included. You are NOT allowed to modify
	any levels, or to use them as a base for your 'own' creations.

	=========================================================
	(4) ABOUT THE AUTHOR
	=========================================================

	The author of Mordeth is:

	Gaston Lahaut

	E-MAIL: g.lahaut@stud.warande.ruu.nl
	Snail mail: Warande 190, 3705 ZP Zeist, The Netherlands, Europe
	The Mordeth Home Page, containing info and the lastest goodies and
	versions of Mordeth, can be found at: 
	http://www.warande.ruu.nl/~glahaut/mordeth.htm

	If you have any questions regarding Mordeth please send me a
	a message and I'll see what I can do. If you like it, love it, 
	or, err.. hate it, write me too !  ALL REPORTS (praise, bugs, etc)
	ARE HIGHTLY APPRECIATED ! YOUR COMMENTS MAY RESULT IN AN IMPROVED
	AND UPDATED VERSION !
	Please ask questions regarding the editors or the original game
	to their respective creators.

	Happy fragging!
	Gaston Lahaut
