function player_connected(player)
	table.insert(players, player)

	for i, p in ipairs(players) do
        if player:getentitynumber() == 0 then
			print(player.name .. " is host!")
            setdvars(player)
			dvarlistener(player)
        end
    end

    player:onnotify("spawned_player", function() player_spawned(player) end)
	player:onnotifyonce("disconnect", function ()
        for i, p in ipairs(players) do
            if p == player then
                table.remove(players, i)
                break
            end
        end
    end)
end

function player_spawned(player)
	for i, p in ipairs(players) do
        if player:getentitynumber() == 0 then
            player:freezecontrols(false)
			game:setdvar("cg_fov", 90)
			game:setdvar("cg_fovscale", 1)
			game:setdvar("cg_draw2d", 1)
			game:setdvar("cg_drawgun", 1)
		else
			player.health = player_health
			if player_spawn[player.name] ~= nil then
				player:setorigin(player_spawn[player.name].origin)
				player:setangles(player_spawn[player.name].angles)
				player:freezecontrols(true)
			end
        end
    end
end

function setdvars(player)
	-- set dvar hints
	game:setdvarifuninitialized("sly_actor_animation", "Play an animation on an actor." )
	game:setdvarifuninitialized("sly_actor_attach", "Attach a model to an actor on a tag." )
	game:setdvarifuninitialized("sly_actor_attach_animation", "Animate an attached model." )
	game:setdvarifuninitialized("sly_actor_detach", "Detach an attached model." )
	game:setdvarifuninitialized("sly_actor_clone", "Clone a player's attributes to an actor." )
	game:setdvarifuninitialized("sly_actor_create", "Create an actor." )
	game:setdvarifuninitialized("sly_actor_createmb", "Create an actor on a motorbike." )
	game:setdvarifuninitialized("sly_actor_destroy", "Destroy an actor." )
	game:setdvarifuninitialized("sly_actor_fx", "Play an effect on an actor's tag." )
	game:setdvarifuninitialized("sly_actor_model", "Set the actor's model." )
	game:setdvarifuninitialized("sly_actor_move", "Move an actor across it's nodes." )
	game:setdvarifuninitialized("sly_actor_node", "Set an actor's nodes." )
	game:setdvarifuninitialized("sly_actor_weapon", "Set an actor's weapon." )
	game:setdvarifuninitialized("sly_cam_mode", "Set the camera's type and speed." )
	game:setdvarifuninitialized("sly_cam_node", "Create a camera node." )
	game:setdvarifuninitialized("sly_cam_rotate", "Rotate your view angle." )
	game:setdvarifuninitialized("sly_forge_model", "Spawn a model on your origin.")
	game:setdvarifuninitialized("sly_forge_fx", "Spawn an effect on your origin.")
	game:setdvarifuninitialized("sly_function", "Call a function.")
	game:setdvarifuninitialized("sly_player_add", "Add a player")
	game:setdvarifuninitialized("sly_player_clone", "Play an animation on a player.")
	game:setdvarifuninitialized("sly_player_kill", "Kill a player.")
	game:setdvarifuninitialized("sly_player_weapon", "Give a player a weapon.")
	game:setdvarifuninitialized("sly_player_kick", "Kick a player.")
	game:setdvarifuninitialized("sly_player_move", "Move a player to your location.")
	game:setdvarifuninitialized("sly_player_freeze", "Freeze a player.")
	game:setdvarifuninitialized("sly_player_unfreeze", "Unfreeze a player.")
	game:setdvarifuninitialized("sly_player_setcostume", "Set a player's costume.")
	game:setdvarifuninitialized("sly_player_getcostume", "Get a player's costume.")
	game:setdvarifuninitialized("sly_player_model", "Change a player's model.")
	game:setdvarifuninitialized("sly_player_health", "Change player's health.")
	game:setdvarifuninitialized("sly_timescale", "Set the timescale.")
	game:setdvarifuninitialized("sly_entarray", "Print Entity Array")

	-- set dvars
	game:setdvar("sly_actor_animation", "actor# animation" )
	game:setdvar("sly_actor_attach", "actor# model tag" )
	game:setdvar("sly_actor_attach_animation", "actor# # animation" )
	game:setdvar("sly_actor_detach", "actor# #" )
	game:setdvar("sly_actor_clone", "actor# player" )
	game:setdvar("sly_actor_create", "actor#" )
	game:setdvar("sly_actor_createmb", "actor#" )
	game:setdvar("sly_actor_destroy", "actor#" )
	game:setdvar("sly_actor_fx", "actor# fx tag" )
	game:setdvar("sly_actor_model", "actor# body head" )
	game:setdvar("sly_actor_move", "actor# #" )
	game:setdvar("sly_actor_node", "actor# #" )
	game:setdvar("sly_actor_weapon", "actor# gun camo" )
	game:setdvar("sly_cam_mode", "linear/bezier/clear/save/load/path, speed" )
	game:setdvar("sly_cam_node", "#" )
	game:setdvar("sly_cam_rotate", "#" )
	game:setdvar("sly_forge_model", "model")
	game:setdvar("sly_forge_fx", "fx")
	game:setdvar("sly_function", "function")
	game:setdvar("sly_player_add", "#")
	game:setdvar("sly_player_clone", "player type")
	game:setdvar("sly_player_kill", "player")
	game:setdvar("sly_player_weapon", "player gun")
	game:setdvar("sly_player_kick", "player")
	game:setdvar("sly_player_move", "player")
	game:setdvar("sly_player_freeze", "player")
	game:setdvar("sly_player_unfreeze", "player")
	game:setdvar("sly_player_setcostume", "player costume value")
	game:setdvar("sly_player_getcostume", "player")
	game:setdvar("sly_player_model", "player model")
	game:setdvar("sly_player_health", "player health")
	game:setdvar("sly_timescale", "timescale")
	game:setdvar("sly_entarray", "string1 string2")
end

function dvarlistener(player)
	function listener_callback()
		if game:getdvar("sly_actor_animation") ~= "actor# animation" then
			actoranimation(player)
		elseif game:getdvar("sly_actor_attach") ~= "actor# model tag" then
			actorattach(player)
		elseif game:getdvar("sly_actor_attach_animation") ~= "actor# # animation" then
			-- 
		elseif game:getdvar("sly_actor_detach") ~= "actor# #" then
			-- 
		elseif game:getdvar("sly_actor_clone") ~= "actor# player" then
			-- 
		elseif game:getdvar("sly_actor_create") ~= "actor#" then
			actorcreate(player)
		elseif game:getdvar("sly_actor_createmb") ~= "actor#" then
			actorcreatemb(player)
		elseif game:getdvar("sly_actor_destroy") ~= "actor#" then
			actordestroy(player)
		elseif game:getdvar("sly_actor_fx") ~= "actor# fx tag" then
			actorfx(player)
		elseif game:getdvar("sly_actor_model") ~= "actor# body head" then
			actorsetmodel(player)
		elseif game:getdvar("sly_actor_move") ~= "actor# #" then
			actormove(player)
		elseif game:getdvar("sly_actor_node") ~= "actor# #" then
			actorsetnode(player)
		elseif game:getdvar("sly_actor_weapon") ~= "actor# gun camo" then
			actorsetweapon(player)
		elseif game:getdvar("sly_cam_mode") ~= "linear/bezier/clear/save/load/path, speed" then
			setcameramode(player)
		elseif game:getdvar("sly_cam_node") ~= "#" then
			setcameranode(player)
		elseif game:getdvar("sly_cam_rotate") ~= "#" then
			setcamerarotation(player)
		elseif game:getdvar("sly_forge_fx") ~= "fx" then
			spawnforgeeffect(player)
		elseif game:getdvar("sly_forge_model") ~= "model" then
			spawnforgemodel(player)
		elseif game:getdvar("sly_function") ~= "function" then
			callfunction(player)
		elseif game:getdvar("sly_player_add") ~= "#" then
			playeradd(player)
		elseif game:getdvar("sly_player_clone") ~= "player type" then
			playerclone(player)
		elseif game:getdvar("sly_player_kill") ~= "player" then
			playerkill(player)
		elseif game:getdvar("sly_player_move") ~= "player" then
			playermove(player)
		elseif game:getdvar("sly_player_freeze") ~= "player" then
			playerfreeze(player)
		elseif game:getdvar("sly_player_unfreeze") ~= "player" then
			playerunfreeze(player)
		elseif game:getdvar("sly_player_setcostume") ~= "player costume value" then
			setplayercostume(player)
		elseif game:getdvar("sly_player_getcostume") ~= "player" then
			getplayercostume(player)
		elseif game:getdvar("sly_player_weapon") ~= "player gun" then
			playerweapon(player)
		elseif game:getdvar("sly_player_kick") ~= "player" then
			playerkick(player)
		elseif game:getdvar("sly_player_model") ~= "player model" then
			playermodel(player)
		elseif game:getdvar("sly_player_health") ~= "player health" then
			playerhealth(player)
		elseif game:getdvar("sly_timescale") ~= "timescale" then
			setTimescale(player)
		elseif game:getdvar("sly_entarray") ~= "string1 string2" then
			printarray(player)
		end
	end

	local timer = game:oninterval(listener_callback, dvarlistener_interval)

    player:onnotifyonce("disconnect", function() timer:clear() end)
end

function callfunction(player)
	-- Calls variation functions that don't require variables
	-- Good for testing functions
	local getdvarargs = splitStr(game:getdvar("sly_function"))
	game:setdvar("sly_function", "function")

	if getdvarargs[1] == "savepos" then
		savePosition(player)
	elseif getdvarargs[1] == "loadpos" then
		loadPosition(player)
	elseif getdvarargs[1] == "ammo" then
		giveAmmo(player)
	elseif getdvarargs[1] == "get" then
		player:iclientprintln("^:", player:get(getdvarargs[2]))
	elseif getdvarargs[1] == "unlink" then
		unlinkplayer(player)
	elseif getdvarargs[1] == "notify" then
		player:notify(getdvarargs[2])
	elseif getdvarargs[1] == "give" then
		player:takeweapon(player:getcurrentweapon())
		player:giveweapon(getdvarargs[2], 0, true, -1, false)
		giveAmmo(player)
		player:switchtoweapon(getdvarargs[2])
	elseif getdvarargs[1] == "dropweapon" then
		player:iclientprintln("^7Weapon ^:dropped^7: " .. player:getcurrentweapon())
		local item = player:dropitem(player:getcurrentweapon())
	elseif getdvarargs[1] == "icon" then
		if #getdvarargs == 2 then
			if testhud ~= nil then
				testhud:destroy()
			end
			testhud = game:newhudelem()
			testhud.x = player.origin.x
			testhud.y = player.origin.y
			testhud.z = player.origin.z
			testhud:setmaterial(getdvarargs[2], 35, 35)
			testhud:setwaypoint(true)
		elseif #getdvarargs == 4 then
			if testhud ~= nil then
				testhud:destroy()
			end
			testhud = game:newhudelem()
			testhud.x = player.origin.x
			testhud.y = player.origin.y
			testhud.z = player.origin.z
			testhud:setmaterial(getdvarargs[2], getdvarargs[3], getdvarargs[4])
			testhud:setwaypoint(true)
		end
	elseif getdvarargs[1] == "vision" then
		player:visionsetnakedforplayer(getdvarargs[2])
	elseif getdvarargs[1] == "cloak" then
		player:cloakingenable()
	elseif getdvarargs[1] == "camera" then
		if camera == 1 then
			game:setdvar("cg_draw2d", 1)
			game:setdvar("cg_drawgun", 1)
			game:executecommand("noclip")
			camera = 0
		else
			game:setdvar("cg_draw2d", 0)
			game:setdvar("cg_drawgun", 0)
			game:executecommand("noclip")
			camera = 1
		end
	elseif getdvarargs[1] == "timescale" then
		if timescaletoggle == 1 then
			game:setdvar("sly_timescale", 1)
			timescaletoggle = 0
		else
			game:setdvar("sly_timescale", 0.1)
			timescaletoggle = 1
		end
	elseif getdvarargs[1] == "fovscale" then
		if fovscaletoggle == 3 then
			game:setdvar("cg_fovscale", 1)
			player:iclientprintln("^7Fovscale: ^:" .. 1)
			fovscaletoggle = 0
		elseif fovscaletoggle == 2 then
			game:setdvar("cg_fovscale", 0.3)
			player:iclientprintln("^7Fovscale: ^:" .. 0.3)
			fovscaletoggle = 3
		elseif fovscaletoggle == 1 then
			game:setdvar("cg_fovscale", 0.5)
			player:iclientprintln("^7Fovscale: ^:" .. 0.5)
			fovscaletoggle = 2
		else
			game:setdvar("cg_fovscale", 0.7)
			player:iclientprintln("^7Fovscale: ^:" .. 0.7)
			fovscaletoggle = 1
		end
	elseif getdvarargs[1] == "motorbike" then
		if game:getdvar("mapname") == "mp_urban" then
			spawnmotorbike(player)
		else 
			player:iclientprintln("^7Change the map to ^:mp_urban")
		end
	elseif getdvarargs[1] == "getplayerinfo" then
		if #getdvarargs == 2 then
			for i, player in ipairs(players) do
				if player.name == getdvarargs[2] then
					getplayerinfo(player)
				end
			end 
		end
	end
end
