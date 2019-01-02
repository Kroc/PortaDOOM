GZDoom 3.7.1
--------------------------------------------------------------------------------
*Tue Jan 01, 2019 3:13 pm*

Highlights

    Just bug fixes

Details

    fixed everlasting fast projectile after hitting ceiling - Without the test for ceiling hit fast projectile could enter its Death state every tick infinitely
    fixed crash in AutoUseStrifeHealth - The loop never checked if the item was still valid and would continue to try to use it, even after it was removed from the inventory and destroyed. As native code this just failed silently, but with the VM it needs to be explicitly checked.
    fixed typo in sky preparation.
    Fixed: SXF_CLEARCALLERSPECIAL cleared the spawned actor's special instead of the caller.
    Fixed settings_controller not updating properly when a player becomes the new arbitrator in a netgame.
    added missing return in P_RemoveThing.
    added missing null pointer check to SBarInfo's inventory bar drawer.
    fixed ammo check for weapon with 'uses both' flags
    fixed SPC music loops
    fixed precaching of switches. The backwards animation accessed the wrong array which in case of sequences with different length could crash
    fixed missing attack sound in A_CustomPunch
    Fixed: IsFakePain received the modified damage instead of the raw, preventing ALLOWPAIN from working as intended.
    TNT.WAD fixes
    Have Plutonia MAP16 pit kill player

GZDoom 3.7.0 Released
--------------------------------------------------------------------------------
*Thu Dec 27, 2018 9:01 am*

UDMF changes - important for editor authors!

    Expand UDMF and ZScript API for side's own additive colors
    Add 'useowncoloradd_{top,mid,bottom}' sidedef properties to the UDMF spec
    Please be aware there are also now UDMF fields for destructible geometry. (implementation details here)

Highlights

    Completely revamped textures system, allowing for more future extensibility and rework, also fixes a few issues
    add support for scaled textures in the software renderer
    Untranslated fonts now appear as truecolor
    Improvements to Doom64 colouring
    Add NOFRICTION and NOFRICTIONBOUNCE flags
    declared Actor's Morph() and UnMorph() functions virtual
    scale factor is now applied to all scaling modes
    add vanilla lightmode that behaves exactly as Doom's original light did
    Cheat-enforced CVARs can now be changed in normal single player games without sv_cheats
    Added a JIT compiler for DECORATE and ZScript which should allow some maps and mods to perform slightly, if not significantly faster in some cases 64 bit only!
    scriptified the AltHUD
    Many bug fixes as usual
    Lights are now referenced by sections rather than surface, to speed up light linking. This should allow a dynamically-lit plasma bolt to pass over a 3D bridge in Frozen Time without turning the game into a slide show.
    Many scriptifications from native code to ZScript
    Add shader cache for Intel GPU's which should result in faster startups (especially on Windows) - first startup will still be slower, though
    Added IsPointInMap(Vector3 p).
    Added destructible geometry, exported to ZScript
    Added a function to get the actor's age in ticks.
    Added a new field to the Actor class which stores the amount of ticks passed since the game started on the moment the actor was spawned.
    Added a function to the Actor class to get its spawn time relative to the current level.
    Added spawn time information to the output of the "info" console command.
    Export AllClasses
    Update GME up to 0.6.2 version
    changed the way alpha works on DrawLine and DrawThickLine so they're consistent
    GL renderer is now partly multi-threaded, resulting in a 10-20% speedup, depending on a map's complexity.
    add "neutral" gender option and better obit formatting

Details

    Many scriptifications from native code to ZScript
    moved Extradata parser into MapLoader class.
    moved slope creation functions and most initialize-time variables into MapLoader class.
    moved the content from p_glnodes into the MapLoader class.
    moved most content of p_setup.cpp into a MapLoader class.
    NOFRICTION now applies to Z friction when flying or swimming
    fixed crash in Actor.Warp() with null destination
    remove some obsolete bit of cruft from the class type system.
    fixed 3D floor initialization for actor spawning. - Since actors are being spawned before the renderer gets set up this needs to fully initialize the list before spawning the actors, then take it down again for creating the vertex buffer and then recreate it.
    Expand UDMF and ZScript API for side's own additive colors
    Add 'useowncoloradd_{top,mid,bottom}' sidedef properties to the UDMF spec
    dynamically update polyobj lines
    Split off all reactive functionality (pain, infighting, etc) into its own function, ReactToDamage.
    Refactored all DamageMobj's damage <= 0 values.
    Any unconditional cancellations now return -1. ReactToDamage will not be called if values < 0.
    All pain/wound/target changing allowances return 0.
    Add NOFRICTION and NOFRICTIONBOUNCE flags

    NOFRICTION disables all friction effects on the thing it's set on
    (including the speed cap from water/crouching), and NOFRICTIONBOUNCE
    disables the "bounce off walls on an icy floor" effect on the thing
    it's set on.
    fix first softpoly frame being empty
    declared Actor's Morph() and UnMorph() functions virtual
    set vid_scalefactor to 1 when using vid_setscale
    initialize the index field for particles.

    This won't contribute to sort order so it should be the same for all particles, which it wasn't because it was never set.
    fixed sprite sorting in the hardware renderer.

    This did no longer sort sprites in the same position reliably since the feature to render sprites which only partially are inside a sector was added.
    With this, sprites in the same position are no longer guaranteed to be added to the render list in sequence.
    Fixed by adding an 'order' field to AActor which gets incremented with each spawned actor and reset when a new level is started.

    The software renderer will also need a variation of this fix but its data no longer has access to the defining actor when being sorted, so a bit more work is needed here.
    remove shadow acne when dynlights perfectly align with planes
    improve softpoly 3d floor drawing somewhat
    fixed random number generation in SpawnFizzle.

    This should now produce the same value range as Hexen's original code.
    fixed bad attempt at restoring position in A_CustomBulletAttack.
    fix null pointer crash, replace DONT_DRAW with a boolean, make rw_pic a local variable
    gave the strifehumanoid's burn states dynamic lights.

    Unlike everything else from the IWADs this had to use the 'light' keyword in ZScript because this is merely a base class for many others and the light definitions here need to be inheritable.
    renamed back arguments of A_FireProjectile.
    fixed default initialization of software warp textures
    fixed multipatch texture resolving
    empty screenshot array is returned by base framebuffer
    removed the redundant GetOffsetPosition export and added direct native support to its existing variants
    cleaned up use of the random function in script files.

    Many uses of random() & value have been turned into random(0, value).
    This is not only more efficient, it also ensures better random distribution because the parameter-less variant only returns values between 0 and 255.
    fixed the decal translation handler truncated the translation ID

    This was yet another of those old misguided 16 bit space 'optimizations'.
    fixed: The random sound handler was using 16 bit storage throughout

    Changed to use 32 bit and also fixed the random number call which was using the byte value variant of the access operator, effectively limiting the number of choices to 256.
    fixed PlayerInfo.FindMostRecentWeapon

    returning multiple values from a subfunction is currently not working so this has to add an indirection.
    a few more explicit local buffer allocations removed.
    use a TArray to pass the screenshot buffer
    fixed lost settings controller state upon new game
    cleaned up player reinitialization upon new game
    fix decals looking blackened due to low lookup table precision when alpha is zero
    fixed: For an initial weapon pickup, sv_unlimited_pickup wasn't checked for the included ammo.
    Export P_GetOffsetPosition and ADynamicLight::SetOffset to ZScript
    added missing null pointer checks to cheat code.
    Fixed the position of the soul sphere within one of the secret areas (sector 324) of Alien Vendetta MAP28.
    removed the hasglnodes variables.

    Since the software renderer also requires GL nodes now this was always true.
    fix MemcpyCommand not using the same lines for the threads as softpoly (visible as a race condition when screenblocks didn't start at top of screen)
    moved P_OpenMapData and related content out of p_setup.cpp.
    made Ammo.GetParentAmmo virtual
    vWorldNormal is not normalized but R_DoomColormap requires this
    moved all shutdown handling for sound related resources to I_ShutdownSound instead of registering separate atterm handlers.
    fixed: The Heretic sky height hack needs to be stored in the already created texture object as well.
    added an option to GAMEINFO to either force or disable loading of the default lights and brightmaps.

    The mod which prompted me to add this is "The Chosen" which is a Dehacked-based TC and repurposes many original actors for something entirely different.
    The stock lights are not usable for this and would make it impossible to add a GAMEINFO lump to it because then there is no way to disable loading of lights in the startup screen.
    remove InitSoftwareSky
    fix sky drawer issues when not using max screenblocks
    Add line numbers to JIT stack traces. (#667)
    Added a function for triggering use/push specials for usage in custom monster AI.
    Exported P_CheckFor3DFloorHit and P_CheckFor3DCeilingHit to ZScript.
    fixed: A powered up weapon which shares its ready state with the parent but is currently in a firing sequence may not force-switch the weapon, because that will cause the sequence to run in the wrong weapon's context.
    fixed: 'frame' in GLDEFS light definitions was case sensitive.
    add support for writing the native call stack
    improve the stack trace when the jit is active
    fix r_multithreaded 0 not working
    move more of the light calculation code to the drawerargs
    replaced several explicit allocations with TArrays.
    fixed: Alpha textures need to use a color's grayscale value, not their red channel.
    fixed inconsistent dymanic lights setup with UBO
    delay converting sprite lightlevels to a shade until we hit ColormapLight
    delay converting wall lightlevels to a shade until we hit the drawer
    fix heretic light torch in software renderer and remove some code duplication
    move visibility calculation to LightVisibility
    add support for scaled textures in the software renderer
    use TArrays for MD3 storage.
    fixed: For non-persistent buffers, sprite vertices need to be recalculated in the splitter code of the translucent sorter.
    fix sky drawers not staying within their numa node
    removed redundant std::move.
    improved error reporting for badly defined translations.

    This needs to be handled by the caller for all use cases because the translation parser lacks the context to do a proper error report.
    fixed: sidedef-less GLWalls may not apply per-sidedef render properties.

    These always come from open-sector render hacks where the renderer tries to fill in some gaps
    fixed: Both main and worker thread were modifying the portal state.

    The parts in the main thread have been offloaded to a new worker job to avoid having to use a mutex to protect the portal state.
    fixed: no sprites were drawn in a sector if it only had ones in its sectorportal_thinglist.
    let FxNop have a value type, even if it's just TypeError.
    fixed two broken ScriptUtil calls in FraggleScript.
    added a 'forceworldpanning' map flag.

    Since unfortunately this cannot be set as a general default, let's at least make it as easy as possible to disable that panning+scaling madness without having to edit the texture data.
    fixed: The light defaults were not fully deleted on an engine restart.
    store UnchangedSpriteNames in Dehacked in a less hacky manner.
    use a TArray in PPUniforms.

    This makes the vast majority of code in that class just go away
    handle CR_UNTRANSLATED so that it doesn't force CR_UNTRANSLATED to the palette.

    Since the entire font setup is very much incapable of handling this during rendering, short of a complete rewrite, it was necessary to put the relevant code into the places which process the characters for drawing so that it can disable the translation table (which needs to be passed as raw data to the draw functions) and keep track of both the translatable and the original variant of the character graphics.
    use TArrays for most buffers being used in the font class.
    use a TArray to store the particles and remove all 16 bit global variables.

    This means one less exit function to deal with - and these days 16 bit variables are a pointless attempt at saving space.
    use symbolic constants for the light modes.
    add vanilla lightmode that behaves exactly as Doom's original light did
    enable the texture scalers in software mode.
    code simplification.
    fixed incorrect alignment of scaled world panned textures combined with per-sidedef scaling in the hardware renderer

    This particular case incorrectly factored in the sidedef's scaling factor for how to calculate the offset.
    Fortunately this is a very rare case - a quick check yielded no maps depending on it.
    Should any map surface that depends on this bug a compatibility option may be needed but it doesn't seem likely that this may be the case.
    disable music playback if WinMM stream cannot be opened
    fixed memory leak with texture creation.
    fixed 3D floor texture setup.

    This code really makes zero sense, it looks like the cases for upper and lower texture should never be entered ever.
    fixed invalid texture accesses in the software renderer.
    Force node rebuild for Plutonia 2 MAP29 to fix BSP glitches
    cleaned out the FHardwareTexture class, now that the translations are finally handled on a higher level.
    added a number of darken2.wad maps to rebuild nodes in compatibility.txt
    fixed crash on invoking vid_setsize CCMD with one argument
    separated the savepic texture handler from the regular PNG texture

    This was leaking memory with being handled like a regular image texture and also would prevent further changes to the in-game texture handling because the savegame picture was imposing some limitations on FPNGTexture's implementation
    add font characters to the texture manager for easier management

    These were the only non-transient textures not being handled by the texture manager which complicarted operations that require itrer
    added a 'check only' option to CreateTexBuffer.

    This is meant to calculate the content ID without constructing the texture buffer.
    FHardwareTextureContainer.

    This is essentially a stripped down version of FHardwareTexture, which can exist on the API independent size, and which stores pointers to hardware textures instead of OpenGL texture handles.
    Force node rebuild for Plutonia 2 MAP25 to fix BSP glitches
    print VM stack trace on startup abort exception
    re-added PlayerInfo.BringUpWeapon (as a deprecated function for compatibility with 3.6.0 mods)
    fixed deprecation warnings for member functions not checking the version.
    split gl_texture_hqresize into two variables - one for mode, one for multiplier.
    Fixed: the vid_rendermode CVAR could get wrong values.
    fixed return value of native call to dynamic array's Reserve()

    viewtopic.php?t=62841
    server CVARs can be changed only by settings controller

    Initially, settings controller flag was false by default
    It was not touched during construction and destruction of player_t instances though
    Now, with all members initialized in class definition, this flag must be saved and restored manually

    viewtopic.php?t=62830
    Let FSkyboxTexture map to the last defined regular texture of the same name instead of its first face

    This is normally a better fallback for the software renderer.
    Use FImageTexture for the null texture

    FDummyTexture had a big problem: Whenever it was accessed by accident it crashed the app because it wasn't fully implemented.

    What it should do is return empty pixels of the given size, and an unextended FImageTexture is doing just that.
    Made SWPaletteTexture an ImageSource and let it be managed by the texture manager.

    This is a lot easier to manage because the palette is just static data that can easily mimic an image.
    implemented a proper texture composition cache.

    This will mostly ensure that each patch used for composition is only loaded once and automatically unloaded once no longer needed.
    fixed precaching to consider animations and switches
    removed erroneous assertion - viewtopic.php?t=62815
    fixed Actor.A_StopSound() native call - Wrong function overload was selected by compiler - viewtopic.php?t=62820
    made some changes to the FImageSource interface that allows forwarding the bRemap0 flag, but do it so that it doesn't permanently alter how the image looks.

    In ZDoom this would affect everything using a patch that got used in a front sky layer, even if the texture was totally unrelated. It is only owed to the low usability of such patches for other purposes that this hasn't caused problems.
    changed multipatch texture composition to always composite off full source images and not do it recursively.

    Previously it tried to copy all patches of composite sub-images directly onto the main image.
    This caused massive complications throughout the entire true color texture code and made any attempt of caching the source data for composition next to impossible because the entire composition process operated on the raw data read from the texture and not some cacheable image. While this may cause more pixel data to be processed, this will be easily offset by being able to reuse patches for multiple textures, once a caching system is in place, which even for the IWADs happens quite frequently.

    Removing the now unneeded arguments from the implementation also makes things a lot easier to handle.
    reworked how the software renderer manages its textures.
        it's no longer the main texture objects managing the pixel buffer but FSoftwareTexture.
        create proper spans for true color textures. The paletted spans only match if the image does not have any translucent pixels.
        create proper warp textures instead of working off the paletted variants.
    Added Plutonia 2 MAP10 and MAP11 to the "rebuildnodes" compatibility list.
    fixed crash with FraggleScript in Nimrod MAP02.
    fixed broken Z coordinate in Actor.Vec3Angle() native call
    Disable PALVERS substitution when true color rendering is active.
    Renamed FTextureManager::GetTexture to GetTextureID
    moved the span and swtruecolor creation code into FSoftwareTexture.
    moved the software rendering specific parts of the sky setup to r_skyplane.cpp.
    handle the Harmony status bar icon scaling a bit more robustly.

    Considering that the physical texture size should be abstracted away from modding this needs to be done differently.
    Doing any calculations with physical texture sizes on the mod side is only going to cause errors so this had been changed to always return scaled size.
    add plutonia map32 to node regen compatibility - viewtopic.php?f=2&t=62777
    fixed native calls to LevelLocals.GetUDMF*() functions
    changing vid_scalefactor now always shows current scaling data unless it gets set to "1"
    vid_scaletoheight/width now works in all scaling modes, and can now also scale on custom resolutions directly
    scriptified P_CheckMeleeRange2.
    deprecated a few functions that depend on AAPTR_* to be useful.
    fixed: ST_FormatMapName did not clear the string it wrote to before appending text.
    fixed: SlotPriority must be a float.
    Enforce CheckCheatmode() for cheat-enforced CVARs, allowing them to be changed in normal single player games
    moved a large part of the VM thunks out of p_mobj.cpp.
    fixed: SBar_SetClipRect had a superfluous argument resulting in incorrect behavior
    scriptified ASpecialSpot.
    scriptified A_SpawnSingleItem, which was the last piece of native code still referencing AInventory
    scriptified A_SelectWeapon and inlined the last remaining use of APlayerPawn::SelectWeapon.
    scriptified A_SelectWeapon
    The 'A' prefix has no meaning in class names on the script side - even in comments.
    fixed max. ammo display on AltHud.
    added missing min/max unsigned instructions for the VM.
    always apply vid_scalefactor now, even when vid_scalemode is not 0 or 1.
    fixed crash with weapons which remove themselves from the inventory but continue calling action functions.

    This is still an error, so now this throws a meaningful exception.
    hardened the seg integrity checks against extremely broken mods.

    Temple of the Lizardmen 3 has segs lumps in every level that seem to use a different data format and are completely unusable, up to triggering undefined behavior.
    fixed: The static variant of PClass::FindFunction may only be used for actual static variables.
    Fix RemoveInventory not calling DetachFromOwner when an item is the first in the owner's inventory.
    Fix CheckAddToSlots not working because it uses GetReplacement incorrectly.
    fixed issues with Dehacked's ad-hoc script code generation

        The functions had no prototype and caused crashes.
        even after creating a prototype it didn't work because CreateAnonymousFunction was set up incorrectly for the case where a known return type was given.
    disable alpha test on models if the renderstyle isn't STYLE_Normal
    implemented missing 'exact' parameter for ThinkerIterator.Next.
    fixed accidentally misnamed parameter in A_Explode.
    started replacing direct references to class AInventory.

    The easiest part was the type checks which could be changed to the name variant with a global search and replace.
    fixed: P_PoisonPlayer and P_PoisonDamage did not check for NODAMAGE.
    fixed: P_PoisonDamage's check for Buddha2 and the Buddha powerup were inverted.
    fixed: P_PoisonDamage checked the modified damage instead of the raw, allowing amplifiers to boost the damage beyond telefrag and circumventing regular buddha.
    scriptified AInventory::Tick.
    scriptified the AutoUseHealth feature.

    This again is a piece of code that reads and even writes to inventory items' properties, so better have it on the script side.
    scriptified the decision making of the invuseall CCMD.

    Custom items had no way to adjust to this - and it also was the last native access to ItemFlags.
    scriptified P_DropItem.
    scriptified the no-spawn flag check for armor and health items.
    consolidated the check for "is actor an owned inventory item" into a subfunction.
    scriptified G_PlayerFinishLevel.
    fixed incomplete null checks in A_RadiusThrust.
    scriptified AActor::ClearInventory
    properly hook up the alt HUD with the status bar.
    scriptified the last components of the alternative HUD.
    moved the ALTHUDCF parser PClass::StaticInit, so that it gets done right after creating the actor definitions.

    All left to do is not to reallocate the AltHud object for each frame but store it in a better suited place.
    scriptified the main drawer for the in-game HUD and removed all intermediate VM calls from the native source.
    scriptified the AltHUD
    added the missing TNT1A0 check for icon-less keys.

    Since it tries to get the icon from the spawn state it also has to check if that actually has a valid sprite.
    Fixed A_JumpIfNoAmmo not working.
    fixed the AngleToVector calls in stateprovider.txt.

    This looks like a search & replace gone wrong.
    Restored A_SpawnItemEx's "chance" to "failchance" to prevent mod breakage from named parameters.
    fixed script call in PickNewWeapon.
    scriptified invnext and invprev CCMDs.
    moved ValidateInvFirst to the script side because this was one of the major functions that directly reference AInventory.
    moved AInventory::DoRespawn fully to the script side.
    made CallTryPickup a global function.
    re-fixed the massacre fix for Dehacked-modified inventory items.

    Instead of overriding the Massacre method it is preferable to clear the flags causing the bad behavior, most notably ISMONSTER.
    scriptified GiveAmmo and the one remaining piece of native code still using it.
    scriptified DropInventory.
    scriptified UseInventory and several functions using the already scriptified ones,
    scriptified TakeInventory, including the ACS/FS interfaces.
    scriptified RemoveInventory and Inventory.OnDestroy.
    scriptified GiveInventory and made the interface a bit more configurable by mods.

    Now a child type can decide for itself how to treat 'amount'.
    The scripting interfaces to this function in ACS and FraggleScript have been consolidated and also scriptified.
    scriptified AddInventory.
    added a second version of Hacx's MAP05 to the compatibility fixer list.
    fixed character to int conversion for UTF8-characters.
    Added a flag to make bouncing objects disappear when hitting sky surfaces
    Exported AActor::Grind to ZScript.
    cleaned up the sound options menu.

    There were still some leftover definitions from FMod and far too many things were at the top level. Anything non-essential has been moved to the "Advanced Sound Options" submenu and the pointless sound backend switch has been removed entirely.
    fixed declaration of ChangeStatNum.
    use psprite renderstyle on HUD models
    fixed: P_Recalculate3DFloors may not be called before the vertex buffer has been set up.
    explicitly declare the constructor and destructor methods of FCheckPosition so that they get a working prototype.
    Fixed textures on the two switches that rise from the floor in the eastern area of TNT MAP31
    fixed spelling (mostly comments)
    fixed the mapping of additive translucency to color-based translucency.

    The destination mode sould be 'One', not 'InvSrcColor'.
    Now both of these are available as explicit modes, not just through the optional mapping.
    only do shade clamps if needed
    move the jit runtime to its own file
    use SSE for the dynlights
    use SSE for the normal walls
    finished adding direct native functions to vmthunks.cpp.
    change DrawSpanOpt32 to render a scanline in multiple steps as the speed is about the same and it will make it easier to use SSE for each of the steps
    moved VM thunks from p_sectors.cpp to a separate file and started adding direct native implementations.

    For a few larger functions I took them out of sector_t and made them global functions to avoid creating more unnecessary stubs.
    fixed handling of dummy flags.
    allow defining flags in the script declaration of a class and do that for Weapon.
    moved MarkPrecacheSounds completely to the script side and added native support to make this a usable feature.
    some cleanup on the weapon slot interface.

    This really shouldn't make any decisions from directly reading weapon class defaults.
    scriptified cht_Takeweaps.
    removed the less-parameters versions of P_SpawnPlayerMissile, because there was only one native call left to them.
    scriptified ApplyKickback.
    moved the kickback code in P_DamageMobj into a subfunction.

    This is a first attempt to reduce the complexity of that 600+ lines monstrosity, and also a good first target for scriptification.
    scriptified A_WeaponReady and its subfunctions.
    fixed: When extracting a MiniBSP for polyobject rendering, the parent subsector must copy all its relevant properties to the children.
    scriptified P_BobWeapon as a virtual function on PlayerPawn.
    a little bit of cleanup on some code that repeatedly accessed some fields in AWeapon and produced far too many search results when looking for this.
    removed the bot related properties from AWeapon.

    This stuff is now kept locally in the bot code so that it doesn't infest the rest of the engine.
    And please don't read the new botsupp.txt file as some new means to configure bots! This was merely done to get this data out of the way.
    The bots are still broken beyond repair and virtually unusable, even if proper data is provided for all weapons.
    consolidated the 3 nearly identical code fragments handling the weapon's YAdjust for the different renderers into a utility function in DPSprite.
    exported the blood spawning part of P_LineAttack as a virtual ZScript function.
    moved the weapon selection logic to PlayerPawn as overridable virtual functions.
    took the weapon selection logic out of the WeaponSlots data and blocked all direct access to the weapon slots internals

    This seriously needs to be independent from the data store and better abstracted. More work to come to move this to its proper place.
    change teleport freeze handling to a player property plus virtual override on PlayerPawn for increased configurability.
    removed MeleeWeapon flag from the tomed PhoenixRod and the fighterhammer.

    In both cases, having this flag on will render the monster-backing-off-check for melee attacks ineffective because it would misinterpret these weapons as close range only - which they aren't. Even for the PhoenixRod the range is longer than what gets checked here.
    As a consequence, the bot's check for missile shooting melee weapons has also become pointless because no such weapon is defined anymore.
    exported one FraggleScript function for testing.
    exported a few more weapon handling functions so that the native GetDownState stub could be removed.
    let player_t::Resurrect use P_BringUpWeapon to raise the weapon again instead of doing it directly.
    add monster tags (Friendly Names) for Hexen
    tnt1a0 is not a png, rename it in gzdoom.pk3
    scriptified A_FireBullets and A_CustomBulletAttack.
    deleted redundant native ActivateMorphWeapon method.
    started with a ScriptUtil class which will allow moving function implementations for ACS and FraggleScript to zscript.txt

    So far 3 functions for testing implemented.
    made ZRock4 solid like in vanilla Hexen
    fixed: Since out types cannot be marked as such in a function prototype (as it'd cause parameter mismatches in the resolving pass) it is necessary to check the argflags as well when determining the register type.
    Fix null pointer access in p_terrain.cpp
    expose defaultbloodcolor to ZScript.
    made CDoomError inherit from std::exception so that the main catch block can also deal with exceptions thrown by the STL.
    Also do not ignore empty exception messages as irrelevant. The only irrelevant exception type is CNoRunExit.
    fixed initialization of default parameters in dynamically created function calls like in the MENUDEF parser
    fix a rendering glitch when changing resolution
    add NUMA awareness to drawer threads
    Add shader cache for Intel GPU's which should result in faster startups (especially on Windows) - first startup will still be slower, though
    interpolate the normal for models
    removed the quite redundant GetStateForButtonName function

    Since it forwards directly to FindState and has no script bindings there is no need to keep it, it'd only complicate the full scriptification of the weapon class if it stuck around.
    fixed some issues with the bodyque and moved this variable into FLevelLocals
        it was never saved in savegames, leaving the state of dead bodies undefined
        it shouldn't be subjected to pointer substitution because all it contains is old dead bodies, not live ones.
    fixed: Ceiling render hack segments were inserted into the floor list and incorrectly rendered.
    fixed the type checks for object arrays.

    Null pointers must be allowed and non-object pointers which are not null must be explicitly checked for because the code could crash on them when performing a static_cast on an incorrect type.
    P_Thing_Raise fixes & cleanup
        Transfer flags directly into the function and process inside instead of the action functions
        Pass in raiser for all function calls
    restored the old A_Jump prototype because DECORATE needs this to parse the arguments.
    fixed: FTexture::SmoothEdges must forward its result to the base texture in case a redirection is in effect.

    Both need the bMasked flag, or some code will think that the texture is not fully opaque if no holes were found.
    use the same formula for calculating 3DMidTex offsets as the renderer when per-sidedef scaling is used.
    fixed stencil cap generation for old hardware and changed it so that it only gets done once for each stencil setup, not for each stencil pass.
    fixed: CVar.ResetToDefault was missing a check for use outside of menus.
    add warning text when falling back to the VM
    changed PhosphorousFire.DoSpecialDamage to match SVE's handling:

        Everything with a damage factor for fire only uses that.
        Everything that bleeds takes half damage
        Robots take quarter damage.
    fixed: AActor' friction field was not saved
    Readonly pointer casting now works in ZScript.
    corrected A_DropFire for real, using the SVE source as reference.
    fixed: A_DropFire accidentally cleared the XF_HURTSOURCE flag by setting only XF_NOSPLASH.
    Make BounceFlags 32 bit wide.
    BOUNCEONUNRIPPABLES flag; makes actors bounce on actors with DONTRIP flag
    changed the stencil cap drawer to only cover the area which is actually used by the portal.

    This will now both exclude floor caps when only ceiling elements are used and everything outside the bounding box of active portal lines.
    Hopefully this is enough to fix the issues with portal caps but of course it is not foolproof if someone just makes the right setup.
    went back to the original portal stencil setup from 3.4.0.

    The main reason is to unify the portal hierarchy again. The split into a hardware independent and a hardware dependent part turned out to be unnecessary and complicated matters.
    Another issue was that the new stencil setup code was having a few subtle problems, so this recreates the original ones with indirect API calls.
    P_Thing_Raise returned true while P_Thing_CanRaise returned false for the condition of having no raise state. P_Thing_Raise now returns false.
    Added RaiseActor(Actor other, int flags = 0)
    Added CanResurrect(Actor other, bool passive)
    fixed: ZScript's finalization code used the last parsed lump for of one translation unit as reference, not the base lump.

    This resulted in incorrect messages but also could produce some more subtle errors.
    added ZScript export for side_t::SetSpecialColor.
    more options for Doom 64 style gradients on walls:

        Colors can now be defined per sidedef, not only per sector.
        Gradients can be selectively disabled or vertically flipped per wall tier.
        Gradients can be clamped to their respective tier, i.e top and bottom of the tier, not the front sector defines where it starts.

    The per-wall colors are implemented for hardware and softpoly renderer only, but not for the classic software renderer, because its code is far too scattered to do this efficiently.
    Fixed: Decal generator should be taken from the current weapon instance instead of the default instance.
    do not abort on unclosed sections.

    Apparently they can indeed happen with broken map setups like isolated linedefs somewhere in the wild (see Strife MAP08.)
    Although they are a problem for triangulation, this isn't what sections get used for currently so it's of no real concern.
    In case this is needed later their work data gets marked as 'bad' for the time being.
    fixed: It may happen that a degenerate subsector ends up without any section or sector. Try to assign the best fit in such a case so that the relevant pointers are not null.
    instead of copying the sector planes to GLWall, just store pointers to the front and back sector for later use.

    Until now this wasn't doable because these could have come from hw_FakeFlat which only were local copies on the stack.
    With the recent change these faked sectors live long enough so that they can be passed around here.
    cache the results of hw_FakeFlat for the remainder of the current scene instead of storing this in local variables.

    An exception is made for the sprite drawer which needs to call this in the worker thread on some occasions for as-yet unprocessed sectors.
    This case may not alter the cache to avoid having to add thread synchronization to it.

    The main reason for this change is that pointers to such manipulated sectors can now be considered static in the renderer.
    Due to them being short lived local buffers it was not possible to carry them along with the render data for information retrieval.
    Added DMG_NO_ENHANCE for DamageMobj. - Disables PowerDamage's effect, similar to DMG_NO_PROTECT disabling PowerProtect.
    replaced a few temporary allocations with TArray and added a few convenience loader functions for this.

    Amazingly with today's optimizers this creates code which is just as good as doing it all manually with the added benefit of being safer.
    hole filling subsectors must also be explicitly triangulated for the automap because they may be non-convex.
    clear spechit before leaving P_CheckPosition.

    Otherwise this may contain residual data from the last call.
    One can only hope that this doesn't cause other side effects - this entire code is one horrendous mess of bad ideas.
    Added IsPointInMap(Vector3 p).
    added copyright header to p_destructible.cpp
    fixed typo with RNG name.
    silenced debug message in standard mode.
    Added destructible geometry, exported to ZScript
    fixed typo in sight checking code.
    disabled the hack for fixing the original design of the portal in KDiZD's Z1M1.

    This portal got fixed in a later re-release of KDiZD and no other portal needs this runtime fix to my knowledge.
    The main problem here is that this runtime fix requires some manipulation of the render data that does not work anymore.

    Should other maps need this fix as well they are probably best served with a compatibility entry.
    Added a function to get the actor's age in ticks.
    Added a new field to the Actor class which stores the amount of ticks passed since the game started on the moment the actor was spawned.
    Added a function to the Actor class to get its spawn time relative to the current level.
    Added spawn time information to the output of the "info" console command.
    Extend SKYEXPLODE flag for LineAttack
    use Xcode 10.1 for Travis CI builds
    restored screen clear in Cocoa backend when setting video mode

    This still doesn't work well in windowed mode
    In fullscreen the effect is quite noticeable thought
    added a method to FileReader to read the contents into an array and used it on the MIDI sources for testing.
    added warning for constant conditional expression

    ZScript code like `if (x = 0) // ...` no longer causes assertion failure in Debug but produces a warning regadless of configuration

    viewtopic.php?t=62422
    fixed potential crash when drawing status bar log
    prevented GME compilation warning spam with Clang
    versioned the return mismatch check to demote it to a warning for older versions than 3.7.
    made 'return void' case a compilation error
    added far stronger restrictions for when the Boom-Texture-Y-offset compatibility flag may trigger.

    This had absolutely no sanity checks and unconditionally picked the source texture if one existed.
    It should only be done for wall textures, only for those defined in TEXTUREx and only for those where the scale is identical with the underlying texture.
    fixed: Do not pass Sysex messages to Windows's GS Wavetable synth.

    This will totally refuse to play a MIDI if that happens.
    Duke Nukem's Alienz.mid, which did not play before works after this change.
    added fake vid_renderer CVAR so that mods that checked for it to determine the renderer will get 1 returned instead of 0.

    The majority of mods which did such a thing checked for the hardware renderer so this should be the default.
    fixed: P_DamageMobj should clear reactiontime only for non-players.

    For players this variable has an entirely different meaning which does not agree with being modified here.
    made DBrokenLines serializable.
    fixed handling of wrapped midtextures to be actually useful when used in sky sectors.
    Export AllClasses
    Update GME up to 0.6.2 version
    changed the way alpha works on DrawLine and DrawThickLine so they're consistent
    Added VelIntercept.
        Uses the same code as Thing_ProjectileIntercept to aim and move the projectile.
            targ: The actor the caller will aim at.
            speed: Used for calculating the new angle/pitch and adjusts the speed accordingly. Default is -1 (current speed).
            aimpitch: If true, aims the pitch in the travelling direction. Default is true.
            oldvel: If true, does not replace the velocity with the specified speed. Default is false.
    Split the code from Thing_ProjectileIntercept and have that function call VelIntercept.
    Fixed sector floor/ceiling actions not triggering in P_XYMovement
    Introduced an enum named EventHandlerType and changed the bool argument in E_NewGame to this type.
    Static NewGame events now fire before loading a map, and normal NewGame events fire after registering per-map handlers and before all other events.
    Static event handlers now unregister after per-map handlers.
    All event handlers now unregister in reverse order.
    added a non-multithreaded option for the renderer and fixed a few places where the wrong sector was used

    The render_sector is only relevant for flats, but never for walls or sprites!
    added option to disable alpha testing for user shaders.
    fixed missing binding of the light buffer.

    I thought this wasn't needed but apparently the buffer refactoring caused this not to be done automatically anymore.
    Best have it once at the start of each frame where the cost is negligible.
    use standard sprite lighting for voxels.

    Per-pixel lighting requires normals which voxels do not have.
    removed memcpy workarounds from GLWall, GLFlat and GLSprite after making sure that all 3 are trivially copyable.
    fixed error message for old OpenGL versions. There was still a mention of "with framebuffer support" which is core in 3.3.
    added a bit of profiling code to the multithreaded parts of the renderer.
    GL renderer is now partly multi-threaded
    added a few comments to the renderstate to document where certain functions are used.
    fixed stencil marking for SSAO.
    cleanup of the buffer binding interface.

    Some stuff is not really needed and the vertex buffers no longer need to insert themselves into the render state.
    cleanup of hw_bsp.cpp.
    add "neutral" gender option and better obit formatting
    removed the Bind function from FFlatVertexBuffer.
    uncoupled texture precaching from regular binding for rendering.

    The precaching should not depend on code that may be subject to change.
    basic multithreading for the render data generation.
    do a texture check when drawing fog borders in the software renderer. this does not fix the crash issue, but mitigates it enough with a check that likely should be in place, anyhow.
    moved the entire OpenGL backend into a separate namespace.
    fixed dynamic light profiling counters.

    The draw counters were never incremented and this should be reset only once per scene, not once per viewpoint.
    portal refactoring
    fix softpoly bug where sprites and translucent walls in front of models would disappear
    portal check is overridden by a different inverted check in the software renderer
    Cull two-sided lines using the same rules as the software renderer is using (as suspicious as they may be)
    fixed default values for S_ChangeMusic

    viewtopic.php?t=62323#p1076849
    added a compatibility fix for Hacx's MAP05.

    This is by no means perfect and looks different than what was originally intended, but at least this doesn't totally fail to render properly with the OpenGL renderer.
    fixed: attaching a new status bar to a player now calls 'setsizeneeded' - fixes an issue where the screen geometry is out of sync with the characteristics of the new status bar.
    fix distance attenuation for PBR materials
    Visually align Doom 2 MAP04 crusher floors

    Use Transfer_Heights to fake floors on the crusher sectors
    Preserve line locknumber in savegames.
    fixed: use 'setsizeneeded' more often in the scaling code. recalculating screen geometry for 2D elements when it changes never really hurts.
    Fixed many IWAD mapping errors
    Exported PickNewWeapon function from PlayerPawn to ZScript.

GZDoom 3.6.0
--------------------------------------------------------------------------------
*Wed Oct 10, 2018 9:22 pm*

Highlights:

* Add OBJ model support
* added Screen.DrawThickLine for drawing lines with thickness
* fixed: sound from poly objects through portals will now propegate properly
* Add HITOWNER flag, when set, allows a projectile to collide with its shooter.
* Allow LineAttack's LAF_NOINTERACT to fill FTranslatedLineTarget's information.
* Added DMG_EXPLOSION flag.
* Adds OnDrop virtual to inventory items. Called on the dropped item at the end of AActor::DropInventory.
* enabled the linear shadowmap filter.
* update xBRZ upscaler to version 1.6
* (modern only) added 5x and 6x upscaling with xBRZ
* Add 'normalNx' texture scaling (normal2x, 3x, 4x, 5x, and 6x) (5x and 6x only supported in modern)
* Upgrade libADLMIDI and libOPNMIDI
* Exports various resurrection-related functions to ZScript.
* Fixes for Wraith Corporation WADs

Details:

* Additional blocking-related flags for Actor.LineTrace()
* Added CheckReplacement to event handlers, a function inspired by its namesake in Unreal's Mutator class.
* Add "IsFinal" parameter for CheckReplacement.
* Add HITOWNER flag, when set, allows a projectile to collide with its shooter.
* support static const arrays inside structs
* prohibit assignment of dynamic arrays
* Add ZScript method `LevelLocals.SphericalCoords`.
* fixed: sound from poly objects through portals will now propegate properly
* defaulted constructors and assignment operators of several trivial types.
* removed most of the old LastIndexOf methods in FString, only leaving one for ZScript and clearly giving it a name that says it all. RIndexOf has been made the proper version of LastIndexOf internally now.
* Added paths for all games on Steam for Linux since they now offer the ability to download all games for Proton/Wine.
* Check ~/.steam on Linux for the config.
* add menu sliders for `vr_ipd` and `vr_screendist`
* added Screen.DrawThickLine for drawing lines with thickness
* fixed: always initialize active colors in special font
* update french language translation from Tapwave
* Add OBJ model support
* fixed the use of Doom-Legacy-style 3D floor lighting in light mode 8.
* fixed math imprecisions in horizon vertex generation.
* be more thorough with 'in menu' checks for certain protected functions.
* Fixed code generation of infinite for loop
* Add NewGame to EventHandler
* Make StatusScreen::End virtual
* Allow LineAttack's LAF_NOINTERACT to fill FTranslatedLineTarget's information.
* Added DMG_EXPLOSION flag.
* do not render lights from uninitialized data.
* Adds OnDrop virtual to inventory items. Called on the dropped item at the end of AActor::DropInventory.
* clamp the software light to never get brighter than the initial light level
* enabled the linear shadowmap filter.
* update xBRZ upscaler to version 1.6
* (modern only) added 5x and 6x upscaling with xBRZ
* Add 'normalNx' texture scaling (normal2x, 3x, 4x, 5x, and 6x) (5x and 6x only supported in modern)
* Upgrade libADLMIDI and libOPNMIDI
* Exports various resurrection-related functions to ZScript.
* Computed facet normals for UE1 models were not normalized when they were supposed to.
* removed dynamic lights from Hexen's Mana pickups.
* fixed potential null pointer access in Hexen's spike code.
* Fixes for Wraith Corporation WADs
* fixed: smooth teleporters could fudge the player over an adjacent line, causing the player to appear on top of a cliff that is much higher than the original teleport.
* fixed: MD3s with a skin-less surface left the renderer in an undefined state. The frame interpolation factor wasn't reset and rendering prematurely aborted with no chance to recover.



GZDoom 3.5.1
--------------------------------------------------------------------------------
* Sat Aug 25, 2018 8:19 pm*

Notice: This release has been split into two. There is now a "modern" version and a "vintage" version, for older hardware. The reason for this is that some recent changes to improve performance on modern hardware resulted in quite severe slowdowns on Intel's OpenGL 2 hardware. So in order to give these users the best possible experience it was decided to provide this vintage build which adds all new non-renderer-related features with the latest state of the renderer from before the abovementioned change. The vintage version is provided thanks to the efforts of drfrag.

Please note that this solution is only a temporary measure. User share of OpenGL 2 hardware had already been low when we ran our survey with GZDoom 3.3 and once this drops any further the vintage build will be discontinued. If you cannot run the main (modern) build we strongly recommend to upgrade your hardware.

Please note that the survey is now closed. GZDoom 3.5.1 does not include the survey code that 3.5.0 did.

Highlights:

* Implemented "resolution mode selector"
* add post processing support to the software renderer and softpoly
* add vid_hdr cvar that enables higher than 8bpc output for monitors that support it
* fix: softpoly TEXTURES sprites with scale of 2 are tiled
* add dithering support to emulate higher BPC displays than your real one. this should allow smoother gradients for light fades and such.
* Make various getter and pure-math Actor methods clearscope.

Details:

* add vid_hdr cvar that enables higher than 8bpc output for monitors that support it
* fix: softpoly TEXTURES sprites with scale of 2 are tiled
* Implemented "resolution mode selector"
* add post processing support to the software renderer and softpoly
* Fix model rendering only using interpolated yaw. Pitch and roll are now also interpolated.
* add dithering support to emulate higher BPC displays than your real one. this should allow smoother gradients for light fades and such.
* clear GLWF_TRANSLUCENT at the end of PutWall.
* fixed FraggleScript's moving camera.
* Make various getter and pure-math Actor methods clearscope.
* disable runtime buffer security check in release build.
* prohibit assignment of dynamic arrays
* Avoid overriding vr eye-specific buffer binding during 2D rendering.
* only render visual portals if they are front facing in softpoly
* disable survey code, 3.5.0's is over
* got rid of FNameNoInit and made the default constructor of FName non-initializing.
* Add the "RightIndexOf" method to FString, which works like String.lastIndexOf from JavaScript
* Deprecate the LastIndexOf method of StringStruct

GZDoom 3.5.0
--------------------------------------------------------------------------------
*Mon Jul 30, 2018 1:49 pm*

Notice: This release has been split into two. There is now a "modern" version and a "vintage" version, for older hardware. The reason for this is that some recent changes to improve performance on modern hardware resulted in quite severe slowdowns on Intel's OpenGL 2 hardware. So in order to give these users the best possible experience it was decided to provide this vintage build which adds all new non-renderer-related features with the latest state of the renderer from before the abovementioned change. The vintage version is provided thanks to the efforts of drfrag.

Please note that this solution is only a temporary measure. User share of OpenGL 2 hardware had already been low when we ran our survey with GZDoom 3.3 and once this drops any further the vintage build will be discontinued. If you cannot run the main (modern) build we strongly recommend to upgrade your hardware.

To get a proper baseline here this version re-enables the survey code from GZDoom 3.3 with slightly more detailed statistics. Unfortunately recent developments made the information about used graphics hardware a bit too coarse and does not really help assessing the real need and extent of providing vintage support, so this one sends a bit more detailed information about the graphics hardware being used, in particular the precise OpenGL version being used.
You will be prompted for opt-in just as before (but your last preference will be remembered, if you ran a version that used it previously).

Highlights:

* (modern branch only) Fullscreen is now borderless window (which, technically, it always has been, anyhow). Removed hacks which changed the desktop resolution in order to simulate exclusive fullscreen because they were a constant stability concern.
* (modern branch only) fixed a performance regression with the software renderer, introduced by the recent changes to the video backend in 3.4.
* Save item statistics - Items are now saved into save games and are displayed on the statfile
* Upgrade libADLMIDI and libOPNMIDI
* Large number of MinGW fixes
* add tags for all Doom and Heretic monsters for mods that reveal monster names
* various compatibility fixes for old maps and mods
* fixed titlepic animation
* Custom hardware shaders now can use custom texture units
* default to "fullscreen" display
* fixed a potential exploit with malformed WAD files. Thanks to xanaxdev ( th0razine@ret2p.lt ) for reporting it.

Details:

* fixed: redirect script access to the compatflags CVARs to their internal shadow variables. This is needed so that MAPINFO settings for these flags don't get ignored.
* enable model rendering in the software renderer
* fixed: flag CVars in ZScript referenced wrong addresses
* fixed: ZScript used the wrong variable for compatflags2. The variable it accessed was only the settings from the compatibility.txt lump.
* fixed: remove ARM specific gl_es definition since it's not even really much different from the main line definition, anyhow
* fixed generation of brightmaps for sprites. This forgot to take the added empty border for filtering improvement into account.
* fixed: ADynamicLight's shadowmap index must be reset when loading a savegame. (this fixes lights not rendering properly when loading)
* fixed portal restoration on revisiting level in hub. Added function to test if map is being reentered
* (modern branch only) render refactorings and fixes, use uniform blocks for postprocessing shaders to prepare for move to vulkan
* (modern branch only) Remove all code to handle OpenGL 2 and <3.3.
* (modern branch only) Force render buffers to always be active
* (modern branch only) Fullscreen is now borderless window (which, technically, it always has been, anyhow). Removed hacks which changed the desktop resolution in order to simulate exclusive fullscreen.
* Save item statistics - Items are now saved into save games and are displayed on the statfile
* Fixed: End of file detection in MAPINFO parser was not correct - It should check for the special "End" flag instead of trusting that if the last token was a closing brace, all was correct. This can fail if the last token in a multiline string is a brace.
* Large number of MinGW fixes
* Don't let DEarthquake depend on r_viewpoint. - The ticFrac value should be passed as a parameter, especially since this gets called from code that sets up r_viewpoint.
* Fixed: DBaseStatusBar::Draw did not use its ticFrac parameter when being called from scripts - Instead it directly went to the global viewpoint again which would be inconsistent.
* Upgrade libADLMIDI and libOPNMIDI
* disable the wipe code entirely when a stereo3D mode is active.
* add tags for all Doom and Heretic monsters for mods that reveal monster names
* (Mac and Linux) fixed excess keyboard events in Cocoa and SDL backend
* UE1 model fixes and code cleanup
* various compatibility fixes for old maps and mods
* player setup backdrop now uses a CC0 texture, instead of the procedural one generated from ZDoom
* fixed titlepic animation
* Custom hardware shaders now can use custom texture units
* rewrite the user shader support for materials - new syntax is to create a 'Material ProcessMaterial()' function
* re-enabled stats sending
* (modern only) Add vid_setsize <x> <y> to adjust the window size
* Add vid_setscale <x> <y> [bool linear] [bool fake 10:12] to adjust the virtual resolution inside the window.
* fixed: vid_showcurrentscaling now always shows the correct window geometry and virtual scaling geometry
* scaling code now always requires GZDoom to output at least 320x200 to prevent assertion failures
* fixed missing decals on 3D floors with hardware renderer
* disable any texture clamping for textures with a user shader.
* fixed: The BossCube must account for its target being gone.
* default to "fullscreen" display
* fixed buffer overflow in saved game comment
* fixed: A global variable was used to pass MeansOfDeath to ClientObituary. Now it passes this value through the intermediate Actor.Die method.
* allow skipping optional arguments of the parent function in a virtual override definition. - This is mainly to allow retroactive addition to existing virtual functions without breaking existing content. The MeansOfDeath fix for Actor.Die would not be possible without such handling.

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