function actordestroy(player)
	-- Destroy an actor
	local num = tonumber(game:getdvar("sly_actor_destroy"))
	game:setdvar("sly_actor_destroy", "actor#")

	actor_pants[num]:delete()
	actor_eyewear[num]:delete()
	actor_hat[num]:delete()
	actor_gear[num]:delete()
	actor_exo[num]:delete()
	actor_kneepads[num]:delete()
	actor_gloves[num]:delete()
	actor_shoes[num]:delete()
	actor_head[num]:delete()
	actor_weapon[num]:delete()
	actor_weapon_attach[num]:delete()
	actor[num]:delete()
end

function actorcreate(player)
	-- Create an actor
	local num = tonumber(game:getdvar("sly_actor_create"))
	game:setdvar("sly_actor_create", "actor#")

	if num >= 1 and num <= 10 then
		if actor[num] ~= nil then
			actor[num]:delete()
		end
		if actor_head[num] ~= nil then
			actor_head[num]:delete()
		end
		if actor_eyewear[num] ~= nil then
			actor_eyewear[num]:delete()
		end
		if actor_hat[num] ~= nil then
			actor_hat[num]:delete()
		end
		if actor_pants[num] ~= nil then
			actor_pants[num]:delete()
		end
		if actor_gear[num] ~= nil then
			actor_gear[num]:delete()
		end
		if actor_exo[num] ~= nil then
			actor_exo[num]:delete()
		end
		if actor_kneepads[num] ~= nil then
			actor_kneepads[num]:delete()
		end
		if actor_gloves[num] ~= nil then
			actor_gloves[num]:delete()
		end
		if actor_shoes[num] ~= nil then
			actor_shoes[num]:delete()
		end

		if actor_weapon[num] ~= nil then
			actor_weapon[num]:delete()
		end
		if actor_weapon_attach[num] ~= nil then
			actor_weapon_attach[num]:delete()
		end
		actor[num] = game:spawn("script_model", player.origin)
		actor[num].origin = player.origin
		actor[num].angles = player.angles
		actor[num]:setmodel("mp_top_m_a_01a")
		actor[num]:scriptmodelplayanim("mp_stand_idle")
		actor[num]:enablelinkto()
		
		-- head correct
		actor_head[num] = game:spawn("script_model", actor[num]:gettagorigin("j_spine4"))
		actor_head[num]:linkto(actor[num], "j_spine4", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_head[num]:setmodel("mp_head_cormack")
		actor_head[num]:scriptmodelplayanim("mp_stand_idle")

		-- eyewear correct
		actor_eyewear[num] = game:spawn("script_model", actor[num]:gettagorigin("j_head"))
		actor_eyewear[num]:linkto(actor[num], "j_head", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_eyewear[num]:setmodel("mp_eyewear_01a_cormack")

		-- hat correct
		actor_hat[num] = game:spawn("script_model", actor[num]:gettagorigin("j_head"))
		actor_hat[num]:linkto(actor[num], "j_head", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_hat[num]:setmodel("mp_headgear_01a_cormack")

		-- pants
		actor_pants[num] = game:spawn("script_model", actor[num]:gettagorigin("j_mainroot"))
		actor_pants[num]:linkto(actor[num], "j_mainroot", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_pants[num]:setmodel("mp_pants_m_01b_k")
		actor_pants[num]:scriptmodelplayanim("mp_stand_idle")

		-- kneepads
		actor_kneepads[num] = game:spawn("script_model", actor[num]:gettagorigin("j_mainroot"))
		actor_kneepads[num]:linkto(actor[num], "j_mainroot", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_kneepads[num]:setmodel("mp_kneepad_03a")
		actor_kneepads[num]:scriptmodelplayanim("mp_stand_idle")

		-- gloves
		actor_gloves[num] = game:spawn("script_model", actor[num]:gettagorigin("pelvis"))
		actor_gloves[num]:linkto(actor[num], "pelvis", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_gloves[num]:setmodel("mp_glove_03a")
		actor_gloves[num]:scriptmodelplayanim("mp_stand_idle")

		-- shoes
		actor_shoes[num] = game:spawn("script_model", actor[num]:gettagorigin("pelvis"))
		actor_shoes[num]:linkto(actor[num], "pelvis", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_shoes[num]:setmodel("mp_boot_01a")
		actor_shoes[num]:scriptmodelplayanim("mp_stand_idle")

		-- gear
		actor_gear[num] = game:spawn("script_model", actor[num]:gettagorigin("pelvis"))
		actor_gear[num]:linkto(actor[num], "pelvis", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_gear[num]:setmodel("mp_loadouts_m_01a")
		actor_gear[num]:scriptmodelplayanim("mp_stand_idle")

		-- exo
		actor_exo[num] = game:spawn("script_model", actor[num]:gettagorigin("pelvis"))
		actor_exo[num]:linkto(actor[num], "pelvis", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_exo[num]:setmodel("mp_exo_01a")
		actor_exo[num]:scriptmodelplayanim("mp_stand_idle")

		--actor_weapon[num] = game:spawn("script_model", actor[num]:gettagorigin("j_gun"))
		--actor_weapon[num]:linkto(actor[num], "j_gun", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))

		local fx = game:spawnfx(forge_fx["3dping"], actor[num].origin)
		game:triggerfx(fx)

		player:iprintln("^7Actor ^:" .. num .. "^7 created.")
	elseif num > 10 then
		player:iprintln("You can only create 10 actors.")
	end
end

function actorcreatemb(player)
	-- Create an actor
	local num = tonumber(game:getdvar("sly_actor_createmb"))
	game:setdvar("sly_actor_createmb", "actor#")

	if num >= 1 and num <= 10 then
		if actor[num] ~= nil then
			actor[num]:delete()
		end
		if actor_head[num] ~= nil then
			actor_head[num]:delete()
		end
		if actor_eyewear[num] ~= nil then
			actor_eyewear[num]:delete()
		end
		if actor_hat[num] ~= nil then
			actor_hat[num]:delete()
		end
		if actor_pants[num] ~= nil then
			actor_pants[num]:delete()
		end
		if actor_gear[num] ~= nil then
			actor_gear[num]:delete()
		end
		if actor_exo[num] ~= nil then
			actor_exo[num]:delete()
		end
		if actor_kneepads[num] ~= nil then
			actor_kneepads[num]:delete()
		end
		if actor_gloves[num] ~= nil then
			actor_gloves[num]:delete()
		end
		if actor_shoes[num] ~= nil then
			actor_shoes[num]:delete()
		end

		if actor_weapon[num] ~= nil then
			actor_weapon[num]:delete()
		end
		if actor_weapon_attach[num] ~= nil then
			actor_weapon_attach[num]:delete()
		end

		actor[num] = game:spawn("script_model", player.origin)
		actor[num].origin = vector:new(player.origin.x,player.origin.y,player.origin.z + 5)
		actor[num].angles = player.angles
		actor[num]:setmodel("vehicle_urb_police_hoverbike_ai")
		actor[num]:scriptmodelplayanim("urban_hoverbike_idle")
		actor[num]:enablelinkto()

		actor_head[num] = game:spawn("script_model", actor[num]:gettagorigin("tag_player"))
		actor_head[num]:linkto(actor[num], "tag_player", vector:new(-10, 0, 47), vector:new(0, 90, 0))
		actor_head[num]:setmodel("urb_hoverbike_rider")
		actor_head[num]:scriptmodelplayanim("urban_hoverbike_racer_2")

		local fx = game:spawnfx(forge_fx["3dping"], actor[num].origin)
		game:triggerfx(fx)

		player:iprintln("^7Actor ^:" .. num .. "^7 created.")
	elseif num > 10 then
		player:iprintln("You can only create 10 actors.")
	end
end

function actorsetmodel(player)
	-- Create an actor
	local getdvarargs = splitStr(game:getdvar("sly_actor_model"))
	game:setdvar("sly_actor_model", "actor# body head")
	local num = tonumber(getdvarargs[1])

	if #getdvarargs == 2 then
		if actor_head[num] ~= nil then
			actor_head[num]:delete()
		end
		actor[num]:setmodel(getdvarargs[2])
	elseif #getdvarargs == 3 then
		if actor_head[num] ~= nil then
			actor_head[num]:delete()
		end
		actor[num]:setmodel(getdvarargs[2])
		actor_head[num] = game:spawn("script_model", actor[num]:gettagorigin("j_spine4"))
		actor_head[num]:linkto(actor[num], "j_spine4", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_head[num]:setmodel(getdvarargs[3])
	end
end

function actoranimation(player)
	-- Sets actor animation
	local getdvarargs = splitStr(game:getdvar("sly_actor_animation"))
	game:setdvar("sly_actor_animation", "actor# animation")
	local num = tonumber(getdvarargs[1])

	if #getdvarargs == 2 then
		if actor_head[num] ~= nil then
			actor_head[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_pants[num] ~= nil then
			actor_pants[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_eyewear[num] ~= nil then
			actor_eyewear[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_hat[num] ~= nil then
			actor_hat[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_gear[num] ~= nil then
			actor_gear[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_exo[num] ~= nil then
			actor_exo[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_kneepads[num] ~= nil then
			actor_kneepads[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_gloves[num] ~= nil then
			actor_gloves[num]:scriptmodelplayanim(getdvarargs[2])
		end
		if actor_shoes[num] ~= nil then
			actor_shoes[num]:scriptmodelplayanim(getdvarargs[2])
		end
		actor[num]:scriptmodelplayanim(getdvarargs[2])
	end
end

function actormove(player)
	-- Moves the actor across their two nodes
	local getdvarargs = splitStr(game:getdvar("sly_actor_move"))
	game:setdvar("sly_actor_move", "actor# #")

	if #getdvarargs == 2 then
		local num = tonumber(getdvarargs[1])
		local speed = tonumber(getdvarargs[2])

		actor[num].origin = actor_node[num][1].origin
		actor[num].angles = actor_node[num][1].angles

		actor[num]:moveto(actor_node[num][2].origin, speed, 0, 0)
		actor[num]:rotateto(actor_node[num][2].angles, speed, 0, 0) --rotateto
	elseif #getdvarargs == 4 then
		local num = tonumber(getdvarargs[1])
		local speed = tonumber(getdvarargs[2])
		local accel = tonumber(getdvarargs[3])
		local deccel = tonumber(getdvarargs[4])

		actor[num].origin = actor_node[num][1].origin
		actor[num].angles = actor_node[num][1].angles

		actor[num]:moveto(actor_node[num][2].origin, speed, accel, deccel)
		actor[num]:rotateto(actor_node[num][2].angles, speed, accel, deccel) --rotateto
	end
end

function actorfx(player)
	-- Plays fx on the actor's tag
	local getdvarargs = splitStr(game:getdvar("sly_actor_fx"))
	game:setdvar("sly_actor_fx", "actor# fx tag")

	local num = tonumber(getdvarargs[1])
	if #getdvarargs == 2 then
		local fx = game:spawnfx(forge_fx[getdvarargs[2]], actor[num]:gettagorigin("tag_origin"))
		game:triggerfx(fx)
	elseif #getdvarargs == 3 then
		local fx = game:spawnfx(forge_fx[getdvarargs[2]], actor[num]:gettagorigin(getdvarargs[3]))
		game:triggerfx(fx)
	end
end

function actorsetweapon(player)
	-- Sets the actor's weapon on j_gun
	local getdvarargs = splitStr(game:getdvar("sly_actor_weapon"))
	game:setdvar("sly_actor_weapon", "actor# gun camo")

	local num = tonumber(getdvarargs[1])
	if #getdvarargs == 2 then
		-- no camo selected
		if actor_weapon[num] ~= nil then
			actor_weapon[num]:delete()
		end
		if actor_weapon_attach[num] ~= nil then
			actor_weapon_attach[num]:delete()
		end
		actor_weapon[num] = game:spawn("script_model", actor[num]:gettagorigin("j_gun"))
		actor_weapon[num]:linkto(actor[num], "j_gun", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_weapon[num]:setmodel(getdvarargs[2])
	elseif #getdvarargs == 3 then
		-- camo selected
		if actor_weapon[num] ~= nil then
			actor_weapon[num]:delete()
		end
		if actor_weapon_attach[num] ~= nil then
			actor_weapon_attach[num]:delete()
		end
		actor_weapon[num] = game:spawn("script_model", actor[num]:gettagorigin("j_gun"))
		actor_weapon[num]:linkto(actor[num], "j_gun", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_weapon[num]:setmodel(game:getweaponmodel(getdvarargs[2]))
	end
end

function actorsetnode(player)
	local getdvarargs = splitStr(game:getdvar("sly_actor_node"))
	game:setdvar("sly_actor_node", "actor# #")

	local actornum = tonumber(getdvarargs[1])
	local nodenum = tonumber(getdvarargs[2])

	if #getdvarargs == 2 and actor[actornum] ~= nil then
		if nodenum >= 1 and nodenum <= 2 then
			if actor_node[actornum] == nil then
				actor_node[actornum] = {}
				actor_node_icon[actornum] = {}
				player:iprintln("actor node created")
			end
			if actor_node[actornum][nodenum] ~= nil then
				actor_node[actornum][nodenum]:delete()
				actor_node_icon[actornum][nodenum]:destroy()
				player:iprintln("actor node exists, deleting...")
			end

			-- create actor node
			actor_node[actornum][nodenum] = game:spawn("script_model", player.origin)
			actor_node[actornum][nodenum].origin = player.origin
			actor_node[actornum][nodenum].angles = player.angles

			-- create actor node icon
			actor_node_icon[actornum][nodenum] = game:newhudelem()
			actor_node_icon[actornum][nodenum].x = actor_node[actornum][nodenum].origin.x
			actor_node_icon[actornum][nodenum].y = actor_node[actornum][nodenum].origin.y
			actor_node_icon[actornum][nodenum].z = actor_node[actornum][nodenum].origin.z
			actor_node_icon[actornum][nodenum]:setshader("ui_reticle_dlc_10", 15, 15)
			actor_node_icon[actornum][nodenum]:setwaypoint(true)

			local fx = game:spawnfx(forge_fx["3dping"], actor_node[actornum][nodenum].origin)
			game:triggerfx(fx)
		else
			player:iprintln("You can only create two nodes!")
		end
	else
		player:iprintln("No node selected!")
	end
end

function actorattach(player)
	local getdvarargs = splitStr(game:getdvar("sly_actor_attach"))
	game:setdvar("sly_actor_attach", "actor# model tag")

	if #getdvarargs == 3 then
		local num = tonumber(getdvarargs[1])
		local weaponmodel = getdvarargs[2]
		local tag = getdvarargs[3]

		if actor_weapon_attach[num] ~= nil then
			actor_weapon_attach[num]:delete()
		end

		actor_weapon_attach[num] = game:spawn("script_model", actor_weapon[num]:gettagorigin(tag))
		actor_weapon_attach[num]:linkto(actor_weapon[num], tag, vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_weapon_attach[num]:setmodel(weaponmodel)

		--actor_weapon_attach[num] = game:spawn("script_model", actor_weapon[num]:gettagorigin("tag_acog_2"))
		--actor_weapon_attach[num]:linkto(actor_weapon[num], "tag_acog_2", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		--actor_weapon_attach[num]:setmodel("weapon_acog_iw6")
	end
end