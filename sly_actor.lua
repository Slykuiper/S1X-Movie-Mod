function actordestroy(player)
	-- Destroy an actor
	local num = tonumber(game:getdvar("sly_actor_destroy"))
	game:setdvar("sly_actor_destroy", "actor#")

	actor[num].origin = nil
	actor[num].angles = nil
	actor[num].model = nil
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
		if actor_weapon[num] ~= nil then
			actor_weapon[num]:delete()
		end
		if actor_weapon_attach[num] ~= nil then
			actor_weapon_attach[num]:delete()
		end
		actor[num] = game:spawn("script_model", player.origin)
		actor[num].origin = player.origin
		actor[num].angles = player.angles
		actor[num]:setmodel(player:getcustomizationbody())
		actor[num]:enablelinkto()
		actor_head[num] = game:spawn("script_model", actor[num]:gettagorigin("j_spine4"))
		actor_head[num]:linkto(actor[num], "j_spine4", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))
		actor_head[num]:setmodel(player:getcustomizationhead())

		actor_weapon[num] = game:spawn("script_model", actor[num]:gettagorigin("j_gun"))
		actor_weapon[num]:linkto(actor[num], "j_gun", vector:new(0.0, 0.0, 0.0), vector:new(0.0, 0.0, 0.0))

		actor[num]:scriptmodelplayanim("mp_stand_idle")
		actor_head[num]:scriptmodelplayanim("mp_stand_idle")

		--local fx = game:spawnfx(forge_fx["3dping"], actor[num].origin)
		--game:triggerfx(fx)

		player:iclientprintln("^7Actor ^:", num, "^7 created.")
	elseif num > 10 then
		player:iclientprintln("You can only create 10 actors.")
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
		actor[num]:rotateto(actor_node[num][2].angles, speed, 0, 0)
	elseif #getdvarargs == 4 then
		local num = tonumber(getdvarargs[1])
		local speed = tonumber(getdvarargs[2])
		local accel = tonumber(getdvarargs[3])
		local deccel = tonumber(getdvarargs[4])

		actor[num].origin = actor_node[num][1].origin
		actor[num].angles = actor_node[num][1].angles

		actor[num]:moveto(actor_node[num][2].origin, speed, accel, deccel)
		actor[num]:rotateto(actor_node[num][2].angles, speed, accel, deccel)
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
				print("actor node created")
			end
			if actor_node[actornum][nodenum] ~= nil then
				actor_node[actornum][nodenum]:delete()
				actor_node_icon[actornum][nodenum]:destroy()
				print("actor node exists, deleting...")
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
			actor_node_icon[actornum][nodenum]:setmaterial("ui_reticle_dlc_10", 15, 15)
			actor_node_icon[actornum][nodenum]:setwaypoint(true)

			--local fx = game:spawnfx(forge_fx["3dping"], actor_node[actornum][nodenum].origin)
			--game:triggerfx(fx)
		else
			player:iclientprintln("You can only create two nodes!")
		end
	else
		player:iclientprintln("No node selected!")
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