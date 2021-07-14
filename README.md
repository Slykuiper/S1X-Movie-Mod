# S1x Movie Mod
[![IMAGE ALT TEXT HERE](https://i.ytimg.com/vi/MSp49m0rm3g/maxresdefault.jpg)](https://www.youtube.com/watch?v=MSp49m0rm3g)


This is my S1x Movie Making Mod. Free to download or use code snippets in your own mod, I encourage you to learn and get into coding to have more control over your cinematics (and modding is rewarding). Mod is provided as-is, support won't be provided if you DM or reach out for support. Check out the [IW6X Scripting Guide](https://github.com/XLabsProject/iw6x-client/wiki/Scripting) for a great overview of LUA scripting for IW6x and S1x.  

There is no actual Theater Mode or demo system ([confirmed](https://youtu.be/iki-tcDYsi0?t=29)) in Advanced Warfare. All cinematics created with this mod are recorded live in-game with FRAPS or OBS.  

### Installation
Download S1x at https://xlabs.dev/s1x_download.  
Download [this mod](https://github.com/Slykuiper/S1X-Movie-Mod/archive/refs/heads/main.zip) and put the **slymvm** folder in `\[rootfolder]\S1x\scripts\`. Create the scripts folder if it's missing.

### Reshade
S1x is confirmed to work with Reshade 4.9.1. It may not work with other versions. Create a shortcut and launch S1x that way if you want to use Reshade. Right click on s1x.exe and create a shortcut, add `-multiplayer` to the target and click Apply. Turn Post Processing Anti-Aliasing to Off in the Advanced Video Settings. **Reshade only works in private match**, any shaders using a depth pass (like Depth of Field) won't work on dedicated servers.

# Commands
This mod has a ton of commands, I'll try and highlight them all but feel free to look at the code to see how they're written in-case I leave out any parameters.

### Default Commands
Useful commands that exist in the game that'll help with movie making.  
Use Shift + tilde to view the extended in-game console.

Command | Usage | Description
------------ | ------------- | -------------  
listassetpool | `listassetpool 40 mors` |  Lists loaded in-game assets, can be filtered with keys. `listassetpool 40 mors` would return all of the MORS sniper rifle variants.
fast_restart | `fast_restart` | Restarts the game instantly.
god | `god` | Gives you unlimited health.
noclip | `noclip` | Allows you to move freely through objects.
spawnbot | `spawnbot` | Adds bots to your match. `spawnbot` will add one bot. `spawnbot 7` will add 7 bots.
kick | `kick RezTech` | Kicks a bot or player from your match.
give | `give iw5_morsloot9_mp` | Gives you a specified weapon.


### S1x Movie Mod Commands
By default player health is set to 50 to one-shot kill with snipers.
You can edit the default player health by changing `player_health = 50` in `__init__.lua`  
You can precache effects, models, animations, and materials by adding them in `sly_precache.lua`  

### Players / Bots
Player & Bot names are case sensitive.
Command | Usage | Description
------------ | ------------- | -------------  
sly_player_add `number` |`sly_player_add 4` | Adds designated number of bots to your match.
sly_player_kick `name` | `sly_player_kick RezTech` | Kicks a player from your match. `sly_player_kick all` will kick all players.
sly_player_kill `name` | `sly_player_kill RezTech` | Kills a player. `sly_player_kill all` will kill all players.
sly_player_move `name` | `sly_player_move RezTech` | Moves a player to your location. `sly_player_move all` will move all players to your location.
sly_player_freeze `name` | `sly_player_freeze RezTech` | Freezes a player so they can't move or shoot. `sly_player_freeze all` will freeze all players. This is great when getting cinematics with bots to control if/when you want their AI & pathing to work.
sly_player_unfreeze `name` | `sly_player_unfreeze RezTech` | Unfreezes a player, allowing them to move and shoot. `sly_player_unfreeze all` will unfreeze all players.
sly_player_health `name number`| `sly_player_health RezTech 50` | Set's a player's health. `sly_player_health all 50` will give all players except host the desired health. **Currently not working.**
sly_player_weapon `name weapon_name`| `sly_player_weapon RezTech iw5_morsloot9_mp` | Gives a player a specific weapon. **Currently only works on players, not bots.**
sly_player_model `name model_name`| `sly_player_model RezTech infected` | Set's a player's model. It's not fully developed, "infected" works since it's a single model but other models don't work since a player's "costume" consists of multiple parts and is set a different way. 
sly_player_getcostume `name`| `sly_player_getcostume RezTech` | Saves a player's costume. Not too useful for the average user, but a useful function for saving costumes created in the Armory. `sly_player_getcostume RezTech all` will save all of the player's costumes (they have 4) to the `slymvm\costumes\` folder.
sly_player_setcostume `name costume_name`| `sly_player_setcostume RezTech boxer` | Set's a player's costume. Costumes aren't loaded on the fly, you need to `fast_restart` for it to take effect. **Currently only works for host**.  
sly_player_clone `name clone_name`| `sly_player_clone RezTech MOD_SUICIDE` | Clone's a player. Using without a second variable (`sly_player_clone RezTech`), a spawn basic clone on the player, good for clearing ragdolls and dead bodies. Using a second variable will trigger a random death animation from an array of specific dead animations. See the table below for a list of useful clone types or check **line 27** of `sly_player.lua` for a full list. I added an optional hit-location argument which may affects how which death animation gets triggered. Usage `sly_player_clone RezTech MOD_IMPACT right_hand`. Check **line 59** of `sly_player.lua` for a full list. 
​ | `sly_player_clone RezTech clear` | Spawns 9 ragdolls on the player. Useful for clearing all ragdolls near players.
​ | `sly_player_clone RezTech MOD_GRENADE` | Spawns a ragdoll with an explosive death animation on the player. Similar to , MOD_PROJECTIVE, MOD_PROJECTIVE_SPLASH, and MOD_EXPLOSIVE.
​ | `sly_player_clone RezTech MOD_SUICIDE` | Spawns a typical death animation on the player.
​ | `sly_player_clone RezTech MOD_SUICIDE` | Spawns a death animation on the player, occasionally headshot-related.


### Dolly Camera

### Spawning Models & Effects

Command | Usage | Description
------------ | ------------- | -------------  
sly_forge_model `model` | `sly_forge_model defaultactor` | Spawns a model on your location. Use `listassetpool 7` with a key to find desired models. Most models need to be precached, do so in the **precache_models()** function in `sly_precache.lua` 
sly_forge_fx `effect` | `sly_forge_fx blood2` | Spawns an effect in front of you. Use `listassetpool 42` with a key to find desired effects and define them in the **precache_fx()** function in `sly_precache.lua`

### Actors
I tried pretty hard to make "actors" a thing, but the way costumes work make it a bit complicated. Left the code in for people to tinker with, I'll share my research below.

### Misc & Util Functions
Random debug or useful functions I made. Changing these would be a great start to tinkering with modding.
Command | Usage | Description
------------ | ------------- | -------------  
sly_function savepos | `sly_function savepos` | Saves your position.
sly_function loadpos | `sly_function loadpos` | Loads your position to the saved location.
sly_function cloak | `sly_function cloak` | Cloaks the player.
sly_function camera | `sly_function camera` | Alternate bind instead of noclip
sly_function timescale | `sly_function timescale` | Useful bind that toggles between timescale 1 and 0.1
sly_timescale `number` | `sly_timescale timescale` | Set the timescale.
sly_function fovscale | `sly_function fovscale` | Useful bind that toggles between multiple fovscale values: `1, 0.3, 0.5, and 0.7` Modify to suit your needs
sly_function get `key` | `sly_function get` | Returns specific player variables. Some keys: `origin, health, team, score, model, angles`
sly_function notify `key` | `sly_function notify beziercalc_finished` | Calls the notify() function with a specific key. Useful for debugging.
sly_function unlink | `sly_function unlink` | Unlinks you from any linked entities. Great if you're stuck in a camera path.
sly_function dropweapon | `sly_function dropweapon` | Drops your current weapon. Great for getting a weapon's pullout animation for clips. 
sly_function icon `material` | `sly_function icon headicon_dead` | Creates a waypoint hud element at your feet with a desired material. 
sly_function vision `vision_name` | `sly_function vision` | Sets the player's vision to a desired vision. Some visions: `default, black_bw, aftermath, end_game, near_death_mp`
sly_function motorbike | `sly_function motorbike` | I was testing spawning functioning vehicles. This is super jank and only works on Urban. F to enter/exit, Sprint to drive
