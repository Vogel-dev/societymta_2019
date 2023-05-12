--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local sx, sy = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
local font = dxCreateFont("cz.ttf", 14)
local font2 = dxCreateFont("cz.ttf", 19)
local naprawiany_pojazd = false
local okno1 = false
local okno2 = false
local okno3 = false
local okno4 = false

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

local blip = createBlip(-2060.11, 175.47, 28.52, 55)
setBlipVisibleDistance(blip, 300)

local blip2 = createBlip(-2090.42, 1422.11, 7.10, 55)
setBlipVisibleDistance(blip2, 300)


local stanowiska = {
{-2050.83, 178.81, 28.85},
{-2050.69, 170.41, 28.84},
{-2279.93, -127.27, 35.32},
{-2074.36, 1422.46, 7.10},
{-2090.77, 1421.93, 7.10},

}

for i,v in ipairs(stanowiska) do
	marker = createMarker(v[1], v[2], v[3]-1.95, "cylinder", 2.5, 153, 85, 187, 100)
	setElementData(marker, "mechanik", true)
	addEventHandler("onClientMarkerHit", marker, function(gracz)
		if gracz ~= localPlayer then return end
		local pojazd = getPedOccupiedVehicle(localPlayer)
		if not pojazd then return end
		if getVehicleController(pojazd) ~= localPlayer then return end
		if isElement(naprawa1) then
			destroyElement(naprawa1)
		end
		if isElement(naprawa2) then
			destroyElement(naprawa2)
		end
		if isElement(naprawa3) then
			destroyElement(naprawa3)
		end
		if isElement(naprawa4) then
			destroyElement(naprawa4)
		end
		local x,y,z = getElementPosition(pojazd)
		naprawa1 = createMarker(x,y,z, "cylinder", 0.3, 185, 43, 39, 50)
		addEventHandler("onClientMarkerHit", naprawa1, naprawaprzod)
		naprawa2 = createMarker(x,y,z, "cylinder", 0.3, 185, 43, 39, 50)
		addEventHandler("onClientMarkerHit", naprawa2, naprawatyl)
		naprawa3 = createMarker(x,y,z, "cylinder", 0.3, 21, 101, 192, 50)
		addEventHandler("onClientMarkerHit", naprawa3, naprawaprawy)
		naprawa4 = createMarker(x,y,z, "cylinder", 0.6, 21, 101, 192, 50)
		addEventHandler("onClientMarkerHit", naprawa4, naprawalewy)
		setElementData(naprawa1, "naprawianypojazd", pojazd)
		setElementData(naprawa2, "naprawianypojazd", pojazd)
		setElementData(naprawa3, "naprawianypojazd", pojazd)
		setElementData(naprawa4, "naprawianypojazd", pojazd)
		attachElements(naprawa1, pojazd, 0, 3.3, -0.6)
		attachElements(naprawa2, pojazd, 0, -3.3, -0.6)
		attachElements(naprawa3, pojazd, 2, 0, -0.6)
		attachElements(naprawa4, pojazd, -2, 0, -0.6)
		setElementData(pojazd, "naprawiany", true)
	end)
	addEventHandler("onClientMarkerLeave", marker, function(gracz)
		if gracz ~= localPlayer then return end
		local pojazd = getPedOccupiedVehicle(localPlayer)
		if not pojazd then return end
		if getVehicleController(pojazd) ~= localPlayer then return end
		if isElement(naprawa1) then
			destroyElement(naprawa1)
		end
		if isElement(naprawa2) then
			destroyElement(naprawa2)
		end
		if isElement(naprawa3) then
			destroyElement(naprawa3)
		end
		if isElement(naprawa4) then
			destroyElement(naprawa4)
		end
	end)
end

-- przod

local czesciprzod = {
	{"Silnik", 1, 100, "silnik"},
	{"Maska", 2, 50, "zderzak"},
	{"Szyba przednia", 8, 50, "zderzak"},
	{"Zderzak przedni", 9, 50, "zderzak"},
	{"Światło lewy przód", 11, 50, "swiatla"},
	{"Światło prawy przód", 12, 50, "swiatla"},
}

function sprawdz_czesc1(czesc)
	if czesc  ==  1 then
		if getElementHealth(naprawiany_pojazd) > 1000 then 
			return true 
		else
			return false
		end
	elseif czesc  ==  2 then
		if getVehicleDoorState(naprawiany_pojazd, 0) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  8 then
		if getVehiclePanelState(naprawiany_pojazd, 4) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  9 then
		if getVehiclePanelState(naprawiany_pojazd, 5) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  11 then
		if getVehicleLightState(naprawiany_pojazd, 0) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  12 then
		if getVehicleLightState(naprawiany_pojazd, 1) == 0 then
			return true
		else
			return false
		end
	end
end

local grid1 = { }

function naprawaprzod(gracz)
	if gracz ~= localPlayer then return end
	if getPedOccupiedVehicle(localPlayer) then return end
	naprawiany_pojazd = getElementData(source, "naprawianypojazd")
	for i, v in ipairs(czesciprzod) do
		if sprawdz_czesc1(tonumber(v[2])) ~= true then
			table.insert(grid1, {1, v[1], v[2], v[3], v[4]})
		end
	end
	okno1 = true
	addEventHandler("onClientRender", root, gui1)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")	
	setElementData(localPlayer, "player:blackwhite", true)
	setElementFrozen(localPlayer, true)
end

function gui1()
	dxDrawImage(screenW * 0.3404, screenH * 0.2344, screenW * 0.3243, screenH * 0.5404, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Naprawanie cześci z przodu", scale_x(506), scale_y(220), scale_x(934), scale_y(279), tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        else
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        end
    for i, v in ipairs(grid1) do
    	local dodatekY = (scale_y(63))*(i-1)
    	local dodatekY2 = (scale_y(126))*(i-1)

    	dxDrawRectangle(scale_x(519), scale_y(280)+dodatekY, scale_x(405), scale_y(60), tocolor(0, 0, 0, 120), false)
    	dxDrawImage(scale_x(529), scale_y(285)+dodatekY, scale_x(50), scale_y(50), "gfx/"..v[5]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	shadowText(v[2], scale_x(600), scale_y(280)+dodatekY2, scale_x(736), scale_y(310), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    	shadowText("Cena naprawy: "..v[4].." $", scale_x(600), scale_y(310)+dodatekY2, scale_x(736), scale_y(340), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
		if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) then
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        else
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        end
    	shadowText("Napraw", scale_x(806), scale_y(291)+dodatekY2, scale_x(913), scale_y(327), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	for i,v in ipairs(grid1) do
  		local dodatekY = (scale_y(63))*(i-1)
  		if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) and okno1 == true then
  			local hajs = getElementData(localPlayer, "pieniadze") or 0
  			if hajs >= tonumber(v[4]) then
				exports["smta_base_notifications"]:noti("Naprawiłeś "..v[2].." za "..v[4].." $")
				table.remove(grid1, i)
				triggerServerEvent("napraw:czesc", localPlayer, naprawiany_pojazd, v[3])
				setElementData(localPlayer, "pieniadze", hajs-tonumber(v[4]))
			else
				exports["smta_base_notifications"]:noti("Niestać cię na naprawe tej części", "error")
			end
  		end
  	end
    if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) and okno1 == true then
    	removeEventHandler("onClientRender", root, gui1)
    	okno1 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    	grid1 = { }
    	setElementFrozen(localPlayer, false)
    end
  end
end)

-- tyl

local czescityl = {
	{"Bagażnik", 3, 50, "zderzak"},
	{"Zderzak tylni", 10, 50, "zderzak"},
}

function sprawdz_czesc2(czesc)
	if czesc  ==  3 then 
		if getVehicleDoorState(naprawiany_pojazd, 1) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  10 then
		if getVehiclePanelState(naprawiany_pojazd, 6) == 0 then
			return true
		else
			return false
		end
	end
end

local grid2 = { }

function naprawatyl(gracz)
	if gracz ~= localPlayer then return end
	if getPedOccupiedVehicle(localPlayer) then return end
	naprawiany_pojazd = getElementData(source, "naprawianypojazd")
	for i, v in ipairs(czescityl) do
		if sprawdz_czesc2(tonumber(v[2])) ~= true then
			table.insert(grid2, {1, v[1], v[2], v[3], v[4]})
		end
	end
	okno2 = true
	addEventHandler("onClientRender", root, gui2)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	setElementFrozen(localPlayer, true)
end

function gui2()
	dxDrawImage(screenW * 0.3404, screenH * 0.2344, screenW * 0.3243, screenH * 0.5404, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Naprawanie cześci z tyłu", scale_x(506), scale_y(220), scale_x(934), scale_y(279), tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        else
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        end
    for i, v in ipairs(grid2) do
    	local dodatekY = (scale_y(63))*(i-1)
    	local dodatekY2 = (scale_y(126))*(i-1)

    	dxDrawRectangle(scale_x(519), scale_y(280)+dodatekY, scale_x(405), scale_y(60), tocolor(0, 0, 0, 120), false)
    	dxDrawImage(scale_x(529), scale_y(285)+dodatekY, scale_x(50), scale_y(50), "gfx/"..v[5]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	shadowText(v[2], scale_x(600), scale_y(280)+dodatekY2, scale_x(736), scale_y(310), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    	shadowText("Cena naprawy: "..v[4].." $", scale_x(600), scale_y(310)+dodatekY2, scale_x(736), scale_y(340), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
		if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) then
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        else
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        end
    	shadowText("Napraw", scale_x(806), scale_y(291)+dodatekY2, scale_x(913), scale_y(327), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	for i,v in ipairs(grid2) do
  		local dodatekY = (scale_y(63))*(i-1)
  		if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) and okno2 == true then
  			local hajs = getElementData(localPlayer, "pieniadze") or 0
  			if hajs >= tonumber(v[4]) then
				exports["smta_base_notifications"]:noti("Naprawiłeś "..v[2].." za "..v[4].." $")
				table.remove(grid2, i)
				triggerServerEvent("napraw:czesc", localPlayer, naprawiany_pojazd, v[3])
				setElementData(localPlayer, "pieniadze", hajs-tonumber(v[4]))
			else
				exports["smta_base_notifications"]:noti("Niestac cię na naprawe tej części", "error")
			end
  		end
  	end
    if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) and okno2 == true then
    	removeEventHandler("onClientRender", root, gui2)
    	okno2 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    	grid2 = { }
    	setElementFrozen(localPlayer, false)
    end
  end
end)

-- lewa strona

local czescilewa = {
	{"Drzwi lewy przód", 4, 50, "drzwi"},
	{"Drzwi lewy tył", 6, 50, "drzwi"},
}

function sprawdz_czesc3(czesc)
	if czesc  ==  4 then
		if getVehicleDoorState(naprawiany_pojazd, 2) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  6 then
		if getVehicleDoorState(naprawiany_pojazd, 4) == 0 then
			return true
		else
			return false
		end
	end
end

local grid3 = { }

function naprawalewy(gracz)
	if gracz ~= localPlayer then return end
	naprawiany_pojazd = getElementData(source, "naprawianypojazd")
	if getPedOccupiedVehicle(localPlayer) then return end
	for i, v in ipairs(czescilewa) do
		if sprawdz_czesc3(tonumber(v[2])) ~= true then
			table.insert(grid3, {1, v[1], v[2], v[3], v[4]})
		end
	end
	okno3 = true
	addEventHandler("onClientRender", root, gui3)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	setElementFrozen(localPlayer, true)
end

function gui3()
	dxDrawImage(screenW * 0.3404, screenH * 0.2344, screenW * 0.3243, screenH * 0.5404, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Naprawanie cześci z lewej strony", scale_x(506), scale_y(220), scale_x(934), scale_y(279), tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        else
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        end
    for i, v in ipairs(grid3) do
    	local dodatekY = (scale_y(63))*(i-1)
    	local dodatekY2 = (scale_y(126))*(i-1)

    	dxDrawRectangle(scale_x(519), scale_y(280)+dodatekY, scale_x(405), scale_y(60), tocolor(0, 0, 0, 120), false)
    	dxDrawImage(scale_x(529), scale_y(285)+dodatekY, scale_x(50), scale_y(50), "gfx/"..v[5]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	shadowText(v[2], scale_x(600), scale_y(280)+dodatekY2, scale_x(736), scale_y(310), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    	shadowText("Cena naprawy: "..v[4].." $", scale_x(600), scale_y(310)+dodatekY2, scale_x(736), scale_y(340), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    	if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) then
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        else
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        end
    	shadowText("Napraw", scale_x(806), scale_y(291)+dodatekY2, scale_x(913), scale_y(327), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	for i,v in ipairs(grid3) do
  		local dodatekY = (scale_y(63))*(i-1)
  		if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) and okno3 == true then
  			local hajs = getElementData(localPlayer, "pieniadze") or 0
  			if hajs >= tonumber(v[4]) then
				exports["smta_base_notifications"]:noti("Naprawiłeś "..v[2].." za "..v[4].." $")
				table.remove(grid3, i)
				triggerServerEvent("napraw:czesc", localPlayer, naprawiany_pojazd, v[3])
				setElementData(localPlayer, "pieniadze", hajs-tonumber(v[4]))
			else
				exports["smta_base_notifications"]:noti("Niestac cię na naprawe tej części", "error")
			end
  		end
  	end
    if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) and okno3 == true then
    	removeEventHandler("onClientRender", root, gui3)
    	okno3 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    	grid3 = { }
    	setElementFrozen(localPlayer, false)
    end
  end
end)


-- prawa strona

local czesciprawa = {
	{"Drzwi prawy przód", 5, 50, "drzwi"},
	{"Drzwi prawy tył", 7, 50, "drzwi"},
}

function sprawdz_czesc4(czesc)
	if czesc  ==  5 then
		if getVehicleDoorState(naprawiany_pojazd, 3) == 0 then
			return true
		else
			return false
		end
	elseif czesc  ==  7 then
		if getVehicleDoorState(naprawiany_pojazd, 5) == 0 then
			return true
		else
			return false
		end
	end
end

local grid4 = { }

function naprawaprawy(gracz)
	if gracz ~= localPlayer then return end
	naprawiany_pojazd = getElementData(source, "naprawianypojazd")
	if getPedOccupiedVehicle(localPlayer) then return end
	for i, v in ipairs(czesciprawa) do
		if sprawdz_czesc4(tonumber(v[2])) ~= true then
			table.insert(grid4, {1, v[1], v[2], v[3], v[4]})
		end
	end
	okno4 = true
	addEventHandler("onClientRender", root, gui4)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	setElementFrozen(localPlayer, true)
end

function gui4()
	dxDrawImage(screenW * 0.3404, screenH * 0.2344, screenW * 0.3243, screenH * 0.5404, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Naprawanie cześci z prawej strony", scale_x(506), scale_y(220), scale_x(934), scale_y(279), tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        else
        	dxDrawImage(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        end
    for i, v in ipairs(grid4) do
    	local dodatekY = (scale_y(63))*(i-1)
    	local dodatekY2 = (scale_y(126))*(i-1)

    	dxDrawRectangle(scale_x(519), scale_y(280)+dodatekY, scale_x(405), scale_y(60), tocolor(0, 0, 0, 120), false)
    	dxDrawImage(scale_x(529), scale_y(285)+dodatekY, scale_x(50), scale_y(50), "gfx/"..v[5]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	shadowText(v[2], scale_x(600), scale_y(280)+dodatekY2, scale_x(736), scale_y(310), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    	shadowText("Cena naprawy: "..v[4].." $", scale_x(600), scale_y(310)+dodatekY2, scale_x(736), scale_y(340), tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
		if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) then
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        else
        	dxDrawImage(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34), ":smta_veh_stations/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false, false, false, false, false)
        end
    	shadowText("Napraw", scale_x(806), scale_y(291)+dodatekY2, scale_x(913), scale_y(327), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	for i,v in ipairs(grid4) do
  		local dodatekY = (scale_y(63))*(i-1)
  		if mysz(scale_x(807), scale_y(292)+dodatekY, scale_x(106), scale_y(34)) and okno4 == true then
  			local hajs = getElementData(localPlayer, "pieniadze") or 0
  			if hajs >= tonumber(v[4]) then
				exports["smta_base_notifications"]:noti("Naprawiłeś "..v[2].." za "..v[4].." $")
				table.remove(grid4, i)
				triggerServerEvent("napraw:czesc", localPlayer, naprawiany_pojazd, v[3])
				setElementData(localPlayer, "pieniadze", hajs-tonumber(v[4]))
			else
				exports["smta_base_notifications"]:noti("Niestac cię na naprawe tej części", "error")
			end
  		end
  	end
    if mysz(screenW * 0.6463, screenH * 0.2474, screenW * 0.0110, screenH * 0.0247) and okno4 == true then
    	removeEventHandler("onClientRender", root, gui4)
    	okno4 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    	grid4 = { }
    	setElementFrozen(localPlayer, false)
    end
  end
end)

addEventHandler("onClientVehicleEnter", root, function(thePlayer, seat)
	if seat ~= 0 then return end
	if thePlayer ~= localPlayer then return end
	if getElementData(source, "naprawiany") then
		if isElement(naprawa1) then
			destroyElement(naprawa1)
		end
		if isElement(naprawa2) then
			destroyElement(naprawa2)
		end
		if isElement(naprawa3) then
			destroyElement(naprawa3)
		end
		if isElement(naprawa4) then
			destroyElement(naprawa4)
		end
	end
end)

-- dodatki

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
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