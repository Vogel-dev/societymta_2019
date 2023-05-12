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

local okno = false

local rzeczy = {
	--- nazwa, tekst, cena, %najedzenia, grafika
	{"Hamburger", "", 15, 20, 1},
	{"Hotdog", "", 5, 15, 2},
	{"Kebab", "", 10, 25, 3},
	{"Woda", "", 3, 5, 7},
	{"Cola", "", 4, 5, 6},
}

function gui()
	dxDrawImage(screenW * 0.3581, screenH * 0.2721, screenW * 0.2846, screenH * 0.4557, ":smta_base_eats/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.6243, screenH * 0.2852, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6243, screenH * 0.2852, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.6243, screenH * 0.2852, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    for i, v in ipairs(rzeczy) do
    	local dodatekY = (73*py)*(i-1)
    	local dodatekY2 = (146*py)*(i-1)
			if mysz(screenW * 0.5757, screenH * 0.3477, screenW * 0.0485, screenH * 0.0339) then
        	dxDrawImage(screenW * 0.5757, screenH * 0.3477, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5757, screenH * 0.3477, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
			if mysz(screenW * 0.5757, screenH * 0.4258, screenW * 0.0485, screenH * 0.0339) then
        	dxDrawImage(screenW * 0.5757, screenH * 0.4258, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5757, screenH * 0.4258, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
			if mysz(screenW * 0.5757, screenH * 0.5039, screenW * 0.0485, screenH * 0.0339) then
        	dxDrawImage(screenW * 0.5757, screenH * 0.5039, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5757, screenH * 0.5039, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
			if mysz(screenW * 0.5757, screenH * 0.5807, screenW * 0.0485, screenH * 0.0339) then
        	dxDrawImage(screenW * 0.5757, screenH * 0.5807, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5757, screenH * 0.5807, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
			if mysz(screenW * 0.5757, screenH * 0.6602, screenW * 0.0485, screenH * 0.0339) then
        	dxDrawImage(screenW * 0.5757, screenH * 0.6602, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5757, screenH * 0.6602, screenW * 0.0485, screenH * 0.0339, ":smta_base_eats/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
   	end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	for i,v in ipairs(rzeczy) do
  		local dodatekY = (73*py)*(i-1)
  		if mysz(826*px, 301*py+dodatekY, 100*px, 50*py) and okno == true then
  			--local najedzenie = getElementData(localPlayer, "najedzenie") or 0
  			--if najedzenie >= 100 then exports["smta_base_notifications"]:noti("Jesteś najedzony", "error") return end
			  --setElementData(localPlayer, "najedzenie", najedzenie+tonumber(v[4]))
			if getElementData( localPlayer, "pieniadze" ) < tonumber(v[3]) then
				exports['smta_base_notifications']:noti( "Brakuje Ci pieniędzy, na zakupienie tego.", "error" );
				return;
			end
  			setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-tonumber(v[3]))
  			exports["smta_base_notifications"]:noti("Kupujesz "..v[1].."")
			triggerServerEvent("daj:fastfoody", localPlayer, v[1])
  		end
  	end
    if mysz(screenW * 0.6243, screenH * 0.2852, screenW * 0.0110, screenH * 0.0247) and okno == true then
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
  	if getElementDimension(localPlayer) ~= 0 or getElementInterior(localPlayer) ~= 0 then return end
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