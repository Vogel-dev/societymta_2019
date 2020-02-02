--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local px, py = screenW/1440, screenH/900

local font = dxCreateFont("cz.ttf", 16)

local blip = createBlip(-2289.87, -145.83, 35.01, 27)
setBlipVisibleDistance(blip, 300)

local okno = false


function gui()
	local veh = getPedOccupiedVehicle(localPlayer)
	dxDrawImage(screenW * 0.3441, screenH * 0.2656, screenW * 0.3118, screenH * 0.4688, ":smta_veh_boosters_montage/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.6375, screenH * 0.2786, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6375, screenH * 0.2786, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.6375, screenH * 0.2786, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.5426, screenH * 0.3646, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5426, screenH * 0.3646, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5426, screenH * 0.3646, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.5426, screenH * 0.4714, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5426, screenH * 0.4714, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5426, screenH * 0.4714, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.5426, screenH * 0.5781, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5426, screenH * 0.5781, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5426, screenH * 0.5781, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    if getElementData(veh, "ms1") == 1 then
    	shadowText("Zdemontuj", screenW * 0.5449, screenH * 0.3672, screenW * 0.6324, screenH * 0.4128, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    else
    	shadowText("Zamontuj", screenW * 0.5449, screenH * 0.3672, screenW * 0.6324, screenH * 0.4128, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
    if getElementData(veh, "ms2") == 1 then
    	shadowText("Zdemontuj", screenW * 0.5449, screenH * 0.4740, screenW * 0.6324, screenH * 0.5195, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    else
    	shadowText("Zamontuj", screenW * 0.5449, screenH * 0.4740, screenW * 0.6324, screenH * 0.5195, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
    if getElementData(veh, "ms3") == 1 then
    	shadowText("Zdemontuj", screenW * 0.5449, screenH * 0.5807, screenW * 0.6324, screenH * 0.6263, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    else
    	shadowText("Zamontuj", screenW * 0.5449, screenH * 0.5807, screenW * 0.6324, screenH * 0.6263, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
end


addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.6375, screenH * 0.2786, screenW * 0.0110, screenH * 0.0247) and okno == true then
        removeEventHandler("onClientRender", root, gui)
        okno = false
        showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    elseif mysz(screenW * 0.5426, screenH * 0.3646, screenW * 0.0919, screenH * 0.0534) and okno == true then
    	triggerServerEvent("mont:ms", localPlayer, 1)
    elseif mysz(screenW * 0.5426, screenH * 0.4714, screenW * 0.0919, screenH * 0.0534) and okno == true then
    	triggerServerEvent("mont:ms", localPlayer, 2)
    elseif mysz(screenW * 0.5426, screenH * 0.5781, screenW * 0.0919, screenH * 0.0534) and okno == true then
    	triggerServerEvent("mont:ms", localPlayer, 3)
    end
  end
end)


function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*screenW,cy*screenH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

addEventHandler("onClientMarkerHit", resourceRoot, function(gracz)
	if gracz ~= localPlayer then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if getPedOccupiedVehicle(localPlayer) and getElementData(veh, "id") and getVehicleController(veh) == localPlayer then
		addEventHandler("onClientRender", root, gui)
		showCursor(true)
		setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
		setElementData(localPlayer, "player:blackwhite", true)
		okno = true
	end
end)

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end