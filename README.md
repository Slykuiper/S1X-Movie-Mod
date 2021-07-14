# S1X Movie Mod

This is my S1X Movie Making Mod. Free to download or use code snippets in your own mod, I encourage you to learn and get into coding to have more control over your cinematics. This mod was made There's a lot to this mod so I'll try and sum it up as best I can.

### Notes
Mod is provided as-is. Support won't be provided if you DM or reach out for support.  
There is no actual Theater Mode or demo system in Advanced Warfare. All cinematics created with this mod are recorded live in-game.  
Shoutout to the hard work from Snake and others who created IW4X\IW6X\S1X

### Installation
Download S1X at https://xlabs.dev/s1x_download
Download the files and put the **slymvm** folder in `\[rootfolder]\S1x\scripts\`. If the scripts folder is missing you can create it.

### Reshade
S1x is confirmed to work with Reshade 4.9.1. It may not work with other versions. Right click on s1x.exe and create a shortcut, add -multiplayer to the target and click Apply. Turn Post Processing Anti-Aliasing to Off in the Advanced Video Settings. 

# Commands
This mod has a ton of commands, I'll try and highlight them all but feel free to look at the code to see how they're written in-case I leave out any parameters.

### Default Commands
Useful commands that exist in the game that'll help with movie making

listassetpool
fast_restart
You can edit the default player health by changing `player_health = 50` in `__init__.lua`. By default player's health is set to 50 to one-shot kill with snipers.
