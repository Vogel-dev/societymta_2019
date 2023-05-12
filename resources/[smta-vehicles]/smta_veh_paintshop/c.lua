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
local kolor1 = false
local kolor2 = false
local font = dxCreateFont("cz.ttf", 21)
local font2 = dxCreateFont("cz.ttf", 18)

local blip = createBlip(-2027.86, 116.88, 28.55, 58)
setBlipVisibleDistance(blip, 300)

local r, g, b = 0, 0, 0

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


function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

function gui1()
        dxDrawImage(screenW * 0.2272, screenH * 0.2773, screenW * 0.5456, screenH * 0.4466, ":smta_veh_paintshop/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if mysz(screenW * 0.2404, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677) then
        	dxDrawImage(screenW * 0.2404, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.2404, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.4154, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677) then
        	dxDrawImage(screenW * 0.4154, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4154, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.5904, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677) then
        	dxDrawImage(screenW * 0.5904, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5904, screenH * 0.4258, screenW * 0.1676, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		dxDrawRectangle(screenW * 0.4176, screenH * 0.5104, screenW * 0.1625, screenH * 0.0781, tocolor(r, g, b, 255), false)
		if mysz(screenW * 0.4162, screenH * 0.5065, screenW * 0.1669, screenH * 0.0872) then
        	dxDrawImage(screenW * 0.4162, screenH * 0.5065, screenW * 0.1669, screenH * 0.0872, ":smta_veh_paintshop/gfx/ramka_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4162, screenH * 0.5065, screenW * 0.1669, screenH * 0.0872, ":smta_veh_paintshop/gfx/ramka_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		shadowText("Kliknij (podgląd)", screenW * 0.4184, screenH * 0.5130, screenW * 0.5801, screenH * 0.5872, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		if mysz(screenW * 0.2441, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742) then
        	dxDrawImage(screenW * 0.2441, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742, ":smta_veh_paintshop/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.2441, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742, ":smta_veh_paintshop/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.6221, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742) then
        	dxDrawImage(screenW * 0.6221, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742, ":smta_veh_paintshop/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.6221, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742, ":smta_veh_paintshop/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Akceptuj", screenW * 0.2485, screenH * 0.6263, screenW * 0.3684, screenH * 0.6901, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Anuluj", screenW * 0.6250, screenH * 0.6276, screenW * 0.7463, screenH * 0.6888, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
end

addEvent("lakernia:kolor1:gui", true)
addEventHandler("lakernia:kolor1:gui", root, function(marker)
	local cuboid = getElementData(marker, "cuboid:kolor1")
	if cuboid then
		vehx = getElementsWithinColShape(cuboid, "vehicle")
		if #vehx < 1 then
			exports["smta_base_notifications"]:noti("Na stanowisku do malowania nie ma żadnego pojazdu.", "error")
			return
		end
		if #vehx > 1 then
			exports["smta_base_notifications"]:noti("Na stanowisku do malowania jest zbyt wiele pojazdów.", "error")
			return
		end
		if getVehicleType(vehx[1]) ~= "Automobile" then return end
		veh = vehx[1]
		setmarker = marker
		if getElementData(veh, "wlasciciel") ~= getElementData(localPlayer, "dbid") then exports["smta_base_notifications"]:noti("Nie jesteś właścicielem tego pojazdu", "error") return end
		showCursor(true)
		setElementData(localPlayer, "hud", true)
		showChat(false)
		executeCommandHandler("radar")
		kolor1 = true
		addEventHandler("onClientRender", root, gui1)
		exports["smta_oth_editbox"]:editbox_create("", "R", screenW * 0.2485, screenH * 0.4245, screenW * 0.4007, screenH * 0.4909, screenW * 0.2404, screenH * 0.4258, screenW * 0.1676, screenH * 0.0651, "r")
		exports["smta_oth_editbox"]:editbox_create("", "G", screenW * 0.4228, screenH * 0.4245, screenW * 0.5750, screenH * 0.4909, screenW * 0.4154, screenH * 0.4258, screenW * 0.1676, screenH * 0.0651, "g")
		exports["smta_oth_editbox"]:editbox_create("", "B", screenW * 0.5985, screenH * 0.4258, screenW * 0.7507, screenH * 0.4922, screenW * 0.5904, screenH * 0.4258, screenW * 0.1676, screenH * 0.0651, "b")
	end
end)


addEventHandler("onClientClick", root, function(btn, state)
if btn == "left" and state == "down" then
	if myszka(screenW * 0.6221, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742) and kolor1 == true then
		removeEventHandler("onClientRender", root, gui1)
		kolor1 = false
		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		exports["smta_oth_editbox"]:editbox_destroy("r")
		exports["smta_oth_editbox"]:editbox_destroy("g")
		exports["smta_oth_editbox"]:editbox_destroy("b")
	elseif myszka(screenW * 0.4176, screenH * 0.5104, screenW * 0.1625, screenH * 0.0781) and kolor1 == true then
		r = exports["smta_oth_editbox"]:editbox_text("r")
		g = exports["smta_oth_editbox"]:editbox_text("g")
		b = exports["smta_oth_editbox"]:editbox_text("b")
		if r == "" then
			r = 0
		end
		if g == "" then
			g = 0
		end
		if b == "" then
			b = 0
		end
	elseif myszka(screenW * 0.2441, screenH * 0.6211, screenW * 0.1279, screenH * 0.0742) and kolor1 == true then
		if r == "" then
			r = 0
		end
		if g == "" then
			g = 0
		end
		if b == "" then
			b = 0
		end
		if getElementData(setmarker, "kolor") == 1 then
			triggerServerEvent("lakernia:pomaluj1", localPlayer, veh, r, g, b)
		elseif getElementData(setmarker, "kolor") == 2 then
			triggerServerEvent("lakernia:pomaluj2", localPlayer, veh, r, g, b)
		end
	end
end
end)


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