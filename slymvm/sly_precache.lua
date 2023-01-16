function precache_weapons()
	game:precachemodel("npc_sentry_minigun_base")
	game:precachemodel("tag_player")
	game:precachemodel("defaultactor")
end

function precache_models()
	--[[
	game:precachemodel("mp_top_m_a_01a")
	game:precachemodel("mp_head_cormack")
	game:precachemodel("mp_pants_m_01b_k")
	game:precachemodel("mp_eyewear_01a_cormack")
	game:precachemodel("mp_headgear_01a_cormack")
	game:precachemodel("mp_loadouts_m_01a")
	game:precachemodel("mp_kneepad_03a")
	game:precachemodel("mp_glove_03a")
	game:precachemodel("mp_boot_01a")
	game:precachemodel("mp_exo_01a")
	game:precachemodel("urb_hoverbike_rider")
	game:precachemodel("vehicle_urb_police_hoverbike_ai")
	]]--
end

function precache_animations()
	game:precachempanim("urban_hoverbike_idle")
	game:precachempanim("urban_hoverbike_racer_1")
	game:precachempanim("urban_hoverbike_racer_2")
	game:precachempanim("pb_sprint_hold")
	game:precachempanim("mp_stand_idle")
	--[[
	game:precachempanim("mp_stand_idle")
	game:precachempanim("mp_pistol_sprint")
	game:precachempanim("pb_stand_death_lowerback")
	game:precachempanim("pb_stand_death_head_collapse")
	game:precachempanim("pb_stand_death_neckdeath_thrash") -- nice
	-- death animations
	
	game:precachempanim("pb_stand_death_nervedeath")
	game:precachempanim("pb_stand_death_headchest_topple")
	game:precachempanim("pb_stand_death_chest_blowback")
	game:precachempanim("pb_stand_death_chest_spin") -- nice
	game:precachempanim("pb_stand_death_shoulder_stumble")
	game:precachempanim("pb_stand_death_shoulderback") -- nice
	-- idle animations
	-- sprint animations
	game:precachempanim("pb_sprint_hold")
	game:precachempanim("pb_sprint_lmg")
	game:precachempanim("pb_sprint_smg")
	game:precachempanim("pb_sprint_assault")
	game:precachempanim("pb_sprint_sniper")
	game:precachempanim("pb_sprint_shotgun")
	]]--
end

function precache_fx()
	-- effects
	forge_fx["blood1"] = game:loadfx("vfx/weaponimpact/flesh_impact_blood_splat_med")
	forge_fx["blood2"] = game:loadfx("vfx/weaponimpact/flesh_impact_blood_spurt_med")
	forge_fx["3dping"] = game:loadfx("vfx/code/exo_slam_impact")
	forge_fx["motorbike1"] = game:loadfx("vfx/code/high_jump_exo_land_light")
end

function precache_materials()
	-- materials
	game:precacheshader("white")
	game:precacheshader("headicon_dead")
end