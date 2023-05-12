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
local font = dxCreateFont("cz2.ttf", 30)
local font2 = dxCreateFont("cz.ttf", 12)
local font3 = dxCreateFont("cz.ttf", 16)
local font4 = dxCreateFont("cz2.ttf", 16)
local font5 = dxCreateFont("cz.ttf", 38)
local tekst = ""
local tekst2 = ""
local okno1 = false
local okno2 = false
local okno3 = false
local okno4 = false
local ile = 1
local kupno = false
local gielda = false
local wymiana = false
local gprem = false


local k = 1
local n = 5
local m = 5

local premki = {
	{"1 PUNKT DIAMOND", "2,46"},
	{"3 PUNKTY DIAMOND", "4,92"},
	{"7 PUNKTÓW DIAMOND", "7,38"},
	{"14 PUNKTÓW DIAMOND", "11,07"},
	{"30 PUNKTÓW DIAMOND", "17.22"},
}

local premki2 = {
	{"KONTO DIAMOND 1 DZIEŃ", "1"},
	{"KONTO DIAMOND 3 DNI", "3"},
	{"KONTO DIAMOND 7 DNI", "7"},
	{"KONTO DIAMOND 14 DNI", "14"},
	{"KONTO DIAMOND 30 DNI", "30"},
}

local edit = guiCreateEdit(0.38, 0.61, 0.16, 0.04, "Kod, który otrzymałes w sms'ie", true)  
guiSetVisible(edit, false)
local liczbapp = guiCreateEdit(0.37, 0.64, 0.08, 0.04, "Ilość DP", true)
local cenapp = guiCreateEdit(0.46, 0.64, 0.08, 0.04, "Cena za sztukę", true) 
guiSetVisible(liczbapp, false)
guiSetVisible(cenapp, false)   

local tabgielda = { }

function gui()
	dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, ":smta_base_premium/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	shadowText(""..(getElementData(localPlayer, "pp") or 0).."", screenW * 0.0337, screenH * 0.0938, screenW * 0.3265, screenH * 0.1563, tocolor(150, 150, 150, 255), 1.00, font5, "left", "bottom", true, true, true, true, true)
	if okno2 == false and okno4 == false then
		if kupno == true then
			dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, ":smta_base_premium/gfx/bgkupno.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
			--dxDrawImage(screenW * 0.3697, screenH * 0.6862, screenW * 0.0864, screenH * 0.0391, ":smta_base_premium/gfx/kupno_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			--dxDrawImage(screenW * 0.3697, screenH * 0.6862, screenW * 0.0864, screenH * 0.0391, ":smta_base_premium/gfx/kupno_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		if wymiana == true then
			dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, ":smta_base_premium/gfx/bgwymiana.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    		--dxDrawImage(screenW * 0.4561, screenH * 0.6862, screenW * 0.0864, screenH * 0.0391, ":smta_base_premium/gfx/wymiana_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	else
    		--dxDrawImage(screenW * 0.4561, screenH * 0.6862, screenW * 0.0864, screenH * 0.0391, ":smta_base_premium/gfx/wymiana_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	end
		if gielda == true then
			dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, ":smta_base_premium/gfx/bggielda.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    		--dxDrawImage(screenW * 0.5425, screenH * 0.6862, screenW * 0.0871, screenH * 0.0391, ":smta_base_premium/gfx/gielda_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    	else
    		--dxDrawImage(screenW * 0.5425, screenH * 0.6862, screenW * 0.0871, screenH * 0.0391, ":smta_base_premium/gfx/gielda_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
   		end
    end
	if kupno == true then
		dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, ":smta_base_premium/gfx/bgkupno2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		shadowText("KUPNO PUNKTÓW DIAMOND", scale_x(467), scale_y(49), scale_x(973), scale_y(370), tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
		--dxDrawImage(scale_x(930), scale_y(207), scale_x(16), scale_y(16), ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if okno1 == true then
			for i, v in ipairs(premki) do
				local dodatekY = (scale_y(70))*(i-1)
    			if mysz(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352) then
    				dxDrawImage(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    			else
    				dxDrawImage(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    			end
    		end
    	else
    		dxDrawText(tekst2, scale_x(467), scale_y(187), scale_x(974), scale_y(554), tocolor(0, 0, 0, 255), 1.00, font3, "center", "center", false, false, false, false, false)
    		dxDrawText(tekst, scale_x(466), scale_y(186), scale_x(973), scale_y(553), tocolor(150, 150, 150, 255), 1.00, font3, "center", "center", false, false, false, true, false)
        	if mysz(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352) then
        		dxDrawImage(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        	else
        		dxDrawImage(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        	end
    	end
    end
    if wymiana == true then
		shadowText("WYMIANA PUNKTÓW DIAMOND", scale_x(467), scale_y(49), scale_x(973), scale_y(370), tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
		if okno3 == true then
			for i, v in ipairs(premki2) do
				local dodatekY = (scale_y(70))*(i-1)
    			if mysz(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352) then
    				dxDrawImage(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    			else
    				dxDrawImage(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    			end
    		end
    	else
    		dxDrawText(tekst2, scale_x(467), scale_y(187), scale_x(974), scale_y(554), tocolor(0, 0, 0, 255), 1.00, font3, "center", "center", false, false, false, false, false)
    		dxDrawText(tekst, scale_x(466), scale_y(186), scale_x(973), scale_y(553), tocolor(150, 150, 150, 255), 1.00, font3, "center", "center", false, false, false, true, false)
        	if mysz(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352) then
        		dxDrawImage(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        	else
        		dxDrawImage(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        	end
    	end
    end
    if gielda == true then
    	shadowText("GIEŁDA PUNKTÓW DIAMOND", scale_x(467), scale_y(49), scale_x(973), scale_y(370), tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
		if mysz(screenW * 0.5527, screenH * 0.6419, screenW * 0.0542, screenH * 0.0352) then
			dxDrawImage(screenW * 0.5527, screenH * 0.6419, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_off2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(screenW * 0.5527, screenH * 0.6419, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_on2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
        local x = 0
        for i, v in ipairs(tabgielda) do
        	if i >= k and i <= n then 
        		x = x+1
        		local dodatekY = (55*px)*(x-1)

        		dxDrawImage(screenW * 0.3785, screenH * 0.3047+dodatekY, screenW * 0.2438, screenH * 0.0664, ":smta_base_premium/gfx/rec.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        		dxDrawText(v["nick"], screenW * 0.3851, screenH * 0.3112+(dodatekY*2), screenW * 0.4744, screenH * 0.3646, tocolor(150, 150, 150, 255), 1.00, font3, "left", "center", false, false, false, false, false)
        		dxDrawText(v["ilosc"], screenW * 0.4817, screenH * 0.3112+(dodatekY*2), screenW * 0.5359, screenH * 0.3646, tocolor(150, 150, 150, 255), 1.00, font3, "left", "center", false, false, false, false, false)
        		dxDrawText(v["cena"].." $", screenW * 0.5608, screenH * 0.3112+(dodatekY*2), screenW * 0.6149, screenH * 0.3646, tocolor(150, 150, 150, 255), 1.00, font3, "left", "center", false, false, false, false, false)
				if mysz(screenW * 0.6362, screenH * 0.3229+dodatekY, screenW * 0.0542, screenH * 0.0352) then
					dxDrawImage(screenW * 0.6362, screenH * 0.3229+dodatekY, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				else
					dxDrawImage(screenW * 0.6362, screenH * 0.3229+dodatekY, screenW * 0.0542, screenH * 0.0352, ":smta_base_premium/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				end
        		if v["nick"] == getPlayerName(localPlayer) then
        			--dxDrawText("Usun", 864*px, 225*py+(dodatekY*2), 954*px, 259*py, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        		else
        			--dxDrawText("Kup", 864*px, 225*py+(dodatekY*2), 954*px, 259*py, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        		end
        	end
        end
    end
end

addEventHandler( "onClientClick", getRootElement(), function (btn, state)
	if btn == 'left' and state == 'down' then
		for i, v in ipairs(premki) do
		for i, v in ipairs(premki) do
			local dodatekY = (scale_y(70))*(i-1)
			if mysz(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352) and okno1 == true and okno2 == false and kupno == true then
				okno1 = false
				okno2 = true
				guiSetVisible(edit, true)
				if v[1] == "1 PUNKT DIAMOND" then
					ile = 1
					tekst = "Ilość PUNKTÓW DIAMOND: #B92B271\n\n#969696Treść sms: #B92B27MSMS.SMTA\n#969696Numer: #B92B2772480\n#969696Koszt: #B92B272,46 PLN\n\n#969696Poniżej wpisz kod zwrotny"
					tekst2 = "Ilość PUNKTÓW DIAMOND: 1\n\nTreść sms: MSMS.SMTA\nNumer: 72480\nKoszt: 2,46 PLN\n\nPoniżej wpisz kod zwrotny"
				elseif v[1] == "3 PUNKTY DIAMOND" then
					ile = 3
					tekst = "Ilość PUNKTÓW DIAMOND: #B92B273\n\n#969696Treść sms: #B92B27MSMS.SMTA\n#969696Numer: #B92B2774480\n#969696Koszt: #B92B274,92 PLN\n\n#969696Poniżej wpisz kod zwrotny"
					tekst2 = "Ilość PUNKTÓW DIAMOND: 3\n\nTreść sms: MSMS.SMTA\nNumer: 74480\nKoszt: 4,92 PLN\n\nPoniżej wpisz kod zwrotny"
				elseif v[1] == "7 PUNKTÓW DIAMOND" then
					ile = 7
					tekst = "Ilość PUNKTÓW DIAMOND: #B92B277\n\n#969696Treść sms: #B92B27MSMS.SMTA\n#969696Numer: #B92B2776480\n#969696Koszt: #B92B277.38 PLN\n\n#969696Poniżej wpisz kod zwrotny"
					tekst2 = "Ilość PUNKTÓW DIAMOND: 7\n\nTreść sms: MSMS.SMTA\nNumer: 76480\nKoszt: 7.38 PLN\n\nPoniżej wpisz kod zwrotny"
				elseif v[1] == "14 PUNKTÓW DIAMOND" then
					ile = 14
					tekst = "Ilość PUNKTÓW DIAMOND: #B92B2714\n\n#969696Treść sms: #B92B27MSMS.SMTA\n#969696Numer: #B92B2779480\n#969696Koszt: #B92B2711.07 PLN\n\n#969696Poniżej wpisz kod zwrotny"
					tekst2 = "Ilość PUNKTÓW DIAMOND: 14\n\nTreść sms: MSMS.SMTA\nNumer: 79480\nKoszt: 11.07 PLN\n\nPoniżej wpisz kod zwrotny"
				elseif v[1] == "30 PUNKTÓW DIAMOND" then
					ile = 30
					tekst = "Ilość PUNKTÓW DIAMOND: #B92B2730\n\n#969696Treść sms: #B92B27MSMS.SMTA\n#969696Numer: #B92B2791400\n#969696Koszt: #B92B2717.22 PLN\n\n#969696Poniżej wpisz kod zwrotny"
					tekst2 = "Ilość PUNKTÓW DIAMOND: 30\n\nTreść sms: MSMS.SMTA\nNumer: 91400\nKoszt: 17.22 PLN\n\nPoniżej wpisz kod zwrotny"
				end
			end
		end
		if wymiana == true then
			for i, v in ipairs(premki2) do
				local dodatekY = (scale_y(70))*(i-1)
				if mysz(screenW * 0.5593, screenH * 0.3060+dodatekY, screenW * 0.0542, screenH * 0.0352) and okno3 == true and okno4 == false and wymiana == true then
					okno3 = false
					okno4 = true
					if v[1] == "KONTO DIAMOND 1 DZIEŃ" then
						ile = 1
						tekst = "Ilość dni konta diamond: #B92B271\n\n#969696Koszt: #B92B271 DP"
						tekst2 = "Ilość dni konta diamond: 1\n\nKoszt: 1 DP"
					elseif v[1] == "KONTO DIAMOND 3 DNI" then
						ile = 3
						tekst = "Ilość dni konta diamond: #B92B273\n\n#969696Koszt: #B92B273 DP"
						tekst2 = "Ilość dni konta diamond: 3\n\nKoszt: 3 DP"
					elseif v[1] == "KONTO DIAMOND 7 DNI" then
						ile = 7
						tekst = "Ilość dni konta diamond: #B92B277\n\n#969696Koszt: #B92B277 DP"
						tekst2 = "Ilość dni konta diamond: 7\n\nKoszt: 7 DP"
					elseif v[1] == "KONTO DIAMOND 14 DNI" then
						ile = 14
						tekst = "Ilość dni konta diamond: #B92B2714\n\n#969696Koszt: #B92B2714 DP"
						tekst2 = "Ilość dni konta diamond: 14\n\nKoszt: 14 DP"
					elseif v[1] == "KONTO DIAMOND 30 DNI" then
						ile = 30
						tekst = "Ilość dni konta diamond: #B92B2730\n\n#969696Koszt: #B92B2730 DP"
						tekst2 = "Ilość dni konta diamond: 30\n\nKoszt: 30 DP"
					end
				end
			end
		end
		if gielda == true then
			local x = 0
			for i, v in ipairs(tabgielda) do
				if i >= k and i <= n then 
        			x = x+1
        			local dodatekY = (55*px)*(x-1)
					if mysz(screenW * 0.6362, screenH * 0.3229+dodatekY, screenW * 0.0542, screenH * 0.0352) and gielda == true and gprem == true then
						if v["nick"] == getPlayerName(localPlayer) then
							triggerServerEvent("usun:pp", localPlayer, v["id"])
							triggerServerEvent("pokaz:gieldepp", localPlayer)
						else
							triggerServerEvent("kup:pp", localPlayer, v["id"])
							triggerServerEvent("pokaz:gieldepp", localPlayer)
						end
					end
				end
			end
		end
		local dodatekY = (scale_y(70))*(i-1)
		if mysz(scale_x(930), scale_y(207), scale_x(16), scale_y(16)) and okno1 == false and okno2 == true then
			okno1 = true
			okno2 = false
			guiSetVisible(edit, false)
		elseif mysz(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352) and okno1 == false and okno2 == true then
			if guiGetText(edit) == "" or guiGetText(edit) == "Kod, który otrzymałes w sms'ie" then return end
			triggerServerEvent("sprawdzPremium", localPlayer, guiGetText(edit), ile)
		elseif mysz(screenW * 0.5593, screenH * 0.6133, screenW * 0.0542, screenH * 0.0352) and okno3 == false and okno4 == true then
			triggerServerEvent("wymien:pp", localPlayer, ile)
		elseif mysz(822*px, 585*py, 126*px, 38*py) and gielda == true then
			if niemozesz == true then return end
			local cena = guiGetText(cenapp)
			local ilosc = guiGetText(liczbapp)
			if not tonumber(ilosc) then return end
			if not tonumber(cena) then return end
			if cena:len() > 6 then return end
			if cena == "Cena" then return end
			if ilosc == "Ilość" then return end
			if cena == "" then return end
			if ilosc == "" then return end
			if tonumber(cena) < 1 then return end
			if tonumber(ilosc) < 1 then return end
			if string.find(cena, 'E') then return end
    		if string.find(cena, 'e') then return end
  			if string.find(cena, 'r') then return end
			if tonumber(ilosc) > tonumber(getElementData(localPlayer, "pp")) then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej ilość DP", "error") return end
			triggerServerEvent("wystaw:pp", localPlayer, tonumber(ilosc), tonumber(cena))
			triggerServerEvent("pokaz:gieldepp", localPlayer)
			niemozesz = true
        	setTimer(function()
            	niemozesz = false
        	end, 500, 1)
		elseif mysz(scale_x(930), scale_y(207), scale_x(16), scale_y(16)) and okno3 == false and okno4 == true then
			okno3 = true
			okno4 = false
		elseif mysz(screenW * 0.3697, screenH * 0.6862, screenW * 0.0864, screenH * 0.0391) and gprem == true and okno4 == false and okno2 == false then
			kupno = true
			gielda = false
			wymiana = false
			guiSetVisible(liczbapp, false)
			guiSetVisible(cenapp, false)
		elseif mysz(screenW * 0.4561, screenH * 0.6862, screenW * 0.0864, screenH * 0.0391) and gprem == true and okno4 == false and okno2 == false  then
			kupno = false
			gielda = false
			wymiana = true
			okno3 = true
			okno4 = false
			guiSetVisible(liczbapp, false)
			guiSetVisible(cenapp, false)
		elseif mysz(screenW * 0.5425, screenH * 0.6862, screenW * 0.0871, screenH * 0.0391) and gprem == true and okno4 == false and okno2 == false  then
			kupno = false
			gielda = true
			wymiana = false
			triggerServerEvent("pokaz:gieldepp", localPlayer)
			guiSetVisible(liczbapp, true)
			guiSetVisible(cenapp, true)
		end
	end
end
end)

addEvent("poka:gieldepp", true)
addEventHandler("poka:gieldepp", root, function(tab)
	tabgielda = tab
end)

bindKey("mouse_wheel_down", "both", function()
	if gielda ~= true then return end
	if n >= #tabgielda then return end
	k = k+1
	n = n+1
end)

bindKey("mouse_wheel_up", "both", function()
	if gielda ~= true then return end
	if n == m then return end
	k = k-1
	n = n-1
end)

function showF4()
	--if not getElementData(localPlayer, "duty") then exports["smta_base_notifications"]:noti("Trwa poprawianie systemu premium", "error") return end
	if okno1 == false and okno2 == false then
		addEventHandler("onClientRender", root, gui)
		okno1 = true
		gprem = true
		showCursor(true)
		setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
		kupno = true
		gielda = false
		wymiana = false
	else
		guiSetVisible(liczbapp, false)
		guiSetVisible(cenapp, false)
		guiSetVisible(edit, false)
		setElementData(localPlayer, "hud", false)
		removeEventHandler("onClientRender", root, gui)
		gprem = false
		okno1 = false
		okno2 = false
		okno3 = false
		okno4 = false
		gielda = false
		showCursor(false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
	end
end
bindKey('F4', 'down', showF4);
addCommandHandler("diamond", showF4);

--opcje

function mysz( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

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