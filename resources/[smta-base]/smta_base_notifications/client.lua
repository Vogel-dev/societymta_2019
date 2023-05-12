--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local czcionka = dxCreateFont("czcionka.ttf", 14)
local tabela = {}
local gui_showed = false

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

function gui()
	for i,v in ipairs(tabela) do
		local nczas = getTickCount()
		if nczas > v.tick+v.czas then
			local sczas = v.tick+v.czas
			local progress = (sczas - nczas) / 15000
			v.alpha = interpolateBetween(v.alpha, 0, 0, 0, 0, 0, progress, "InOutQuad")
			v.alpha3 = interpolateBetween(v.alpha3, 0, 0, 0, 0, 0, progress, "InOutQuad")
		end
		if v.alpha < 1 then
			table.remove(tabela, 1)
			if #tabela < 1 then
				removeEventHandler("onClientRender", root, gui)
				gui_showed = false
			end
		end
		local nn = interpolateBetween(-screenW, 0, 0, 0, 0, 0, (getTickCount()-v.tick)/800, "InOutQuad") 
		local dodatekY = (scale_y(-84))*(i-1)
		local dodatekY2 = (scale_y(-168))*(i-1)

        dxDrawImage(screenW * 0.0147+nn, screenH * 0.6380+dodatekY, screenW * 0.2199, screenH * 0.0846, ""..v.typ..".png", 0, 0, 0, tocolor(255, 255, 255, v.alpha), false)
		dxDrawText(v.text, screenW * 0.0539+nn, screenH * 0.6382+dodatekY2, screenW * 0.2274+nn, screenH * 0.7229, tocolor(0, 0, 0, v.alpha), 1.00, czcionka, "left", "center", false, true	, false, false, false)
		dxDrawText(v.text, screenW * 0.0537+nn, screenH * 0.6380+dodatekY2, screenW * 0.2272+nn, screenH * 0.7227, tocolor(150, 150, 150, v.alpha), 1.00, czcionka, "left", "center", false, true	, false, false, false)
	end
end

addEvent("notka", true)
addEventHandler("notka", root, function(txt, rodzaj)
	if #tabela > 2 then
		table.remove(tabela, 1)
	end
		if rodzaj == "error" then
			playSound("error.wav")
			table.insert(tabela, {text=txt, alpha=255, tick=getTickCount(), czas=7000, alpha3=255, typ="error"})
		elseif rodzaj == "success" then
			playSound("info.mp3")
			table.insert(tabela, {text=txt, alpha=255, tick=getTickCount(), czas=7000, alpha3=255, typ="success"})
		else
			playSound("info.mp3")
			table.insert(tabela, {text=txt, alpha=255, tick=getTickCount(), czas=7000, alpha3=255, typ="success"})
		end
	if gui_showed ~= true then
		addEventHandler("onClientRender", root, gui)
		gui_showed = true
	end
	outputConsole(txt)
end)

function noti(data, rodzaj)
	triggerEvent("notka", localPlayer, data, rodzaj)
end