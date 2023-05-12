--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

local sw, sh = guiGetScreenSize();
local zoom = 1;

if sw < 1920 then
    zoom = math.min(2, 1920/sw);
end

local function sx(po)
    return (po/1920)*sw;
end

local function sy(po)
    return (po/1080)*sh;
end

local font = dxCreateFont("cz.ttf", 20)
local font2 = dxCreateFont("cz.ttf", 10)

addEventHandler("onClientRender", root, function()
	if getElementData(localPlayer, "hud") then return end
	if getPedOccupiedVehicle(localPlayer) then
		local pojazd = getPedOccupiedVehicle(localPlayer)
		local paliwo = getElementData(pojazd, "paliwo") or 100
		local distance = getElementData(pojazd, "przebieg") or 0
		--distance = string.format("%08d", distance)
		local sx2, sy2, sz2 = getElementVelocity(pojazd)
		local predkosc = (sx2^2 + sy2^2 + sz2^2)^(0.5)
		local kmh = predkosc * 180
		local kmh2 = predkosc * 145
		if getVehicleOverrideLights(pojazd) == 1 then
			dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/bialy.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/bialyon.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end	
	    dxDrawImage(sx(1430), sy(640), sx(550), sy(550), ":smta_veh_speedometer/licznik/wskazowka.png", kmh2, 0, 0, tocolor(255, 255, 255, 255), false)
	    if paliwo > 2 and paliwo < 12 then
	    	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	    end
	    if paliwo > 13 and paliwo < 24 then
	    	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	   	 	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	   	end
	   	if paliwo > 25 and paliwo < 37 then
	   		dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	   	 	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	    	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	    end
	    if paliwo > 38 then
	   		dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	   	 	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	    	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	    	dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/paliwo4.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	    end
	    dxDrawImage(sx(1430), sy(606), sx(550), sy(550), ":smta_veh_speedometer/licznik/benzyna.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		shadowText(string.format("%06d", distance), sx(1430), sy(920), sx(1980), sy(990), tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
	    shadowText(string.format("%1d", kmh), sx(1430), sy(860), sx(1980), sy(990), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	end
end)