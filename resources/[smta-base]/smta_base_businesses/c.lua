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
local okno = false

local font = dxCreateFont("cz.ttf", 16)

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

addEvent("gui:otworz", true) 
addEventHandler("gui:otworz", getRootElement(), function(hitElement,owner,name,id,cost,saldo,data)
    if hitElement ~= localPlayer then return end
    biznes_wlasciciel = owner
    biznes_name = name
    biznes_id = id
    biznes_cost = cost
    biznes_saldo = saldo
    biznes_data = data
    addEventHandler("onClientRender", root, gui)
    okno = true
    showCursor(true)
end)


function gui()
    dxDrawImage(screenW * 0.3441, screenH * 0.3372, screenW * 0.3119, screenH * 0.3268, ":smta_base_businesses/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        if mysz(screenW * 0.3763, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.3763, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.3763, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.4407, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.4407, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4407, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.5051, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.5051, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5051, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.5695, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.5695, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5695, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Opłać",  screenW * 0.5695, screenH * 0.6042, screenW * 0.6266, screenH * 0.6432, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Właściciel (PID): "..biznes_wlasciciel.."\nNazwa biznesu: "..biznes_name.."\nCena za 3 doby: "..biznes_cost.." $\nSaldo biznesu: "..biznes_saldo.." $\nOpłacony do: "..biznes_data.."", screenW * 0.3770, screenH * 0.4154, screenW * 0.6266, screenH * 0.5742, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Kup", screenW * 0.3763, screenH * 0.6042, screenW * 0.4334, screenH * 0.6432, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Wypłać", screenW * 0.4407, screenH * 0.6042, screenW * 0.4978, screenH * 0.6432, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Sprzedaj", screenW * 0.5051, screenH * 0.6042, screenW * 0.5622, screenH * 0.6432, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.6376, screenH * 0.3503, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6376, screenH * 0.3503, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.6376, screenH * 0.3503, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.6376, screenH * 0.3503, screenW * 0.0110, screenH * 0.0247) and okno == true then
    	removeEventHandler("onClientRender", root, gui)
    	okno = false
    	showCursor(false)
    elseif mysz(screenW * 0.4407, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) and okno == true then
    	triggerServerEvent("wyplac:biznesy", localPlayer, localPlayer)
    elseif mysz(screenW * 0.3763, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) and okno == true then
		triggerServerEvent("kup:biznesy", localPlayer, localPlayer)
    elseif mysz(screenW * 0.5695, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) and okno == true then
    	triggerServerEvent("oplac:biznesy", localPlayer, localPlayer)
    elseif mysz(screenW * 0.5051, screenH * 0.6042, screenW * 0.0571, screenH * 0.0391) and okno == true then
    	triggerServerEvent("sprzedaj:biznesy", localPlayer, localPlayer)
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