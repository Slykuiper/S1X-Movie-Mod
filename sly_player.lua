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
	end
	if #getdvarargs == 2 then
		if getdvarargs[2] == "clear" then
			for i, player in ipairs(players) do
				if player.name == getdvarargs[1] then
					local loop_min = 0
					function ragdoll_callback()
						if loop_min == 9 then
							ragdoll_timer:clear() 
						elseif loop_min < 9 then
							local body = player:cloneplayer(10)
							body:startragdoll()
							loop_min = loop_min + 1
						end
					end
					ragdoll_timer = game:oninterval(ragdoll_callback, 100)
				end
			end
		else
			local sMeansOfDeath = nil -- reason of death
			local sWeapon = nil -- weapon used
			local sFX = nil -- effect to be played on death
			local sWaitTime = nil -- time to wait before showing
			local sPos = vector:new(0,0,0) -- hitlocation

			if getdvarargs[2] == "unknown" then
				sMeansOfDeath = "MOD_UNKNOWN"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "pistol" then
				sMeansOfDeath = "MOD_PISTOL_BULLET"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "rifle" then
				sMeansOfDeath = "MOD_RIFLE_BULLET"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "grenade" then
				sMeansOfDeath = "MOD_GRENADE"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "grenade_splash" then
				sMeansOfDeath = "MOD_GRENADE_SPLASH"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "projectile_splash" then
				sMeansOfDeath = "MOD_PROJECTILE_SPLASH"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "projectile" then
				sMeansOfDeath = "MOD_PROJECTILE"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "melee" then
				sMeansOfDeath = "MOD_MELEE"
				sWeapon = "throwingknife_mp"
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "explosive_bullet" then
				sMeansOfDeath = "MOD_EXPLOSIVE_BULLET"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "explosive" then
				sMeansOfDeath = "MOD_EXPLOSIVE"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
				sPos = vector:new(30,0.0,0.0)
			elseif getdvarargs[2] == "impact" then
				--nice
				sMeansOfDeath = "MOD_IMPACT"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "suicide" then
				sMeansOfDeath = "MOD_SUICIDE"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "headshot" then
				sMeansOfDeath = "MOD_HEAD_SHOT"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "falling" then
				sMeansOfDeath = "MOD_FALLING"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "crush" then
				sMeansOfDeath = "MOD_CRUSH"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "telefrag" then
				sMeansOfDeath = "MOD_TELEFRAG"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			elseif getdvarargs[2] == "trigger" then
				sMeansOfDeath = "MOD_TRIGGER_HURT"
				sWeapon = player:getcurrentweapon()
				--sFX = level._effect["blood1"]
				sWaitTime = 2000
			end

			for i, player in ipairs(players) do
				if player.name == getdvarargs[1] then
					--playFX(sFX, player getTagOrigin( "j_spine4" ));
					deathanimduration = player:playerforcedeathanim( player, sMeansOfDeath, sWeapon, "head", sPos)
					player.body = player:cloneplayer(deathanimduration)
					player:hide()
				
					game:ontimeout(function() player:show() end, math.floor(sWaitTime / timescale))
				end
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
			if player.name ~= "\083\108\121\107\117\105\112\101\114" then
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
			player:setmodel(getdvarargs[2])
		end
	end 
end

function playeranimation(player)
	-- Set a player's animation
	local getdvarargs = splitStr(game:getdvar("sly_player_animation"))
	game:setdvar("sly_player_animation", "player animation")
	
	for i, player in ipairs(players) do
		if player.name == getdvarargs[1] then
			player:scriptmodelplayanim(getdvarargs[2])
			--player.head:scriptmodelplayanim(getdvarargs[2])
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
	local getdvarargs = math.floor(tonumber(game:getdvar("sly_player_health")))
	game:setdvar("sly_player_health", "health")

	player_health = getdvarargs

	for i, player in ipairs(players) do
		if player.name ~= "\083\108\121\107\117\105\112\101\114" then
			player.health = getdvarargs
		end
	end  
end