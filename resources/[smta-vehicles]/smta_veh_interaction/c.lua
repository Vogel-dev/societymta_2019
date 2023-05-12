--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sw, sh = guiGetScreenSize();
local zoom = 1;
if sw < 1920 then
    zoom = math.min(2, 1920/sw);
end

local function sx(po)
    return (po/1920)*sw;
end

local function sy(po)
    return (po/1080)*sh;
end

local interakcja = false

local opcja = 3

local font = dxCreateFont("cz.ttf", 12/zoom)

addEventHandler("onClientRender", root, function()
	local stat = getKeyState("lshift")
	if stat == true then
		local veh = getPedOccupiedVehicle(localPlayer)
		if isPedInVehicle(localPlayer) and getVehicleController(veh) == localPlayer then
			interakcja = true
			dxDrawImage(screenW * 0.0000, screenH * 0.4258, screenW * 1.0000, screenH * 0.1484, ":smta_veh_interaction/img/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			if opcja == 1 then
	        	--dxDrawImage(screenW * 0.3691, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/trunk_close.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	--dxDrawImage(screenW * 0.4235, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/handbrake_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4831, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/trunk_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5426, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/handbrake_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5978, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/engine_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        elseif opcja == 2 then
	        	--dxDrawImage(screenW * 0.3691, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/trunk_close.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4235, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/trunk_close.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4831, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/handbrake_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5426, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/engine_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5978, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/light_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			elseif opcja == 3 then
	        	dxDrawImage(screenW * 0.3691, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/trunk_close.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4235, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/handbrake_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4831, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/engine_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5426, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/light_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5978, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/door_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        elseif opcja == 4 then
	        	dxDrawImage(screenW * 0.3691, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/handbrake_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4235, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/engine_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4831, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/light_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5426, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/door_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5978, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/hood_close.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        elseif opcja == 5 then
	        	dxDrawImage(screenW * 0.3691, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/engine_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4235, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/light_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4831, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/door_close.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.5426, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/hood_close.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	--dxDrawImage(screenW * 0.5978, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/hood_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        elseif opcja == 6 then
	        	dxDrawImage(screenW * 0.3691, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/light_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4235, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/door_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	dxDrawImage(screenW * 0.4831, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/hood_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	--dxDrawImage(screenW * 0.5426, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/hood_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	--dxDrawImage(screenW * 0.5978, screenH * 0.4857, screenW * 0.0338, screenH * 0.0521, ":smta_veh_interaction/img/hood_open.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        end
		end
	else
	interakcja = false
	end
end)

bindKey("mouse_wheel_down", "both", function()
	if interakcja ~= true then return end
	opcjawdol()
end)

bindKey("mouse_wheel_up", "both", function()
	if interakcja ~= true then return end
	opcjawgore()
end)

bindKey("arrow_l", "down", function()
	if interakcja ~= true then return end
	opcjawdol()
end)

bindKey("arrow_r", "down", function()
	if interakcja ~= true then return end
	opcjawgore()
end)

bindKey("space", "down", function()
	local veh = getPedOccupiedVehicle(localPlayer)
	if isPedInVehicle(localPlayer) and getVehicleController(veh) == localPlayer and interakcja == true then
		if opcja == 3 then
			triggerServerEvent("odpalSilnik", localPlayer)
		elseif opcja == 4 then
			triggerServerEvent("wlaczSwiatla", localPlayer)
		elseif opcja == 6 then
			triggerServerEvent("otworzMaske", localPlayer)
        elseif opcja == 1 then
        	triggerServerEvent("otworzBagaznik", localPlayer)
        elseif opcja == 2 then
        	triggerServerEvent("zaciagnijReczny", localPlayer)
        elseif opcja == 5 then
        	triggerServerEvent("zamknijDrzwi", localPlayer)
		end
	end
end)

function opcjawdol()
	opcja = opcja - 1
	if opcja < 1 then
		opcja = 6
	end
end

function opcjawgore()
	if opcja > 5 then
		opcja = 1
	return end
	opcja = opcja + 1
end

