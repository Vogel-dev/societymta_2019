--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local showed = false

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

local f = dxCreateFont("cz.ttf", 15)

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

panelOrg = guiCreateGridList(0.42, 0.07, 0.17, 0.23, true)
guiGridListAddColumn(panelOrg, "ID", 0.15)
guiGridListAddColumn(panelOrg, "Model", 0.3)
guiGridListAddColumn(panelOrg, "Organizacja", 0.3)
guiSetVisible(panelOrg, false)

function gui()
	dxDrawImage(screenW * 0.4083, screenH * 0.0194, screenW * 0.1839, screenH * 0.3352, "window.png")
	if isMouseIn(screenW * 0.4714, screenH * 0.3060, screenW * 0.0571, screenH * 0.0391) then
		dxDrawImage(screenW * 0.4714, screenH * 0.3060, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(screenW * 0.4714, screenH * 0.3060, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
    dxDrawText("Przepisz", screenW * 0.4714, screenH * 0.3060, screenW * 0.5286, screenH * 0.3451, tocolor(150, 150, 150, 255), 1.00, f, "center", "center", false, false, false, false, false)
	if isMouseIn(screenW * 0.5769, screenH * 0.0260, screenW * 0.0110, screenH * 0.0247) then
		dxDrawImage(screenW * 0.5769, screenH * 0.0260, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(screenW * 0.5769, screenH * 0.0260, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
end

function otworz()
	if showed then return end
	addEventHandler("onClientRender", getRootElement(), gui)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	showed = true
	guiSetVisible(panelOrg, true)
end

addEvent("showOrgWindow", true)
addEventHandler("showOrgWindow", root, function(result, id)
	guiGridListClear(panelOrg)
	if not result then return end
	for i,v in pairs(result) do
		local sprawdz = guiGridListAddRow(panelOrg)
		otworz(localPlayer)
		guiGridListSetItemText(panelOrg, sprawdz, 1, v["id"], false, false)
		guiGridListSetItemText(panelOrg, sprawdz, 2, getVehicleNameFromModel(v["model"]), false, false)
		guiGridListSetItemText(panelOrg, sprawdz, 3, v["organizacja"], false, false)
	end
end)

function zamknij()
	removeEventHandler("onClientRender", getRootElement(), gui)
	showCursor(false)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	--executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", false)
	guiSetVisible(panelOrg, false)
	showed = false
end
addEvent("destroyOrgWindow", true)
addEventHandler("destroyOrgWindow", root, zamknij)

addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" then
		if isMouseIn(screenW * 0.4714, screenH * 0.3060, screenW * 0.0571, screenH * 0.0391) and guiGetVisible(panelOrg) then
			local wybral = guiGridListGetSelectedItem(panelOrg) or 0
			local dbid = guiGridListGetItemText(panelOrg, wybral, 1)
			if wybral < 0 then return end
			triggerServerEvent("przepisz", localPlayer, localPlayer, tonumber(dbid))
			zamknij(localPlayer)
		elseif isMouseIn(screenW * 0.5769, screenH * 0.0260, screenW * 0.0110, screenH * 0.0247) and guiGetVisible(panelOrg) then
			zamknij(localPlayer)
		end
	end
end)