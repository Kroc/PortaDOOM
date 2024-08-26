# DOOM CE

Compatible with GZDoom 4.10.0 and newer.

This mod builds on the existing total conversions of PlayStation DOOM and DOOM 64 for GZDoom, PSX DOOM TC and DOOM 64 Retribution, to take advantage of the latest GZDoom versions and adds many features that make them more faithful but were impossible to implement at their time of release. To achieve this, a large amount of the code has been adapted from GEC Master Edition (also known as DZDoom), while looking at the reverse engineered code and existing source ports of these games for reference.

In addition to that, the mod is highly modular and contains many *optional* "enhancements" that deviate from the original experience. Depending on your preference, you can choose to play as close to vanilla as possible, or experiment and play with upscaled textures, PBR materials, flashy particle effects and other features that are common in other GZDoom mods.

Since it runs on the latest GZDoom, that means that it is compatible with other mods, though many have not been fully tested.

Special thanks to Immorpher and the members of the [DOOM 64 Discord](https://discord.gg/Ktxz8nz) for the feedback and bug reports.

## Highlights

- PSX DOOM software lighting emulation (brightness fades with distance).
- DOOM 64 with gradient and additive lighting. Can also be enabled in PSX DOOM too to give it a different look.
- Options to restore the PSX DOOM aspect ratio or to use the Nintendo 64's 3-Point filter.
- The mod is powered by ZScript to make it more accurate to the original.
- PSX DOOM TC Lost Levels can be integrated into the regular episodes to provide the full PC level set.
- Bonus episodes and maps for DOOM 64 from the Absolution TC era.
- Customizable speeds: approximate them to the slower framerate of the originals or make them faster for a bigger challenge.
- Option to restore Arch-Viles in PSX DOOM, Spider Masterminds in PSX FINAL DOOM, Absolution TC exclusive monsters and Doom 2 monsters (Revenants, Arch-Viles, etc) in DOOM 64.
- The Red and Green Demon Keys exclusive to the Outcast Levels TC are included in that episode.
- Choose to play with the dark ambient Console soundtrack, the action oriented PC soundtrack, or both, in which action fades into ambient after the music finishes.
- AI interpolated DOOM 64 animations and Smooth Doom adapted to PSX DOOM.
- 2x AI upscaled textures.
- PBR materials.
- Brightmaps for sprites and textures.
- Play with a fullscreen hud styled like DOOM 64 or the default GZDoom hud.
- Ambient sounds for decorations (torches, barrels, etc).
- Enemies and the player produce footstep sounds.
- Optional story texts taken from the manuals or readme files if they were fanmade.
- Two new difficulties: Nightmare/Hardcore is UV with fast monsters and no respawns, and Ultra-Nightmare/Doomslayer is a modified version of the difficulty introduced in DOOM 64: Retribution.
- Integrates Nashgore with slight tweaks and bug fixes.
- Higher quality and more varied sound effects.
- High quality soundtracks.
- Many more miscellaneous small details.

## Included Maps

### PSX DOOM CE

- **Evil Unleashed/Ultimate DOOM:** PSX campaign. The maps included here are based on conversions made for the PSX Doom TC. Maps that were absent from the original console release come from the PSX Doom Lost Levels community project.
- **Hell on Earth/DOOM II:** PSX campaign. The maps included here are based on conversions made for the PSX Doom TC. Maps that were absent from the original console release come from the PSX Doom Lost Levels community project.
- **No Rest For The Living:** A reimagination of the Xbox mapset. The maps included here are based on conversions by Dexiaz and Salahmander2 for the PSX Doom TC.
- **Bonus maps:** Tech Gone Bad and Phobos Mission Control by BlackxZodiac13, originally created for the PSX Doom TC (based on the maps by John Romero).

### PSX FINAL DOOM CE

- **Master Levels:** PSX campaign. The maps included here are based on conversions made for the PSX Doom TC. Maps that were absent from the original console release come from the PSX Doom Lost Levels community project.
- **TNT: Evilution:** PSX campaign. The maps included here are based on conversions made for the PSX Doom TC. Maps that were absent from the original console release come from the PSX Doom Lost Levels community project.
- **The Plutonia Experiment:** PSX campaign. The maps included here are based on conversions made for the PSX Doom TC. Maps that were absent from the original console release come from the PSX Doom Lost Levels community project.
- **Bonus maps:** DeXiaZ's Mausoleum by Dexiaz and Last Gateway to Sin by BaronOfStuff, originally created for the PSX Doom TC.

### DOOM 64 CE

- **The Absolution/DOOM 64:** The original campaign.
- **The Lost Levels:** These maps are exclusive to Doom 64's 2020 remaster by Nightdive. They are only available if the included installer finds a valid installation of the 2020 release.
- **The Doomsday Levels:** Maps that were exclusive to Kaiser's 2003's Absolution TC and its Outcast Levels expansion, merged into a single episode. The maps included here are based on conversions made by Nevander for Doom 64: Retribution.
- **Redemption Denied:** A 2005 mapset by Steven Searle and AgentSpork for the Absolution TC. The maps included here are based on conversions made by Nevander for Doom 64: Retribution.
- **The Reckoning:** A 2008 mapset by Steven Searle for the Absolution TC. These maps included here are based on conversions made by thexgiddoomerx for Doom 64 EX.
- **Bonus maps:** Waste Processing and Mining Front by Maverick and Temple Ruins and Temple Grounds by Henri Leto, standalone maps made for the Absolution TC, are included. They are based on conversion made by thexgiddoomerx for Doom 64 EX.

Additional mapsets are also available in ModDB's addons tab.

## Feature Presets

Since almost every feature is optional, the mod contains four presets for different levels of enabled "enhancements": *Faithful*, *Faithful Enhanced*, *Modern (Default)* and *Experimental*.

They can be selected by going into the Features Menu and choosing `Features Preset`. It is recommended to choose one before you start a new game.

- **Faithful:** Features will be set as faithful as possible to the original.
- **Faithful Enhanced:** Some enhancements such as smooth animations, ambient sounds, gore and particles trails will be enabled, but gameplay will remain faithful to the original.
- **Modern (default):** More features including subtle gameplay changes will be enabled. Some monsters that weren't available in the console campaigns (Arch-Viles, etc) are also added.
- **Experimental:** Same as Modern, but with new visuals and music style will change over time. In PSX DOOM, some monsters will have the same speed as in PC DOOM.

## Addons

### Auto-loaded addons

There's two download flavors: Lite and Full.

**Lite** is just the base mod for those who don't want any additional features other than those built inside the mod.

**Full** is a massive ~700MB download because it bundles several addon pk3s that get automatically loaded when starting the mod. Each can be safely deleted or moved to a different folder to skip auto-loading them if you prefer not using it.

- **Maps.LostLevels:** Adds missing PC levels into the PSX DOOM campaign, and the 2020 bonus episode into DOOM 64.
- **BGM.Extended:** Extended, higher quality Console soundtrack by Aubrey Hodges. Some bonus tracks are also mapped to some maps when this is present.
- **GFX.Brightmaps:** Brightmaps, textures that remain bright regardless of how dark the room is (like switches, monsters' eyes, etc.).
- **GFX.Decals:** Higher quality decals. You may want to remove this to have more crispy, pixelated, vanilla-friendly decals.
- **GFX.Extra:** Smoothened wall/floor animations, glowing floors, and liquids will produce splashes.
- **GFX.Parallax:** Adds a 3D-like relief effect to liquids.
- **GFX.PBR:** Changes how textures react to lighting. Gives a glossy or metallic effect to textures.
- **SFX.HQ:** Upscaled, higher quality sounds and adds some additional sounds to some monsters.

## Disclaimer

I am not associated with any of the authors of the Total Conversions or any other mod included in this package. All credit belongs to them! If you enjoy a specific feature, make sure to try out their individual, separate mods.

While special care has been taken to be respectful to the originals, this mod does not aim for total accuracy. For that, please check out source ports such as PsyDoom or the commercial DOOM 64 rerelease.

## PSX DOOM CE Installation

Starting from version 2.0.5, PSX DOOM CE does not run standalone and requires the DOOM 2: Hell on Earth WAD to run. This change was made because many map packs depend on DOOM 2 assets that are not present in PSX DOOM.

The BFG Edition and Unity rerelease DOOM 2 WADs are not supported. If you have DOOM 2 installed in Steam, open its installation folder and copy the DOOM2.WAD from the *base* folder (not *rerelease*) into gzdoom's directory.

## DOOM 64 CE Installation

Starting from version 2.0.4, DOOM 64 CE does not run standalone and requires a copy of [DOOM 64 for Steam](https://store.steampowered.com/app/1148590/DOOM_64/), [GOG](https://www.gog.com/en/game/doom_64) or [Epic Games](https://store.epicgames.com/en-US/p/doom-64) to work. Because of this, there are some steps that need to be followed prior to playing it.

Supported DOOM64.WAD Checksums:

- MD5: 0AABA212339C72250F8A53A0A2B6189E
- SHA1: D041456BEA851C173F65AC6AB3F2EE61BB0B8B53
- SHA256: 05EC0118CC130036D04BF6E6F7FE4792DFAFC2D4BD98DE349DD63E2022925365

### Automatic Installation (Recommended)

Run doom64-install.bat. It will try to find your Steam installation of DOOM 64 and automatically patch and create all necessary files to play. If for any reason the Steam installation is not found, you can copy DOOM64.WAD to the same folder as the .bat file and it will use that instead.

Once it finishes, open gzdoom.exe and you will be able to select *DOOM 64 CE* from the list. If you do not wish to use the bundled gzdoom and have it installed elsewhere, copy the IWAD and PK3s to its location or the paths configured in its [IWADSearch.Directories] and [FileSearch.Directories].

### Manual Installation

Inside the *patcher* folder you will find a file called DOOM64.BPS. This file must be used to patch an unaltered Steam DOOM64.WAD. To open it, you can use any utility that supports BPS patching, such as:

- [Floating IPS](https://www.romhacking.net/utilities/1040/)
- [Online ROM Web Patcher](https://hack64.net/tools/patcher.php)
- [RomPatcher.js](https://www.marcrobledo.com/RomPatcher.js/)

The resulting file must be named *DOOM64.IWAD* (note the IWAD extension, not WAD) and placed into the same folder as gzdoom.exe or any path in its [IWADSearch.Directories]. If everything went correctly you will see DOOM 64 CE when opening GZDoom.

The manual method will not convert the Lost Levels campaign since that process is more complicated. For that, please run the automatic installer instead.

## FAQ

### How do I run the game?

First, extract the zip file into a new folder. Then, follow the installation instructions above. Finally, run gzdoom.exe and choose a mod from the list. The pk3 files need to be in a place discoverable by GZDoom, such as the same directory.

### Do you need the GZDoom binaries bundled with the mod?

No. I only bundled it for convenience, its source code has not been modified.

### What is the difference between this and Retribution or the PSX TC?

A lot of the internals are different and work much closer to the original games. Instead of being an approximation based on what the author felt right, a lot has been adapted from reverse engineered source code into ZScript.

Maps that come from Retribution and the PSX TC have been modified to better match the originals, for example correcting sector colors and light specials. Things such as editor numbers and unique textures have been carried over, so custom maps designed for them should also be compatible. The Retribution version of the Doomsday Levels and Redemption Denied were used instead of making new conversions from scratch because they contain small quality of life improvements that are almost unanimously preferred.

### How can I make the game look more like the original versions?

Go to the `Features` menu, and change the preset to `Faithful`. Play the Lite version of the game (or remove all addon pk3s) so that upscales, extra music and other optional stuff doesn't get loaded.

If you want to take it even further, enable the Low Resolution Shader in the Features menu, then enable GZDoom's Full Options Menu, go to Set Video Mode, disable Rendering Interpolation, change Force Aspect Ratio to 4:3 and set Forced Ratio Style to Letterbox.

### Which rendering API should I use?

Ideally only Vulkan or OpenGL should be used. OpenGL ES is only partially supported because it disables shader based effects which this mod relies heavily upon, even on its most faithful settings. It should only be used as a compromise if your hardware has problems running on the other backends.

### There's too many settings in the Features menu, what does each one mean?

I suggest you choose one of the existing default presets and start from there if you want additional tweaks.

### Why am I not seeing any changes in-game after changing settings in the Features menu?

Most require reloading the level to take effect. You'll need to complete the current level or restart the game.

### The levels are too dark, how can I increase brightness?

There is an `Overall Brightness` slider in the `Features` menu. I recommend you use this instead of GZDoom's gamma settings because it preserves the colors better.

### How can I increase the UI size?

GZDoom sets the default UI scale to match your current resolution. If you wish to enlarge it, go to `Options > Scaling Options` and change the `User Interface Scale`.

### Why does the HUD looks stretched vertically?

GZDoom has an option called `HUD preserves aspect ratio`, make sure it is *disabled*. That option is only intended for PC Doom and will make the HUD scale incorrectly with these mods.

### The wrong music is playing. How can I change it?

In the `Features` menu, go to `Audio Features` and change the `Music Type`.

- Choosing `Computer` will only play action based tracks (PC style).
- Choosing `Console` will only play dark ambient tracks (the original soundtrack).
- If `Play Both Music Styles` is enabled, the PC track will play for `Minimum Seconds Playing Before Music Changes` and then fade to the Console track.

### What are the differences between the two new difficulties?

- Nightmare/Hardcore is just Ultra-Violence/Watch Me Die with fast monsters and 50% more ammo.
- Ultra-Nightmare/Doomslayer is a reworked version of the Doomslayer difficulty introduced in DOOM 64: Retribution. This difficulty applies the following modifiers:
    1. Monster health is reduced by 20%
    2. Player damage taken is increased by 20%
    3. Ammo pickups are downgraded to their lowest tier (e.g box of shells to a single shell).
    4. Ammo is worth 300%.
    5. Monsters have a chance to change the frame rate of their next animation, making them faster and more unpredictable.
    6. Monsters have a high chance to stop being stunned by pain and may counter attack if they get into a pain state.
    7. Monsters have a chance to stop infighting.
    8. Monsters that shoot projectiles have 33% chance to fire one that has higher speed.
    9. Monsters are more aggressive.

### What is that red triangle that appears on screen when I get hit?

It's the indicator that shows from which direction you took damage. You can disable it in `Features` > `Interface Features` > `Damage Direction Indicator`.

### Can I play this with Voxel Doom?

[Voxel Doom II](https://www.moddb.com/mods/voxel-doom-ii) is compatible with PSX DOOM, but you must make a small edit to its file. You must open cheello_voxels_v2_1.pk3 (make a backup copy first), and rename the directory *filter/doom.id* to *filter/doom.ce*. Then you can load it on top of CE, but you must disable Smooth Monsters for it to work properly. A caveat is that monsters will revert back to their Doom II timings and behavior instead of how they are in Psx Doom.

### Can I play this with \<x\> mod?

Since the mod runs on the latest GZDoom (4.10+), that means that it is compatible with other mods. It's been tested with Corruption Cards, Project Brutality, QC:DE, Death Foretold, Embers of Armageddon, Guncaster, Trailblazer, GMOTA, Russian Overkill, Complex Doom, Legendoom Lite, Pandemonia, and many others. NOTE: Support is more limited in Doom 64 because most mods assume Doom 2 textures and Doom 2's actor heights.

### Can I play this in Delta Touch or GZDoom VR?

Yes, as long as their upstream GZDoom version is compatible with this mod (4.10+). Though I haven't tested them personally, many others have reported playing in mobile or VR without problems.

### Is this multiplayer compatible?

Yes, but using GZDoom's peer-to-peer support ([Wiki](https://zdoom.org/wiki/Command_line_parameters#Multiplayer_options)). PSX maps are coop-friendly. DOOM 64 does not support coop, but if you download the Retribution maps addon there is partial support (there may be softlocks since they haven't been thoroughly tested).

### What third-party tools were used to create the assets?

I used Substance Alchemist for the PBR textures and ESRGAN (multiple models) for the upscales. To create the smooth DOOM 64 animations, I used DAIN.

### What happened to the Upscaled Textures and Arranged Soundtrack addons?

I removed them from the Full download because I wasn't satisfied with how they were. You can still download them separately from the Addons tab.

### Why were the SIGIL levels removed?

They were just placeholders and not true efforts to make them in the same style as the other PSX maps. I hope to include them again after GEC Master Edition leaves beta, since that mod includes proper conversions.

### How did you port the DOOM 64 levels?

I built my own toolchain. First, a tool that parses the original map data and convert it to UDMF compatible with DZDoom. I then brought as much as I could from DZDoom into ZScript, ACS and custom shaders in this mod. Finally I wrote some additional ZScript scripts that post-process the maps and "understand" some of the custom UDMF properties my tools use.

Since not everything is possible in GZDoom, the biggest challenges were:

- Creating custom textures for all the flipped textures and switch overlays. I ended up making a script for it. Canvas textures were not an option because you can't apply materials to them.
- Approximate the line/sector special behavior and speed.
- Converting the fake 3D floor effect. GZDoom provides some ways to make it work, but they don't work in all cases, forcing me to replace them with 3D floors.
- Making everything fit using DOOM 64: Retribution as a base. It clearly wasn't intended for this and many approaches that could have worked more naturally if the original maps were used. Many additional workarounds had to be taken, for example, to support the 3D floors it uses. In the end I think it was worth it, because most people enjoy the small quality of life changes from Retribution.

### How can I access the DOOM 64 "Fun" maps?

You need to beat the secret level Hectic to unlock the Bonus Maps episode.

### What do the red and green artifacts DOOM 64's Outcast levels do?

The Red Artifact consumes player health to slow down all enemies for a short period of time. The Green Artifact is used to spawn platforms that slowly levitate upwards.

### What is the meaning of CE in the title?

There is no specific meaning, but I've seen it called Custom Edition, Complete Edition, Console Edition, Compilation Edition, Console Enhanced, etc.

## Links

- [PSX DOOM TC](https://www.doomworld.com/forum/topic/57957-psx-doomfinal-doom-tc-legacy-tc-see-first-post-for-details/)
- [DOOM 64 Retribution](https://www.doomworld.com/forum/topic/91854-v15-doom-64-retribution/)
- [GEC Master Edition](https://www.doomworld.com/forum/topic/94139-update-v2-psxdoom-psxfinaldoom-doom64-on-gzdoom-gec-master-edition-dec-17-2018/)
- [PsyDoom](https://github.com/BodbDearg/PsyDoom)
- [DOOM64 EX](https://doom64ex.wordpress.com/)
- [PSXDOOM-RE](https://github.com/Erick194/PSXDOOM-RE)
- [PSXFINALDOOM-RE](https://github.com/Erick194/PSXFINALDOOM-RE)
- [DOOM64-RE](https://github.com/Erick194/DOOM64-RE)

## Changelog

## 3.9.2

- 64: Fixed monsters not respawning if respawning is force-enabled through gzdoom's options.
- 64: [In the Void] Fixed the wrong type of demon key spawning in the map.
- PSX: [Unto the Cruel] Fixed the level only appearing after Fear when the Lost Levels addon is loaded.
- PSX: Implemented PSX exclusive light specials to allow for future map conversions. The current campaign does not use them.
- Both: Fixed monsters not respawning if the 'always respawn' gameplay option is enabled.
- Both: Updated the bundled GZDoom to 4.12.2. The minimum required version is still 4.10.

## 3.9.1

- PSX: [Last Gateway to Sin] Fixed the level not loading.
- 64: Fixed vertical doors moving unintended sectors in rare cases.
- 64: Fixed some middle textures not appearing on older converted maps.
- Both: Fixed shaders not applying to textures when the PBR addon is loaded.

### 3.9.0

- PSX: [The Castle] Added missing multiplayer flags to teleport destinations.
- PSX: [Gotcha!] Added missing multiplayer flags to all things in the level.
- PSX: [Tech Gone Bad] Added missing multiplayer flags to all things in the level.
- PSX: Fixed brightmap for the MARBFACE texture.
- PSX: Added an option to toggle scene pixel ratio correction.
- PSX: Fixed scaling of the PSX hud weapon style.
- PSX: Fixed weapon psprites appearing brighter than they should.
- PSX: Fixed the wrong key icon blinking in rare cases.
- 64: Replaced Retribution's MAP01-MAP32 with new map conversions that are more accurate to the originals.
- 64: Fixed the Unmaker not firing automatically after repeatedly holding the fire button too fast.
- 64: Moved the Forbidden Deeper level slot after Darkened.
- Both: Added an option to toggle the Nintendo 64's three point filter.
- Both: Removed the AspectRatio and 3PointFilter addons since their functionality is now included in the main mod.
- Both: Fixed a crash that could happen after friendly monsters kill another monster.
- Both: Freelook is now disabled when the Faithful preset is selected.

### 3.8.2

- PSX: Lowered the intensity of some decoration brightmaps and tweaked some dynamic lights to blend better with the psx gamma correction.
- PSX: [Dis] Fixed the Spiderdemon not spawning in multiplayer mode.
- PSX: [Fear] Removed a multiplayer-only pillar decoration that caused a softlock in cooperative mode.
- 64: Fixed spawned keys not staying on the level after being picked in cooperative mode.
- 64: Fixed weapon special action triggers not activating if the player already owns the weapon in cooperative mode.
- 64: [Alpha Quadrant] Fixed a possible softlock after being locked inside an arena in cooperative mode.
- 64: [Research Lab] Fixed a possible softlock after being locked inside an arena in cooperative mode.
- 64: [Terror Core] Fixed a possible softlock after being locked inside an arena in cooperative mode.
- 64: [Unholy Temple] Fixed a possible softlock after being locked inside an arena in cooperative mode.
- Both: Fixed the light amp goggles effect being too bright if PSX gamma correction is enabled.
- Both: Fixed hud notifications disappearing earlier than they should if another notification took their place.
- Both: Updated the bundled GZDoom to 4.11.3.

### 3.8.1

- 64: Replaced GZDoom lightning flashes with a custom thinker that behaves like the original.
- 64: Added an option to toggle lightning flashes on sectors that have a sky ceiling.
- 64: Re-added the Night Crawler grenade bounce sound in the HQ SFX addon.
- 64: Fixed the low resolution shader aspect ratio being off by one pixel.
- Both: Fixed the screen wipe effect making a bright flash on certain video cards.
- Both: Removed weapon recoil for the smooth Plasma Rifle.
- Both: Updated the bundled GZDoom to 4.11.1.

### 3.8.0

- PSX: Removed the Sigil episode.  It is now provided as an optional download in ModDB's addons tab.
- PSX: Removed brightmaps for FACE01, FACE02 and FACE03 textures.
- 64: Implemented emulation of linear fog fades.
- Both: Added an option to emulate playing on the original resolution.
- Both: Due to changes in the latest GZDoom version, light modes can no longer be changed through the Features menu.
- Both: Added an option to toggle PSX gamma correction.
- Both: Upscales are no longer bundled with the Full version and instead are provided as a separete download. They are still auto-loaded if present.
- Both: Fixed compatibility with GZDoom 4.11.
- Both: Updated the bundled GZDoom to 4.11.

### 3.7.1

- PSX: Fixed some monsters skipping frames when the "Use PC speed" option was enabled.
- PSX: Fixed Hell Knights and Baron of Hells playing their death sound twice.
- 64: Fixed a crash when switching Unmaker modes.
- 64: Fixed the C308 texture using the animation from CFACEA.
- 64: Fixed some projectiles not becoming transparent on death when gzdoom's Classic Transparency option is set to Vanilla.
- 64: [Holding Area] Fixed spawn filters not being applied.
- Both: Fixed bullet casings sometimes getting stuck inside walls.
- Both: Minor bug fixes.

### 3.7.0

- 64: Updated the Spider Mastermind sprite to the latest one by Craneo.
- 64: Hell Time is now compatible with all monsters, even if they come from mods.
- Both: Fire skies are now programmatically generated using canvas textures.
- Both: Updated HUD scripts for blinking keys and showing the level name.
- Both: Updated the console background to better match gzdoom's style.
- Both: Cast roll actors now play their melee animation.
- Both: Cast roll actors can now be customized and added through a custom lump (castdefs).
- Both: Cutscenes can now be customized and added through a custom lump (intrdefs).
- Both: Mod-specific options can now be customized and added through a custom lump (cedefs).
- Both: World ambient sounds can now be customized and added through a custom lump (wrldsnds).
- Both: Footstep sounds can now be customized and added through a custom lump (footsnds).
- Both: Fixed a crash when the player was crushed and squishy gibs were enabled.
- Both: Added an option to change the lost soul limit between 21 (PSX/PC) or 17 (PSX Final/D64), if the compatibility option is enabled.
- Both: Added an option to change the nightmare monster render style.
- Both: Restored the melee attack key due to popular demand.
- Both: Several small optimizations.

### 3.6.3

- PSX: Fixed the "use PC skies" option not working as intended.
- PSX: Fixed fire skies looking too dark with the PSX software light mode.
- 64: Fixed shaders not loading when using Delta Touch.
- 64: Increased the Revenant's missile speed by one unit.
- 64: Increased the Revenant's movement speed by two units.
- 64: Added an additional frame for the Pain Elemental from the Doom 64 Alpha.
- 64: Modified some of the Doom 2 monster spawn locations.
- 64: Added additional spawn locations for Absolution TC monsters in the original campaign to accurately reproduce where they appeared in the TC.
- 64: [Delta Quadrant] Added an way to shoot a secret switch that previously required freelook.
- Both: Fixed special passwords only activating in lowercase.
- Both: Restored the Doom 64 lighting brightness hack for GLES users.
- Both: Reduced the brightness level of the PSX software sector light mode.
- Both: Updated the console font to gzdoom's new font format and is now able to scale properly.
- Both: Updated the way nashgore handles crushed gibs to make it compatible with later gzdoom versions.

### 3.6.2

- 64: Fixed the Revenant projectile attack speed and damage.
- 64: Updated the Chaingunner sprite to the latest one by Craneo and Korp.
- 64: [Staging Area] Fixed sequence lights.
- 64: [Control] Fixed sequence lights.
- Both: Added an option to change the fullscreen HUD font color.
- Both: Added an option to change the fullscreen HUD transparency factor.
- Both: Added support for passwords.
- Both: Removed the hack to give user control for Doom 64 environmental brightness. It is now fixed at 100%.
- Both: Removed the integrated flashlight. There are various standalone mods that can be used instead.
- Both: Removed the integrated weapon wheel mod. There are various standalone mods that can be used instead.
- Both: Removed the melee attack key.

### 3.6.1

- PSX: Revenants now only have a melee threshold when the PC speed setting is active.
- PSX: Fixed the Sigil and NRFTL campaigns forcing a pistol start.
- 64: Updated dynamic light definitions.
- 64: Fixed some light specials not syncing in the main campaign.
- 64: Fixed the Bonus Map menu not unlocking after beating Hectic.
- Both: Fixed Archvile fire timing.
- Both: When Corruption Cards is loaded, bonus map hubs will no longer end the game if you choose to keep your cards.
- Both: Fixed levels not unlocking after quitting the game.
- Both: Normal maps are no longer in the iwads and have been moved to the PBR and Parallax addons.

### 3.6.0

- PSX: Added an option to switch between the Final Doom SSG sprite and the original one.
- PSX: Applied changes by DerTodIstEinDandy to the Icon of Sin to make the spawn list more restricted and slower.
- PSX: Fixed the zombie monsters not playing their third sight and death sound.
- 64: Updated the Revenant missile sprite.
- 64: Updated the Chaingunner sprite to a newer one made by Craneo.
- 64: Updated the Archvile sprite to one made by DrPySpy.
- 64: Added an option to use the Absolution TC chaingunner sprites.
- 64: Added an option to skip the game introduction sequence.
- 64: Reimplemented the episode introductions as cutscenes.
- 64: Changed most glow and strobing light specials to more faithful ones.
- 64: Added an option to control the strobing light intensity.
- 64: Improved the lightning intensity to work like in vanilla.
- Both: Fixed an issue where nightmare monsters spawned through thing spawners would have 4x starting health.
- Both: Mods are no longer able to change the player view height.
- Both: Added class spawn filters to all maps for mods that depend on them.
- Both: Fixed weapons not resetting after entering bonus maps.
- Both: Added an option to skip the startup legals screen.
- Both: Adjusted the sound effect volume to better match the original.
- Both: Reimplemented the ending statistics screen as a cutscene.
- Both: Fire skies now get 3-Point filtered if the addon is loaded.
- Both: Server cvars are no longer cached.
- Both: Flashlight, Weapon Wheel and Melee Attack are now unbound by default.
- Both: Removed the low health indicator effect.
- Both: Removed the integrated weapon sway mod. The standalone mod (Universal Weapon Sway) can still be used.
- Both: Removed the integrated motion blur mod. The standalone mod (Simple Motion Blur) can still be used.
- Both: Removed the integrated screen tilt mod. The standalone mod (Tilt++) can still be used.
- Both: Bumped the GZDoom required version to 4.10.0.

### 3.5.2

- 64: Reverted the Archvile sprites to their previous iteration until DrPySpy finishes them.
- Both: Updated the bundled GZDoom to 4.10.0.

### 3.5.1

- PSX: Fixed the enhanced particle counter not decreasing when they get destroyed.
- 64: Fixed the wall torch enhanced fire moving with sectors.
- 64: [Altar of Pain] Changed the sequence light effect for a more faithful one.

### 3.5.0

- PSX: Added dynamic lights to locked door side strips.
- PSX: The "Use PC Speed" option now also changes the frame speed of monsters.
- 64: Tagged secrets for The Reckoning, Temple Ruins and Temple Grounds.
- 64: Fixed cutscenes with a 560x240 background appearing 20 pixels shifted to the right.
- 64: Fixed fading menus infinitely looping when certain fade speed values were selected.
- 64: Changed the Archvile sprite for a work-in-progress one by DrPySpy.
- 64: Lowered the Revenant missile damage by half, and its speed by 3.
- 64: Fixed the Revenant missile offsets.
- 64: Implemented faithful Doom 64 sector specials (mainly relevant for newer converted maps).
- 64: Fixed the wall torch enhanced fire moving with sectors.
- 64: [Staging Area] Changed the sequence light effect for a more faithful one.
- 64: [Outpost Omega] Changed the demon key sector strobing effect for a more faithful one.
- 64: [The Lair] Changed the demon key sector strobing effect for a more faithful one.
- 64: [Control] Changed the sequence light effect for a more faithful one.
- Both: Improved the Archvile fire animation when enhanced particles are enabled.
- Both: Improved the message style handling. Added options to display messages with 4:3 offsets, to better resemble the originals.
- Both: Added a shortcut to control the max. amount of notification messages at the same time in the Features menu.
- Both: Fixed a bug that prevented some music tracks to play if their file name contained "D_" in the middle.
- Both: Fixed the cast of characters sequence using the wrong offsets on certain rotations.
- Both: Added an option to control the maxmimum number of simultaneous special effects.
- Both: The mod version number is now displayed in the console background.

### 3.4.0

- Both: Added a warning when playing on skills above 3.
- Both: Reworked the Doomslayer/Ultra-Nightmare difficulties.
- Both: Added new cast of character cutscenes that are more faithful to the originals.
- Both: Added an option to show an icon on the fullscreen hud when berserk is active.
- Both: Added an option to display messages styled like the original (padded top left, bottom left).
- Both: Dynamic lights and decals are now disabled with the Faithful preset. Added shortcuts to control their values in the Features menu.
- Both: Screenblocks are now set to their original value with the Faithful preset.
- Both: Fixed the Faithful Enhanced preset incorrectly enabling fast weapons switching.
- Both: The Faithful preset now disables dynamic lights, decals and resets the hud size to how it was in the original.
- PSX: Fixed the upscale SSG animation displaying incorrect frames.
- PSX: Fixed Tower of Babel not showing the correct sky when the Lost Levels addon is loaded.
- PSX: Fixed wrong instruments playing in the PSX FINAL DOOM midi soundtrack.
- 64: Fixed the artifact alignment when using GZDoom's alternative hud.
- 64: Removed non-official secrets from secret counts.
- 64: Added a warning that Mining Front is not completable without freelook.
- 64: Added additional Doom 2 monsters based on their Brutal Doom 64 placements.
- 64: [The Lair] Fixed the secret count.
- 64: [Breakdown] Fixed an incorrectly scaled texture in the super secret room.
- 64: [Evil Sacrifice] Fixed a glitched fake 3d floor sky.
- 64: [Thy Glory] Fixed a cosmetic script not activating after picking up the green armor that spawns.
- 64: [Operations Base] Made a line that opens a secret a repeatable action.
- 64: [Source of Evil] Changed some scripts to prevent soft locking due to spawn blocking.

### 3.3.1

- PSX: Added an option to display the opening logo video, disabled by default and enabled if the Faithful presets are selected.
- PSX: [Main Processing] Fixed the Spider Mastermind getting stuck in a wall.
- 64: Fixed monsters spawners incorrectly increasing  monster and item counts.
- 64: Fixed some cases where waterfall animations would not work without the "Extra" addon.
- 64: [Main Engineering] Fixed chaingunners spawning even if the option to enable Doom 2 monsters was disabled.

### 3.3.0

- Both: Fixed the Weapon Sway settings not applying after loading a saved game.
- Both: Updated the startup graphics.
- Both: Fixed the Lost Soul not having dynamic lights attached on some death frames.
- Both: Reduced the default volume of ambient sound effects to 80%.
- PSX: Fixed the squishy crushed gib effect not working.
- PSX: Fixed the gradient brightness setting not applying without having to reload the level.
- 64: Doom 2 monster placement is now loosely based on Doom 64 for Doom 2.
- 64: The option to include Doom 2 monsters is now enabled on the Modern (Default) preset.
- 64: Fixed spawned monsters not counting as kills / items.
- 64: Fixed the space and void skyboxes not displaying correctly on OpenGL.
- 64: Fixed incorrect gradient color values on Absolution TC levels.
- 64: Updated the installer to autodetect the GOG release.
- 64: [Traps] Fixed darts not spawning.
- 64: [Derelict] Fixed unlit candles, darts and the secret soulsphere not spawning.
- 64: [Shadow Crypt] Fixed the yellow key room lift not lowering on skills below I Own Doom.

### 3.2.1

- Both: Fixed projectile velocity not scaling correctly depending on settings.
- 64: Fixed tracer projectiles not chasing their target.
- 64: Fixed the marine bot behavior.
- 64: Fixed the fast door and fast lift sound not playing correctly in ported maps.
- 64: Changed the Resurrector's experimental flame effect to a less performance-heavy one.
- 64: Fixed the Stalker sprite changing into the Lost Soul sprite.

### 3.2.0

- Both: Made the hitscan random damage rolls more accurate to the original.
- Both: Remade intermission cutscenes using the ScreenJob api.
- Both: Added support for the vertical bullet spread Player Option.
- Both: Added Discord RPC integration.
- Both: Made the mod compatible with GZDoom 4.8.0
- PSX: Adjusted the timing of the shotgun recoil pitch.
- PSX: Improved visibility on Doom 2's city levels when gradient lightning is enabled.
- PSX: Fixed various texture misalignments in the original campaign.
- 64: Clouds are now able to be filtered by the 3-Point filter addon.
- 64: Changed the experimental flame effect to a less performance-heavy one.

### 3.1.3

- Both: Fixed tracers and puffs not spawning when a monster was hit by shotguns.
- Both: Updated default keybinds so they don't reset themselves after being unbound.
- Both: Improved the damage thrust logic to be more faithful and added an option to disable it.
- PSX: Fixed the locked doors not showing any color in the automap.
- 64: Added an option to disable weapon firing knockback.

### 3.1.2

- Both: Fixed various incorrect menu entries.
- PSX: Fixed the map identifiers for The Death Domain and Onslaught.
- PSX: Fixed incorrect map identifiers in Final Doom monster replacer scripts.

### 3.1.1

- Both: Fixed crashes when loading saved games.

### 3.1.0

- 64: Changed the aspect ratio of vanilla fire skies to better resemble the original.
- 64: Retribution maps now use CE's color transfer and interpolation scripts.
- 64: Added an option to control the menu fade speed.
- 64: Fixed the mother demon playing her death sound twice when crushed.
- 64: Added an option to use the PSX software lighting mode.
- 64: Added an option to add Revenants, Masterminds and Arch-Viles to the original episodes.
- PSX: Added an option to shift the Super Shotgun firing delay later in the animation sequence.
- PSX: Added support for actor translucency, additive and subtractive blend flags.
- Both: Smooth monster animations are now affected by actor speed settings.
- Both: Default actor speed for all presets except Experimental is now "Vanilla (30hz)".
- Both: Disabled the "Intensify Sector Colors" by default.
- Both: Improved the intensity of the light amp goggle powerup when gradients are enabled.
- Both: Fixed the invulnerability effect appearing too bright when inverse maps are enabled.
- Both: A menu that lets you select a features preset will now open when the mod is started for the first time.
- Both: Readjusted the feature presets.
- Both: Improved menu tooltips.
- Both: Fixed the Options Search returning duplicate matches.
- Both: Credits now scroll.
- Both: Bug fixes and performance improvements.

### 3.0.1

- Both: Fixed the mod not loading with the GLES renderer.
- Both: Added an option to restore extreme death behavior to vanilla. Without it, some weapons will always trigger a gib.
- Both: Made the Features menu also accessible from the Options menu, in case mods replace the main menu.
- Both: The exaggerated Lost Soul background sound will only activate after seeing the player.
- Both: Lost Souls will only emit light after they've seen the player.
- Both: Fixed some images not displaying properly in aspect ratios wider than 16:9.
- Both: Fixed shader truncation warnings.
- PSX: Fixed the weapon offsets for the PSX weapon sprites.
- PSX: Added missing upscaled sprites for the smooth Cacodemon death animation.
- PSX: Final Doom is once again standalone and no longer requieres Psx Doom.
- 64: Switch brightmaps are now part of the iwad.
- 64: Added the Revenant death sound.
- 64: Lowered the Revenant's height.

### 3.0.0

- Both: Merged the Base and ipk3 files. The PSX and Retribution TCs are no longer included without modifications.
- Both: Reorganized all internal lumps to make it easier to maintain and understand.
- Both: Updated the zscript api version to latest stable and fixed deprecations.
- Both: Sector light color, light level and special colors previously read from external lumps are now baked inside the maps.
- Both: Item pickup sounds now overlap, like the original.
- Both: Slowed down some high tier actors back to vanilla speeds regardless of settings for better balancing.
- Both: Improved mod compatibility.
- Both: Slightly increased the intensity of strobing additive blends.
- Both: Enhanced particles now preserve their transparency when GZDoom's Classic Doom Transparency is set to Vanilla.
- Both: Added an option to use the original episode names (e.g Doom 64 instead of The Absolution).
- Both: Added an option to display the "Entering" text in a single stats screen, like the original.
- Both: Added an option to display the original stats screen and intermission backgrounds.
- Both: Added an option to skip the ending consolidated statistics report.
- Both: Added options to hide episodes and difficultes not present in the originals.
- Both: Added a slider to control Lost Soul translucency since it will be removed on GZDoom > 4.8.
- Both: Changed GZDoom's default night vision mode to classic style.
- Both: Disabled motion blur by default.
- Both: Added a CCARDS lump for compatibility with Corruption Cards.
- Both: Many small bug fixes.
- PSX: Improved the Software lighting mode to be more accurate.
- PSX: Lost Level maps are now in their own autoloaded pk3 that adds them to their corresponding episodes.
- PSX: Corrected the aspect ratio of the fullscreen HUD.
- PSX: Added an option to use the original PSX mugshot.
- PSX: Added an option to use the original weapon sprites.
- PSX: Changed GZDoom's default invulnerability effect to classic style.
- PSX: [Caged] Fixed the correct ambient track not playing.
- 64: Fixed the Chainsaw firing speed.
- 64: Adjusted the way vanilla move bob strength is applied.
- 64: Reduced the intensity of the Intensify Sector Colors option to make levels less dark.
- 64: Added an option to use an alternate shotgun zombie sprite to make it easier to distinguish them.
- 64: Added placeholder sprites for missing Doom 2 monsters to improve compatibility with mods that spawn them.
- 64: Fixed the wrong gib sound being played when the SFX addon was not loaded.
- 64: Added an option to use the DOOM 64 EX Arranged HUD.
- 64: Renamed The Outcast Levels episode to The Doomsday Levels to better reflect that they also include Absolution TC exclusive levels.
- 64: Added texture markers to the patched DOOM 64 IWAD.
- 64: [Dark Entries] Fixed the invisible puzzle soulsphere.
- 64: [Cold Grounds] Fixed some floors incorrectly having the "liquid floor" effect.
- 64: [Control] Fixed misaligned textures.

### 2.1.1

- Both: Fixed the Reset to Defaults option not working on newly created ini files.
- Both: Increased the maximum allowed value for Overall Brightness from 100 to 300.
- Both: Fixed a couple of missing strings in the Blood Options menu.

### 2.1.0

- Both: Fixed an issue with the actor replacement script that could make replaced actors not be affected by scripts (such as the unpickable demon key in OUT09, Nebula).
- Both: Changed the way in which the gradient color brightness is applied for a more accurate one (Vulkan/OpenGL only).
- Both: Brightness controls in the Features menu now get applied without having to restart the map.
- Both: Brightmap intensity now depends on the intensity of the gradient colors, with some exceptions.
- Both: Added some empty pixels around sprites to prevent a gzdoom issue where the sprite would wrap around its edges when texture filtering is enabled.
- Both: Fixed the stats screen not showing the next map name when the next map was a text screen intermission.
- Both: Fixed the stats screen not doing the countdown animation.
- Both: Removed footstep sound when the player is walking in the void.
- Both: Fixed ambient sounds not always getting attached to teleporters.
- Both: Added a key binding for NashGore's clear gore option.
- Both: Added color to secret found and artifact found messages.
- Both: Added a slightly lower pitched chaingun firing sound by Immorpher in the SFX addon.
- Both: Fixed type mismatches in custom shaders.
- Both: Added Doom Builder metadata for actor definitions.
- PSX: Fixed some animations not playing without the Extra addon.
- 64: Fixed rare cases of actors becoming invisible after fading in.
- 64: Added the "repeatable action" flag to doors in ported maps that were missing it.
- 64: Fixed door railings moving along with doors in ported maps.
- 64: Fixed monsters being shootable while being fade spawned.
- 64: Fixed the missile range of the Resurrector.
- 64: Switches will now be displayed slightly brighter than the wall texture they are in.
- 64: Gibs and blood pools will no longer spawn on untextured floors.
- 64: Added a message with instructions when picking up the Red and Green artifacts.
- 64: Lots of compatibility improvements for ported maps.
- 64: [Wretched Vats] Fixed the dart trap throwing a "Macro_Suspend" error.
- 64: [Source of Evil] Fixed a case where not all monsters would teleport after spawning.
- 64: [Temple Ruins] Fixed a case where not all monsters would teleport after spawning.

### 2.0.7

- Both: Fixed the Low Health Indicator causing a VM abort in non-Windows systems.
- Both: Turned off the Low Health Indicator sound by default.
- PSX: [Deimos Lab] Corrected texture misalignments in the room with four lifts.
- 64: Updated the ending graphic to use widescreen art by BearderDoomGuy.
- 64: Fixed the Hell Knight dissapearing after death when not using smooth animations.
- 64: Removed the +NOGRAVITY flag from various decorations for compatibility with Retribution maps.
- 64: Added two Outcast levels that were missing to the Level Select menu.

### 2.0.6

- Both: Cleaned the alpha layer of upscaled sprites.
- Both: Fixed fists being selected by default when changing levels through the Fun map hubs.
- Both: Gib squish effect is now disabled by default.
- Both: Restored the vanilla gib sound When the SFX addon is not loaded.
- Both: Changed the default value of gradient lighting to 100 instead of 50.
- Both: Updated FancyWorld (ambient sound) scripts to latest dev build.
- Both: Reduced the amount of ambient sound actors being spawned to improve performance.
- Both: Replaced some ambient sounds.
- Both: Made the flashlight undroppable.
- Both: Lost Souls no longer play the Nashgore "body splat" sound effect when dying.
- Both: Fixed the completed map counts at the ending statistics screen.
- PSX: [Slough of Despair] Increased the speed of a closing door when crossing the index finger to prevent a possible softlock.
- 64: Fixed actor spawners being removed from the map when affected by the actor fade out script.
- 64: Fixed dart and seeker missile spawn height calculation.
- 64: Fixed Retribution fade in script not fully fading in a previously faded out thing resulting in invisible actors.
- 64: Fixed not being able to exit viewing a camera when using a controller.
- 64: Fixed timings for the Pain Elemental and Resurrector.
- 64: Fixed a segmentation fault that happened on Linux builds when processing incorrecly tagged switch linedefs (specifically, REC09: Source of Evil).
- 64: [Waste Processing] Fixed a missing switch texture.
- 64: [Test Facility] Added Outcast actors to the arena.

### 2.0.5

- PSX: PSX DOOM CE now requires the DOOM 2 IWAD to work.
- PSX: Improved mod support. Mods that replace the player will now work.
- 64: Improved support for the "Nightmare" flag for ported EX maps.
- 64: Provided a way to autoload the Lost Levels if found.

### 2.0.4

- Both: Fixed the WorldGamma shader causing glitchy textures in some cases, such as when substractive rendering is applied.
- Both: Fixed Hell Knights and Barons of Hell infighting with monsters of their same type.
- Both: Fixed exaggerated torch fire effect spawning and despawning correctly.
- 64: DOOM 64 CE now requires a patched Steam DOOM64.WAD to work.
- 64: Removed The Lost Levels.
- 64: Fixed the Reset to Defaults option not working with GZDoom 4.6.1
- 64: Spectres will always be rendered translucent with their fade effect regardless of GZDoom's Spectre Translucency setting.
- 64: Corrected the Hell Knight's non-smooth movement animation speed.
- 64: Corrected the spawn offset of exaggerated fire flames when they spawn on top of torch stands.

### 2.0.3

- Both: Improved compatibility with addon map packs.
- PSX: More secret exits to levels that were not in the original are now tagged as secrets.
- 64: Fixed flickering skyboxes on ported maps.
- 64: Updated the player's gravity algorithm.
- 64: Updated the thing fade in and out script to work better in some edge cases.
- 64: Updated the shader to allow the liquid floor effect on any flat.
- 64: Updated the Computer soundtrack to match the UMP release.
- 64: [Derelict] Fixed the skull keys not being placed in the pedestal.
- 64: [Cold Grounds] Restored the liquid floor effect for non-water flats.
- 64: [Wretched Vats] Restored the liquid floor effect for non-water flats.

### 2.0.2

- Both: Fixed an issue that caused a crash when reloading a save after dying.
- Both: Fixed the Berserk powerup not giving a strength boost.
- Both: Rewrote the Level Select menu logic to make it usable for map pack addons.
- Both: Fixed the sound played when the female gender is selected and a locked door is attempted to be opened.
- Both: Fixed the speed for the scrolling menu tooltips.
- PSX: Fixed the shotgun ejecting a bullet casing instead of a shell casing.
- PSX: Updated the Computer soundtrack to match the latest TNTMP development.
- 64: Items are affected by gravity again. This solves problems like the one in Forge where items were not carried by the conveyor belt.
- 64: Added support for spawning Absolution and Outcast monsters.
- 64: Fixed the color interpolation effect for ported maps.
- 64: Fixed the fading out script for ported maps.
- 64: Fixed the translucency level of spawned actors.
- 64: Removed the ammo requirement of the Levitation Device to make it similar to the Outcast TC.
- 64: Fixed the charge attack of the Acid Demon infinitely accumulating speed.
- 64: Fixed the height calculation for lowering floors on ported maps.
- 64: Updated the Computer soundtrack to match the latest UMP development.

### 2.0.1

- Both: Fixed the teleport sound not playing in some cases.
- PSX: Fixed the Arachnotron's projectile PC speed.
- PSX: Added missing menu options to FINAL DOOM.
- 64: Fixed the title map not behaving correctly..
- 64: Restored the radius of monsters to Retribution values so they don't get stuck in maps not designed with vanilla attributes in mind.
- 64: The render style of projectiles that were not translucent in the original are now controlled by the r_vanillatrans CVar.
- 64: Updated the Computer soundtrack to match the latest UMP development.

### 2.0.0

- Both: Fixed too many bugs to be listed here.
- Both: Added options to customize weapon, player and actor speeds to make them more faithful into the Gameplay Features menu.
- Both: Refactored the actor code and implemented many attributes and actions that make them more faithful to the original.
- Both: Removed the Sprite Shadows mod as it is now included natively into GZDoom.
- Both: Items collected no longer count towards the Average Clear Count statistic.
- Both: Changed a few sounds to rely less on the Sound Caulking mod.
- Both: Added a new key pickup sound if the `SFX.HQ` addon is enabled.
- Both: The Console music style is now enabled by default instead of Both.
- Both: The exaggerated fire sky effect is now disabled by default.
- PSX: PSX FINAL DOOM now requires the PSX DOOM iwad and Base addon.
- PSX: Updated the brightness level to better match the original version.
- PSX: Sectors are now colored using the data from the original levels.
- PSX: Changed some intermission texts to better match the original ones.
- PSX: Twilight Descends is no longer a secret level, like the original.
- PSX: Secret exits to levels that were not in the original are now tagged as secrets.
- 64: The extra bonus fun maps are no longer hidden in the Bonus Fun Map Hub.
- 64: The Lost Levels are now unlocked from the start.
- 64: Added two new artifacts from the Absolution TC to the Outcast Levels if the `Add Outcast Monsters` option is enabled.
- 64: Changed the way the Unmaker fires lasers to be more faithful to the original.
- 64: Changed some placeholder music from the Computer soundtrack.

### 1.1.3

- Both: Fixed an issue with the monster replacement script that could replace items that were in the same location as the monster getting replaced.
- Both: Fixed ambient sounds that were overriding sounds played in the same channel.
- Both: Fixed the ceiling blood color using the same render style as the sprite who created it.
- Both: Changed the Secret Found sound.
- Both: Fixed some cases where the sound effects from the Sound Caulking mod were taking precedence over MorphSound.
- Both: Fixed the weapon wheel to work with controllers.
- Both: Added tooltips for most options in the Features menu and reordered some options.
- Both: `Show extra picture after story intermissions` and `Show title pictures` are now disabled by default.
- PSX: Fixed the skull switch texture over green bricks brightmap.
- PSX: [Mephisto's Mausoleum] Fixed the event not triggering after killing all Mancubi.
- 64: Adjusted the gradients for the Outcast Levels episode to be darker at the top.
- 64: Updated the intro text for The Lost Levels.
- 64: Fixed the fade out timings for the intro texts.
- 64: Updated the Computer soundtrack to match the MTWID release.
- 64: [Stepwalk] Fixed the teleporter stop getting triggered after being used several times.

### 1.1.2

- Both: Made the melee attack's puff not create a decal.
- Both: Fixed various sprite brightmaps.
- Both: Added an option to enable alternate, exaggerated fire skies. It is enabled by default and can be disabled in the `Features > Special Effects` menu or by choosing any Vanilla preset.
- Both: Enabling the Lost Soul exaggerated fire effect to its own option. It is disabled by default and can be enabled in the `Features > Special Effects` menu or by choosing the Exaggerated preset.
- Both: Removed the upscaled fire sky textures.
- Both: Removed the Skyboxes addon. Options for toggling sky types are now in the `Features > Special Effects` menu and are enabled by default.
- PSX: Changed the exaggerated torch effects to a shader based one.
- PSX: Fixed the software lighting applying the wrong colors when gradient lighting is disabled.
- PSX: Fixed the FINAL DOOM's super shotgun's flash state.
- PSX: Fixed the smooth Archvile's death animation.
- PSX: Replaced some upscaled weapon sprites.
- 64: Updated the Computer soundtrack to match the latest MTWID development.
- 64: Fixed the hours calculation for the Statistics viewer.

### 1.1.1

- PSX: Fixed brightmaps not taking their intended effect when using gradient lighting.
- 64: Picking a Berserk powerup will now switch to the Fists.
- 64: [Thy Glory] Added the Check Height flag to a switch that was missing it in the raising pillars section.
- 64: [Delta Quadrant] Made the Demon Key not hidden from the start, like in the original.
- 64: [Delta Quadrant] The final puzzle added in the EX port of this map will now spawn a Megasphere.

### 1.1.0

- Both: Bumped the GZDoom requirement to 4.6.x.
- Both: Modified the script that shows the map's name to obey the UI scaling setting.
- Both: Revamped the Level Select menu. Levels are now selectable if unlocked on any difficulty.
- PSX: Brought over some optional lighting effects from DOOM 64.
- PSX: Slightly increased the default brightness level when PSX Software lighting is disabled.
- PSX: Fixed the Archvile fire not emitting light.
- PSX: Fixed the fire effect in the title screen and cleaned some colored pixels.
- PSX: Fixed the brightmaps for several upscaled sprites.
- PSX: Updated some roughness and metallic maps.
- PSX: Lowered the brightness of the Plutonia episode 1 3D skybox.
- 64: Fixed a bug where ported maps would crash when opening them.
- 64: Added touched up upscaled sprites with cleaner transparency.
- 64: Changed the coloring of torch flames and the Motherdemon's fire effect.
- 64: Added dynamic lights to locked doors in non-Retribution levels.
- 64: Added the updated cloud effects to some levels that were missing it.
- 64: Fixed a bug where the plasma rifle's idle sound would keep playing after changing weapons.
- 64: Fixed the wipe effect briefly flashing after exiting a level using Vulkan.
- 64: Changed the weapon priority of the Chainsaw to be higher than the Fists.
- 64: Updated the Computer soundtrack to match the latest MTWID development.
- 64: [Evil Sacrifice] Fixed a possible softlock in the red key area.
- 64: [Delta Quadrant] Fixed the fence surrounding the Demon Key not changing texture.
- 64: [Delta Quadrant] Removed the Megasphere from the Demon Key fence since it was not in the original.
- 64: [Incinerated Offerings] Reduced the time the platform with the BFG remains lowered by half.
- 64: [Shadow Crypt] Fixed the bars near the exit not changing texture.
- 64: [The Circle of Chaos] Fixed the bars near the blue key not changing texture.

### 1.0.1

- Both: Fixed the punch sound and puffs.
- Both: Fixed the female grunt sound.
- Both: Renamed some features for clarity.
- Both: Fixed the script that replaces actors to also transfer specials.
- Both: Corrected a typo in the credits.
- PSX: Fixed the chainsaw pickup sound.
- PSX: Fixed the vanilla chainsaw fire sounds.
- PSX: Made the plasma fire sound play at a slower rate.
- 64: Fixed shaders making the mod impossible to load in some systems.
- 64: Adjusted the movement speeds and gravity to better match the original and make some jumps without straferunning.
- 64: Fixed a bug that caused skull keys instead of keycards to blink in the HUD when opening locked doors.
- 64: Changed the skybox cloud texture to a different one.
- 64: Improved the way colors are applied to the clouds shader.
- 64: Removed the brightmap for the Demon and Spectre dead sprite.
- 64: Fixed instances where looking at a camera would not register keys if autorun was enabled.
- 64: [The Hazard Pits] Fixed the monitor lowering the lift to reveal the Chainsaw.
- 64: [Incinerated Offerings] Fixed the switch in the secret room only being able to be triggered once.
- 64: [Incinerated Offerings] Fixed the fence surrounding the yellow key not changing texture.
- 64: [Incinerated Offerings] Fixed the switch behind the yellow door only being able to be triggered once.
- 64: [Incinerated Offerings] Made the platform with the BFG lower for more time.
- 64: [Temple Ruins] Fixed the exit door that lacked the Repeatable Action flag.

### 1.0.0

- Both: Initial Release
