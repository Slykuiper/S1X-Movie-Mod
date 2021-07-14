function spawnforgeeffect(player)
	-- Spawns FX on player location
	local getdvarargs = splitStr(game:getdvar("sly_forge_fx"))
	game:setdvar("sly_forge_fx", "fx")

	if #getdvarargs == 2 then
		local forward = player:gettagorigin("j_head")
		local endpos = vector_scal(game:anglestoforward(player:getangles()), 100)
		local endpos2 = vector:new(endpos.x + forward.x, endpos.y + forward.y, endpos.z + forward.z)
		local fx = game:spawnfx(forge_fx[getdvarargs[1]], endpos2)
		game:triggerfx(fx)
	elseif #getdvarargs == 3 then
		local fx = game:spawnfx(forge_fx[getdvarargs[1]], savedorigin)
		game:triggerfx(fx)
	end
	player:iclientprintln("^7Effect ^:", getdvarargs[1], "^7 spawned.")
end

function spawnforgemodel(player)
	-- Spawns Model on player location
	local getdvarargs = splitStr(game:getdvar("sly_forge_model"))
	game:setdvar("sly_forge_model", "model")

	if forge_num == 0 then
		forge_model[forge_num] = game:spawn("script_model", player.origin)
		forge_model[forge_num].origin = player.origin
		forge_model[forge_num].angles = player:getangles()
		forge_model[forge_num]:setmodel(getdvarargs[1])
		local fx = game:spawnfx(forge_fx["3dping"], forge_model[forge_num].origin)
		game:triggerfx(fx)
		forge_num = forge_num + 1
	else
		forge_num = forge_num + 1
		forge_model[forge_num] = game:spawn("script_model", player.origin)
		forge_model[forge_num].origin = player.origin
		forge_model[forge_num].angles = player.angles
		forge_model[forge_num]:setmodel(getdvarargs[1])
		local fx = game:spawnfx(forge_fx["3dping"], forge_model[forge_num].origin)
		game:triggerfx(fx)
	end

	
	player:iclientprintln("^7Model ^:", forge_num, "^7 spawned: ^:", getdvarargs[1])
end