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

actor = {}
actor_head = {}
actor_node = {}
actor_node_icon = {}
actor_weapon = {}
actor_weapon_attach = {}

forge_num = 0
forge_model = {}
forge_fx = {}

player_health = 50
player_spawn = {}

timescale = 1
dvarlistener_interval = 100

precache_weapons()
precache_playermodels()
precache_playeranimations()
precache_fx()
precache_materials()

level:onnotify("connected", player_connected)
game:setdvar("scr_war_timelimit", 0)
game:setdvar("scr_dm_timelimit", 0)
game:setdvar("sv_cheats", 1)
