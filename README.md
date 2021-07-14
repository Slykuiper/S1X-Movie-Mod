# S1x Movie Mod

This is my S1x Movie Making Mod. Free to download or use code snippets in your own mod, I encourage you to learn and get into coding to have more control over your cinematics (and modding is rewarding). Mod is provided as-is, support won't be provided if you DM or reach out for support.  

There is no actual Theater Mode or demo system in Advanced Warfare. All cinematics created with this mod are recorded live in-game.  

### Installation
Download S1x at https://xlabs.dev/s1x_download.  
Download [this mod](https://github.com/Slykuiper/S1X-Movie-Mod/archive/refs/heads/main.zip) and put the **slymvm** folder in `\[rootfolder]\S1x\scripts\`. Create the scripts folder if it's missing.

### Reshade
S1x is confirmed to work with Reshade 4.9.1. It may not work with other versions. Right click on s1x.exe and create a shortcut, add `-multiplayer` to the target and click Apply. Turn Post Processing Anti-Aliasing to Off in the Advanced Video Settings. 

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

Command | Usage | Description
------------ | ------------- | -------------  
sly_player_add |`sly_player_add 4` | Adds designer number of bots to your match.
fast_restart | Restarts the game instantly | `fast_restart`
god | Gives you infinite health | `god`
noclip | Noclip | `noclip`

### Dolly Camera

### Spawning Models & Effects

### Actors

### Misc & Util Functions
