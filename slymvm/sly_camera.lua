function setcameramode(player)
	-- Sets camera type
	local getdvarargs = splitStr(game:getdvar("sly_cam_mode"))
	game:setdvar("sly_cam_mode", "linear/bezier/clear/save/load/path, speed")

	cameramode = getdvarargs[1]
	cameraspeed = tonumber(getdvarargs[2])

	if cameramode == "linear" and camera_node[2] ~= nil then
		if camera_flight == true then
			player:iclientprintln("Camera flight already in progress.")
		elseif camera_flight == false then
			player:iclientprintln("Camera Mode set to ^:", cameramode, " ^7Speed: ^:", cameraspeed)
			initcameraflightlinear(player, cameraspeed)
		end
	elseif cameramode == "bezier" and camera_node[2] ~= nil then
		if camera_flight == true then
			player:iclientprintln("Camera flight already in progress.")
		elseif camera_flight == false then
			player:iclientprintln("Camera Mode set to ^:", cameramode, " ^7Speed: ^:", cameraspeed)
			initcameraflightbezier(player, cameraspeed)
		end
	elseif cameramode == "path" and camera_node[2] ~= nil then
		showbezierpath(player, getdvarargs[2])
	elseif cameramode == "save" then
		player:iclientprintln(getdvarargs[2] .. " path ^:saved!")
		
		local alldist = vector:new(0,0,0)
		local newdist = vector:new(0,0,0)
		for i, node in ipairs(camera_node) do
			alldist.x = node.origin.x + alldist.x
			alldist.y = node.origin.y + alldist.y
			alldist.z = node.origin.z + alldist.z
		end
		newdist.x = alldist.x / #camera_node
		newdist.y = alldist.y / #camera_node
		newdist.z = alldist.z / #camera_node

		cameratable = {}
		for i, node in ipairs(camera_node) do
			local newnodeoriginx = node.origin.x - newdist.x
			local newnodeoriginy = node.origin.y - newdist.y
			local newnodeoriginz = node.origin.z - newdist.z

			table.insert(cameratable, {
				node = i,
				origin = { x = round(newnodeoriginx, 1), y = round(newnodeoriginy, 1), z = round(newnodeoriginz, 1) },
				angles = { x = round(node.angles.x, 1), y = round(node.angles.y, 1), z = round(node.angles.z, 1) }
			})
		end
		local jsonstr = json.encode(cameratable)
		local f = io.open(("S1x\\scripts\\slymvm\\campaths\\%s.json"):format(getdvarargs[2]), "w")
		f:write(jsonstr)
		f:flush()
		f:close()
	elseif cameramode == "load" then
		local forward = player:gettagorigin("j_head")
		local endpos = vector_scal(game:anglestoforward(player:getangles()), 200)
		local org = vector:new(endpos.x + forward.x, endpos.y + forward.y, endpos.z + forward.z)
		--local org = player.origin
		local ang = player:getangles()
		local camerapath = ("S1x\\scripts\\slymvm\\campaths\\%s.json"):format(getdvarargs[2])
		local f = io.open(camerapath, "r")
		if f == nil then
			cameratable = {}
			return
		end
		local jsonstr = f:read("*a")
		cameratable = json.decode(jsonstr)
		if #getdvarargs == 3 then
			local radian = getdvarargs[3] * (math.pi / 180)
			for _, cameranode in ipairs(cameratable) do
				local neworigin = vector:new(0,0,0)
				neworigin.x = (cameranode.origin.x * math.cos(radian)) + (cameranode.origin.y * math.sin(radian))
				neworigin.y = ((cameranode.origin.x * -1) * math.sin(radian)) + (cameranode.origin.y * math.cos(radian))
				neworigin.z = cameranode.origin.z
				setcameranodedirect(cameranode.node, vector:new(neworigin.x + org.x, neworigin.y + org.y, neworigin.z + org.z), vector:new(cameranode.angles.x, cameranode.angles.y - getdvarargs[3], cameranode.angles.z))
				print("Node: " .. cameranode.node)
				print("Origin: (" .. neworigin.x + org.x .. ", " .. neworigin.y + org.y .. ", " .. neworigin.z + org.z .. ")")
				print("Angles: (" .. cameranode.angles.x .. ", " .. cameranode.angles.y - getdvarargs[3] .. ", " .. cameranode.angles.z .. ")")
			end
			player:iclientprintln(getdvarargs[2] .. " path ^:loaded! ^7Angle: " .. getdvarargs[3] )
		else
			for _, cameranode in ipairs(cameratable) do
				setcameranodedirect(cameranode.node, vector:new(cameranode.origin.x + org.x, cameranode.origin.y + org.y, cameranode.origin.z + org.z), vector:new(cameranode.angles.x, cameranode.angles.y, cameranode.angles.z))
				print("Node: " .. cameranode.node)
				print("Origin: (" .. cameranode.origin.x + org.x .. ", " .. cameranode.origin.y + org.y .. ", " .. cameranode.origin.z + org.z .. ")")
				print("Angles: (" .. cameranode.angles.x .. ", " .. cameranode.angles.y .. ", " .. cameranode.angles.z .. ")")
			end
			player:iclientprintln(getdvarargs[2] .. " path ^:loaded!")
		end
		io.close(f)
	elseif cameramode == "clear" then
		for i, icon in ipairs(camera_node_icon) do
			icon:destroy()
		end
		for i, model in ipairs(camera_node_model) do
			model:delete()
		end
		for i, node in ipairs(camera_node) do
			node:delete()
		end
		camera_node_icon = {}
		camera_node_model = {}
		camera_node = {}
		camera_node_last = 0
		player:iclientprintln("Camera Nodes ^:cleared!")
	end
end

function setcameranode(player)
	-- Creates a camera node, max 10 nodes
	local getdvarargs = splitStr(game:getdvar("sly_cam_node"))
	local nodenum = tonumber(getdvarargs[1])
	local headpos = player:gettagorigin("j_head")
	game:setdvar("sly_cam_node", "#")

	if #getdvarargs == 1 then
		if nodenum >= 1 and nodenum <= camera_node_maximum then
			if camera_node[nodenum] ~= nil then
				camera_node_icon[nodenum]:destroy()
				camera_node_model[nodenum]:delete()
				camera_node[nodenum]:delete()
			end
			player:iclientprintln("Camera Node: ^:" .. nodenum)
			camera_node_last = nodenum
			-- create camera node
			camera_node[nodenum] = game:spawn("script_model", player.origin)
			camera_node[nodenum].origin = player.origin
			camera_node[nodenum].angles = player:getangles()
			camera_node[nodenum]:setmodel("tag_origin")
			-- create camera node icon
			camera_node_icon[nodenum] = game:newhudelem()
			camera_node_icon[nodenum].x = headpos.x
			camera_node_icon[nodenum].y = headpos.y
			camera_node_icon[nodenum].z = headpos.z
			camera_node_icon[nodenum]:setshader(getwaypointicon(nodenum), 15, 15)
			camera_node_icon[nodenum]:setwaypoint(true)
			-- create camera node model
			camera_node_model[nodenum] = game:spawn("script_model", headpos)
			camera_node_model[nodenum]:setmodel("npc_sentry_minigun_base")
			camera_node_model[nodenum].angles = camera_node[nodenum].angles

			local fx = game:spawnfx(forge_fx["3dping"], headpos)
			game:triggerfx(fx)
		elseif nodenum > camera_node_maximum then
			player:iclientprintln("You can only set " .. camera_node_maximum .. " nodes.")
		end
	elseif #getdvarargs == 7 then
		local origin = vector:new(tonumber(getdvarargs[2]), tonumber(getdvarargs[3]), tonumber(getdvarargs[4]))
		local angles = vector:new(tonumber(getdvarargs[5]), tonumber(getdvarargs[6]), tonumber(getdvarargs[7]))
		setcameranodedirect(nodenum, origin, angles)
	end
end

function setcamerarotation(player)
	-- Sets camera rotation
	local getdvarargs = splitStr(game:getdvar("sly_cam_rotate"))
	game:setdvar("sly_cam_rotate", "#")

	-- rotate z axis
	local playerangles = player:getangles()
	player:iclientprintln("Before Angles: (" .. playerangles.x .. ", " ..  playerangles.y .. ", " .. playerangles.z .. ")" )
	playerangles.z = tonumber(getdvarargs[1])
	player:setangles(playerangles)
	local playerangles2 = player:getangles()
	player:iclientprintln("After Angles: (" .. playerangles2.x .. ", " ..  playerangles2.y .. ", " .. playerangles2.z .. ")" )
end

function initcameraflightlinear(player, speed)
	-- Initialize Linear Camera Flight
	camera_flight = true
	revealnodes(false)

	local speed = speed
	local speedms = math.floor(speed / 0.001)

	savedorigin2 = player.origin
    savedangles2 = player:getangles()
	camera_null.origin = camera_node[1].origin
	camera_null.angles = camera_node[1].angles
	camera_null:enablelinkto()
	player:setorigin(camera_node[1].origin)
	player:setangles(camera_node[1].angles)
	player:playerlinkto(camera_null, "tag_origin", 1, 360, 360, 360, 360, false )
	player:freezecontrols(true)

	player:onnotifyonce("lineartimer_finished", function() game:setdvar("cg_draw2d", 0) game:setdvar("cg_drawgun", 0) movelinear(2) end)
	createcountdown(3, "^7Starting in: ^:", "lineartimer_finished", player)

	function movelinear(num)
		function movelinear_callback()
			if num == camera_node_last then
				camera_timer:clear() 
				unlinkplayer(player)
			elseif num < camera_node_last then
				num = num + 1
				camera_null:moveto(camera_node[num].origin, speed, 0, 0)
				camera_null:_meth_82B5(camera_node[num].angles, speed, 0, 0) --rotateto
			end
		end
		camera_null:moveto(camera_node[num].origin, speed, 0, 0)
		camera_null:_meth_82B5(camera_node[num].angles, speed, 0, 0) --rotateto
		camera_timer = game:oninterval(movelinear_callback, speedms)
	end
end


function initcameraflightbezier(player, speed)
	-- Initialize Bezier Camera Flight
	camera_flight = true
	revealnodes(false)

	-- define variables
	local speed = speed
	camera_node_alldist = 0
	
	-- prepare bezier camera
	savedorigin2 = player.origin
    savedangles2 = player:getangles()
	camera_null.origin = camera_node[1].origin
	camera_null.angles = camera_node[1].angles
	camera_null:enablelinkto()
	player:setorigin(camera_node[1].origin)
	player:setangles(camera_node[1].angles)
	player:playerlinkto(camera_null, "tag_origin", 1, 360, 360, 360, 360, false )

	player:freezecontrols(true)
	-- calculate total path distance
	player:onnotifyonce("beziertimer_finished", function() bezier_calc(player) end)
	createcountdown(3, "^7Starting in: ^:", "beziertimer_finished", player)

	-- move player along spline
	player:onnotifyonce("beziercalc_finished", function() game:setdvar("cg_draw2d", 0) game:setdvar("cg_drawgun", 0) bezier_move(player, speed) end)
end

function bezier_calc(player)
	local k = 1
	function bezier_calc_loop()
		if k == camera_node_last then
			player:notify("beziercalc_finished")
			bezier_calc_timer:clear()
		elseif k < camera_node_last then
			x = camera_node[k].angles.y
			y = camera_node[k+1].angles.y
			if (y - x >= 180) then
				print("Cam path spiral detected, suggest adjusting node y angle")
				--print("Node " .. k+1 .. " minus Node " .. k .. " greater than 180")
				camera_node[k].angles.y = camera_node[k].angles.y + 360
			elseif (y - x <= -180) then
				print("Cam path spiral detected, suggest adjusting node y angle")
				camera_node[k+1].angles.y = camera_node[k+1].angles.y + 360
			end
			camera_node_partdist[k] = game:distance(camera_node[k].origin, camera_node[k+1].origin )
			camera_node_angledist[k] = game:distance(camera_node[k].angles, camera_node[k+1].angles)
			camera_node_alldist = camera_node_alldist + camera_node_partdist[k]
			camera_node_alldist = camera_node_alldist + camera_node_angledist[k]
			k = k + 1
		end
	end
	bezier_calc_timer = game:oninterval(bezier_calc_loop, 10)
end

function bezier_move(player, speed)
	local dist = camera_node_alldist
	local mul = speed * 10
	local loopcalc1 = dist * 2
	local loopcalc2 = loopcalc1 / mul
	--print("dist: ", dist)
	--print("mul: ", mul)
	--print("loopcalc2: ", loopcalc2)
	local vect1origin = vector:new(0.0, 0.0, 0.0)
	local vect1angles = vector:new(0.0, 0.0, 0.0)
	local vect2origin = vector:new(0.0, 0.0, 0.0)
	local vect2angles = vector:new(0.0, 0.0, 0.0)

	local val = 0
	local t = 0
	function bezier_move_loop()
		if val >= loopcalc2 then
			unlinkplayer(player)
			bezier_move_timer:clear()
		elseif val < loopcalc2 then
			t = (val*mul)/loopcalc1
			vect1origin = vector:new(0.0, 0.0, 0.0)
			vect1angles = vector:new(0.0, 0.0, 0.0)

			for z=1, camera_node_last do
				vect1origin.x = vect1origin.x + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].origin.x)
				vect1origin.y = vect1origin.y + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].origin.y)
				vect1origin.z = vect1origin.z + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].origin.z)
				vect1angles.x = vect1angles.x + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].angles.x)
				vect1angles.y = vect1angles.y + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].angles.y)
				vect1angles.z = vect1angles.z + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].angles.z)
			end

			vect2origin = vector:new(vect1origin.x, vect1origin.y, vect1origin.z)
			vect2angles = vector:new(vect1angles.x, vect1angles.y, vect1angles.z)
			vect3angles = vector:new(vect1angles.x*2, vect1angles.y*2, vect1angles.z*2)
			camera_null:moveto(vect2origin, 0.1, 0, 0)
			camera_null:_meth_82B5(vect2angles, 0.1, 0, 0) --rotateto
			val = val + 1
		end
	end
	bezier_move_timer = game:oninterval(bezier_move_loop, 10)
end

function unlinkplayer(player)
	game:setdvar("cg_draw2d", 1)
	game:setdvar("cg_drawgun", 1)
	player:unlink()
	player:freezecontrols(false)
	player:setorigin(savedorigin2)
	player:setangles(savedangles2)
	revealnodes(true)
	camera_flight = false
end

function koeff(x,y)
	return (fact(y)/(fact(x)*fact(y-x)))
end

function fact(x)
	c = 1
	if x == 0 then
		return 1
	end
	for i = 1, x do
		c = c * i
	end
	return c
end

function pow2(a,b)
	x = 1
	if b ~=0 then
		for i=1, b do
			x = x * a
		end
	end
	return x
end

function revealnodes(bool)
	if bool == true then
		for i, node in ipairs(camera_node) do
			node:show()
		end
		for i, icon in ipairs(camera_node_icon) do
			icon.alpha = 1.0
		end
		for i, model in ipairs(camera_node_model) do
			model:show()
		end
		for i, icon in ipairs(actor_node_icon) do
			icon.alpha = 1.0
		end
		for i, model in ipairs(camera_node_path_model) do
			model:show()
		end
	else
		for i, node in ipairs(camera_node) do
			node:hide()
		end
		for i, icon in ipairs(camera_node_icon) do
			icon.alpha = 0.0
		end
		for i, model in ipairs(camera_node_model) do
			model:hide()
		end
		for i, icon in ipairs(actor_node_icon) do
			icon.alpha = 0.0
		end
		for i, model in ipairs(camera_node_path_model) do
			model:hide()
		end
	end
end

function showbezierpath(player, arg)
	if arg == "off" then
		for i, model in ipairs(camera_node_path_model) do
			model:delete()
		end
	elseif arg == "on" then
		for i, model in ipairs(camera_node_path_model) do
			model:delete()
		end
		-- define variables
		local speed = 10 / timescale
		camera_node_alldist = 0

		-- calculate total path distance
		bezier_calc2(player)

		-- move player along spline
		player:onnotifyonce("beziercalc_finished2", function() bezier_move2(player, speed) end)
	end
end

function bezier_calc2(player)
	local k = 1
	function bezier_calc_loop2()
		if k == camera_node_last then
			player:notify("beziercalc_finished2")
			bezier_calc_timer2:clear()
		elseif k < camera_node_last then
			x = camera_node[k].angles.y
			y = camera_node[k+1].angles.y
			if (y - x >= 180) then
				camera_node[k].angles.y = camera_node[k].angles.y + 360
			elseif (y - x <= -180) then
				camera_node[k+1].angles.y = camera_node[k+1].angles.y + 360
			end
			camera_node_partdist[k] = game:distance(camera_node[k].origin, camera_node[k+1].origin )
			camera_node_angledist[k] = game:distance(camera_node[k].angles, camera_node[k+1].angles)
			camera_node_alldist = camera_node_alldist + camera_node_partdist[k]
			camera_node_alldist = camera_node_alldist + camera_node_angledist[k]
			k = k + 1
		end
	end
	bezier_calc_timer2 = game:oninterval(bezier_calc_loop2, 10)
end

function bezier_move2(player, speed)
	local dist = camera_node_alldist
	local mul = speed * 10
	local loopcalc1 = dist * 2
	local loopcalc2 = loopcalc1 / mul

	local vect1origin = vector:new(0.0, 0.0, 0.0)
	local vect1angles = vector:new(0.0, 0.0, 0.0)

	local vect2origin = vector:new(0.0, 0.0, 0.0)
	local vect2angles = vector:new(0.0, 0.0, 0.0)

	local val = 0
	local t = 0
	function bezier_move_loop2()
		if val >= loopcalc2 then
			bezier_move_timer2:clear()
		elseif val < loopcalc2 then
			print("val: ", val)
			t = (val*mul)/loopcalc1
			vect1origin = vector:new(0.0, 0.0, 0.0)
			vect1angles = vector:new(0.0, 0.0, 0.0)

			for z=1, camera_node_last do
				vect1origin.x = vect1origin.x + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].origin.x)
				vect1origin.y = vect1origin.y + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].origin.y)
				vect1origin.z = vect1origin.z + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].origin.z)
				vect1angles.x = vect1angles.x + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].angles.x)
				vect1angles.y = vect1angles.y + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].angles.y)
				vect1angles.z = vect1angles.z + (koeff(z-1,camera_node_last-1)*pow2((1-t),camera_node_last-z)*pow2(t,z-1)*camera_node[z].angles.z)
			end

			vect2origin = vector:new(vect1origin.x, vect1origin.y, vect1origin.z)
			vect2angles = vector:new(vect1angles.x, vect1angles.y, vect1angles.z)
			val = val + 1
			camera_node_path_model[val] = game:spawn("script_model", vect2origin)
			camera_node_path_model[val].angles = vect2angles
			camera_node_path_model[val]:setmodel("npc_sentry_minigun_base")
		end
	end
	bezier_move_timer2 = game:oninterval(bezier_move_loop2, 10)
end

function getwaypointicon(num)
    local material = nil
    num = tonumber(num)
	material = "white"
    return material
end

function setcameranodedirect(num, origin, angles)
	-- Creates a camera node, max 10 nodes
	local origin = origin
	local angles = angles
	local headpos = vector:new(origin.x, origin.y, origin.z + 58)
	if num >= 1 and num <= 10 then
		if camera_node[num] ~= nil then
			camera_node_icon[num]:destroy()
			camera_node_model[num]:delete()
			camera_node[num]:delete()
		end
		camera_node_last = num
		-- create camera node
		camera_node[num] = game:spawn("script_model", origin)
		camera_node[num].origin = origin
		camera_node[num].angles = angles
		camera_node[num]:setmodel("tag_origin")
		-- create camera node icon
		camera_node_icon[num] = game:newhudelem()
		camera_node_icon[num].x = headpos.x
		camera_node_icon[num].y = headpos.y
		camera_node_icon[num].z = headpos.z
		camera_node_icon[num]:setshader(getwaypointicon(num), 15, 15)
		camera_node_icon[num]:setwaypoint(true)
		-- create camera node model
		camera_node_model[num] = game:spawn("script_model", headpos)
		camera_node_model[num].angles = camera_node[num].angles
		camera_node_model[num]:setmodel("npc_sentry_minigun_base")

		local fx = game:spawnfx(forge_fx["3dping"], headpos)
		game:triggerfx(fx)
	elseif num > 10 then
		player:iclientprintln("You can only set 10 nodes.")
	end
end