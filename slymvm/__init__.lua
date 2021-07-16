json = require("libs.json")
include("sly_main")
include("sly_utils")
include("sly_precache")
include("sly_player")
include("sly_forge")
include("sly_actor")
include("sly_camera")

print("==============================================")
print("Slykuiper's S1x Movie Making Mod")
print("==============================================")

-- define global variables
players = {}

camera_null = game:spawn("script_model", vector:new(0.0, 0.0, 0.0))
camera_null:setmodel("tag_origin")
camera_node = {}
camera_node_icon = {}
camera_node_model = {}
camera_node_path_model = {}
camera_node_last = 0
camera_node_alldist = 0
camera_node_partdist = {}
camera_node_angledist = {}
camera_flight = false

actor = {}
actor_head = {}
actor_pants = {}
actor_eyewear = {}
actor_hat = {}
actor_gear = {}
actor_exo = {}
actor_kneepads = {}
actor_gloves = {}
actor_shoes = {}
actor_weapon = {}
actor_weapon_attach = {}
actor_node = {}
actor_node_icon = {}

actor_test = {}

forge_num = 0
forge_model = {}
forge_fx = {}

player_health = 50
player_spawn = {}

timescale = 1
dvarlistener_interval = 100

camera = 0
timescaletoggle = 0

fovscaletoggle = 3

playercostume = {}
--playercostume[0] = "gender"
--playercostume[0] = "head"
playercostume[1] = "eyewear"
playercostume[2] = "hat"
playercostume[3] = "shirt"
playercostume[4] = "gear"
playercostume[5] = "gloves"
playercostume[6] = "pants"
playercostume[7] = "kneepads"
playercostume[8] = "shoes"
playercostume[9] = "exo"

precache_weapons()
precache_models()
precache_animations()
precache_fx()
precache_materials()

level:onnotify("connected", player_connected)
game:setdvar("scr_war_timelimit", 0)
game:setdvar("scr_war_scorelimit", 0)
game:setdvar("scr_dm_timelimit", 0)
game:setdvar("scr_dm_scorelimit", 0)
game:setdvar("scr_game_grappling_hook", 1)
game:setdvar("sv_cheats", 1)