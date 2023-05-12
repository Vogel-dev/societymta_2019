--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local px,py = sx/1440, sy/900

local font = dxCreateFont("cz.ttf", 14)

local okno = false

local miejsca = {
	{301.42, 182.01, 1007.17, 3},
	{-2122.66, 544.85, 44.44, 0},
	{1589.55, 1723.45, -33.73, 1},
}

for i, v in ipairs(miejsca) do
	local marker = createMarker(v[1], v[2], v[3]-.95, "cylinder", 1.1, 59, 122, 87, 100)
	setElementInterior(marker, v[4])
	addEventHandler("onClientMarkerHit", marker, function(gracz)
		if gracz ~= localPlayer then return end
        if getElementData(localPlayer, "frakcja") then
		  addEventHandler("onClientRender", root, gui)
		  okno = true
          showCursor(true)
          setElementData(localPlayer, "hud", true)
            showChat(false)
            executeCommandHandler("radar")
            setElementData(localPlayer, "player:blackwhite", true)
        end
	end)
end


function gui()
	local wyplata = (getElementData(localPlayer, "sluzba") or 0) * (getElementData(localPlayer, "frakcja:wyplata") or 0)
	dxDrawImage(screenW * 0.4063, screenH * 0.3945, screenW * 0.1874, screenH * 0.2122, ":smta_factions_payouts/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Wypłata: "..wyplata.." $", screenW * 0.4070, screenH * 0.4414, screenW * 0.5937, screenH * 0.5443, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    if mysz(screenW * 0.4714, screenH * 0.5443, screenW * 0.0571, screenH * 0.0391) then
        dxDrawImage(screenW * 0.4714, screenH * 0.5443, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
        dxDrawImage(screenW * 0.4714, screenH * 0.5443, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    shadowText("Odbierz", screenW * 0.4714, screenH * 0.5456, screenW * 0.5286, screenH * 0.5833, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    if mysz(screenW * 0.5754, screenH * 0.4036, screenW * 0.0110, screenH * 0.0247) then
        dxDrawImage(screenW * 0.5754, screenH * 0.4036, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
        dxDrawImage(screenW * 0.5754, screenH * 0.4036, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
end


addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.4714, screenH * 0.5443, screenW * 0.0571, screenH * 0.0391) and okno == true then
        removeEventHandler("onClientRender", root, gui)
        showCursor(false)
        setElementData(localPlayer, "hud", false)
        showChat(true)
        executeCommandHandler("radar")
        setElementData(localPlayer, "player:blackwhite", false)
        okno = false
        local wyplata = getElementData(localPlayer, "sluzba")*getElementData(localPlayer, "frakcja:wyplata")
        setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+wyplata)
        setElementData(localPlayer, "sluzba", 0)
    elseif mysz(screenW * 0.5754, screenH * 0.4036, screenW * 0.0110, screenH * 0.0247) and okno == true then
        removeEventHandler("onClientRender", root, gui)
        showCursor(false)
        setElementData(localPlayer, "hud", false)
        showChat(true)
        executeCommandHandler("radar")
        setElementData(localPlayer, "player:blackwhite", false)
        okno = false
    end
  end
end)

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

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