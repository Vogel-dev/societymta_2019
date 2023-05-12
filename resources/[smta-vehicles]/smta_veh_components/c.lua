--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local discordczas = getRealTime()
local screenW, screenH = guiGetScreenSize()
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

local k = 1
local n = 5
local m = 5

local lampki = {
	{"Białe", 1000, 255, 255, 255},
	{"Czerwone", 2500, 225, 0, 0},
	{"Niebieskie", 2500, 0, 0, 225},
	{"Zielone", 2500, 0, 225, 0},
	{"Żółte", 2500, 255,200,0},
	{"Różowe", 2500, 255,192,203},
	{"Xenon", 1500, 166,253,255},
}

local neony = {
	{"Białe", 10000, 255, 255, 255},
	{"Czerwone", 15000, 225, 0, 0},
	{"Niebieskie", 15000, 0, 0, 225},
	{"Zielone", 15000, 0, 225, 0},
	{"Żółte", 15000, 255,200,0},
	{"Różowe", 15000, 255,192,203},
	{"Xenon", 15000, 166,253,255},
}


local inne = {
	--{"Tempomat", 750, "tempomat"},
}


local font = dxCreateFont("cz.ttf", 18)
local fonts = dxCreateFont("cz.ttf", 14)
local fontG = dxCreateFont("cz.ttf", 21)
local okno = false
local lampki_info = false
local lampki_select = false

local neony_info = false
local neony_select = false

local edit1 = guiCreateEdit(0.44, 0.56, 0.12, 0.03, "", true)
guiSetVisible(edit1, false)

function gui()
	local veh = getPedOccupiedVehicle(localPlayer)
	dxDrawImage(screenW * 0.3441, screenH * 0.2370, screenW * 0.3118, screenH * 0.5260, ":smta_veh_components/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    if okno == 1 then
		if mysz(screenW * 0.3676, screenH * 0.6563, screenW * 0.0735, screenH * 0.1302) then
        	dxDrawImage(screenW * 0.3676, screenH * 0.6563, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/inne_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.3676, screenH * 0.6563, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/inne_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
				if mysz(screenW * 0.3676, screenH * 0.5781, screenW * 0.0735, screenH * 0.1302) then
        	dxDrawImage(screenW * 0.3676, screenH * 0.5781, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/zerowanie_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.3676, screenH * 0.5781, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/zerowanie_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
				if mysz(screenW * 0.3676, screenH * 0.4909, screenW * 0.0735, screenH * 0.1302) then
        	dxDrawImage(screenW * 0.3676, screenH * 0.4909, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/rejestracje_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.3676, screenH * 0.4909, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/rejestracje_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
				if mysz(screenW * 0.3676, screenH * 0.3893, screenW * 0.0735, screenH * 0.1302) then
        	dxDrawImage(screenW * 0.3676, screenH * 0.3893, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/neony_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.3676, screenH * 0.3893, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/neony_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
				if mysz(screenW * 0.3676, screenH * 0.2878, screenW * 0.0735, screenH * 0.1302) then
        	dxDrawImage(screenW * 0.3676, screenH * 0.2878, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/swiatla_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.3676, screenH * 0.2878, screenW * 0.0735, screenH * 0.1302, ":smta_veh_components/gfx/swiatla_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	    shadowText("Zmiana kolory świateł", screenW * 0.4537, screenH * 0.3112, screenW * 0.6316, screenH * 0.3893, tocolor(255, 255, 255, 255), 1.00, fontG, "left", "center", false, false, false, false, false)
	    shadowText("Neony w pojeździe - Brak dostępnych", screenW * 0.4537, screenH * 0.4128, screenW * 0.6316, screenH * 0.4909, tocolor(255, 255, 255, 255), 1.00, fonts, "left", "center", false, false, false, false, false)
	    shadowText("Rejestracja pojazdu", screenW * 0.4537, screenH * 0.5195, screenW * 0.6316, screenH * 0.5977, tocolor(255, 255, 255, 255), 1.00, fontG, "left", "center", false, false, false, false, false)
	    shadowText("Zerowanie przebiegu", screenW * 0.4537, screenH * 0.6029, screenW * 0.6316, screenH * 0.6810, tocolor(255, 255, 255, 255), 1.00, fontG, "left", "center", false, false, false, false, false)
	    shadowText("Inne komponenty", screenW * 0.4537, screenH * 0.6849, screenW * 0.6316, screenH * 0.7630, tocolor(255, 255, 255, 255), 1.00, fontG, "left", "center", false, false, false, false, false)
	elseif okno == 2 then
		shadowText("Kolor:", screenW * 0.3654, screenH * 0.3060, screenW * 0.4088, screenH * 0.3359, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Cena:", screenW * 0.4257, screenH * 0.3060, screenW * 0.4691, screenH * 0.3359, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        local x = 0
        for i, v in ipairs(lampki) do
        	if i >= k and i <= n then
        		x = x+1
        		local addY = (sy(73))*(x-1)
        		if mysz(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612) then
					dxDrawRectangle(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612, tocolor(55, 55, 55, 120), false)
				else
					dxDrawRectangle(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612, tocolor(0, 0, 0, 120), false)
				end
		        dxDrawRectangle(screenW * 0.3662, screenH * 0.3490+addY, screenW * 0.0250, screenH * 0.0456, tocolor(v[3], v[4], v[5], 255), false)
		        shadowText(v[2].." $", screenW * 0.4316, screenH * 0.3464+(addY*2), screenW * 0.5037, screenH * 0.3932, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
		    end
	    end
	    if lampki_select == true then
	    	shadowText("Czy chcesz zakupić:\n"..lampki_info[1].." za "..lampki_info[2].." $", sx(874), sy(369), sx(1362), sy(587), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	    else
        	shadowText("Wybierz kolor", sx(874), sy(369), sx(1362), sy(587), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        end
		if mysz(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Zmień", screenW * 0.5375, screenH * 0.5078, screenW * 0.6272, screenH * 0.5495, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Anuluj", screenW * 0.5375, screenH * 0.5898, screenW * 0.6272, screenH * 0.6315, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    elseif okno == 13 then
		shadowText("Kolor:", screenW * 0.3654, screenH * 0.3060, screenW * 0.4088, screenH * 0.3359, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Cena:", screenW * 0.4257, screenH * 0.3060, screenW * 0.4691, screenH * 0.3359, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        local x = 0
        for i, v in ipairs(neony) do
        	if i >= k and i <= n then
        		x = x+1
        		local addY = (sy(73))*(x-1)
        		if mysz(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612) then
					dxDrawRectangle(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612, tocolor(55, 55, 55, 120), false)
				else
					dxDrawRectangle(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612, tocolor(0, 0, 0, 120), false)
				end
		        dxDrawRectangle(screenW * 0.3662, screenH * 0.3490+addY, screenW * 0.0250, screenH * 0.0456, tocolor(v[3], v[4], v[5], 255), false)
		        shadowText(v[2].." $", screenW * 0.4316, screenH * 0.3464+(addY*2), screenW * 0.5037, screenH * 0.3932, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
		    end
	    end
	    if neony_select == true then
	    	shadowText("Czy chcesz zakupić:\n"..neony_info[1].." za "..neony_info[2].." $", sx(874), sy(369), sx(1362), sy(587), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	    else
        	shadowText("Wybierz kolor neonów", sx(874), sy(369), sx(1362), sy(587), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        end
		if mysz(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end		
		if mysz(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Zamontuj", screenW * 0.5375, screenH * 0.5078, screenW * 0.6272, screenH * 0.5495, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Anuluj", screenW * 0.5375, screenH * 0.5898, screenW * 0.6272, screenH * 0.6315, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    elseif okno == 4 then
    	shadowText("Zmiana tablic rejestracyjnych\n\nCena za zmiane: 5000 $\n\nPoniżej podaj tekst na nowej rejestracji", sx(543), sy(330), sx(1374), sy(631), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		if mysz(sx(719), sy(677), sx(167), sy(50)) then
        	dxDrawImage(sx(719), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(sx(719), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(sx(1035), sy(677), sx(167), sy(50)) then
        	dxDrawImage(sx(1035), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(sx(1035), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Zmień", sx(719), sy(677), sx(886), sy(727), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Anuluj", sx(1035), sy(677), sx(1202), sy(727), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    elseif okno == 5 then
    	shadowText("Zerowanie przebiegu w pojeździe\n\nTwoje auto posiada "..string.format("%1d", getElementData(veh, "przebieg")).." km przebiegu\nzerowanie będzie kosztować "..(string.format("%1d", getElementData(veh, "przebieg"))*5).." $", sx(543), sy(330), sx(1374), sy(631), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		if mysz(sx(719), sy(677), sx(167), sy(50)) then
        	dxDrawImage(sx(719), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(sx(719), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(sx(1035), sy(677), sx(167), sy(50)) then
        	dxDrawImage(sx(1035), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(sx(1035), sy(677), sx(167), sy(50), ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Wyzeruj", sx(719), sy(677), sx(886), sy(727), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("Anuluj", sx(1035), sy(677), sx(1202), sy(727), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    elseif okno == 6 then
    	for i, v in ipairs(inne) do
    		local addY = (sy(76))*(i-1)

	    	dxDrawRectangle(screenW * 0.3441, screenH * 0.3333+addY, screenW * 0.3118, screenH * 0.0690, tocolor(0, 0, 0, 120), false)
	        shadowText(v[1], screenW * 0.3566, screenH * 0.3333+(addY*2), screenW * 0.4625, screenH * 0.4023, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	        shadowText(v[2].." $", screenW * 0.4625, screenH * 0.3333+(addY*2), screenW * 0.5684, screenH * 0.4023, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
			if mysz(screenW * 0.5566, screenH * 0.3411+addY, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5566, screenH * 0.3411+addY, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5566, screenH * 0.3411+addY, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	        if getElementData(veh, v[3]) then
	        	shadowText("Demontuj", screenW * 0.5574, screenH * 0.3424+(addY*2), screenW * 0.6485, screenH * 0.3893, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	        else
	        	shadowText("Montuj", screenW * 0.5574, screenH * 0.3424+(addY*2), screenW * 0.6485, screenH * 0.3893, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	        end
	    end
		if mysz(screenW * 0.5566, screenH * 0.6901, screenW * 0.0919, screenH * 0.0534) then
        	dxDrawImage(screenW * 0.5566, screenH * 0.6901, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5566, screenH * 0.6901, screenW * 0.0919, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Cofnij", screenW * 0.5581, screenH * 0.6901, screenW * 0.6485, screenH * 0.7435, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	end
end

local montaze = {
{-2292.69, -169.76, 35.32},
}

for i, v in ipairs(montaze) do
	local marker = createMarker(v[1], v[2], v[3]-1.5, "cylinder", 2.5, 0, 127, 255, 50)
	setElementData(marker, "tuning", true)
	napis = createElement("text")
    setElementPosition(napis, v[1], v[2], v[3])
    setElementData(napis, "text", "Montaż komponentów do pojazdu")
	addEventHandler("onClientMarkerHit", marker, function(gracz)
		if gracz ~= localPlayer then return end
		if not getPedOccupiedVehicle(localPlayer) then return end
		local veh = getPedOccupiedVehicle(localPlayer)
		if not getElementData(veh, "id") then return end
		if getElementData(veh, "wlasciciel") ~= getElementData(localPlayer, "dbid") then exports["smta_base_notifications"]:noti("Nie jesteś właścicielem tego pojazdu", "error") return end
		addEventHandler("onClientRender", root, gui)
		okno = 1
		showCursor(true)
		setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
		setElementData(localPlayer, "player:blackwhite", true)
	end)
end

addEventHandler("onClientClick", root, function(btn, state)
	if btn ~= "state" and state ~= "down" then return end
	if mysz(screenW * 0.6375, screenH * 0.2500, screenW * 0.0110, screenH * 0.0247) and okno ~= false then
		removeEventHandler("onClientRender", root, gui)
		okno = false
		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
	elseif mysz(screenW * 0.3676, screenH * 0.2878, screenW * 0.0735, screenH * 0.1302) and okno == 1 then
		okno = 2
	elseif mysz(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534) and okno == 2 then
		if lampki_select == true then
			local kasa = getElementData(localPlayer, "pieniadze")
			if kasa >= lampki_info[2] then
				lampki_select = false
				triggerServerEvent("zamontuj:lampki", localPlayer, lampki_info[3], lampki_info[4], lampki_info[5])
				setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-lampki_info[2])
				exports["smta_base_notifications"]:noti("Zmieniłeś kolor świateł za "..lampki_info[2].." $")
				lampki_info = false
				okno = 1
			else
				exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error")
			end
		else
			exports["smta_base_notifications"]:noti("Nie wybrałeś koloru świateł", "error")
		end
	elseif mysz(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534) and okno == 2 then
		okno = 1
	elseif mysz(screenW * 0.3676, screenH * 0.3893, screenW * 0.0735, screenH * 0.1302) and okno == 1 then
		okno = 3
	elseif mysz(screenW * 0.5353, screenH * 0.5026, screenW * 0.0919, screenH * 0.0534) and okno == 3 then
		if neony_select == true then
			local kasa = getElementData(localPlayer, "pieniadze")
			if kasa >= neony_info[2] then
				neony_select = false
				--triggerServerEvent("zamontuj:neony", localPlayer, neony_info[3], neony_info[4], neony_info[5])
				--setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-neony_info[2])
				--exports["smta_base_notifications"]:noti("Zamontowałeś neony za "..neony_info[2].." $")
				neony_info = false
				okno = 1
			else
				--exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error")
			end
		else
			--exports["smta_base_notifications"]:noti("Nie wybrałeś koloru neonów", "error")
		end
	elseif mysz(screenW * 0.5353, screenH * 0.5846, screenW * 0.0919, screenH * 0.0534) and okno == 3 then
		okno = 1
	elseif mysz(screenW * 0.3676, screenH * 0.4909, screenW * 0.0735, screenH * 0.1302) and okno == 1 then
		okno = 4
		guiSetVisible(edit1, true)
		guiSetText(edit1, getVehiclePlateText(getPedOccupiedVehicle(localPlayer)))
	elseif mysz(sx(719), sy(677), sx(167), sy(50)) and okno == 4 then
		local tekst = guiGetText(edit1)
		if tekst:len() > 7 then exports["smta_base_notifications"]:noti("Rejestracja nie może być dłuższa niż 7 znaków", "error") return end
		local kasa = getElementData(localPlayer, "pieniadze")
		if kasa >= 5000 then
			if tekst == getVehiclePlateText(getPedOccupiedVehicle(localPlayer)) then return end
			triggerServerEvent("zmien:tablice", localPlayer, tekst)
			exports["smta_base_notifications"]:noti("Zmieniłeś tablice rejestracyjne.")
			setElementData(localPlayer, "pieniadze", kasa-5000)
		else
			exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error")
		end
	elseif mysz(sx(1035), sy(677), sx(167), sy(50)) and okno == 4 then
		okno = 1
		guiSetVisible(edit1, false)
	elseif mysz(screenW * 0.3676, screenH * 0.5781, screenW * 0.0735, screenH * 0.1302) and okno == 1 then
		okno = 5
	elseif mysz(sx(719), sy(677), sx(167), sy(50)) and okno == 5 then
		local kasa = getElementData(localPlayer, "pieniadze")
		local veh = getPedOccupiedVehicle(localPlayer)
		if kasa >= (string.format("%1d", getElementData(veh, "przebieg"))*5) then
			exports["smta_base_notifications"]:noti("Wyzerowałeś przebieg za "..(string.format("%1d", getElementData(veh, "przebieg"))*5).." $")
			setElementData(localPlayer, "pieniadze", kasa-(string.format("%1d", getElementData(veh, "przebieg"))*5))
			setElementData(veh, "przebieg", 0)
		else
			exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error")
		end
	elseif mysz(sx(1035), sy(677), sx(167), sy(50)) and okno == 5 then
		okno = 1
	elseif mysz(screenW * 0.3676, screenH * 0.6563, screenW * 0.0735, screenH * 0.1302) and okno == 1 then
		okno = 6
	elseif mysz(screenW * 0.5566, screenH * 0.6901, screenW * 0.0919, screenH * 0.0534) and okno == 6 then
		okno = 1
	end
	if okno == 2 then
		local x = 0
		for i, v in ipairs(lampki) do
			if i >= k and i <= n then
				x = x +1
				local addY = (sy(73))*(x-1)
        		if mysz(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612) then
					lampki_info = {v[1], v[2], v[3], v[4], v[5]}
					lampki_select = true
				end
			end
		end
	end
	if okno == 3 then
		local x = 0
		for i, v in ipairs(neony) do
			if i >= k and i <= n then
				x = x +1
				local addY = (sy(73))*(x-1)
        		if mysz(screenW * 0.3625, screenH * 0.3411+addY, screenW * 0.1478, screenH * 0.0612) then
					neony_info = {v[1], v[2], v[3], v[4], v[5]}
					neony_select = true
				end
			end
		end
	end
	if okno == 6 then
		local veh = getPedOccupiedVehicle(localPlayer)
		for i, v in ipairs(inne) do
			local addY = (sy(76))*(i-1)
			if mysz(screenW * 0.5566, screenH * 0.3411+addY, screenW * 0.0919, screenH * 0.0534) then
				local kasa = getElementData(localPlayer, "pieniadze")
				if getElementData(veh, v[3]) then
					setElementData(veh, v[3], false)
					exports["smta_base_notifications"]:noti("Demontujesz "..v[1])
					setElementData(localPlayer, "pieniadze", kasa + (tonumber(v[2])/2))
				else
					if kasa < tonumber(v[2]) then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error") return end
					setElementData(veh, v[3], 1)
					exports["smta_base_notifications"]:noti("Montujesz "..v[1])
					setElementData(localPlayer, "pieniadze", kasa - tonumber(v[2]))
				end
			end
		end
	end
end)

bindKey("mouse_wheel_down", "both", function()
    if (okno == 2 or okno == 3) and mysz(screenW * 0.3625, screenH * 0.3424, screenW * 0.1485, screenH * 0.3294) then
        scrollUp()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if (okno == 2 or okno == 3) and mysz(screenW * 0.3625, screenH * 0.3424, screenW * 0.1485, screenH * 0.3294) then
        scrollDown()
    end
end)

function scrollDown()
    if n == m then return end
    k = k-1
    n = n-1
end

function scrollUp()
    if n >= #lampki then return end
    k = k+1
    n = n+1
end


-- dodatki


function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sw,cy*sh
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end