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
local ile = 0

local font = dxCreateFont("cz.ttf", 20)
local font2 = dxCreateFont("cz.ttf", 35)

local stacje = {
-- Idlewood
{-2023.97, 156.58, 28.84},
{-1675.52, 402.00, 7.18},
{-1667.00, 410.03, 7.18},
{-1678.87, 421.19, 7.18},
{-1684.28, 416.08, 7.18},
{-1678.68, 410.23, 7.18},
{-1673.03, 416.06, 7.18},
{-2407.04, 970.51, 45.30},
{-2406.72, 981.27, 45.30},
{-2415.09, 981.61, 45.30},
{-2415.10, 970.83, 45.30},
--lertivo
{-2089.36, 1387.22, 7.10},
{-2089.21, 1379.23, 7.10},
{-2079.22, 1379.75, 7.10},
{-2079.15, 1386.91, 7.10},
}

local blipy = {
{-2023.97, 156.58, 28.84},
{-1675.52, 402.00, 7.18},
{-2407.04, 970.51, 45.30},
{-2079.15, 1386.91, 7.10},
}

for i, v in ipairs(stacje) do
	stacja = createMarker(v[1], v[2], v[3]-1.95, "cylinder", 2.5, 21, 96, 189, 100)
	setElementData(stacja, "stacja", true)
end

for i, v in ipairs(blipy) do
	blip = createBlip(v[1], v[2], v[3], 51)
	setBlipVisibleDistance(blip, 150)
end

addEventHandler("onClientMarkerHit", resourceRoot, function(gracz)
	if gracz ~= localPlayer then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		addEventHandler("onClientRender", root, gui)
		tankuje = true
		ile = 0
		showCursor(true)
	end
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(gracz)
	if gracz ~= localPlayer then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		removeEventHandler("onClientRender", root, gui)
		tankuje = false
		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
	end
end)

function tankuj(auto)
	local paliwo = getElementData(auto, "paliwo")
	local bak = getElementData(auto, "bak")
	if tonumber(paliwo) >= tonumber(bak) then return end
	if getElementData(auto, "rodzajpaliwa") == "PB95" then
		if getElementData(localPlayer,"pieniadze") > 3 then
			local suma = string.format("%1d", (4*ile))
			setElementData(auto, "paliwo", paliwo+ile)
			setElementData(localPlayer, "pieniadze", getElementData(localPlayer,"pieniadze")-suma)
			exports["smta_base_notifications"]:noti("Zatankowano pojazd za "..suma.." $")
		end
	elseif getElementData(auto, "rodzajpaliwa") == "ON" then
		if getElementData(localPlayer,"pieniadze") > 5 then
			local suma = string.format("%1d", (6*ile))
			setElementData(auto, "paliwo", paliwo+ile)
			setElementData(localPlayer, "pieniadze", getElementData(localPlayer,"pieniadze")-suma)
			exports["smta_base_notifications"]:noti("Zatankowano pojazd za "..suma.." $")
		end
	end
end

function gui()
	local veh = getPedOccupiedVehicle(localPlayer)
	local cena = 4
	local tekst = "PB95"
	if getElementData(veh, "rodzajpaliwa") == "PB95" then
		cena = 4 
		tekst = "PB95"
	elseif getElementData(veh, "rodzajpaliwa") == "ON" then
		cena = 6 
		tekst = "ON"
	end
	setElementData(localPlayer, "hud", true)
	showChat(false)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
	setElementData(localPlayer, "player:blackwhite", true)
	roundedRectangle(screenW * 0.2824, screenH * 0.5612, screenW * 0.2419/getElementData(veh, "bak")*getElementData(veh, "paliwo"), screenH * 0.0807, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.2654, screenH * 0.3307, screenW * 0.4691, screenH * 0.3398, ":smta_veh_stations/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.7154, screenH * 0.3438, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.7154, screenH * 0.3438, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.7154, screenH * 0.3438, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    shadowText("Dystrybutor "..tekst, screenW * 0.2691, screenH * 0.3359, screenW * 0.7316, screenH * 0.4557, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText(""..string.format("%1.2f", ile).." L", screenW * 0.2816, screenH * 0.4714, screenW * 0.3963, screenH * 0.5313, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.5404, screenH * 0.5664, screenW * 0.1787, screenH * 0.0703) then
        	dxDrawImage(screenW * 0.5404, screenH * 0.5664, screenW * 0.1787, screenH * 0.0703, ":smta_veh_stations/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5404, screenH * 0.5664, screenW * 0.1787, screenH * 0.0703, ":smta_veh_stations/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.5404, screenH * 0.4688, screenW * 0.1787, screenH * 0.0703) then
        	dxDrawImage(screenW * 0.5404, screenH * 0.4688, screenW * 0.1787, screenH * 0.0703, ":smta_veh_stations/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5404, screenH * 0.4688, screenW * 0.1787, screenH * 0.0703, ":smta_veh_stations/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    shadowText("Zatankuj", screenW * 0.5441, screenH * 0.4753, screenW * 0.7162, screenH * 0.5339, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    shadowText("Wyzeruj", screenW * 0.5441, screenH * 0.5716, screenW * 0.7162, screenH * 0.6302, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    shadowText("1 L = "..cena.." $", screenW * 0.4096, screenH * 0.4688, screenW * 0.5243, screenH * 0.5286, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    if getKeyState("space") == true then
		if (getElementData(veh, "paliwo") + ile) >= getElementData(veh, "bak") then return end
		ile = ile+0.01
	end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.7154, screenH * 0.3438, screenW * 0.0110, screenH * 0.0247) and tankuje == true then
    	removeEventHandler("onClientRender", root, gui)
    	tankuje = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    elseif mysz(screenW * 0.5404, screenH * 0.5664, screenW * 0.1787, screenH * 0.0703) and tankuje == true then
    	ile = 0 
    elseif mysz(screenW * 0.5404, screenH * 0.4688, screenW * 0.1787, screenH * 0.0703) and tankuje == true then
    	if ile < 1 then exports["smta_base_notifications"]:noti("Minimalnie musisz zalać 1L", "error") return end
    	tankuj(getPedOccupiedVehicle(localPlayer))
    	ile = 0
    end
  end
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

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

function ramka1(x, y, w, h, color)
  	local color2 = tocolor(185, 43, 39)
  	roundedRectangle(x-2, y-2, w+4, h+4, color2, false)
  	roundedRectangle(x, y, w, h, color, false)
end

function ramka2(x, y, w, h, color)
  	local color2 = tocolor(21, 101, 192)
  	roundedRectangle(x-2, y-2, w+4, h+4, color2, false)
  	roundedRectangle(x, y, w, h, color, false)
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

--[[
setTimer(function()
	local veh = getPedOccupiedVehicle(localPlayer)
	if tankuje == true and veh and getVehicleController(veh) == localPlayer and getKeyState("space") == true then
		tankuj(veh)
	end
end, 110, 0)
]]