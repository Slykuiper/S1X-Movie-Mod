--[[
***************************************
General Functions
***************************************
--]]

function splitStr(theString)
 
  stringTable = {}
  local i = 1
 
  -- Cycle through the String and store anything except for spaces
  -- in the table
  for str in string.gmatch(theString, "[^%s]+") do
    stringTable[i] = str
    i = i + 1
  end
 
  -- Return multiple values
  return stringTable, i
end

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end


--[[
local VectorToString = function(vec)
    return vec.x..' '..vec.y..' '..vec.z
end

local StringToVector = function(str)
        local tab = {}
    for a in string.gmatch(str,"%d+") do
           table.insert(tab,a)
        end
        return Vector3.new(tab[1],tab[2],tab[3])
end
--]]

function vectortostring(vec)
    return vec.x..' '..vec.y..' '..vec.z
end

function dump(value, call_indent)

  if not call_indent then 
    call_indent = ""
  end

  local indent = call_indent .. "  "

  local output = ""

  if type(value) == "table" then
      output = output .. "{"
      local first = true
      for inner_key, inner_value in pairs ( value ) do
        if not first then 
          output = output .. ", "
        else
          first = false
        end
        output = output .. "\n" .. indent
        output = output  .. inner_key .. " = " .. dump ( inner_value, indent ) 
      end
      output = output ..  "\n" .. call_indent .. "}"

  elseif type (value) == "userdata" then
    output = "userdata"
  else 
    output =  value
  end
  return output 
end

function vector_scal(vec, scale)
 	vec.x = vec.x * scale
    vec.y = vec.y * scale
    vec.z = vec.z * scale
 	return vec
end

function getplayerinfo(player)
	--Prints player information
    print("==============================================")
    print("Player Info: " .. player.name)
    
	print("Player Origin: " .. vectortostring(player.origin))
	print("Player Angles: " .. vectortostring(player:getangles()))
    --print("Player Viewhands 2: " .. player:getviewmodel())
	print("Player Equipment: " .. player:getcurrentoffhand())
    --print("getweaponarray: " .. player:getweaponarray())
   --print("getweaponattachmentdisplaynames: " .. player:getweaponattachmentdisplaynames(player:getcurrentweapon()))
    --print("getweaponattachments: " .. player:getweaponattachments(player:getcurrentweapon()))
    print("Current Weapon: " .. game:getweapondisplayname(player:getcurrentweapon()) .. " || " .. player:getcurrentweapon() .. " || " .. game:getweaponmodel(player:getcurrentweapon()))
    print("==============================================")
end

function getcamoextension(num)
    local camoname = nil
    num = tonumber(num)

    if num == 0 then
        camoname = ""
    elseif num == 1 then
        camoname = "_snow"
    elseif num == 2 then
        camoname = "_brush"
    elseif num == 3 then
        camoname = "_autumn"
    elseif num == 4 then
        camoname = "_ocean"
    elseif num == 5 then
        camoname = "_tan"
    elseif num == 6 then
        camoname = "_red"
    elseif num == 7 then
        camoname = "_dark"
    elseif num == 8 then
        camoname = "_green"
    elseif num == 9 then
        camoname = "_net"
    elseif num == 10 then
        camoname = "_trail"
    elseif num == 11 then
        camoname = "_winter"
    elseif num == 12 then
        camoname = "_gold"
    elseif num == 13 then
        camoname = "_camo23"
    elseif num == 14 then
        camoname = "_camo29"
    elseif num == 15 then
        camoname = "_camo30"
    elseif num == 16 then
        camoname = "_camo31"
    elseif num == 17 then
        camoname = "_camo32"
    elseif num == 18 then
        camoname = "_camo33"
    elseif num == 19 then
        camoname = "_camo28"
    elseif num == 20 then
        camoname = "_camo26"
    elseif num == 21 then
        camoname = "_camo25"
    elseif num == 22 then
        camoname = "_camo22"
    elseif num == 23 then
        camoname = "_camo21"
    elseif num == 24 then
        camoname = "_camo11"
    elseif num == 25 then
        camoname = "_camo08"
    elseif num == 26 then
        camoname = "_camo06"
    elseif num == 27 then
        camoname = "_camo15"
    elseif num == 28 then
        camoname = "_camo20"
    elseif num == 29 then
        camoname = "_camo09"
    elseif num == 30 then
        camoname = "_camo19"
    elseif num == 31 then
        camoname = "_camo16"
    elseif num == 32 then
        camoname = "_camo17"
    elseif num == 33 then
        camoname = "_camo14"
    elseif num == 34 then
        camoname = "_camo13"
    elseif num == 35 then
        camoname = "_camo18"
    elseif num == 36 then
        camoname = "_camo10"
    elseif num == 37 then
        camoname = "_camo24"
    elseif num == 38 then
        camoname = "_camo27"
    elseif num == 39 then
        camoname = "_camo07"
    elseif num == 40 then
        camoname = "_clan01"
    elseif num == 41 then
        camoname = "_clan02"
    elseif num == 42 then
        camoname = "_camo03"
    elseif num == 43 then
        camoname = "_camo12"
    elseif num == 44 then
        camoname = "_camo04"
    elseif num == 45 then
        camoname = "_camo05"
    end
    return camoname
end

--[[
***************************************
TIMERS
USAGE:
    function my_callback()
        player:iprintlnbold("yay!")
    end
    player:onnotify("timer_finished", my_callback)
    createcountup(5, "^7Starting in: ^:", "timer_finished", player)
***************************************
--]]
function createcountdown(max, message, notify, player)
    --local max = max / timescale
    local i = max
    local i_bar = max * 30
    local progressbar_maxwidth = 150
    local progressbar_bg_strokewidth = 2

    if progressbar ~= nil then
        progressbar_text:destroy()
        progressbar_bg:destroy()
		progressbar:destroy()
	end
    progressbar_text = game:newclienthudelem(player)
    progressbar_text.alpha = 1
    progressbar_text.alignx = "center"
	progressbar_text.aligny = "middle"
    progressbar_text.horzalign = "center"
	progressbar_text.vertalign = "middle"
    progressbar_text.x = 0
    progressbar_text.y = -95
	progressbar_text.color = vector:new(1.0, 1.0, 1.0)
    progressbar_text.font = "bodyFont"
    progressbar_text.fontscale = 1

    progressbar_bg = game:newclienthudelem(player)
    progressbar_bg.alpha = 1
    progressbar_bg.alignx = "center"
	progressbar_bg.aligny = "middle"
    progressbar_bg.horzalign = "center"
	progressbar_bg.vertalign = "middle"
    progressbar_bg.x = 0
    progressbar_bg.y = -80
	progressbar_bg.color = vector:new(0.0, 0.0, 0.0)
	progressbar_bg:setshader("white", (progressbar_maxwidth + (progressbar_bg_strokewidth * 2)), (10 + (progressbar_bg_strokewidth * 2)))

    progressbar = game:newclienthudelem(player)
    progressbar.alpha = 1
    progressbar.alignx = "center"
	progressbar.aligny = "middle"
    progressbar.horzalign = "center"
	progressbar.vertalign = "middle"
    progressbar.x = 0
    progressbar.y = -80
	progressbar.color = vector:new(0.5, 1.0, 0.5)
	progressbar:setshader("white", progressbar_maxwidth, 10)

	function countdowncreator(max, message, notify)
		if i <= max and i > 0 then
			progressbar_text:settext(message .. tostring(i))
			i = i - 1
		else
			player:notify(notify)
            progressbar_text:destroy()
			countdowntimer:clear()
		end
	end

    function countdownbarcreator(input)
        local progressbar_percent = i_bar / input
        local progressbar_width = progressbar_maxwidth * progressbar_percent
        local progressbar_bg_width = progressbar_width + (progressbar_bg_strokewidth * 2)
        if i_bar <= input and i_bar > 0 then
            progressbar_bg:setshader("white", math.floor(progressbar_bg_width), (10 + (progressbar_bg_strokewidth * 2)))
            progressbar:setshader("white", math.floor(progressbar_width), 10)
			i_bar = i_bar - 1
		else
            progressbar_bg:destroy()
			progressbar:destroy()
            countdownbar:clear()
		end
	end

	countdowntimer = game:oninterval(function() countdowncreator(max, message, notify) end, 1000)
    countdownbar = game:oninterval(function() countdownbarcreator(max*30) end, 33)
    player:onnotifyonce("disconnect", function() countdowntimer:clear() end)
end

function createcountup(max, message, notify, player)
	local i = 1
	function countupcreator(max, message, notify)
		if i <= max then
			player:iprintlnbold(message, i)
			i = i + 1
		else
			player:notify(notify)
			countuptimer:clear()
		end
	end
		
	countuptimer = game:oninterval(function() countupcreator(max, print, notify) end, 1000)
    player:onnotifyonce("disconnect", function() countuptimer:clear() end)
end

function savePosition(player)
	-- Saves player's position
	savedorigin = player.origin
    savedangles = player:getangles()
	player:iprintln("Position ^:saved.")
end

function loadPosition(player)
	-- Loads player's position
	if savedorigin ~= nil then
		player:setorigin(savedorigin)
		player:setangles(savedangles)
		player:iprintln("Position ^:loaded.")
	end
end

function giveAmmo(player)
	-- Gives ammo
	player:setweaponammoclip(player:getcurrentweapon(), 9999 )
	player:givemaxammo(player:getcurrentweapon())

	player:setweaponammoclip(player:getcurrentoffhand(), 9999 )
	player:givemaxammo(player:getcurrentoffhand())
end

function setTimescale(player)
	-- Change timescale
	timescale = tonumber(game:getdvar("sly_timescale"))
	game:setdvar("sly_timescale", "timescale")

	player:iprintln("Timescale ^:", timescale)
	game:setslowmotion(timescale, timescale, 0)
end

function printarray(player)
    -- Print Entity Array properties
	local getdvarargs = splitStr(game:getdvar("sly_entarray"))
	game:setdvar("sly_entarray", "string1 string2")

    if #getdvarargs == 2 then
        -- player classname
		local ents = game:getentarray(getdvarargs[1], getdvarargs[2])
		local count = 0
		for i = 1, #ents do 
            print("**********************************")
			print("Entity Name: " .. ents[i].name )
            print("Entity Team: " .. ents[i].team )
			print("Entity Health: " .. ents[i].health )
			print("Entity Score: " .. ents[i].score )
            print("Entity Model: " .. ents[i].model )
            print("Entity Exo Costume viewmodel: " .. ents[i].exocloak.costume.viewmodel )
            print("Entity Exo Costume Body: " .. ents[i].exocloak.costume.body )
            --print("Entity Costume Body: " .. ents[i].costume.body )
            --print("Entity Costume Body: " .. ents[i].costume.body )
            
			print("Entity Position: (" .. ents[i].origin.x .. ", " .. ents[i].origin.y .. ", " .. ents[i].origin.z .. ")")
			print("Entity Angles: (" .. ents[i].angles.x .. ", " .. ents[i].angles.y .. ", " .. ents[i].angles.z .. ")")
            print("**********************************")
			count = count + 1
		end
	end
end

function unescape(s)
    s = string.gsub(s, "+", " ")
    s = string.gsub(s, "%%(%x%x)", function (h)
        return string.char(tonumber(h, 16))
        end)
    return s
end

function show_message(player, string)
    local elem = game:newclienthudelem(player)
    elem.elemType = "font"
    elem.font = "default"
    elem.fontscale = 2
    elem.x = 0
    elem.y = -100
    elem.alignx = "center"
    elem.aligny = "middle"
    elem.horzalign = "center"
    elem.vertalign = "middle"
    --elem.glowcolor = vector:new(1.0, 1.0, 1.0)
    --elem.glowalpha = 0.5
    elem.color = vector:new(1.0, 1.0, 1.0)
    elem.alpha = 1
    elem:settext(string)
    elem:setpulsefx(40, 6000, 600)
    
    game:ontimeout(function()
        elem:destroy()
    end, 4000)
end

function spawnmotorbike(player)
    if motorbike ~= nil then
		motorbike:delete()
        motorbike_spawned = false
	end

	motorbike = game:spawn("script_model", player.origin)
	motorbike.origin = player.origin
	motorbike.angles = player.angles
	motorbike:setmodel("vehicle_urb_police_hoverbike_ai")
	motorbike:scriptmodelplayanim("urban_hoverbike_idle")
	motorbike:enablelinkto()
    motorbike_spawned = true
    --print("motorbike_spawned = true")

    if motorbikefx_timer ~= nil then
        motorbikefx_timer:clear()
    end
    function motorbike_fx()
        local fx = game:spawnfx(forge_fx["motorbike1"], motorbike.origin)
	    game:triggerfx(fx)	
    end
    motorbikefx_timer = game:oninterval(motorbike_fx, 100)
    motorbike:setcursorhint("HINT_ACTIVE")
	motorbike:sethintstring("Press [{+activate}] to enter Motorbike.")
	motorbike:makeusable()
    player_motorbike = false
    motorbike:onnotify("trigger", function() watchmotorbikeusage(motorbike, player) end)
end

function watchmotorbikeusage(motorbike, player)
    --print("watchmotorbikeusage")
    if player_motorbike == true then
        --print("exitmotorbike")
        player:notify("exitmotorbike")
        motorbike:setcursorhint("HINT_ACTIVE")
        motorbike:sethintstring("Press [{+activate}] to enter ^:Motorbike")
        player:unlink()
	    player:freezecontrols(false)
	    player:setorigin(vector:new(motorbike.origin.x + math.floor(math.random (-50, 50)), motorbike.origin.y + math.floor(math.random (-50, 50)), motorbike.origin.z))
        game:setdvar("camera_thirdperson", 0)
        player:allowprone(true)
        player:allowstand(true)
        player:allowcrouch(true)
        player:setstance("stand")
        player:notifyonplayercommandremove( "motorbike_active", "+breath_sprint" )
	    player:notifyonplayercommandremove( "motorbike_active", "+melee_breath" )
	    player:notifyonplayercommandremove( "motorbike_inactive", "-breath_sprint" )
	    player:notifyonplayercommandremove( "motorbike_inactive", "-melee_breath" )
        player_motorbike = false
        player_motorbike_active = false
    elseif player_motorbike == false then
        player_motorbike = true
        --print("entermotorbike")
        player:notify("entermotorbike")
        motorbike:setcursorhint("HINT_ACTIVE")
	    motorbike:sethintstring("Press [{+activate}] to exit ^:Motorbike")

	    player:setorigin(motorbike:gettagorigin("tag_body"))
	    player:setangles(motorbike.angles)
        player:allowprone(false)
        player:allowstand(false)
        player:allowcrouch(true)
        player:setstance("crouch")
	    player:playerlinkto(motorbike, "tag_body", 1, 70, 70, 20, 20, false )
        game:setdvar("camera_thirdperson", 0)
        player:notifyonplayercommand( "motorbike_active", "+breath_sprint" )
	    player:notifyonplayercommand( "motorbike_active", "+melee_breath" )
	    player:notifyonplayercommand( "motorbike_inactive", "-breath_sprint" )
	    player:notifyonplayercommand( "motorbike_inactive", "-melee_breath" )
        trottlemotorbike(motorbike, player)
        rotatemotorbike(motorbike, player)
    end
end

function rotatemotorbike(motorbike, player)
    if motorbikerotate_timer ~= nil then
        motorbikerotate_timer:clear()
        --print("motorbikerotate_timer cleared")
    end
    function motorbike_rotate()
        if player_motorbike == true then
            --print("motorbike_rotate")
            motorbike:rotateto(player.angles, 0.3, 0, 0) --rotateto
        end
    end
    motorbikerotate_timer = game:oninterval(motorbike_rotate, 50)
end
function trottlemotorbike(motorbike, player)
    player_motorbike_active = false
	player:onnotify("motorbike_active", function()
        --print("motorbike_active")
        player_motorbike_active = true
        if motorbike_timer ~= nil then
            motorbike_timer:clear()
            --print("motorbike_timer cleared")
        end
        function motorbike_drive()
            if player_motorbike_active == true then
                --print("player_motorbike_active")
                local forward = player:gettagorigin("j_head")
		        local endpos = vector_scal(game:anglestoforward(player:getangles()), 100)
		        local endpos2 = vector:new(endpos.x + forward.x, endpos.y + forward.y, motorbike.origin.z)
                motorbike:moveto(endpos2, 0.1, 0, 0)

                game:earthquake(0.15, 0.2, player:gettagorigin("j_spine4"), 50)
            end
        end
        motorbike_timer = game:oninterval(motorbike_drive, 50)
    end)
    player:onnotify("motorbike_inactive", function() 
        --print("motorbike_inactive") 
        player_motorbike_active = false 
        motorbike_timer:clear() 
    end)
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end