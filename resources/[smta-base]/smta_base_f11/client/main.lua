--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local px, py = sx/1440, sy/900

local strona = 1
local mapa = false

local font = dxCreateFont("gfx/cz2.ttf", 19)

function onClientResourceStart()	
	map = Map.new():init()
	map:setBounds(x*100,y*100,x*800,y*550)
	map:setAlpha(200)

	map.Switch = function()
		map:setVisible(not map:isVisible())
		showChat(not map:isVisible())
		if map:isVisible() == false then
			removeEventHandler("onClientRender", root, gui)
			setElementData(localPlayer, "hud", false)
			triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
			setElementData(localPlayer, "player:blackwhite", false)
			mapa = false
		else
			addEventHandler("onClientRender", root, gui)
			setElementData(localPlayer, "hud", true)
			triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
			setElementData(localPlayer, "player:blackwhite", true)
			mapa = true
		end
	end
	bindKey('F11', 'down', map.Switch)

	setPlayerHudComponentVisible("radar",false)
	toggleControl("radar",false)
end
addEventHandler("onClientResourceStart",resourceRoot,onClientResourceStart)

function gui()
	dxDrawImage(screenW * 0.7145, screenH * 0.1250, screenW * 0.1991, screenH * 0.7370, ":smta_base_f11/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if strona == 1 then
		dxDrawImage(1036*px, 163*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 237*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/24.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 311*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/14.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 385*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/52.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 459*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/47.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 533*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/51.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 607*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/45.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 681*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/55.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	shadowText("Fast Food", 1101*px, 163*py, 1317*px, 227*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Prawo jazdy kat. B", 1101*px, 237*py, 1317*px, 301*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Monopolowy", 1101*px, 311*py, 1317*px, 375*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Praca dorywcza", 1100*px, 385*py, 1316*px, 449*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Salon pojazdów", 1100*px, 459*py, 1316*px, 523*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Stacja paliw", 1100*px, 533*py, 1316*px, 597*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Przebieralnia", 1100*px, 607*py, 1316*px, 671*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Mechanik", 1100*px, 681*py, 1316*px, 745*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    elseif strona == 2 then
    	dxDrawImage(1036*px, 163*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/20.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 237*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/23.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 311*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/35.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 385*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/30.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 459*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/22.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	--dxDrawImage(1036*px, 533*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/34.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	--dxDrawImage(1036*px, 607*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/40.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		--dxDrawImage(1036*px, 533*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/36.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 533*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/36.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	shadowText("Przechowalnia", 1101*px, 163*py, 1317*px, 227*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Łowisko", 1101*px, 237*py, 1317*px, 301*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Giełda pojazdów", 1101*px, 311*py, 1317*px, 375*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Frakcja SAPD", 1100*px, 385*py, 1316*px, 449*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Frakcja SAMC", 1100*px, 459*py, 1316*px, 523*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	--shadowText("Frakcja SARA", 1100*px, 533*py, 1316*px, 597*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	--shadowText("Frakcja SATC", 1100*px, 607*py, 1316*px, 671*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
		--shadowText("Frakcja SAFD", 1100*px, 681*py, 1316*px, 745*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Frakcja SAFD", 1100*px, 533*py, 1316*px, 597*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    elseif strona == 3 then
    	dxDrawImage(1036*px, 163*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/27.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 237*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/8.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 311*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/17.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 385*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/48.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	dxDrawImage(1036*px, 459*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/53.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1036*px, 533*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/43.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1036*px, 607*py, 65*px, 64*py, ":smta_base_f11/gfx/icons/58.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	shadowText("Tuning", 1101*px, 163*py, 1317*px, 227*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Sklep spożywczy", 1101*px, 237*py, 1317*px, 301*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Bankomat", 1101*px, 311*py, 1317*px, 375*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Sklep z wędkami", 1100*px, 385*py, 1316*px, 449*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    	shadowText("Cygan", 1100*px, 459*py, 1316*px, 523*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Kasyno", 1100*px, 533*py, 1316*px, 597*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Lakiernia", 1100*px, 607*py, 1316*px, 671*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
end


bindKey("e", "down", function()
	if mapa ~= true then return end
	if strona == 3 then return end
	strona = strona+1
end)

bindKey("q", "down", function()
	if mapa ~= true then return end
	if strona == 1 then return end
	strona = strona-1
end)


-- add

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end