--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()

local showed = false
local wybrane = 1
local element = false

local font = dxCreateFont("cz.ttf", 14)
local font2 = dxCreateFont("cz.ttf", 10)

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

local opcje_ekipa = {
{"Brak"},
{"Napraw pojazd"},
{"Postaw pojazd na koła"},
{"Odeślij pojazd do przechowalni"},
{"Zatankuj pojazd"},
{"Zaciągnij ręczny w pojeździe"},
{"Przenieś pojazd do siebie"},
{"Przenieś do pojazdu"},
}

local opcje_policja = {
{"Brak"},
{"Zmierz prędkość pojazdu"},
{"Zaciągnij ręczny w pojeździe"},
}

function gui()
	if not element or element and not isElement(element) then return end
	if isPedInVehicle(localPlayer) then
		removeEventHandler("onClientRender", root, gui)
		element = false
		showed = false
		return
	end
	if getElementData(localPlayer, "duty") then
		if isElementFrozen(element) and opcje_ekipa[6][1] == "Zaciągnij ręczny w pojeździe" then
			opcje_ekipa[6][1] = "Spuść ręczny w pojeździe"
		elseif not isElementFrozen(element) and opcje_ekipa[6][1] == "Spuść ręczny w pojeździe" then
			opcje_ekipa[6][1] = "Zaciągnij ręczny w pojeździe"
		end
		local uid = getElementData(element, "id") or "BRAK"
		local poj = getElementData(element, "pojemnosc") or 1.2
		local rodzaj = getElementData(element, "rodzajpaliwa") or "BRAK"
		local fuel = getElementData(element, "paliwo") or 50
		local bak = getElementData(element, "bak") or 50
		local wlasciciel = getElementData(element, "wlasciciel") or "BRAK"
		local lastuser = getElementData(element, "ostatnikierowca") or "BRAK"
		local mk1 = getElementData(element, "ms1") or 0
		local mk2 = getElementData(element, "ms2") or 0
		local mk3 = getElementData(element, "ms3") or 0
		local distance = getElementData(element, "przebieg") or 0
		distance = string.format("%.1f", distance)
		if fuel then
			stan = "Stan paliwa: "..string.format("%01d", fuel).."/"..bak
		elseif gas then
			stan = "Stan gazu: "..string.format("%01d", gas).."/"..bak
		else
			stan = "BRAK"
		end
	    local h = getVehicleHandling(element)
		local sx,sy,sz = getElementVelocity(element)
		local speed = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*165)
		local org = getElementData(element, "oname") or "BRAK"
		local faction = getElementData(element, "frakcja") or "BRAK"
		local o1 = speed.." KM/H\nID Pojazdu: "..uid.."\nWłaściciel: "..wlasciciel.." (PID) \nOstatni kierowca: "..lastuser
		local o2 = "Model: ("..getVehicleName(element)..") ("..getVehicleModel(element)..")\nPrzebieg pojazdu: "..distance.." KM\n"..stan.."\nStan pojazdu: "..math.floor((getElementHealth(element)/10)).."%\nOrganizacja: "..org.."\nFrakcja: "..faction.."\nSB 1: "..mk1.." SB 2: "..mk2.." SB 3: "..mk3.."\nPojemność silnika: "..poj.."dm³\nRodzaj silnika: "..rodzaj
		dxDrawImage(screenW * 0.3552, screenH * 0.0630, screenW * 0.2896, screenH * 0.2519, "window.png")
		shadowText(o1, screenW * 0.3599, screenH * -0.0352, screenW * 0.4922, screenH * 0.2991, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		shadowText(o2, screenW * 0.5078, screenH * 0.0452, screenW * 0.6401, screenH * 0.2991, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		shadowText("Akcja: "..opcje_ekipa[wybrane][1], screenW * 0.3667, screenH * -0.0154, screenW * 0.6307, screenH * 0.5926, tocolor(255, 0, 0, 255), 1.00, font, "center", "center", false, false, false, false, false)
	else
		if getElementData(localPlayer, "player:duty") == "TEST" then	
		if isElementFrozen(element) and opcje_policja[3][1] == "Zaciągnij ręczny w pojeździe" then
			opcje_policja[3][1] = "Spuść ręczny w pojeździe"
		elseif not isElementFrozen(element) and opcje_policja[3][1] == "Spuść ręczny w pojeździe" then
			opcje_policja[3][1] = "Zaciągnij ręczny w pojeździe"
		end
		local uid = getElementData(element, "veh:uid") or "BRAK"
		local poj = getElementData(element, "veh:poj") or 1.2
		poj = (poj*1000)
		local rodzaj = getElementData(element, "veh:rodzaj") or "BRAK"
		local rejka = getVehiclePlateText(element) or ""
		local fuel = getElementData(element, "veh:fuel") or 25
		local gas = getElementData(element, "veh:gas") or 25
		local bak = getElementData(element, "veh:bak") or 25
		local wlasciciel = getElementData(element, "veh:owner") or "BRAK"
		local lastuser = getElementData(element, "veh:lastuser") or "BRAK"
		local distance = getElementData(element, "veh:distance") or 0
	    local h = getVehicleHandling(element)
		local sx,sy,sz = getElementVelocity(element)
		local speed = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*165)
		distance = string.format("%.1f", distance)
		if fuel then
			stan = "Stan Benzyny "..string.format("%01d", fuel).."/"..bak
		elseif gas then
			stan = "Stan LPG "..string.format("%01d", gas).."/"..bak
		else
			stan = "BRAK"
		end
		local org = getElementData(element, "veh:org") or "BRAK"
		local faction = getElementData(element, "veh:faction") or "BRAK"
		local o1 = speed.." KM/H\nUID Pojazdu: "..uid.."\nWłaściciel: "..wlasciciel.."\nOstatni kierowca: "..lastuser
		local o2 = "Model: ("..getVehicleName(element)..") ("..getVehicleModel(element)..")\nPrzebieg: "..distance.." KM\n"..stan.."\nStan Pojazdu: "..math.floor((getElementHealth(element)/10)).."%\nOrganizacja: "..org.."\nFrakcja: "..faction
		exports["smta-utils"]:WindowCreate(true, screenW * 0.3531, screenH * 0.3185, screenW * 0.2938, screenH * 0.2870, tocolor(255, 255, 255, 255), false)
        shadowText(o1, screenW * 0.3615, screenH * 0.3417, screenW * 0.4995, screenH * 0.5213, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText(o2, screenW * 0.4995, screenH * 0.3417, screenW * 0.6375, screenH * 0.5213, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Akcja: "..opcje_policja[wybrane][1], screenW * 0.3667, screenH * 0.5454, screenW * 0.6307, screenH * 0.5926, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	end
end
end

addEventHandler("onClientPlayerTarget",root, function(el)
	if el and getElementType(el) ~= "vehicle" then return end
	if isPedAiming(localPlayer) and showed == true and not el then
		removeEventHandler("onClientRender", root, gui)
		element = false
		showed = false
	end
    if isPedAiming(localPlayer) and el and getPedWeapon(localPlayer) == 22 then
		if showed then
			removeEventHandler("onClientRender", root, gui)
			element = false
			showed = false
		else
			addEventHandler("onClientRender", root, gui)
			element = el
			showed = true
		end
    end
end)

addEventHandler("onClientPlayerWeaponSwitch", root, function()
	if showed == true and not el then
		removeEventHandler("onClientRender", root, gui)
		element = false
		showed = false
	end 
end)

bindKey("mouse1", "down", function()
	if showed ~= true then return end
	if not element then return end
	if not isElement(element) then return end
	triggerServerEvent("suszarka", localPlayer, wybrane, element)
end)

bindKey("mouse_wheel_down", "both", function()
	if showed ~= true then return end
	if wybrane == 1 then return end
	wybrane = wybrane-1
end)

bindKey("mouse_wheel_up", "both", function()
	if getElementData(localPlayer, "duty") then
		if showed ~= true then return end
		if wybrane == #opcje_ekipa then return end
		wybrane = wybrane+1
	else
		if showed ~= true then return end
		if wybrane == #opcje_policja then return end
		wybrane = wybrane+1
	end
end)

