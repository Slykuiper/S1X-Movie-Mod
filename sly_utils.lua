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
	-- Prints player information
    --print("==============================================")
    --print("Player Info: ", player.name)
    
	--print("Player Origin: ", vectortostring(player.origin))
	--print("Player Angles: ", vectortostring(player:getangles()))
    --print("Player Viewhands 2: " .. player:getviewmodel())
	--print("KEYOUT_" .. player:getcurrentweapon())
    --print("Player Weapon: " .. player:getcurrentweapon())
	--print("Player Weapon 2: " .. player:getcurrentprimaryweapon())
	--print("Player Equipment: " .. player:getcurrentoffhand())
    --print("getweaponarray: " .. player:getweaponarray())
    --print("getweaponattachmentdisplaynames: " .. player:getweaponattachmentdisplaynames(player:getcurrentweapon()))
    --print("getweaponattachments: " .. player:getweaponattachments(player:getcurrentweapon()))
    --print("Current Weapon: " .. game:getweapondisplayname(player:getcurrentweapon()) .. " || " .. player:getcurrentweapon() .. " || " .. game:getweaponmodel(player:getcurrentweapon()))
    --print("==============================================")
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
        player:iclientprintlnbold("yay!")
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
    progressbar_text.font = "bigfixed"
    --progressbar_text.fontscale = 0.5

    progressbar_bg = game:newclienthudelem(player)
    progressbar_bg.alpha = 1
    progressbar_bg.alignx = "center"
	progressbar_bg.aligny = "middle"
    progressbar_bg.horzalign = "center"
	progressbar_bg.vertalign = "middle"
    progressbar_bg.x = 0
    progressbar_bg.y = -80
	progressbar_bg.color = vector:new(0.0, 0.0, 0.0)
	progressbar_bg:setmaterial("white", (progressbar_maxwidth + (progressbar_bg_strokewidth * 2)), (10 + (progressbar_bg_strokewidth * 2)))

    progressbar = game:newclienthudelem(player)
    progressbar.alpha = 1
    progressbar.alignx = "center"
	progressbar.aligny = "middle"
    progressbar.horzalign = "center"
	progressbar.vertalign = "middle"
    progressbar.x = 0
    progressbar.y = -80
	progressbar.color = vector:new(0.5, 1.0, 0.5)
	progressbar:setmaterial("white", progressbar_maxwidth, 10)

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
            progressbar_bg:setmaterial("white", math.floor(progressbar_bg_width), (10 + (progressbar_bg_strokewidth * 2)))
            progressbar:setmaterial("white", math.floor(progressbar_width), 10)
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
			player:iclientprintlnbold(message, i)
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
	player:iclientprintln("Position ^:saved.")
end

function loadPosition(player)
	-- Loads player's position
	if savedorigin ~= nil then
		player:setorigin(savedorigin)
		player:setangles(savedangles)
		player:iclientprintln("Position ^:loaded.")
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

	player:iclientprintln("Timescale ^:", timescale)
	game:setslowmotion(timescale, timescale, 0)
end