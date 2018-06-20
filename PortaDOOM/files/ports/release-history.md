GZDoom 3.4.0
--------------------------------------------------------------------------------
*Wed Jun 06, 2018 5:24 pm*

Highlights

* enable `#include` support in "modeldef" files
* removed DirectDraw and Direct3D backends, removed un-accelerated SDL framebuffer backend
* reorganization of 2D and 3D rendering code in preparation for Vulkan in the future, performance improvements on newer hardware
* CVAR that handles it is now `vid_rendermode` - `vid_renderer`, `swtruecolor`, and `r_polyrender` have been removed and combined into new CVAR
* added a `lightsizefactor` command to gldefs.
* allow animated title pics
* Add support for Unreal Engine 1 vertex mesh format
* added LevelLocals vec2/3Offset(Z) functions for portal-aware offsetting without needing actors
* Add `OnGiveSecret` virtual function on `Actor` for customizing behavior of secret finding
* `BLOCKASPLAYER` flag: treat non-player actors as blockable by "block players" lines
* added 'revealed on automap' linedef flag, UDMF only
* added forced automap style to linedef, UDMF only
* Added startup song definition for custom IWADs
* This release contains a major render optimization for highly detailed maps that may give a +20% performance improvement on Intel and AMD hardware (less on NVidia because the driver has far less overhead that could be optimized away)

Notes

* removed DirectDraw and Direct3D backends, removed unaccerated SDL framebuffer backend
* reorganization of 2D and 3D rendering code in preparation for Vulkan in the future
* renderer can now be "live switched" between the Software renderer and Hardware-accelerated OpenGL modes - like old GZDoom
* CVAR that handles it is now 'vid_rendermode' - vid_renderer, swtruecolor, and r_polyrender have been removed and combined into new CVAR
* include and forward declaration cleanup: lots of unused stuff removed
* rendering settings removed from launch popup: they can now be changed dynamically in-game
* internal level compatibility definitions are now carried out by ZScript, more level compatibility settings * have been added
* Thread-Local Storage is now required on all compiler systems in order to use GZDoom. This means you cannot * use OpenBSD versions earlier than 6.3, and GCC is still unavailable for that platform.
* improvements to models in Software Renderer (still in beta state, but available for experimentation, use * 'r_models')
* Added activation type to WorldLine(Pre)Activated events
* Added names for arguments in DStaticEventHandler class definition
* protected critical portal data from getting written to by user code. This data is game critical and may only * be altered by code that knows what is allowed and what not.
* added a compatibility handler for Kama Sutra MAP01's ending area.
* fix softpoly portal crash
* Fixed missing textures on Valhalla with hardware renderer
* more rendering fixes for Softpoly and Hardware-OpenGL
* fix missing fuzz initialization in softpoly
* Removed gl_lights_checkside
* Made 100% kills possible and unstuck imp on Valhalla map
* added a 'lightsizefactor' command to gldefs.
* Actor's Activation property is now stored in saved game
* fix softpoly mirrors
* Made 100% kills possible on Altar of Evil, easy skill
* (internal ZScript) Add info about UseSpecial flag feature conflict above Actor.Used
* Fixed initialization issues with dynamic lights.
* Implemented workaround for ZScript LineTrace with 3D floors
* Added missing commented enum entry for ETraceFlags on ZScript side
* Only call additional LineCheck if there are 3D floors
* Enabled playing of *gasp sound by default
* Added startup song definition for custom IWADs
* Fixed walkthrough blocker in Sin City 2 via compatibility entry
* allow animated title pics.
* don't force the renderer to remain active in windowed mode when in the background.
* OPL Synth fix: Double-voice instruments randomly don't play second voice
* updated LZMA library to version 18.05
* serialize 'spawned' object flag, WorldThingDestroyed event relies on it
* added compatibility fix for bad sector reference in Plutonia MAP11.
* use libc++ for all targets on macOS
* SDL: clear button state when switching from/to GUI input
* added r_debug_draw that shows how the software renderer composes its scene (remember that Youtube video * Edward850 made?)
* added end line to recursive sound warning
* reduce the number of direct OpenGL calls done by the post processing steps
* fixed calculation of glow color
* fixed crash during autoloading of material textures
* fixed sloped drawer crash
* added end line to various messages so they don't screw up further output anymore
* fixed alpha of weapon sprite.
* added 'vid_scaletowidth' and 'vid_scaletoheight' to calculate 'vid_scalefactor' to reach a certain value on * screen dynamics (i.e. if you want 320 pixels wide, use vid_scaletowidth 320)
* Add support for Unreal Engine 1 vertex mesh format.
* added LevelLocals vec2/3Offset(Z) functions for portal-aware offsetting without needing actors
* trigger WorldThingDamaged event before WorldThingDied
* set a sane lower limit for vid_scalefactor, removed some code redundancy
* define zdoom.rc as a proper Windows text file, stop Git from mismanaging it
* add 'vid_showcurrentscaling' ccmd - shows both virtual and real screen resolution for the current render
* made vr_enable_quadbuffered windows-only, some fixes to it
* use an indexed vertex buffer to render flats
* use triangles instead of triangle fans to render flats.
* render sector planes in one draw call.
* added 'revealed on automap' linedef flag, UDMF only
* added forced automap style to linedef, UDMF only
* added CVAR to disable WGL_EXT_swap_control_tear. ('gl_control_tear') - see commit 'cc65490' for more info
* added a CVAR to disable per-plane rendering.
* replaced tabs with spaces in UDMF spec
* added new linedef properties to UDMF spec
* fix model interpolation bug
* fixed applying of alpha to weapon sprites
* enable #include support in modeldef files
* Add Line Specials Line_SetAutomapFlags, Line_SetAutomapStyle
* force model light to be attenuated
* restore startup game state on restart
* fixed blinking frame after saving a game
* when restoring a savegame with errors, show the console instead of a 'very fatal error' crash (commit * message: fixed: When deserializing the object list, the array must be nulled before using it so that a * premature abort does not end up working on random data.)
* replace softpoly block drawers with span drawers and make them use blending rules directly from render styles
* add dynlights to softpoly pal mode
* fixed rendering of environment map on mirrors
* fixed Windows XP compatibility for MSVC 2017 targets
* limited length of server CVAR name to 63 characters
* fixed: +DONTSPLASH disabled all terrain effects, not just the splash.
* use a linear light ramp on the textured automap for light modes 0 and 1.
* fix savepic render buffer issues
* Swap front face culling for GL model drawer (CCW should be the default).
* Added mirroring handling to software models.
* use affine dynlights in softpoly
* fix memory arena allocation alignment for 32 bit systems.
* fixed: For melee attacks with a short attack range P_AimLineAttack must check for hits from above and below.
* fixed mouse cursor positioning in menu for Cocoa backend
* fixed linking with sanitizer(s) enabled
* Fixed: Dehacked must not validate parameters for MBF special functions.
* fixed - sector sounds were not translated through static portals properly
* BLOCKASPLAYER flag: treat non-player actors as blockable by "block players" lines
* fix crash on dying when player class has no death states
* fix softpoly colored fog bug in the new drawers
* fix dynlight color not being applied on sprites
* Adds "OnGiveSecret" virtual function on Actor for customizing behavior of secret finding.
* fix software renderer dynamic lights not working properly in mirrors
* fixed autoaiming for unranged attacks.
* fix null pointer crash in softpoly
* add dynamic lights to softpoly and software renderer models

GZDoom 3.4.1 Released
--------------------------------------------------------------------------------
*Graf Zahl » Wed Jun 13, 2018 7:05 pm*

Release Notes

* fixed: redirect script access to the compatflags CVARs to their internal shadow variables. This is needed so that MAPINFO settings for these flags don't get ignored.
* fixed: flag CVars in ZScript referenced wrong addresses
* fixed: ZScript used the wrong variable for compatflags2.
* fixed: remove ARM specific gl_es definition since it's not even really much different from the main line definition, anyhow
* fixed generation of brightmaps for sprites. This forgot to take the added empty border for filtering improvement into account.
* fixed ADynamicLight's shadowmap index must be reset when loading a savegame.
* fixed portal restoration on revisiting level in hub. - Added function to FLevelLocals to test if map is being re-entered
* fixed crash with GL 3.x and fixed colormap active.

GZDoom 3.3.2 released
--------------------------------------------------------------------------------
*Thu Apr 12, 2018 4:49 pm*

Major Highlights

* Fixed detection of .ipk7 custom IWADs
* Restored vanilla behavior of lightning for original Hexen
* Added loading of ZSDF lumps by full paths
* disabled the survey code.
* Exports `P_ActivateLine` to ZScript (along with constants for activation type)
* Increased size of the savegame comment area.

Full List

* Forbade dynamic array as the return type of a function
* Fixed detection of .ipk7 custom IWADs
* Reintroduced discarding of custom IWAD duplicates
* Updated zlib to 1.2.11
* Fixed potential crash on usage of Mystic Ambit Incant
* Fixed crash when `vid_setmode` CCMD is used from command line
* Restored vanilla behavior of lightning for original Hexen
* Fix mid texture rendering for self-referencing sector lines
* Added zero initialization of implicit dynamic array items
* Added loading of ZSDF lumps by full paths
* Added message for absent explicitly referenced dialog file
* disabled the survey code.
* Exports `P_ActivateLine` to ZScript (along with constants for activation type)
* Separated `P_ActivateLine` ZScript export into two functions, one with and one without a vector parameter.
* Increased size of the savegame comment area.

GZDoom 3.3.1 Released
--------------------------------------------------------------------------------
*Sun Apr 01, 2018 3:50 pm*

Major Highlights

* Better handling of defaults with some ZScript/DECORATE functions
* Many bug fixes since 3.3.0

Full List

* Fixed typo in libOPN error messages
* ADL&OPN: More setup: Chips count and Volume model!
* Fixed applying of unsafe context in waiting command
* fixed: A sprite having a picnum was not animating its image in the hardware renderer.
* fixed: A sidedef's sector and linedef references were writable.
* Fix black pixels when subtractive lights are in range for PBR materials
* fixed: FBuildTexture::CopyTrueColorPixels returned incorrect transparency information
* Revert "- fixed: 3D floor that extend into the real sector's floor were not clipped properly."
* changed the default settings for fluid_patchset, timidity_config and midi_config to point to the default sound font
* Typo fix in linetrace flags checking.
* ADL&OPL: Added a fallback for a blank instruments in GS/XG banks
* Merged list of video modes for Cocoa and SDL backends
* ADLMIDI: Update latest update of DMXOPL3 bank
* Fixed crash when event handler class isn't derived from StaticEventHandler
* Set more suitable limit for sound velocity validation
* Fix the blank banks list of ADLMIDI
* Fixed infinite loop with None class in random spawner
* Fixed infinite loop with zero height fast projectile
* Fixed uninitialized members in DPSprite class
* Fixed crash on accessing player sprite's state in software renderer
* Default newradius in A_SetSize
* Fixed handling of default value in Actor.Vec3Angle()
* Added ability to load any IWAD without extension
* Removed check for duplicate IWADs
* Localize the word “for” in Strife’s trading dialogs
* Fixed handling of default values in String.Mid()
* made all elements of DehInfo and State read-only.
* Fixed excessive growth of ACS string pool

GZDoom 3.3.0
--------------------------------------------------------------------------------
*Sun Mar 25, 2018 12:30 pm*

ZScript & Mapping Highlights

* Added dynamic spot lights, configurable in the UDMF map format
* export 'GetChecksum' as part of FLevelLocals in ZScript
* Mod-defined aliases no longer permanently change CVARs
* add 'FriendlySeeBlocks' actor property that allows a modder to expand the maximum radius that a friendly monster can see enemies. - accessible from both ZScript/DECORATE and UDMF
* Custom submenus are no longer removed from altered protected menu
* Exported S_GetMSLength to ZScript.
* Added GetRadiusDamage. Returns the raw calculated explosion damage falloff by distance only.
* added Screen.getViewWindow function
* Exported Trace() interface to ZScript
* Added 'TeleportSpecial' as an alias for 'Teleport' in ZScript to deconflict from the Actor.Teleport function.
* Added Distance(2/3)DSquared functions.
* fixed skip_super application for ZScript.
* split off the interface part of DHUDMessage
* Export sector effect pointers, fix missing pointer assignment on Lighting effect creation.
* Made left button down event available to UI event handler
* Exported Inventory.AltHUDIcon field to ZScript
* Add WorldLinePreActivated to override line activation
* Adds "DI_MIRROR" flag to statusbar image drawing, useful for rearview mirrors
* Enable string & float user_ properties in UDMF things

Other Highlights

* Added in-game reverb editor using the menu system
* Improved French translations
* fixed 'precise' rendering in OpenGL
* New Materials Shader system to allow textures to show new properties such as glossiness and specularity, affected by dynamic lights, or with PBR, reflecting their direct surroundings
* new rocket smoke sprites by Talon1024.
* Import Timidity++ into GZDoom directly
* added light definition for megasphere.
* fixed midtex nowrap clipping bug when 3d floors are in view (Software Renderer)
* Improved profilethinkers in various ways
* add variables 'am_unexploredsecretcolor' and 'am_ovunexploredsecretcolor' to mark undiscovered secrets differently in the automap
* Added support for ADLMIDI and OPNMIDI libraries

Full List

* Added in-game reverb editor using the menu system
* Added dynamic spot lights, configurable in the UDMF map format
* Fixed: Do not output empty conversation replies to the console
* Fixed: Added bounds check for local variables in ACS VM
* Fixed transfer of count secret flag from random spawner
* export 'GetChecksum' as part of FLevelLocals in ZScript
* Add "fuzz software" to GL that renders fuzz like the scaled fuzz mode in the software renderer
* Added unsafe execution context for console commands
* "Unsafe" aliases no longer permanently change CVARs
* Fixed crash on finishgame CCMD before starting new game
* Fixed a case of infinite loop in A_BrainDie
* add 'FriendlySeeBlocks' actor property that allows a modder to expand the maximum radius that a friendly monster can see enemies. - accessible from both ZScript/DECORATE and UDMF
* Improved French translation using Tapwave's submissions, also covers previously missing strings.
* Add option to enable or disable borderless windowed for Windows only.
* Custom submenus are no longer removed from altered protected menu
* fixed: Disabled interpolation point "thinking"
* Fixed crash when resolving multipatches with missing textures
* Added missing fields to StrifeDialogueNode ZScript definition
* Fixed rare crash when menu is closed from Ticker() function
* fixed: Dynamic arrays for object pointers need different treatment than arrays for regular pointers, because they require GC::WriteBarrier to be called.
* Exported S_GetMSLength to ZScript.
* Added GetRadiusDamage. Returns the raw calculated explosion damage falloff by distance only.
* added Screen.getViewWindow function
* Exported Trace() interface to ZScript
* fixed: precise rendering did not work anymore due to a missing reference operator in the setup function for the needed data.
* fixed: The culling mode for translucent models must be inverted when rendering a mirror.
* fixed: Changed quad stereo mode restart notification
* Fixed Sector.SetYScale() function in ZScript
* new rocket smoke sprites by Talon1024.
* compatibility node rebuild for Doom2's MAP25
* fixed: iterating through portal groups must check for situations where badly constructed maps let items end up in another portal group.
* fixed: Upon resurrection, a monster must check if the current setting of the link flags (NOBLOCKMAP and NOSECTOR) match the defaults.
* let fluid_reverb and fluid_chorus default to 'off'.
* Fix typo that made DepleteAmmo always use Secondary Ammo
* Fixed crash on exit caused by undefined class
* Added compatibility entry for Ultimate Simplicity MAP11 - This eliminates potential blocker in level progression
* Fixed crash in stereoscopic modes caused by camera without player
* Now compiles on FreeBSD
* Removed last remnants of PowerPC Mac support
* fixed: Properly parse FLAC and Ogg Vorbis files for their comments
* let the texture manager handle the special OpenGL textures so that they get deleted and recreated when needed. (fixes mirrors and particles looking crazy after 'restart' ccmd)
* Import Timidity++ into GZDoom directly
* fixed: check for deathmatch starts before forcing an unfriendly player to use them.
* use submenus for soundfont selection both for better overview and avoiding a music restart for each selection change.
* added a compatibility setting for Perdition's Gate MAP31 which was having render issues with an unsupported vanilla effect.
* Added 'TeleportSpecial' as an alias for 'Teleport' in ZScript to deconflict from the Actor.Teleport function.
* added light definition for megasphere.
* silence all error messages in the state map parser for DEHSUPP when re-reading the data.
* Added Distance(2/3)DSquared functions.
* fixed: Send a GM reset SYSEX event when music playback is started.
* fixed some problems with the stepping up through a portal logic
* fixed: For two-sided midtextures the light lists were always taken from the sector referenced by the rendered sidedef, not the sector in which the line gets renderered.
* fixed skip_super application for ZScript.
* fixed: PowerMorph.EndEffect should not tinker around with morph duration.
* fixed: perform the stepping adjustment for FastProjectiles in 3D.
* fixed translucent sorting for particles.
* split off the interface part of DHUDMessage
* Fixed potential crash during state validation
* fixed: Camera textures must always be drawn with texture mode opaque, because the contents of their alpha channels are undefined.
* fixed: A preincrement of a local variable generated wrong code if passed as a function parameter
* print an error message if the requested MIDI device cannot be started.
* removed an unchecked fixed size buffer in the KEYCONF parser.
* Export sector effect pointers, fix missing pointer assignment on Lighting effect creation.
* Fixed freeze after saving game when cl_waitforsave CVAR set to false
* Fixed initialization of search paths on macOS
* Made left button down event available to UI event handler
* get rid of FAKE3D_REFRESHCLIP and fix holes in 3d floors with wrapped midtextures
* Disabled GCC loop vectorization for R_LoadKVX() function
* fixed midtex nowrap clipping bug when 3d floors are in view (software)
* Extended profilethinkers CVAR with sorting ability
* Improved profilethinkers in various ways
* add variables 'am_unexploredsecretcolor' and 'am_ovunexploredsecretcolor' to mark undiscovered secrets differently in the automap
* put unexplored secret color picker in the menu
* fixed empty dynamic arrays in savegames
* implemented anonymous stats collector (info here: viewtopic.php?f=49&p=1044005#p1044005)
* fixed some crashes related to music playback with tags
* fixed some issues related to BUILD resources
* Added target and last enemy to linetarget CCMD output
* Exported Inventory.AltHUDIcon field to ZScript
* fixed crash when reloading a map in softpoly
* fixed status bar chain wiggling when paused
* Added support for ADLMIDI and OPNMIDI libraries
* Added warnings when using original OpenAL (and not OpenAL-Soft as recommended)
* Add WorldLinePreActivated to override line activation
* Fix 3D floors clipping into floor
* Fix issues with RenderStyle "Shaded" and alpha textures
* Adds "DI_MIRROR" flag to statusbar image drawing, useful for rearview mirrors
* Enable string & float user_ properties in UDMF things
* Fixes for DDS texture loader
* disable XP toolset warning for 64 bit builds.

Important note:

This version of GZDoom is running a survey to let us developers know a little bit about the hardware that GZDoom is being run on. It is completely anonymous and will only send 3 points of data:

* operating system
* number of CPU cores
* renderer being used, including the generation of graphics hardware

All 3 points do not contain anything explicit, but only some rough categorization of the information. (e.g. we cannot see what graphics card you own or what specific CPU you have.)

We would like to ask as many users as possible to allow sending this data. The more users participate, the better we can decide where to put our focus in future development.
More detailed information can be found here.

GZDoom 3.2.5
--------------------------------------------------------------------------------
*Thu Jan 04, 2018 3:38 pm*

This is yet another point release for GZDoom, which addresses a serious flaw that has appeared since its ACS implementation. Everyone is urged to upgrade ASAP, and no support will be provided for any version prior to this once the binaries for all platforms are available.

Notable features since 3.2.4:

* externalise `DCanvas::DrawLine` to ZScript
* implemented `i_soundinbackground` to continue playing sounds and music while in background
* OpenGL rendering now continues even when losing focus if not running fullscreen
* added `playerrespawn` skill flag to allow gameplay mods to retroactively enable player respawns in single player on all maps
* improved Advanced Sound Options menu - added option for FluidSynth chorus, removed fractional part from FluidSynth voices option
* fixed applying of Doom 64 lighting to horizon portals
* particles are now interpolated

More-complete changelog since 3.2.4:

* externalise `DCanvas::DrawLine` to ZScript
* fixed inconsistent colour remapping via translation ranges
* added bounds checks for colour translation indices
* fixed VM abort when drawing from ZScript happens during 0 game tic
* whitelist `reset2saved`, `undocolorpic`, `openmenu` in menudef
* fixed potential crash calling undefined function in zscript
* fixed crash after restart CCMD
* added compatibility settings for Hanging Gardens, compatibility settings can now be applied for all map types (including UDMF)
* fixed take ammo cheat
* implemented `i_soundinbackground` to continue playing sounds and music while in background
* OpenGL rendering now continues even when losing focus if not running fullscreen
* prevent level from exiting if no deathmatch starts are available in multiplayer
* fixed tics to seconds conversion, now in ZScript - stat screens now display correct values
* disabled modifier keys processing in UI by Cocoa backend - modifier keys no longer trigger bound actions in menu/console/chat
* added `GetPixelStretch` to `LocalLevels` struct
* fix: bind default framebuffer before testing whether hardware stereo 3D is supported. This allows NVidia 3D vision glasses to function correctly when `gl_light_shadowmap` is on.
* Add "requires restart" to "enable quad stereo" option menu label, to help folks set up 3D.
* Added ability to perform reverse fades with `A_SetBlend`
* added `playerrespawn` skill flag to allow gameplay mods to retroactively enable player respawns in single player on all maps
* improved Advanced Sound Options menu - added option for FluidSynth chorus, removed fractional part from FluidSynth voices option
* fixed applying of Doom 64 lighting to horizon portals
* particles are now interpolated
* fix culling bug in SoftPoly
* applied texture offsets and scales on animated doors
* fix rendering of wrapped midtex with sky ceiling
* The player set up menu 'Press Space' message can now be localized
* better angle selection for rotated automap sprites
* added optional angles to player's coordinates display
* fixed boss special commands in UMAPINFO
* fixed ammo limit for give cheat
* applied vertical offset to transferred sky in OpenGL renderer
* fixed initialization of `BlockThingsIterator` objects
* added `CheckMove()` function to ZScript `Actor` class
* Added vector diff functions to ZScript `LevelLocals` class
* add font characters for French and Portugese languages
* add `gl_riskymodernpath` for computers that worked before the GL>=3.3 modern path enforcement
* fixed ACS stack checking

GZDoom 3.2.4
--------------------------------------------------------------------------------
*Sun Dec 17, 2017 2:16 am*

This is yet another point release for GZDoom, which addresses a serious flaw that has appeared since version 3.0.0. Everyone is urged to upgrade ASAP, and no support will be provided for any version prior to this once the binaries for all platforms are available.

Notable features since 3.2.3:

* Added `DMG_NO_PAIN` for `DamageMobj`
* Fixed bright sprites in sectors with Doom 64 lighting
* Added free space margin aka safe frame for automap
* Rotating Sky & Model smoothness fixes
* implemented `win_borderless` for fake fullscreen in Windows

More-complete changelog since 3.2.3:

* Unified implementation of 'directory as resource file' for POSIX targets
* Fixed: Sky scrolling is now stored in a higher precision data structure; is now smoother than in 3.2.3.
* Fixed: Model rotating is now calculated in a higher precision data structure; is now smoother than in 3.2.3.
* Fixed directory creation for POSIX targets
* fix backslashes in MD3 skin names.
* Fixed overbright screenshots with hardware gamma off
* changed `ttl` in `particle_t` from `short` to `int32_t` for longer lifespan.
* fixed: `screen->FrameTime` should use an adjusted frame start time
* implemented `win_borderless` for fake fullscreen in Windows
* Fixed loading of external DeHackEd patches
* Fixed inconsistent angle of spawned leaves
* Fixed English localization issues
* Added free space margin aka safe frame for automap - limit for automap empty space margin set to 90%
* repaired the video scaling code in OpenGL for `vid_scalemode 0` and `vid_scalefactor` != 1.0
* Fixed crash when loading saved game with missing ACS module
* Added null check for probe in `SectorAction.OnDestroy()`
* Fixed error check when saving GL nodes
* fixed: `AActor::UnlinkFromWorld` must also destroy all portal link nodes for the calling actor.
* do not allow outside access to the variable storing the CCMD for `OptionMenuItemCommand`.
* use a whitelist for `DoCommand` zscript command
* Stop demo recording after ending game with `menu_endgame` CCMD
* Fixed bright sprites in sectors with Doom 64 lighting
* Added `DMG_NO_PAIN` for `DamageMobj`

GZDoom 3.2.3 Released
--------------------------------------------------------------------------------
*Sun Dec 03, 2017 11:14 am*

This is an additional point release to address some issues with the 3.2.2 point release and add even more features. Due to the way this release was handled, the change log will include 3.2.2's changes as well.

Notable features since 3.2.1:

* new timer code, GZDoom now appears a lot smoother in interpolated frames
* more bugfixes, including some for non-Windows platforms
* improve speed for ARMv7 processors by setting tuning options to the Cortex-a7 CPU (for Raspberry Pi 2)
* Several ZScript extensions and fixes
* Improved OpenGL profile selection on Linux
* Rather than giving version info, GZDoom now displays the name of the game you are currently playing in the window title. This can be disabled via `i_friendlywindowtitle`
* Implemented unicode handling in some functions
* improved handling of temporary files on timidity++
* added latch keyword to CVARINFO
* new grenade and ice shard sprites, removed non-GPL copyrighted assets

More-complete changelog since 3.2.1:

* let the 3 relevant text functions handle UTF-8 strings

  These functions are: `DCanvas::DrawTextCommon`, `V_BreakLines` and `FFont::StringWidth`.

  This will allow strings from UTF-8 encoded assets to display properly, but also handle the OpenAL device name on international systems, as this will be returned as an UTF-8 string.

  Due to backwards compatibility needs the decoding function is rather lax to allow both UTF-8 and ISO 8859-1 to pass through correctly - and this also implies that it will allow mixed encodings which may happen if strings from different sources get concatenated.

* sanitization of temporary file stuff for Timidity++.
  * do not use the global temp directory. Instead create one in the AppData folder.
  * removed lots of unneeded code from tmpfileplus.
  * use C++ strings in there.
* fixed potential memory leak in `M_VerifyPNG`.
* Fixed incomplete ACS string pool state after loading of saved game
* Added `static` to `CreateCeiling` (base.txt)
* Fix 'Requested invalid render buffer sizes' when executing the reverbedit command from fullscreen
* fixed upscaled fuzz drawing in swrenderer
* UMAPINFO parser, including some convenience additions to `FScanner`.
* fix shader targets being case sensitive
* `i_friendlywindowtitle` cvar: Show name of the game instead of GZDoom's version/last commit data
* Fixed applying of brightmaps to overridden textures
* Fixed detection of the first entry from internal IWADINFO
* fixed: high uptime was causing overloads in `uint32_t` and float structures (float losing loss of precision) - this caused any computer online for more than a few days to experience jankiness with internal animations such as rotations and shader timers. Unfortunately, this sounds the death knell for 32-bit platforms, since `uint64_t` is now required in time-critical structures, which will hurt performance tremendeously, but 64-bit systems will be unaffected.
* exported `P_Thing_Warp` to ZScript.
* Inside the renderer, use only the time value being passed to `RenderView`.
* get the timer used for animation only once at the very beginning of the frame and pass it on to the renderer to avoid any dependencies on the timer's implementation.
* Exposed `String.Remove()` function to ZScript
* Upgrade timer code to use nanosecond accuracy internally
* Fixed return state of player entered event
* Switch to C++11 steady clock, and Remove the platform specific timer implementations
* add doom e1m6 to `rebuildnodes` list.
* Fix freeze interpolation bug
* added latching CVARs to CVARINFO
* fixed: put limits on `A_SoundVolume`
* Improved OpenGL profile selection in SDL backend
* Extended `LineAttack()` with offsets and new flags
* Place the HUD model correctly in the world so that shader light calculations work
* Removed unused parameter from several functions in `FStateDefinitions` class
* Fix wrong math for model/light distance check
* Added runtime check for negative array indices in VM
* Added implicit scope for `if`/`else`, `while` and `do`/`while` statements in ZScript.
* Scope is added only for variable or constant definition so it will no longer leak to outer scope
* Added string representation of 'static const' token - No more 'Unknown(-141)' in 'Expecting ...' error message
* Extended `String.LastIndexOf()` with `endIndex` parameter
* de-init `DoomStartupInfo` on 'restart' ccmd so that the window title always contains the correct game information.
* Added workaround for MSVC 2017 internal compiler error
* Added `Wads.CheckNumForFullName()` to ZScript
* Added `Wads.ReadLump()` to ZScript
* Added `Wads.FindLump()` to ZScript
* Exposed string split functionality to ZScript
* Added ability to split `FString` on tokens
* Fixed potential crash in resolving of multiple assignment
* Fixed wrong owner for "*evillaugh" sound
* improve speed for ARMv7 processors by specifying hardware float calculations, and tuning it specifically for the Cortex-a7 CPU (for Raspberry Pi 2).
* Made dynamic array's `Find()` and `Max()` functions contant
* Added ZScript functions `GetBool()` and `SetBool()` to CVar class
* Fixed non-portable usage of `__solaris__` preprocessor definition
* Added ability to get texture name from script
* Use `TexMan.GetName(TextureID tex)` member function
* removed the ugly grenades from the extra .pk3, now that the main file contains a much nicer and unproblematic replacement.
* added `classicflight` user cvar which allows players to move forward and backward without pitch when flying
* Fixed out of bound read in zip file loader
* New grenade sprites

  sprites from Eriguns1:  
  https://github.com/XaserAcheron/eriguns  

* added new Ice Shards, and removed the zd_extra version

GZDoom 3.2.2
--------------------------------------------------------------------------------
*Sun Dec 03, 2017 12:11 am*

Notable features:

* new timer code, GZDoom now appears a lot smoother in interpolated frames
* more bugfixes, including some for non-Windows platforms
* improve speed for ARMv7 processors by setting tuning options to the Cortex-a7 CPU (for Raspberry Pi 2)
* Several ZScript extensions and fixes
* Improved OpenGL profile selection on Linux
* Rather than giving version info, GZDoom now displays the name of the game you are currently playing in the window title. This can be disabled via `i_friendlywindowtitle`

More complete changelog:

* add new ice shards for frozen actors exploding (without hexen), removed zd_extra version
* new grenade sprites
* added 'classicflight' user cvar which allows players to move forward laterally rather than according to their pitch. (Works like Heretic/Hexen/Duke3D/etc)
* fixed out of bound read in zip file loader
* added ability to get texture name from script
* fix non-portable usage of `__solaris__` preprocessor definition
* added zscript functions `GetBool()` and `SetBool()` to CVar class
* Made dynamic array's `Find()` and `Max()` functions constant
* improve speed for ARMv7 processors by setting tuning options to the Cortex-a7 CPU (for Raspberry Pi 2)
* exposed string split functionality to ZScript
* added `Wads.FindLump()` to zscript
* added `Wads.ReadLump()` to zscript
* Added `Wads.CheckNumForFullName()` to ZScript
* Extended `String.LastIndexOf()` with `endIndex` parameter (zscript)
* Added implicit scope for `if`/`else`, `while` and `do`/`while` statements in ZScript
* Scope is added only for variable or constant definition so it will no longer leak to outer scope
* Added runtime check for negative array indices in VM
* Extended `LineAttack()` with offsets and new flags
* Improved OpenGL profile selection in SDL backend
* fixed: put limits on `A_SoundVolume`
* added latching CVARs to CVARINFO
* game timer now uses performance counters and only calculates values once per frame
* force rebuild nodes for doom e1m6 - fixes a clipping issue with a certain door closed
* fixed return state of player entered event
* exported `P_Thing_Warp` to ZScript
* put in timer resets in the shader system to reduce the effects of running GZDoom too long and the timers losing precision
* also reset shader timers when a new level is started
* Fixed detection of the first entry from internal IWADINFO
* Fixed applying of brightmaps to overridden textures
* fixed: Made shader targets not case sensitive
* fixed bad use of `FScanner::GetNumber` and `GetFloat` in code inherited from ZDoomGL. This could lead to bad error messages if some malformed definitions were used.
* Rather than giving version info, GZDoom now displays the name of the game you are currently playing in the window title. This can be disabled via `i_friendlywindowtitle`

GZDoom 3.2.1
--------------------------------------------------------------------------------
*Sun Oct 22, 2017 3:26 pm*

The main reason for this release is because texture uniforms were uploaded to shaders incorrectly in 3.2.0. However, the rest of master was just bugfixes and minor improvements, so it was merged for this release. (I got permission from Graf to do this release)

Changes from 3.2.0:

* Fixed applying of height argument in `A_Fire()` function
* Removed all code needed to support macOS earlier than 10.7 Lion
* Fixed crash on attempt to register IDs for undefined class
* added `vid_cropaspect`. This cvar turns `vid_aspect` into a letterboxing function that will crop the unused sides of the screen away, instead of stretching it. Requires one of the non-legacy OpenGL framebuffers to work.
* remove `vid_tft` and `vid_nowidescreen` and associated menu option. Their functionality was supersceded and extended by `vid_aspect==3` (which has the same effect as setting both to true anyhow), and it was mostly just redundant.
* Fixed: don't interpolate view movements if a key press didn't result in any changes.
* If *nix, add default gzdoom.pk3 directory to `File.Search` paths
* fixed: inverted color order for post-process textures to BGRA to correctly match the internal texture standard in GZDoom
* added ability to change slider color using mapinfo's gameinfo
* added 'startuptype' to `iwadinfo`, allowing to change the game startup screen with custom iwads
* Fixed applying of compatibility settings for IWADs
* Fixed a few cases when IWAD was checked by hardcoded index
* Fixed arch-vile bleeding when damaging target

GZDoom 3.2.0 Released
--------------------------------------------------------------------------------
*Tue Oct 03, 2017 11:52 pm*

Major release highlights:

* zd_extra.pk3 splits off copyright infringing assets, allowing game makers to delete this file and distribute a fully GPL-conforming copy of GZDoom without further changes.
* Custom IWAD support
* Video render scaling (play in 320x200, or any custom resolution)
* Custom screen shader support
* MENUDEF replacements are now merged, allowing GZDoom to easily present new menu features in older mods that include one
* Tons of fixes and improvements

Changes from 3.1.0:

    Merged with QZDoom 2.0.0
    "Software" light mode (in OpenGL) now supports radial fog setting
    Unsloped Flats can now use non-power-2 textures in software mode
    Menus now merge in with a mod's custom MENUDEF when it provides menu replacements. This is due to older mods' menus becoming very quickly outdated.
    Rise of the Wool Ball is now supported as an IWAD
    Custom IWAD support is now available. A custom IWAD file must have the extension ipk3/iwad, and contain a "iwadinfo" lump similar to GZDoom.pk3's with only this IWAD's information and no file list.
    "Classic Transparency" option - turn off ZDoom's additive transparency effects for the original game resources.
    Better non-accelerated buffer support for software rendering - when vid_hw2d is disabled or otherwise using an unaccelerated framebuffer, stencils and on-screen objects now show up better.
    (Windows only) vid_used3d is now renamed to vid_glswfb. This matches the same CVAR that is available on Mac/Linux.
    vid_glswfb is now exposed to the menu.
    r_visibility now affects GL's Software lightmode as well as Softpoly.
    Player Sprite overlays now support the PSPF_MIRROR flag which flips the sprite horizontally across the entire screen.
    Menu Blurring option - when running in OpenGL mode, a mod can now blur the screen when the menu is active.
    Unfriendly players - when a PlayerPawn object has -FRIENDLY set, they become a playable monster and interact with the game world as one. Additionally, they become deathmatch opponents, capable of dealing and taking damage from other players.
    Custom Screen Shaders - mods are now able to include their own post processing shaders, insertable before the bloom pass ("beforebloom"), before 2D objects are drawn ("scene"), and after everything is on the screen ("screen").
    vid_saturation saturates/desaturates the screen - improves the appearance of the screen when using certain brightness/gamma settings as well as allowing the user to play in 'black and white' (similar to the display control panel option). (Requires post-processing shaders to be active and hardware gamma must be disabled)

Changes since QZDoom 2.0.0:

    r_visibility now works in OpenGL (software lightmode only) and SoftPoly
    (Software only) Added r_line/sprite_distance_cull cvar that culls lines or sprites beyond the specified distance
    (OpenGL only) Added 'enabled' property for post-process shaders, to automatically enable them without the assistance of ZScript
    Enable Core Profile on macOS only when OpenGL 3.3 is available
    Use multiple threads for xBRZ upscaling
    Added new "sv_damagefactor*" variables.
        sv_damagefactorplayer: Scales damage for player
        sv_damagefactorfriendly: Scales damage for all other +FRIENDLY objects
        sv_damagefactormobj: Scales damage for everything else (incl. monsters and decorations)
    added per-class think time profiling tool.
    Fixed crash when drawing untranslated font
    Fixed applying of color to untranslated fonts in hardware renderer
    added 'kill baddies' cheat - does the same thing as 'kill monsters' only it ignores friendly monsters
    changed gl_ssao_portals default to 1
    (OpenGL hardware/software framebuffer only) Revamped vid_max_* variables. Originally debug variables, they've been redesigned to allow screen resizing based on aesthetics.
        The variable controlling the entire system is now vid_scalemode:
            0 == neighbor scaling, controlled by vid_scalefactor
            1 == linear scaling, controlled by vid_scalefactor
            2 == 320x200, neighbor scaled
            3 == 640x400, neighbor scaled
            4 == 1280x800, linear scaled
        vid_scalefactor added for modes 0 and 1, which changes the render resolution to any arbitrary amount the user specifies >0, and resizes the screen to that amount. Valid values are >0 to <=2.0, where values above 1.0 are super-sampled to the screen (allowing up to SSAAx4 super-resolution). Please note that due to the way this is implemented, screenshots generated using this system will be in their original render resolution, so a super-sampled screenshot will actually come out in higher resolution.
        menu options for this system have been added
        please note that this system is not available in the DirectDraw/Direct3D software framebuffers. For those, ZDoom's old -2 and -4 command-line parameters still work. (For now)
    post-process GLDefs parsing is more strict than QZDoom's, and will error out if invalid keywords are used.
    Lemon parser now uses dynamic stack size comparable to C++'s, allowing deeper nesting of if, for, and while loops in ZScript
    fix dynamic light clamping in true-color software renderer
    BSP node cache will now no longer write to NTFS alternate streams. In Linux/Mac systems, this means said filenames will no longer contain a colon.
    The classic software renderer now supports use of the 'maxviewpitch' CVar - it still cannot pan to a full 90 degrees, though (sorry folks) ;)
    (Source code) Some OpenBSD support is now in the source. Please note that this is currently HUGELY unsupported by the dev team and comes as a user contribution. (From our perspective: 'here be dragons, tread ye carefully')
    Models now have normals in the hardware renderer, allowing them to be affected by dynamic lights and SSAO
    sv_singleplayerrespawn changed from a 'latching' cvar to a 'cheat' cvar using the new cheat cvar system. This means the cvar can now be enabled dynamically for single player games, however, it is still disabled when cheats are.
    added render visibility flags - will selectively make objects disappear on the screen when certain rendering feature criteria is not met. The goal of this is to allow two different objects to appear on the screen based on renderer type, as a deterministic-supporting substitution for the oft-requested "moar reliable vid_renderer checks plzplz" - this feature is also intentionally designed to be future proof (i.e. if you use this feature MODS WON'T BREAK when new features are introduced in the associated renderers!).
    added 'r_showcaps' ccmd to show which render flags are currently active in the renderer
    maximized window state is now saved between sessions as well as when 'swtruecolor' is changed
    Support binding textures for custom PP shaders
    added per-level exit texts independent of the current cluster.
        This is mainly to support UMAPINFO which does not have clusters but has been extended to define separate exit texts for each target map that can be reached from a given map.
        Special names 'normal' and 'secret' can be used to define texts specific to the default exits.

        New MAPINFO properties:

            exittext = mapname, "text"...
            textmusic = mapname, "musicname", order
            textflat = mapname, flatname
            textpic = mapname, picname

        textflat and textpic are like 'flat' and 'pic' for clusters, one defines a tiled background, the other a fullscreen image.
        Setting an empty exittext will disable a cluster-based text screen that may apply to the given map.
    timidity++ fixes for Linux
    Significantly improve shadowmap light performance for faces with a large number of lights but where only a few applies to each individual fragment
    More classic IWAD compatibility fixes for missing textures
    Fixed unset inflictor in WorldThingDamaged event
    removed tag 0 check for 3D floors because as seems to be par for course in Doom modding, some people actually exploited this bug.
    handle state label resolution in a non-actor context more gracefully.
    addressed incorrect ACS printbold implementation: For native Hexen maps it will now be correct, but all others will have to set a flag in MAPINFO's 'gameinfo' section to avoid problems with numerous ZDoom maps depending on the incorrect implementation.
    Reset interpolation coordinates for all actors before the current thinking turn instead of at the start of each actor's own Tick function so that indirect actor movement gets properly interpolated.
    fixed: The color for untranslated font was missing its alpha channel.
    print a warning if a decal definition cannot find an animator. This is important because DECALDEF cannot tentatively find animators declared after the decal.
    let PlayerPawn.ForwardThrust use its angle parameter.
    fixed: a destination-less line portal should be ignored by the sight checking code.
    added a user reserved range of statnums from 70-90
    fixed: FastProjectile's movement code was missing a portal check.
    softpoly now uses a zbuffer, similar to hardware rendering
    Add sprite adjustment to softpoly
    Fixed camera rotation from FraggleScript
    Fixed crash when morph item is used from ACS
    Fixed incorrect damage flags' checks for A_Kill...() functions
    more softpoly fixes
    softpoly now supports sloped 3d floors
    Fixed handling of default arguments in Actor.GiveSecret()
    In software rendering, lights now check if they are too far above or below a certain plane before rendering. An example of this is in unloved.pk3 where in map02, some lights are above the ceiling.
    Fixed VM abort with null activator for SecretTrigger object
    fixed: changing 'uiscale' did not always update the screen size properly.
    Game will now print the version at the start of the log.
    Properly handle VM abort exception when occurred in menu
    Add GOG path for Doom 3: BFG Edition
    fixed: When offsetting the projectile for testing, P_CheckMissileSpawn must also reset the projectile's sector to its new location.
    fixed: When stepping through a sector portal and touching a two sided line on the opposite side, its opening must be used, regardless of the FFCF_NOFLOOR flag.
    fixed: The struct field compiler did not check for forward declared type references that hadn't been resolved yet.
    Added per-actor camera FOV.
    Player FOV changes are now transmitted over the network using floats.
    Fixed Infinity and NaN floating point values formatting as string
    (8-bit software) Fixed overflow for precise blend mode
    Added Actor.A_SoundVolume(int slot, double volume) function to ZScript
    Fixed crash caused by script number collision of ACS typed scripts
    fixed: Do not call DoEffect when predicting player movement.
    fixed crash when defining a global constant which references a class member constant in its value.
    fixed: For original Hexen, executing a death special should not clear it. This addresses the bell in HexDD's Badlands being rung before it is ready to use. This also removes the redundant special handling in the ZBell actor.
    gzdoom.pk3 has now been GPL-ized and has had many assets replaced with free GPL-conforming assets.
    zd_extra.pk3 is now included in the GZDoom distribution. This file contains the assets replaced in gzdoom.pk3 to their original assets, with the exception of the MBF German Shepherd, which now uses Nash's dog sprite replacement. If you are creating a commercial game, you may now simply remove zd_extra.pk3 to avoid copyright issues.
    Static executable assets now replaced as well. The Doom marine is now completely gone, the crash logger now shows a dying marine from FreeDoom, instead. GZDoom sports its own logo icon.
    Unsafe math operations removed from armv8 - they were deterministic breaking and broke original monster behavior.
    added: m_showinputgrid == '-1' allows for on-screen keyboard to never show when inputting text, even when using a mouse
    shadowmap quality is now exposed to the menu
    OpenGL 3.0 is now allowed for software OpenGL framebuffer (aka vid_glswfb) - The Mesa rendering library supports this just fine, and it seems it runs without trouble on known troublesome 3.0 cards.
    OpenGL 3.3 is now required for the modern rendering path for hardware rendering. This means that ALL OpenGL cards prior to this version will revert to the legacy rendering path; no longer using shaders or clip planes. This was done due to there being too many compatibility issues and bugs with cards and drivers from this era.
    fixed playersprite calculations in softpoly
    classic software renderer now supports 'pixelratio' mapinfo definition - allowing mappers to now create square pixel maps in all 3 renderers.
    softpoly now supports dynamic lights in truecolor mode
    Updated "cream" and "olive" definitions in TEXTCOLO to be more readable
    Added four text colors: ice, fire, sapphire, teal
    added TID to 'actorlist' and similar console commands output
    Fixed read beyond buffer boundary during font color parsing
    Fix speed of sound and unit scale
    Fixed bugs with Line_PortalSetTarget and added more portal geometry warnings
        fixed: A bug exists where portals that have been deactivated with Line_PortalSetTarget cannot be reactivated, even if given a valid target.
        fixed: Another bug exists where portals that were created in an inactive state (using a target line tag of 0) could never be activated. (Even with the above bugfix.)
        Linked portals that have been demoted to teleport portals because they do not have a return portal now emit a warning.
        Portals that are supposed to be traversable, but do not have back-sector now demote to visual portals and emit a warning, because nothing could ever possibly traverse them anyway.
    Fixed flags when demoting interactive portals
        Interactive portals demoted to visual due to not having a back-sector would not have their interactive flag properly cleared.

QZDoom 2.0.0
--------------------------------------------------------------------------------
*Mon Jul 10, 2017 5:13 pm*

The main purpose of this release is to standardise and make available to modders the custom screen shader system. However, it comes with it a lot of updates, mostly from GZDoom since its latest release:

Updates/fixes:

    Updated to GZDoom 3.1.0, plus some fixes after.
    (from GZDoom) "Software" light mode (in OpenGL) now supports radial fog setting
    (from GZDoom) Unsloped Flats can now use non-power-2 textures in software mode
    (from GZDoom) Menus now merge in with a mod's custom MENUDEF when it provides menu replacements. This is due to older mods' menus becoming very quickly outdated.
    (from GZDoom) Blade of Agony (Chapter 2) is now supported as an IWAD
    (from GZDoom) Rise of the Wool Ball is now supported as an IWAD
    (from GZDoom) "Classic Transparency" option - turn off ZDoom's additive transparency effects for the original game resources.
    (from GZDoom) Better non-accelerated buffer support for software rendering - when vid_hw2d is disabled or otherwise using an unaccelerated framebuffer, stencils and on-screen objects now show up better.
    (from GZDoom) (Windows only) vid_used3d is now renamed to vid_glswfb. This matches the same CVAR that is available on Mac/Linux.
    (from GZDoom) vid_glswfb is now exposed to the menu.
    (from GZDoom) r_visibility now affects GL's Software lightmode as well as Softpoly.
    Player Sprite overlays now support the PSPF_MIRROR flag which flips the sprite horizontally across the entire screen.
    Menu Blurring option - when running in OpenGL mode, a mod can now blur the screen when the menu is active.
    Unfriendly players - when a PlayerPawn object has -FRIENDLY set, they become a playable monster and interact with the game world as one. Additionally, they become deathmatch opponents, capable of dealing and taking damage from other players.
    Custom Screen Shaders - mods are now able to include their own post processing shaders, insertable before the bloom pass ("beforebloom"), before 2D objects are drawn ("scene"), and after everything is on the screen ("screen").
    vid_saturation saturates/desaturates the screen - improves the appearance of the screen when using certain brightness/gamma settings as well as allowing the user to play in 'black and white' (similar to the display control panel option). (Requires post-processing shaders to be active and hardware gamma must be disabled)

GZDoom 3.1.0
--------------------------------------------------------------------------------
*Wed May 31, 2017 11:31 am*

Although this is mainly a bugfix release there are a few notable new features

    support of Strife Veteran Edition's extended single player campaign
    better handling of stereo sounds.
    PlayerThink code has been exported to scripting.
    On Windows and macOS the system's MIDI synth is no longer the default. Instead, FluidSynth and a small soundfont are now included to provide better default playback quality.

Notable bugfixes:

    translucency on weapon sprites works properly
    some layout fixes with SBARINFO based status bars.
    fixed par time display on level summary screen.
    fixed loop tag checks for Ogg files.

GZDoom 3.0.1
--------------------------------------------------------------------------------
*Mon May 01, 2017 10:34 pm*

This is a bugfix release which addresses the following:

* potential crash when changing the render output in-game and continue playing
* crash in the software renderer with camera textures
* for 32 bit Windows libsndfile.dll is reverted to the old version due to some incompatibility with the newer one
* cleanup of dynamic light options

GZDoom 3.0.0
--------------------------------------------------------------------------------
*Sat Apr 29, 2017 6:26 pm*

This is the first version that merges all software rendering features from QZDoom.
In addition this is the first release under the GPL v3.
To comply with the GPL, FModEx had to be removed as a sound backend, so this version will only support OpenAL.

New features aside from merging with QZDoom include:

    scriptable status bars.
    scriptable level status screens.
    static constant arrays in classes.
    support for Doom64-style lighting in the software renderer, with the exception of gradients.
    optimization of the scripting VM by removing some always active debug support.

Please note that starting with this version the 32 bit Windows version will require support for SSE2, because the true color software renderer cannot work without it. As a result it can no longer be used on Pentium 3's and older.

GZDoom 2.4.0 / QZDoom 1.3.0
--------------------------------------------------------------------------------
*Sun Mar 19, 2017 10:14 pm*

GZDoom 2.4.0 and QZDoom 1.3.0 have been released. This is the first official ZDoom.org release for both source ports.

GZDoom 2.4.0:

New render features:

    Doom64-style color properties for sectors (i.e. different color settings for floor, ceiling, walls and sprites.)

New scripting features:

    script versioning to account for syntax differences between versions.
    fully scripted inventory system.
    fully scripted menu system.
    scripted event system.
    printf-style string formatting function for ZScript.
    dynamic arrays for ZScript.
    more access to map data from ZScript.
    user definable actor properties.
    separation of scripts into UI and Play parts to have better access control
    exported obituary code to ZScript to allow more flexibility when handling special cases.
    SectorTagIterator and LineIDIterator classes to search for tags.

Other:

    added GetActorFloorTexture and GetActorFloorTerrain ACS functions.
    added new PRINTNAME_ constants for retrieving next and secret next level in ACS.
    per-sector settable fog density.
    fixed handling of sector action things with special trigger semantics.
    true color fonts can be defined in FONTDEFS.
    added a BOUNCE_NotOnShootables flag to address an old design bug in the bouncing system.
    added StealthAlpha actor property for defining a minimum visibility value of a stealth monster.

    and many more smaller additions and fixes.

QZDoom 1.3.0:

    Updated to GZDoom 2.4.0
    LLVM dependency completely removed
    Dynamic Lights almost fully implemented in software renderer
    Shadowmaps for OpenGL

ZDoom 2.8.1
--------------------------------------------------------------------------------
*Mon Feb 22, 2016 11:34 pm*

ZDoom 2.8.1 has been released. This is primarily a bugfix version over version 2.8.0 with some small additions:

    #region/#endregion is now supported for text lumps. ZDoom doesn't do anything with them but ignore them, but this allows editors to treat them however they like.
    Better localizability of the menus.
    Terrain definitions can now be optional.
    Walking into an area with a reverb effect no longer mutes all sound.
    Heretic's time bomb artifacts now spawn in the proper locations.
    Heretic's powered firemace balls once again seek their targets.
    The whirlwind attack used by Heretic's Ironlich sometimes fizzled out immediately.
    Instant sector movement actions are again instant.
    Various other minor fixes.

GZDoom 2.3.1
--------------------------------------------------------------------------------
*Sat Jan 07, 2017 15:36*

This is a bugfix release. Fixes include:

- Dehacked strings were cut off at the end
- corrected a few cases where dynamic lights were not correctly set up
- default lights for Doom and Heretic are now properly attenuated.
- fixed a few issues with the ZScript compiler
- fixed potential crash with Doom's boss brain
- fixed state validation problem with Dehacked modifications.
- fixed a crash with multiplayer games
- fixed a few more cases where player sprites became momentarily visible during a portal transition.
- made particle translucency calculations more precise

GZDoom 2.3.0
--------------------------------------------------------------------------------
*Sun Jan 01, 2017 15:17*

It's time to celebrate the new year with a new release. Here's 2.3.0.

New features include

    First version with official ZScript support.
    Screen space ambient occlusion (SSAO) for the OpenGL renderer, written by dpJudas
    UDMF-configurable fog density per sector
    Glowing flats settable through UDMF
    Proper rendering processing of large actors
    Improved IWAD picker, allowing to choose the active renderer, or autoloading lights and brightmaps.
    Proper dynamic light definitions for Freedoom.
    Multithreaded software rendering
    Some improvements to the console
    Fixed the pitch issues that were warned about for 2.2.0.

GZDoom 2.2.0 released
--------------------------------------------------------------------------------
*Sun Sep 18, 2016 23:18*

A new version is available. This one merges the legacy support back into the mainline so there is no corresponding 1.x version anymore.

New features:

    Fully functioning Line and Sector Portals
    Roll Sprites
    Flat Sprites
    Sprites Facing Camera
    Bloom
    Multisampling
    Stereo 3D VR
    Quad Stereo
    Tonemap Setting
    Lens Distortion Effect
    DECORATE Anonymous Functions
    Lots of new ZDoom development features

GZDoom 2.1.1 and 1.9.1 released
--------------------------------------------------------------------------------
*Tue Feb 23, 2016 12:12*

These releases coincide with ZDoom 2.8.1 and bring the same fixes. In addition 2.1.1 also fixes the broken fake contrast feature in 2.1.0.

2.1.1 will be the first official release that also comes as a 64 bit version

GZDoom 2.1.0 and 1.9.0 released
--------------------------------------------------------------------------------
*Sat Feb 06, 2016 9:01*

Here's the new versions that coincide with ZDoom 2.8.0. Actually, these have one bug less that was fixed shortly after the ZDoom release.

GZDoom 2.0.05 and 1.8.10 released
--------------------------------------------------------------------------------
*Sun Dec 21, 2014 15:29*

A new release is available!

2.0.04 fixes most of the issues in 2.0.03 and updates to the latest ZDoom, of course.

I also decided to make another update to the 1.8 branch because 1.8.07 contained at least one serious crash bug with polyobjects.

GZDoom 2.0.03 released
--------------------------------------------------------------------------------
*Tue Sep 16, 2014 8:37*

The first non-beta release of GZDoom 2.0 is available.

2.0 is a major overhaul of the rendering system, aimed at cleaning the code base from many of the workarounds needed for non-shader-supporting hardware. It also aims at optimizing things a bit better for modern graphics hardware.

Performance improvements for GL 4.x supporting hardware can be up to 10% (NVidia) or 5%(Intel, AMD) (The high difference is due to far more efficient draw call performance by NVidia drivers, which is 20x higher than on AMD.)
The minimum requirement for this version is OpenGL 3.0, so it should run on all modern hardware, including Intel GMA, but please note that this has not been tested on Intel GMA 3000 so I cannot guarantee that this GPU chipset actually works, as its drivers may lack a few features GZDoom takes for granted. Feedback regarding this issue is appreciated.

There are only a few new features here, the main goal with this version was to create a foundation for future improvements, but the most notable is that the dynamic lighting system is now entirely based on shaders - the old multi-layer-texturing method to apply dynamic lights no longer exists. This should bring some visual improvement for hardware which couldn't support this method with GZDoom 1.x.

GZDoom 1.8.7 released
--------------------------------------------------------------------------------
*Tue Sep 16, 2014 8:24*

This is the final update for GZDoom 1.x, bringing it to the latest state of ZDoom.

This release is done for the sole reason that GZDoom 2.x requires OpenGL 3.0 support, so that users of older hardware (which should slowly disappear from the market) have one last chance to get the latest ZDoom features.

Future development will continue in v 2.x only.

GZDoom 2.0.02 Third beta release
--------------------------------------------------------------------------------
*Tue Aug 19, 2014 17:32*

A new beta of GZDoom 2.0 is available.

This restores support for OpenGL 3.3. A workaround has been added to enable the lighting code with the reduced feature set of the older hardware.

This means that all AMD and NVidia cards that are capable of running GL 3.x are supported again.
Intel GMA 3000 won't work, though, because it never received a GL 3.3 driver. This chipset would run into problems with the new shader code anyway.

This build has been tested on NVidia hardware and on Intel GMA 4000. What I still need is feedback from AMD users, both with older and newer hardware, before I can do an official 2.0 release.

I need the following info:

* are there any visual issues, in particular with dynamic lights?
* how is performance compared to 1.8.6, both with lights on and off?

GZDoom 2.0.01 Second beta release
--------------------------------------------------------------------------------
*Sun Aug 03, 2014 8:43*

The first beta release of the new renderer is available now. Please note that this is a beta release, intended for finding bugs. It should be stable on Geforce cards but no guarantees.

A few notes about compatibility:

This release uses very recent OpenGL 4.4 features, most importantly persistently mapped buffers. This means that the minimum requirements are either a working OpenGL 4.4 driver or support of the GL_ARB_buffer_storage extension. As of this writing this extension is supported by the most recent drivers of NVidia, AMD and Intel for their OpenGL 4.x supporting hardware. If you got hardware that supports GL 4.x but GZDoom shows an error that this extension is missing, please update your driver.

Also, as of this writing there seems to be no driver for Windows XP, supporting this extension, so the binary was compiled without Windows XP support. This will change if I find out that such a driver has been released - but I consider that unlikely.

So why no compatibility handling? The answer to that is that any working attempt of doing this would utterly defeat the intent of the rewrite. All my tests have shown that the only other way to get the data to the GPU fast enough in this particular scenario is (what irony!), to use immediate mode functionality. The classic buffer update methods are simply too slow to perform hundreds or thousands of buffer updates per frame and the current structure of the renderer requires this many buffer updates. Work is in progress to reduce this but this is a time consuming task, so no immediate results would be presentable for older hardware. For now it is important to have this work properly on all modern and future graphics hardware.

Of course I know that there's still a significant amount of hardware out there that does not meet these requirements so for the time being the existing GZDoom 1.8 version will continue to be developed - but it will be feature-frozen on the renderer side.

So what is this about?

GZDoom 2.x features a rewrite of the rendering code to run on modern OpenGL with a core profile. That means that all rendering is now using hardware buffers to pass its data to the graphics card. Depending on the maps being played this provides a performance increase of up to 20% on modern NVidia and Intel hardware. I have no reliable numbers for AMD yet, but it may be less there due to higher driver overhead for issuing draw calls.
This release does not have any new rendering features as the most recent 1.8.x version, but during the rewrite I was able to elimintate some precision issues with the lighting code for sprites so there may be some minor improvement there.

UPDATE: The download was replaced with 2.0.01 which corrects a bug with not rendering the sides of 3D floors.

GZDoom 1.8.6 released
--------------------------------------------------------------------------------
*Thu May 08, 2014 10:00*

This is just a bugfix release that addresses one critical issue with loading of 7z files.

The complete list of changes from 1.8.5:

* 7z loader could crash on some files due to memory corruption while converting lump names
* fixed a problem with using Thing_Raise on monsters using the 'canraise' state flag.
* made interpolation of angle changes via ACS and DECORATE an opt-in feature instead of forcing it unconditionally, restoring default behavior to what it was before 1.8.5.

GZDoom 1.8.5 released.
--------------------------------------------------------------------------------
*Sat May 03, 2014 12:32*

A new release is online.

This contains all the bugfixes from the last 8 months and a few minor new features.
Please note: This is the first official release that was built with Visual Studio 2013. Although I have set the project to create an XP compatible binary I have no means to check if that worked. Please report if it doesn't, I'll try to fix it then if necessary.

GZDoom 1.8.4 released
--------------------------------------------------------------------------------
*Tue Aug 27, 2013 23:07*

Due to a serious bug with scaled texture positioning a new release is online.

Aside from that critical fix, new features include:

* mod-customizable automap overlay colors
* APROP_ViewHeight and APROP_AttackZOffset for ACS
* Player.Aircapacity property which is used as a multiplier for the level's air supply.
* BLOCKHITSCAN line flag
* ACS CheckFlag function

and several other smaller additions plus more bugfixes.

Since my FTP problems still remain unsolved, here's the download:

GZDoom 1.8.3 released
--------------------------------------------------------------------------------
*Sun Jul 28, 2013 9:46*

A new version has just been released.

The most notable change is the ability to display sprites on the cheat (IDDT)- automap.
Other changes include:

* A_BFGSpray now can use the FOILINVUL flag on the BFGExtra actor.
* Player.UseRange property
* string table access for A_Print family.
* damage type specific extreme death and crash states.
* A_Light can now use negative light offsets in GL.

Fixes include

* new compatibility settings for some maps
* fixed some damage type checks for type specific death states

Due to some ISP related problems I cannot upload the new version to my server so please download it from the attachment to this post until the problem gets fixed.

GZDoom 1.8.2 released
--------------------------------------------------------------------------------
*Sun Jun 23, 2013 13:58*

A new version is available. This is a bugfix release and fixes two problems of recent versions:

* wiping the screen caused parts of the level not to be rendered
* texture scaling was broken

IMPORTANT UPDATE: I had to make a hotfix because the savegame versioning was broken in ZDoom's initial git repository. Please upgrade immediately to 1.8.2.
The 1.8.1 package has been deleted from the server already.

GZDoom 1.8.0 released
--------------------------------------------------------------------------------
*Sun Jun 09, 2013 9:07*

This updates GZDoom to ZDoom version 2.7.0. Look over there for a list of new features, it's quite long...

GZDoom 1.7.1 released
--------------------------------------------------------------------------------
*Sun Feb 10, 2013 10:39*

After a seeminly endless delay due to various problems with ZDoom's SVN code here it finally is:

The new GZDoom 1.7.1.

This is mostly done to fix the problems with the new lighting mode. Of course it also adds all the more recent fixes done in ZDoom.

GZDoom 1.7.0 released
--------------------------------------------------------------------------------
*Sun Dec 23, 2012 11:59*

A new version is out - with a new lighting mode that's even closer to the software renderer!

Other changes to the last version include:

* berserk indicator on alternative HUD
* support for BFG edition IWADs
* sound precaching through MAPINFO

GZDoom 1.5.6 released
--------------------------------------------------------------------------------
*Sun Nov 14, 2010 13:54*

A new version is out!

Major changes to the last version include:

* customizable intermission sequences
* more supported music formats (XMI, HMI, HMP)
* better support of Timidity++ for extended MIDI formats
* less quirky jumping code
* major redesign of portal clipping. Problems with one sided lines in portals should be almost completely gone now.

Update: 1.5.05 has been uploaded which fixes some bugs with nonstandard portals and reflective floors.
Update2: 1.5.06 fixes a crash bug with more than 16 portals in a map.

GZDoom 1.5.3 released
--------------------------------------------------------------------------------
*Thu Sep 23, 2010 11:19*

A new release is out.

The one major new feature is the improved menu code. The new menu can be fully controlled with the mouse.

Aside from that it's mostly bugfixes related to the textured automap code that was introduced in 1.5.2

GZDoom 1.5.2 released
--------------------------------------------------------------------------------
*Fri Aug 27, 2010 23:52*

A new release is available.

New features include:

* textured automap
* automap keys configurable in the menu and console
* USDF support
* FluidSynth support for MIDI playback (FluidSynth DLL not included for size reasons.)

Bug fixes:

* some maps with polyobjects got their geometry moved acrpss the map.

UPDATE:

Another release is available which fixes a recently introduced bug in ZDoom's internal node builder.

GZDoom 1.5.0 released
--------------------------------------------------------------------------------
*Wed Aug 11, 2010 7:47*

This release coincides with ZDoom 2.5.0 so the main new feature is the new polyobject code. Of course all other ZDoom changes of recent months are added, too.

GZDoom 1.4.8 released
--------------------------------------------------------------------------------
*Sat Mar 27, 2010 9:39*

A new version is out.

Important new fixes include a critical level transition bug in Strife that made it impossible to get to the Abandoned Front Base and could cause the game to abort if you tried.

It also fixes an issue with item placement in maps at an angle that is not a multiple of 45°.

UPDATE: 1.4.7 has been released. This version fixes 2 semi-critical bugs:

* animations for menu textures using the original graphics names did not work
* Strife conversations could only be initiated with shootable actors.

UPDATE again: 1.4.8 has been released due to another bug introduced by recent ZDoom changes

* picking up an invulnerability sphere while being invulnerable caused a crash.

GZDoom 1.4.5 released
--------------------------------------------------------------------------------
*Fri Mar 19, 2010 8:42*

A new version is out which includes the recent ZDoom extensions to the ambient sounds and of course all fixes and improvements from the last 2 months.

If you downloaded 1.4.4 in the short time it was out please update immediately. That version has some issues which I only noticed after uploading it but before making a news post.

GZDoom 1.4.3 released
--------------------------------------------------------------------------------
*Fri Jan 29, 2010 23:22*

A new version is online.

This is merely a bugfix release that addresses 2 semi-serious bugs:

* shaders did not compile on ATI cards anymore
* sprites were not properly sorted when rendering a mirror.

GZDoom 1.4.2 released
--------------------------------------------------------------------------------
*Sun Jan 24, 2010 11:05*

This updates GZDoom to ZDoom v2.4.1 and also fixes a few bugs:

* sprite display on older graphics cards works again
* sprites with an alpha channel again display as intended
* Maps containing FraggleScript could crash when playing sounds
* some rare crashes with changing a ScriptedMarine's skin.

Important note:

Beginning with this release there won't be downloadable source packages anymore. With a public SVN server I don't see much use in them as they only make some less informed people get outdated sources instead of the most recent development code and due to the time needed to prepare them they always have been a delaying factor for new releases so I hope that in the future there'll be more frequent official releases.

In case somebody needs a specific version they can all be found and downloaded from the tags/ directory on the SVN server.

GZDoom 1.4.1 released
--------------------------------------------------------------------------------
*Tue Jan 05, 2010 10:36*

Version 1.4.1 is online. This is only a bugfix release that addresses several issues that have been found in 1.4.0. Here's the list of important fixes:

* models did not display correctly
* some moving cameras no longer worked.
* some menu layout fixes
* Strife dialogue layout fixes
* improved precision for Floor_Waggle
* improved performance with sprites that contain a lot of empty room on the outside.

GZDoom 1.4.0 released
--------------------------------------------------------------------------------
*Fri Jan 01, 2010 8:52*

To coincide with today's release of ZDoom 2.4.0 here's the latest GZDoom release.

Major new features:

* Monsters can no longer get stuck in each other.
* Generalized version of A_BishopMissileWeave and A_CStaffMissileSlither, called A_Weave
* portals can be defined with linedefs, like in Eternity.
* Major improvement of portal robustness. All geometry lying between the camera and the portal is now discarded before being rendered so there's far less restrictions in defining a portal's layout. (OpenGL only!)

Major fixes:

* replacing puffs now gets recognized properly when checking the damage type
* the options menu no longer gets cut off by the screen borders
* moving a sky viewpoint now is interpolated properly (see Daedalus MAP21's intro for an example)
* Hexen's Flechette-Grenade now gets thrown properly when viewing up or down.

GZDoom 1.3.17 final released
--------------------------------------------------------------------------------
*Sun Nov 29, 2009 17:32*

The final release of GZDoom 1.3.17 is online.

This includes all features from the recent betas plus several bug fixes from the beta testing phase.

New features since 1.2.01:

* load contents of directories into lump directory
* load 7z files like Zips
* more compression algorithms for Zip loading: Implode, Reduce, BZip2 and LZMA.
* per-linedef texture scaling
* limited support of MBF beta emulation features.
* support of user-supplied texture shader effexts. There's on example file in gzdoom.pk3:

      hardwareshader floor4_8 
      {
          shader "shaders/glsl/func_wavex.fp"
          speed 1.4
      }

* dynamic lights can be specified directly in DECORATE by adding 'Light("lightname") to a state definition.
* and of course all the stuff that got added to ZDoom in recent months

Important bugfixes since 1.2.01:

* burn wiping finally works without producing a white screen
* fixed a long standing bug with sprites showing through horizon lines

Improvements since 1.2.01:

* new resource file management code for added robustness and flexibility
* improved renderer performance. The speed hit with using 'quality' mode is mostly gone and performance overall is much better than in previous versions, in particular with NVidia based hardware.
* major improvements of sky positioning

IMPORTANT NOTE FOR NVIDIA USERS:

You MUST update the driver to at least 191.07 for this if you want to run it with shaders. Older versions contain a bug in the shader compiler that affects all of GZDoom's GLSL shaders.

GZDoom 1.3.04 - 1.3.13 Beta
--------------------------------------------------------------------------------
*Fri Oct 16, 2009 23:06*

Here's the latest beta version that includes all the latest changes. This is mostly for testing so that I can get better feedback if everything still works. I think it can be used for regular playing but please be aware that this has not been extensively tested yet.

1.3.10 adds a new 'bench' command that should make running tests easier.

GZDoom 1.0.30 released
--------------------------------------------------------------------------------
*Sat Jan 05, 2008 10:57*

The latest version is out!

Again, this one updates to the latest ZDoom SVN revision (currently 666 ;) ) so all the new ZDoom features like SBARINFO, TEAMINFO and DECORATE extensions are in.

Also new: Screen wipes are finally working in OpenGL mode! However, I was only able to test this on one computer with Windows Vista running so I can't guarantee that it will work properly for everyone.

GZDoom 1.0.19
--------------------------------------------------------------------------------
*Sat Sep 09, 2006 12:10*

At last I was able to merge all the latest ZDoom changes into GZDoom and make the necessary adjustments to make it all work with the OpenGL renderer.