--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local px, py = screenW/1440, screenH/900

local font = dxCreateFont("cz.ttf", 10)
local font2 = dxCreateFont("cz2.ttf", 13)

local blip = createBlip(-2175.25, -39.18, 35.32, 14)
setBlipVisibleDistance(blip, 300)

local okno = false

local rzeczy = {
	--- nazwa, tekst, cena, %najedzenia, grafika
	{"Papieros 'Marlboro Red'", "", 1, 51, 1},
	{"Piwo 'Kuflowe'", "", 1, 39, 2},
	{"Piwo 'Zubr'", "", 3, 65, 3},
	{"Piwo 'Desperados'", "", 6, 18, 7},
	{"'Moet&Chandon'", "", 200, 15, 6},
	{"'Jack Daniels'", "", 75, 51, 1},
	{"'Finlandia'", "", 35, 39, 2},
	{"Gringola", "", 3, 65, 3},
	{"Zestaw naprawczy", "", 5000, 18, 7},
	{"'Srickers'", "", 4, 15, 6},
	{"Chipsy 'Stolarvalue'", "", 3, 15, 6},
}

function gui()
	dxDrawImage(screenW * 0.3587, screenH * 0.1953, screenW * 0.2833, screenH * 0.6094, ":smta_base_shopstolar/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.6245, screenH * 0.2083, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6245, screenH * 0.2083, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.6245, screenH * 0.2083, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    for i, v in ipairs(rzeczy) do
    	local dodatekY = (43.5*py)*(i-1)
		local dodatekY2 = (146*py)*(i-1)
		if mysz(screenW * 0.5761, screenH * 0.2617+dodatekY, screenW * 0.0483, screenH * 0.0339) then
        	dxDrawImage(screenW * 0.5761, screenH * 0.2617+dodatekY, screenW * 0.0483, screenH * 0.0339, ":smta_base_eats/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5761, screenH * 0.2617+dodatekY, screenW * 0.0483, screenH * 0.0339, ":smta_base_eats/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
   	end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	for i,v in ipairs(rzeczy) do
  		local dodatekY = (43.5*py)*(i-1)
  		if mysz(screenW * 0.5761, screenH * 0.2617+dodatekY, screenW * 0.0483, screenH * 0.0339, ":smta_base_eats/gfx/button_on.png") and okno == true then
  			--local najedzenie = getElementData(localPlayer, "najedzenie") or 0
  			--if najedzenie >= 100 then exports["smta_base_notifications"]:noti("Jesteś najedzony", "error") return end
			  --setElementData(localPlayer, "najedzenie", najedzenie+tonumber(v[4]))
			if getElementData( localPlayer, "pieniadze" ) < tonumber(v[3]) then
				exports['smta_base_notifications']:noti( "Brakuje Ci pieniędzy, na zakupienie tego.", "error" );
				return;
			end
  			setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-tonumber(v[3]))
  			exports["smta_base_notifications"]:noti("Kupujesz "..v[1].."")
			triggerServerEvent("daj:rest", localPlayer, v[1])
  		end
  	end
    if mysz(screenW * 0.6245, screenH * 0.2083, screenW * 0.0110, screenH * 0.0247) and okno == true then
    	removeEventHandler("onClientRender", root, gui)
    	okno = false
    	showCursor(false)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", false)
    end
  end
end)

addEventHandler("onClientMarkerHit", resourceRoot, function(gracz)
	if gracz ~= localPlayer then return end
  	if getPedOccupiedVehicle(localPlayer) then return end
  	if getElementData(localPlayer, "bw") then return end
  	--if getElementDimension(localPlayer) ~= 0 or getElementInterior(localPlayer) ~= 0 then return end
	addEventHandler("onClientRender", root, gui)
	okno = true
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(gracz)
  if gracz ~= localPlayer then return end
  removeEventHandler("onClientRender", root, gui)
  okno = false
  showCursor(false)
setElementData(localPlayer, "hud", false)
showChat(true)
--executeCommandHandler("radar")
setElementData(localPlayer, "player:blackwhite", false)
end)

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end