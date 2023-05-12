--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = screenW/1440, screenH/900
local sx2, sy2 = guiGetScreenSize()

local lveh = false
local panel = false
local player = getLocalPlayer()
local font = dxCreateFont("cz.ttf", 14)

addEventHandler("onClientRender", root, function()
    lveh = getPedTarget(player)
    if lveh and getElementType(lveh) == "vehicle" then
        local vx, vy, vz = getElementPosition(lveh)
        local px, py, pz = getElementPosition(player)
        local distance = getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz)
        if distance < 15 then
            if getDoor(lveh) == 0 and (getElementData(lveh, "ms1") == 1 or getElementData(lveh, "ms2") == 1 or getElementData(lveh, "ms3") == 1) then
                if getElementData(lveh, "wlasciciel") == getElementData(player, "dbid") then
                    if panel == true then return end
                    dxDrawImage(screenW * 0.0146, screenH * 0.6250, screenW * 0.1947, screenH * 0.0885, ":smta_jobs_farm/gfx/bg3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                    shadowText("Kliknij 'E', aby edytować silnik pojazdu.", screenW * 0.0146, screenH * 0.6237, screenW * 0.2086, screenH * 0.7135, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
                end
            end
        end
    end
end)

function getPlayerToVehicleRelatedPosition()    
    if (lveh) and (getElementType(lveh) == "vehicle") then   
        local vx, vy, vz = getElementPosition(lveh)
        local rxv, ryv, rzv = getElementRotation(lveh)
        local px, py, pz = getElementPosition(player)
        local anglePlayerToVehicle = math.atan2(px - vx, py - vy)
        local formattedAnglePlayerToVehicle = math.deg(anglePlayerToVehicle) + 180
        local vehicleRelatedPosition = formattedAnglePlayerToVehicle + rzv
        
        if (vehicleRelatedPosition < 0) then
            vehicleRelatedPosition = vehicleRelatedPosition + 360
        elseif (vehicleRelatedPosition > 360) then
            vehicleRelatedPosition = vehicleRelatedPosition - 360
        end
        
        return math.floor(vehicleRelatedPosition) + 2
    else
        return "false"
    end
end

function getDoor(lookAtVehicle)
    local vehicle = lookAtVehicle
    if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
        return 0
    end
end

function gui()
    local tryb1 = getElementData(lveh, "ms1:tryb") or 1
    local tryb2 = getElementData(lveh, "ms2:tryb") or 1
    local tryb3 = getElementData(lveh, "ms3:tryb") or 1
    dxDrawImage(screenW * 0.3441, screenH * 0.2370, screenW * 0.3118, screenH * 0.5260, ":smta_veh_boosters/gfx/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    if getElementData(lveh, "ms1") == 1 then
        if tryb1 == 1 then
            dxDrawImage(screenW * 0.3772, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/off_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.3772, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/off_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if tryb1 == 2 then
            dxDrawImage(screenW * 0.4588, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/1star_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.4588, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/1star_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if tryb1 == 3 then
            dxDrawImage(screenW * 0.5404, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/2star_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.5404, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/2star_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    end
    if getElementData(lveh, "ms2") == 1 then
        if tryb2 == 1 then
            dxDrawImage(screenW * 0.3772, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/off_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.3772, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/off_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if tryb2 == 2 then
            dxDrawImage(screenW * 0.4588, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/1star_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.4588, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/1star_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if tryb2 == 3 then
            dxDrawImage(screenW * 0.5404, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/2star_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.5404, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/2star_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    end
    if getElementData(lveh, "ms3") == 1 then
        if tryb3 == 1 then
            dxDrawImage(screenW * 0.3772, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/fwd_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.3772, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/fwd_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if tryb3 == 2 then
            dxDrawImage(screenW * 0.4588, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/awd_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.4588, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/awd_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if tryb3 == 3 then
            dxDrawImage(screenW * 0.5404, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/rwd_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(screenW * 0.5404, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508, ":smta_veh_boosters/gfx/rwd_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    end
	if mysz(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
end

bindKey("e", "down", function()
    if panel == true then return end
    if lveh and getElementType(lveh) == "vehicle" then
        if getDoor(lveh) == 0 and (getElementData(lveh, "ms1") == 1 or getElementData(lveh, "ms2") == 1 or getElementData(lveh, "ms3") == 1) then
            if (getElementData(lveh, "wlasciciel") == getElementData(player, "dbid")) then
                addEventHandler("onClientRender", root, gui)
                panel = true
                showCursor(true)
				setElementData(localPlayer, "hud", true)
				showChat(false)
				triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
				setElementData(localPlayer, "player:blackwhite", true)
				setVehicleDoorOpenRatio(lveh, 0, 1 - getVehicleDoorOpenRatio(lveh, 0), 1000)
            end
        end
    end
end)

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247) and panel == true then
        removeEventHandler("onClientRender", root, gui)
		setVehicleDoorOpenRatio(lveh, 0, 1 - getVehicleDoorOpenRatio(lveh, 0), 1000)
        panel = false
        showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    elseif mysz(screenW * 0.3772, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms1") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 1, getElementData(lveh, "ms1:tryb"), 1)
        setElementData(lveh, "ms1:tryb", 1)
    elseif mysz(screenW * 0.4588, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms1") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 1, getElementData(lveh, "ms1:tryb"), 2)
        setElementData(lveh, "ms1:tryb", 2)
    elseif mysz(screenW * 0.5404, screenH * 0.3880, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms1") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 1, getElementData(lveh, "ms1:tryb"), 3)
        setElementData(lveh, "ms1:tryb", 3)
    elseif mysz(screenW * 0.3772, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms2") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 2, getElementData(lveh, "ms2:tryb"), 1)
        setElementData(lveh, "ms2:tryb", 1)
    elseif mysz(screenW * 0.4588, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms2") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 2, getElementData(lveh, "ms2:tryb"), 2)
        setElementData(lveh, "ms2:tryb", 2)
    elseif mysz(screenW * 0.5404, screenH * 0.5299, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms2") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 2, getElementData(lveh, "ms2:tryb"), 3)
        setElementData(lveh, "ms2:tryb", 3)
    elseif mysz(screenW * 0.3772, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms3") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 3, getElementData(lveh, "ms3:tryb"), 1)
        setElementData(lveh, "ms3:tryb", 1)
    elseif mysz(screenW * 0.4588, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms3") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 3, getElementData(lveh, "ms3:tryb"), 2)
        setElementData(lveh, "ms3:tryb", 2)
    elseif mysz(screenW * 0.5404, screenH * 0.6719, screenW * 0.0816, screenH * 0.0508) and panel == true and getElementData(lveh, "ms3") == 1 then
        triggerServerEvent("ms:hand", localPlayer, lveh, 3, getElementData(lveh, "ms3:tryb"), 3)
        setElementData(lveh, "ms3:tryb", 3)
    end
  end
end)

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx2,cy*sy2
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end