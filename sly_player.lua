function playerclone(player)
	-- Clones player
	local getdvarargs = splitStr(game:getdvar("sly_player_clone"))
	game:setdvar("sly_player_clone", "player type")
	
	if #getdvarargs == 1 then
		for i, player in ipairs(players) do
			if player.name == getdvarargs[1] then
				local body = player:cloneplayer(10)
				body:startragdoll()
			end
		end   
	elseif #getdvarargs == 2 then
		if getdvarargs[2] == "clear" then
			for i, player in ipairs(players) do
				if player.name == getdvarargs[1] then
					for i=1,9 do local body = player:cloneplayer(10) body:startragdoll() end
				end
			end
		else
			local sMeansOfDeath = getdvarargs[2] -- reason of death
			local sWeapon = player:getcurrentweapon() -- weapon used
			local sWaitTime = 4000 -- time to wait before showing
			local sHitLoc = "head" -- hit location
			local vDir = vector:new(0,0,0) -- hitlocation

			--[[ sMeansOfDeath
				MOD_UNKNOWN, MOD_PISTOL_BULLET, MOD_RIFLE_BULLET, MOD_GRENADE, MOD_GRENADE_SPLASH,
				MOD_PROJECTILE, MOD_PROJECTILE_SPLASH, MOD_MELEE, MOD_HEAD_SHOT, MOD_CRUSH, MOD_TELEFRAG,
				MOD_FALLING, MOD_SUICIDE, MOD_TRIGGER_HURT, MOD_EXPLOSIVE, MOD_IMPACT,
			]]--

			for i, player in ipairs(players) do
				if player.name == getdvarargs[1] then
					deathanimduration = player:playerforcedeathanim( player, sMeansOfDeath, sWeapon, sHitLoc, vDir)
					player.body = player:cloneplayer(deathanimduration)
					local fx = game:spawnfx(forge_fx["blood1"], player:gettagorigin("j_spine4"))
					game:triggerfx(fx)
					player:hide()
				
					game:ontimeout(function() player:show() end, math.floor(sWaitTime / timescale))
				end
			end
		end
	elseif #getdvarargs == 4 then
		-- /sly_player_clone player meansofdeath hitloc waittime 
		local sMeansOfDeath = getdvarargs[2] -- reason of death
		local sWeapon = player:getcurrentweapon() -- weapon used
		local sWaitTime = getdvarargs[4] -- time to wait before showing
		local sHitLoc = getdvarargs[3] -- hit location
		local vDir = vector:new(0,0,0) -- hitlocation

		--[[ sMeansOfDeath
			MOD_UNKNOWN, MOD_PISTOL_BULLET, MOD_RIFLE_BULLET, MOD_GRENADE, MOD_GRENADE_SPLASH,
			MOD_PROJECTILE, MOD_PROJECTILE_SPLASH, MOD_MELEE, MOD_HEAD_SHOT, MOD_CRUSH, MOD_TELEFRAG,
			MOD_FALLING, MOD_SUICIDE, MOD_TRIGGER_HURT, MOD_EXPLOSIVE, MOD_IMPACT,
		]]--

		--[[ sHitLoc
			none, helmet, head, neck, torso_upper, torso_lower, right_arm_upper,
			left_arm_upper, right_arm_lower, left_arm_lower, right_hand,
			left_hand, right_leg_upper, left_leg_upper, right_leg_lower,
			left_leg_lower, right_foot, left_foot, gun
		]]--

		for i, player in ipairs(players) do
			if player.name == getdvarargs[1] then
				deathanimduration = player:playerforcedeathanim( player, sMeansOfDeath, sWeapon, sHitLoc, vDir)
				player.body = player:cloneplayer(deathanimduration)
				player:hide()
				local fx = game:spawnfx(forge_fx["blood1"], player:gettagorigin("j_spine4"))
				game:triggerfx(fx)
				game:ontimeout(function() player:show() end, math.floor(sWaitTime / timescale))
			end
		end
	end
end

function playerkick(player)
	-- Kick player
	local getdvarargs = tostring(game:getdvar("sly_player_kick"))
	game:setdvar("sly_player_kick", "player")

	game:executecommand("kick " .. getdvarargs)  
end

function playerkill(player)
	-- Kills player
	local getdvarargs = tostring(game:getdvar("sly_player_kill"))
	game:setdvar("sly_player_kill", "player")
	
	for i, player in ipairs(players) do
		if player.name == getdvarargs then
			player:suicide()
		end
	end 
end

function playermove(player)
	-- Move a player to your origin
	local getdvarargs = tostring(game:getdvar("sly_player_move"))
	game:setdvar("sly_player_move", "player")

	local org = player.origin
	local ang = player:getangles()
	--print(org.x, org.y, org.z)

	if getdvarargs == "all" then
		for i, player in ipairs(players) do
			if player.name ~= admin then
				player_spawn[player.name] = {}
				player_spawn[player.name].origin = vector:new(org.x + math.floor(math.random (-50, 50)), org.y + math.floor(math.random (-50, 50)), org.z)
				player_spawn[player.name].angles = ang
				player:setorigin(player_spawn[player.name].origin)
				player:setangles(ang)
				player:freezecontrols(true)
			end
		end
	else
		for i, player in ipairs(players) do
			if player.name == getdvarargs then
				player_spawn[player.name] = {}
				player_spawn[player.name].origin = org
				player_spawn[player.name].angles = ang
				player:setorigin(player_spawn[getdvarargs].origin)
				player:setangles(player_spawn[getdvarargs].angles)
				player:freezecontrols(true)
			end
		end
	end
end

function playermodel(player)
	-- Set a player's model
	local getdvarargs = splitStr(game:getdvar("sly_player_model"))
	game:setdvar("sly_player_model", "player model")
	
	for i, player in ipairs(players) do
		if player.name == getdvarargs[1] then
			if getdvarargs[2] == "juggernaut" then
				player:detachall()
				player:setmodel("npc_exo_armor_mp_base")
				player:attach( "head_hero_cormack_sentinel_halo" )
				player:setviewmodel( "vm_view_arms_mech_mp" )
			elseif getdvarargs[2] == "infected" then
				player:detachall()
				player:setmodel("kva_hazmat_body_infected_mp")
				player:attach( "kva_hazmat_head_infected" )
				player:setviewmodel( "vm_kva_hazmat_infected" )
			else
				player:setmodel(getdvarargs[2])
			end
		end
	end 
end

function getplayercostume(player)
	-- Get a player's costume
	local getdvarargs = splitStr(game:getdvar("sly_player_getcostume"))
	game:setdvar("sly_player_getcostume", "player")

	local playername = getdvarargs[1]
	for i, player in ipairs(players) do
		if player.name == playername then
			if #getdvarargs == 1 then
				local activeindex = player:getcommonplayerdata("activeCostume")
				costumetable = {}
				table.insert(costumetable, {
					outfit = activeindex+1,
					name = player.name,
					eyewear = player:getcommonplayerdata( "costumes", activeindex, "eyewear"),
					hat = player:getcommonplayerdata( "costumes", activeindex, "hat"),
					shirt = player:getcommonplayerdata( "costumes", activeindex, "shirt"),
					gear = player:getcommonplayerdata( "costumes", activeindex, "gear"),
					gloves = player:getcommonplayerdata( "costumes", activeindex, "gloves"),
					pants = player:getcommonplayerdata( "costumes", activeindex, "pants"),
					kneepads = player:getcommonplayerdata( "costumes", activeindex, "kneepads"),
					shoes = player:getcommonplayerdata( "costumes", activeindex, "shoes"),
					exo = player:getcommonplayerdata( "costumes", activeindex, "exo")
				})
				local jsonstr = json.encode(costumetable)
				local f = io.open(("S1x\\scripts\\slymvm\\costumes\\%s.json"):format(playername), "w")
				f:write(jsonstr)
				f:flush()
				f:close()
				player:iclientprintln(playername .. "'s costume ^:saved!")
			elseif #getdvarargs == 2 and getdvarargs[2] == "all" then
				for i=0, 3 do
					costumetable = {}
					table.insert(costumetable, {
						outfit = i+1,
						name = player.name,
						eyewear = player:getcommonplayerdata( "costumes", i, "eyewear"),
						hat = player:getcommonplayerdata( "costumes", i, "hat"),
						shirt = player:getcommonplayerdata( "costumes", i, "shirt"),
						gear = player:getcommonplayerdata( "costumes", i, "gear"),
						gloves = player:getcommonplayerdata( "costumes", i, "gloves"),
						pants = player:getcommonplayerdata( "costumes", i, "pants"),
						kneepads = player:getcommonplayerdata( "costumes", i, "kneepads"),
						shoes = player:getcommonplayerdata( "costumes", i, "shoes"),
						exo = player:getcommonplayerdata( "costumes", i, "exo")
					})
					local jsonstr = json.encode(costumetable)
					local f = io.open(("S1x\\scripts\\slymvm\\costumes\\%s.json"):format(playername .. "_outfit" .. i+1), "w")
					f:write(jsonstr)
					f:flush()
					f:close()
				end
				player:iclientprintln("All of " .. playername .. "'s costume ^:saved!")
			end
		end
	end
end

function setplayercostume(player)
	-- Set a player's costume
	local getdvarargs = splitStr(game:getdvar("sly_player_setcostume"))
	game:setdvar("sly_player_setcostume", "player costume value")

	if #getdvarargs == 2 and getdvarargs[2] == "random" then
		-- sly_player_costume corbin random

		for i, player in ipairs(players) do
			if player.name == getdvarargs[1] then
				local costume = game:randomcostume()
				local costumeindex =  player:getcommonplayerdata("activeCostume")
				for i=1, #playercostume do
					print("Category " .. playercostume[i] .. " set with costume value " .. costume[i])
					player:setcommonplayerdata("costumes", costumeindex, playercostume[i], costume[i])
				end
			end
		end
		player:iclientprintln(getdvarargs[1] .. "'s costume set to ^:random!")
	elseif #getdvarargs == 3 then
		if getdvarargs[2] == "load" then
			local costumepath = ("S1x\\scripts\\slymvm\\costumes\\%s.json"):format(getdvarargs[3])
			local f = io.open(costumepath, "r")
			if f == nil then
				costumetable = {}
				return
			end
			local jsonstr = f:read("*a")
			costumetable = json.decode(jsonstr)
			for i, player in ipairs(players) do
				if player.name == getdvarargs[1] then
					local costumeindex =  player:getcommonplayerdata("activeCostume")
					for i=1, #playercostume do
						player:setcommonplayerdata("costumes", costumeindex, playercostume[i], costumetable[1][playercostume[i]])
						print(getdvarargs[1] .. "'s " .. playercostume[i] .. " set to " .. costumetable[1][playercostume[i]] )
					end
					player:notify("changed_kit")
					player:notify("applyLoadout")
				end
			end
			player:iclientprintln(getdvarargs[1] .. "'s costume set to ^:" .. getdvarargs[3])
		else
			-- sly_player_costume corbin shirt 0
			local playername = getdvarargs[1]
			local category = getdvarargs[2]
			local costume = tonumber(getdvarargs[3])
		
			for i, player in ipairs(players) do
				if player.name == playername then
					local costumeindex =  player:getcommonplayerdata("activeCostume")
					player:setcommonplayerdata( "costumes", costumeindex, category, costume)
				end
			end
			print(playername .. "'s " .. category .. " set with costume value " .. costume)
			player:iclientprintln(playername .. "'s " .. category .. " set with costume value " .. costume)
		end
	end
end

function playeradd(player)
	-- Give the player a gun
	local getdvarargs = tonumber(game:getdvar("sly_player_add"))
	game:setdvar("sly_player_add", "#")

	game:executecommand("spawnBot " .. getdvarargs)  
end

function playerweapon(player)
	-- Give the player a gun
	local getdvarargs = splitStr(game:getdvar("sly_player_weapon"))
	game:setdvar("sly_player_weapon", "player gun")

	if #getdvarargs == 2 then
		for i, player in ipairs(players) do
			if player.name == getdvarargs[1] then
				-- no camo selected
				--player:takeweapon(player:getcurrentweapon())
				player:giveweapon(getdvarargs[2], 0, false)
				giveAmmo(player)
				player:switchtoweapon(getdvarargs[2])
			end
		end  
	end
end

function playerhealth(player)
	-- Give the player a gun
	local getdvarargs = splitStr(game:getdvar("sly_player_health"))
	game:setdvar("sly_player_health", "player health")

	if #getdvarargs == 2 then
		for i, player in ipairs(players) do
			if player.name == getdvarargs[1] then
				player_health = math.floor(tonumber(getdvarargs[2]))
			end
		end  
	end
end