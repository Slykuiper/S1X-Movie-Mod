# S1x Movie Mod

This is my S1x Movie Making Mod. Free to download or use code snippets in your own mod, I encourage you to learn and get into coding to have more control over your cinematics (and modding is rewarding). Mod is provided as-is, support won't be provided if you DM or reach out for support.  

There is no actual Theater Mode or demo system in Advanced Warfare. All cinematics created with this mod are recorded live in-game.  

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
listassetpool | `listassetpool 40 mors` |  Lists loaded in-game assets, can be filtered with keys. `listassetpool 40 mors` would return all of the MORS sniper rifle variants
fast_restart | `fast_restart` | Restarts the game instantly
god | `god` | Gives you unlimited health
noclip | `noclip` | Allows you to move freely through objects
spawnbot | `spawnbot` | Adds bots to your match. `spawnbot` will add one bot. `spawnbot 7` will add 7 bots
kick | Kicks a bot or player from your match. | `kick RezTech`


### S1x Movie Mod Commands
By default player health is set to 50 to one-shot kill with snipers.
You can edit the default player health by changing `player_health = 50` in `__init__.lua`  
You can precache effects, models, animations, and materials by adding them in `sly_precache.lua`  

### Players / Bots
Player & Bot names are case sensitive.
Command | Usage | Description
------------ | ------------- | -------------  
sly_player_add `number` |`sly_player_add 4` | Adds designer number of bots to your match.
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


### Dolly Camera

### Spawning Models & Effects

### Actors

### Misc & Util Functions
# S1x Movie Mod

This is my S1x Movie Making Mod. Free to download or use code snippets in your own mod, I encourage you to learn and get into coding to have more control over your cinematics (and modding is rewarding). Mod is provided as-is, support won't be provided if you DM or reach out for support.  

There is no actual Theater Mode or demo system in Advanced Warfare. All cinematics created with this mod are recorded live in-game.  

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
listassetpool | `listassetpool 40 mors` |  Lists loaded in-game assets, can be filtered with keys. `listassetpool 40 mors` would return all of the MORS sniper rifle variants
fast_restart | `fast_restart` | Restarts the game instantly
god | `god` | Gives you unlimited health
noclip | `noclip` | Allows you to move freely through objects
spawnbot | `spawnbot` | Adds bots to your match. `spawnbot` will add one bot. `spawnbot 7` will add 7 bots
kick | Kicks a bot or player from your match. | `kick RezTech`


### S1x Movie Mod Commands
By default player health is set to 50 to one-shot kill with snipers.
You can edit the default player health by changing `player_health = 50` in `__init__.lua`  
You can precache effects, models, animations, and materials by adding them in `sly_precache.lua`  

### Players / Bots
Player & Bot names are case sensitive.
Command | Usage | Description
------------ | ------------- | -------------  
sly_player_add `number` |`sly_player_add 4` | Adds designer number of bots to your match.
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


### Dolly Camera

### Spawning Models & Effects

### Actors

### Misc & Util Functions
