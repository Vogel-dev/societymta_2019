--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

local blip1 = createBlip(-1969.70, 282.20, 34.86, 47)
setBlipVisibleDistance(blip1, 300)

local blip2 = createBlip(-1645.00, 1205.67, 7.00, 47)
setBlipVisibleDistance(blip2, 300)

local blip3 = createBlip(-1905.28, -561.61, 24.28, 53)
setBlipVisibleDistance(blip3, 300)



local px, py = screenW/1440, screenH/900

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

function myszka(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function ramka(x, y, w, h, color)
    local color2 = tocolor(185, 43, 39)
    dxDrawRectangle(x-2, y-2, w+4, h+4, color2, false)
    dxDrawRectangle(x, y, w, h, color, false)
end

local font = dxCreateFont("cz.ttf", 19)
local font2 = dxCreateFont("cz.ttf", 18)
local fontsmall = dxCreateFont("cz.ttf", 14)

function gui()   
    dxDrawImage(screenW * 0.3625, screenH * 0.2005, screenW * 0.2757, screenH * 0.6003, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("\nInformacje o pojezdzie\n\nCena pojazdu: "..vehicle_cena.." $\nPojemność pojazdu: "..vehicle_pojemnosc.."\nPrzebieg pojazdu: "..vehicle_przebieg.." km\nNapęd pojazdu: "..vehicle_naped.."\nRodzaj paliwa pojazdu: "..vehicle_rodzaj, screenW * 0.3676, screenH * 0.2083, screenW * 0.6309, screenH * 0.7031, tocolor(255, 255, 255, 255), 1.00, font2, "center", "top", false, false, false, false, false)
    if myszka(screenW * 0.3750, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638) then
      dxDrawImage(screenW * 0.3750, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
      dxDrawImage(screenW * 0.3750, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    if myszka(screenW * 0.5088, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638) then
      dxDrawImage(screenW * 0.5088, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
      dxDrawImage(screenW * 0.5088, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    shadowText("Zakup", screenW * 0.3765, screenH * 0.7214, screenW * 0.4897, screenH * 0.7747, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    shadowText("Anuluj", screenW * 0.5103, screenH * 0.7214, screenW * 0.6235, screenH * 0.7747, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
end

function akceptowanie()   
    dxDrawImage(screenW * 0.3625, screenH * 0.2005, screenW * 0.2757, screenH * 0.6003, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("\nAkceptowanie kupna auta\n\nCena pojazdu: "..vehicle_cena.." $\nPojemność pojazdu: "..vehicle_pojemnosc.."\nPrzebieg pojazdu: "..vehicle_przebieg.." km\nNapęd pojazdu: "..vehicle_naped.."\nRodzaj paliwa pojazdu: "..vehicle_rodzaj.."\nKolor pojazdu: "..vehicle_color, screenW * 0.3676, screenH * 0.2083, screenW * 0.6309, screenH * 0.7031, tocolor(255, 255, 255, 255), 1.00, font2, "center", "top", false, false, false, false, false)
    if myszka(screenW * 0.3750, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638) then
      dxDrawImage(screenW * 0.3750, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
      dxDrawImage(screenW * 0.3750, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    if myszka(screenW * 0.5088, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638) then
      dxDrawImage(screenW * 0.5088, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
      dxDrawImage(screenW * 0.5088, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    shadowText("Akceptuj", screenW * 0.3765, screenH * 0.7214, screenW * 0.4897, screenH * 0.7747, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    shadowText("Anuluj", screenW * 0.5103, screenH * 0.7214, screenW * 0.6235, screenH * 0.7747, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
end

function wybieraniekoloru()
		dxDrawImage(screenW * 0.2919, screenH * 0.2786, screenW * 0.4162, screenH * 0.4401, ":smta_veh_shops/bgc.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Wybierz kolor dla pojazdu "..vehicle_nazwa..", możesz go przemalować w późniejszym czasie.", 439*px, 268*py, 1001*px, 325*py, tocolor(255, 255, 255, 255), 1.00, fontsmall, "center", "center", false, false, false, false, false)
        
        if myszka(473*px, 335*py, 90*px, 90*py) then
          ramka(473*px, 335*py, 90*px, 90*py, tocolor(185, 43, 39, 255), false)
        else
          dxDrawRectangle(473*px, 335*py, 90*px, 90*py, tocolor(185, 43, 39, 255), false)
        end

        if myszka(573*px, 335*py, 90*px, 90*py) then
          ramka(573*px, 335*py, 90*px, 90*py, tocolor(21, 101, 192, 255), false)
        else
          dxDrawRectangle(573*px, 335*py, 90*px, 90*py, tocolor(21, 101, 192, 255), false)
        end

        if myszka(673*px, 335*py, 90*px, 90*py) then
          ramka(673*px, 335*py, 90*px, 90*py, tocolor(28, 172, 120, 255), false)
        else
          dxDrawRectangle(673*px, 335*py, 90*px, 90*py, tocolor(28, 172, 120, 255), false)
        end

        if myszka(773*px, 335*py, 90*px, 90*py) then
          ramka(773*px, 335*py, 90*px, 90*py, tocolor(252, 232, 131, 255), false)
        else
          dxDrawRectangle(773*px, 335*py, 90*px, 90*py, tocolor(252, 232, 131, 255), false)
        end

        if myszka(873*px, 335*py, 90*px, 90*py) then
          ramka(873*px, 335*py, 90*px, 90*py, tocolor(0, 147, 175, 255), false)
        else
          dxDrawRectangle(873*px, 335*py, 90*px, 90*py, tocolor(0, 147, 175, 255), false)
        end

        if myszka(473*px, 435*py, 90*px, 90*py) then
          ramka(473*px, 435*py, 90*px, 90*py, tocolor(255, 192, 203, 255), false)
        else
          dxDrawRectangle(473*px, 435*py, 90*px, 90*py, tocolor(255, 192, 203, 255), false)
        end

        if myszka(573*px, 435*py, 90*px, 90*py) then
          ramka(573*px, 435*py, 90*px, 90*py, tocolor(255, 255, 255, 255), false)
        else
          dxDrawRectangle(573*px, 435*py, 90*px, 90*py, tocolor(255, 255, 255, 255), false)
        end

        if myszka(673*px, 435*py, 90*px, 90*py) then
          ramka(673*px, 435*py, 90*px, 90*py, tocolor(255, 117, 56, 255), false)
        else
          dxDrawRectangle(673*px, 435*py, 90*px, 90*py, tocolor(255, 117, 56, 255), false)
        end

        if myszka(773*px, 435*py, 90*px, 90*py) then
          ramka(773*px, 435*py, 90*px, 90*py, tocolor(16,5,28, 255), false)
        else
          dxDrawRectangle(773*px, 435*py, 90*px, 90*py, tocolor(16,5,28, 255), false)
        end

        if myszka(873*px, 435*py, 90*px, 90*py) then
          ramka(873*px, 435*py, 90*px, 90*py, tocolor(5, 5, 5, 255), false)
        else
          dxDrawRectangle(873*px, 435*py, 90*px, 90*py, tocolor(5, 5, 5, 255), false)
        end

		if myszka(screenW * 0.5338, screenH * 0.6055, screenW * 0.1596, screenH * 0.0885) then
		dxDrawImage(screenW * 0.5338, screenH * 0.6055, screenW * 0.1596, screenH * 0.0885, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
		dxDrawImage(screenW * 0.5338, screenH * 0.6055, screenW * 0.1596, screenH * 0.0885, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
        shadowText("Anuluj", screenW * 0.5368, screenH * 0.6120, screenW * 0.6897, screenH * 0.6862, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Po wybraniu koloru przejdziesz\ndo akceptowania zakupu", 473*px, 543*py, 792*px, 605*py, tocolor(185, 43, 39, 255), 1.00, fontsmall, "center", "center", false, false, false, false, false)
end

okno = false
okno2 = false
okno3 = false

addEvent("oknoKupnaSalon", true)
addEventHandler("oknoKupnaSalon", root, function(nazwa, przebieg, cena, pojemnosc, naped, rodzaj, model)
	addEventHandler("onClientRender", root, gui)
	okno = true
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
	setElementData(localPlayer, "player:blackwhite", true)
	vehicle_nazwa = nazwa
	vehicle_przebieg = przebieg
	vehicle_cena = cena
	vehicle_pojemnosc = pojemnosc
	vehicle_naped = naped
  	vehicle_rodzaj = rodzaj
  	vehicle_model = model
end)

addEvent("oknoKupnaSalon:close", true)
addEventHandler("oknoKupnaSalon:close", root, function()
  removeEventHandler("onClientRender", root, gui)
  okno = false
	showCursor(false)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
	setElementData(localPlayer, "player:blackwhite", false)
end)


addEventHandler("onClientClick", root, function(btn, state)
if btn == "left" and state == "down" then
	if myszka(screenW * 0.5088, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638) and okno == true then
  		removeEventHandler("onClientRender", root, gui)
  		okno = false
  		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
  	elseif myszka(screenW * 0.3750, screenH * 0.7161, screenW * 0.1147, screenH * 0.0638) and okno == true then
  		removeEventHandler("onClientRender", root, gui)
  		okno = false
  		if tonumber(vehicle_przebieg) < 100 then
  			addEventHandler("onClientRender", root, wybieraniekoloru)
  			okno2 = true
  		else
  			triggerServerEvent("zakupPojazdSalon", localPlayer, localPlayer, "Czarny")
  		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
  		end
  	elseif myszka(screenW * 0.5103, screenH * 0.7214, screenW * 0.6235, screenH * 0.7747) and okno3 == true then
  		removeEventHandler("onClientRender", root, akceptowanie)
  		okno = false
  		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
  	elseif myszka(screenW * 0.3765, screenH * 0.7214, screenW * 0.4897, screenH * 0.7747) and okno3 == true then
  		triggerServerEvent("zakupPojazdSalon", localPlayer, localPlayer, vehicle_color)
  		removeEventHandler("onClientRender", root, akceptowanie)
  		okno = false
  		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
  	elseif myszka(screenW * 0.5338, screenH * 0.6055, screenW * 0.1596, screenH * 0.0885) and okno2 == true then
  		removeEventHandler("onClientRender", root, wybieraniekoloru)
  		okno2 = false
  		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
  	elseif myszka(473*px, 335*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Czerwony"
  		przejdzdoakceptacji()
  	elseif myszka(573*px, 335*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Niebieski"
  		przejdzdoakceptacji()
  	elseif myszka(673*px, 335*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Zielony"
  		przejdzdoakceptacji()
  	elseif myszka(773*px, 335*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Żółty"
  		przejdzdoakceptacji()
  	elseif myszka(873*px, 335*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Turkusowy"
  		przejdzdoakceptacji()
  	elseif myszka(473*px, 435*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Różowy"
  		przejdzdoakceptacji()
  	elseif myszka(573*px, 435*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Biały"
  		przejdzdoakceptacji()
  	elseif myszka(673*px, 435*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Pomarańczowy"
  		przejdzdoakceptacji()
  	elseif myszka(773*px, 435*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Fioletowy"
  		przejdzdoakceptacji()
  	elseif myszka(873*px, 435*py, 90*px, 90*py) and okno2 == true then
  		vehicle_color = "Czarny"
  		przejdzdoakceptacji()
	end
end
end)

function przejdzdoakceptacji()
	addEventHandler("onClientRender", root, akceptowanie)
	okno3 = true
	removeEventHandler("onClientRender", root, wybieraniekoloru)
	okno2 = false
end

local blip = {}

function destroyBlipsAttachedTo(elemente)
	local attached = getAttachedElements ( elemente )
	if ( attached ) then
		for k,element in ipairs(attached) do
			if getElementType ( element ) == "blip" then
				destroyElement ( element )
				blip[elemente] = nil
			end
		end
	end
end

function stworzBlipy()
  for _, p in pairs(getElementsByType("vehicle")) do
    if blip[p] then return end
    if getElementData(p, "id") then
    	if getElementData(p, "wlasciciel") == getElementData(localPlayer, "dbid") then
      	blip[p] = createBlipAttachedTo(p, 50, 2, 255, 0, 0, 255, 1, 9999)
			end
    end
  end
end
setTimer(stworzBlipy, 10000, 0)

addEventHandler("onClientResourceStart", resourceRoot, stworzBlipy)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		destroyBlipsAttachedTo(source)
	end
end)