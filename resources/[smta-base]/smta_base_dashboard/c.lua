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

local listaaut = false
local statystyki = false
local kary = false
local ustawienia = false
local dashboard = false
local osiagniecia = false
local lokalizacja = "N/A"

local k = 1
local n = 4
local m = 4

local k2 = 1
local n2 = 4
local m2 = 4

local pojazdy = {}
local osiagnieciatab = {}

local fontsmall = dxCreateFont("cz.ttf", 13)
local font = dxCreateFont("cz.ttf", 16)
local font2 = dxCreateFont("cz.ttf", 25)

local width = 1082*px
local height = 324*py
local scrollPos = 0
local scrollOffset = 5.0

local maxRender = dxCreateRenderTarget(width, height, true)

function gui()
	dxDrawRectangle(0, 0, screenW, screenH, tocolor(0, 0, 0, 100), false)
    if mysz(389*px, 67*py, 107*px, 88*py) then
        dxDrawImage(342*px, 10*py, 200*px, 200*py, ":smta_base_dashboard/gfx/informacje_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
        dxDrawImage(342*px, 10*py, 200*px, 200*py, ":smta_base_dashboard/gfx/informacje_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    if mysz(667*px, 66*py, 107*px, 88*py) then
        dxDrawImage(621*px, 10*py, 200*px, 200*py, ":smta_base_dashboard/gfx/auta_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
        dxDrawImage(621*px, 10*py, 200*px, 200*py, ":smta_base_dashboard/gfx/auta_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    if mysz(948*px, 67*py, 107*px, 88*py) then
        dxDrawImage(902*px, 10*py, 200*px, 200*py, ":smta_base_dashboard/gfx/ustawienia_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
        dxDrawImage(902*px, 10*py, 200*px, 200*py, ":smta_base_dashboard/gfx/ustawienia_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    if statystyki == true then 
    	local dbid = getElementData(localPlayer, "dbid") or 0
        local pieniadze = string.format("%1d", (getElementData(localPlayer, "pieniadze") or 0))
        local brudnepieniadze = string.format("%1d", (getElementData(localPlayer, "brudne:pieniadze") or 0))
    	local bankomat = getElementData(localPlayer, "bankomat") or 0
    	local rp = getElementData(localPlayer, "punkty") or 0
        local minuty = getElementData(localPlayer, "online")


    	local prawkoA = getElementData(localPlayer, "prawko_a") or 0
    	if prawkoA == 1 then
    		prawkoA = "Posiadasz"
    		prawkoA2 = "#4169E1Posiadasz"
    	else
    		prawkoA = "Nie posiadasz"
    		prawkoA2 = "#B92B27Nie posiadasz"
    	end

    	local prawkoB = getElementData(localPlayer, "prawko_b") or 0
    	if prawkoB == 1 then
    		prawkoB = "Posiadasz"
    		prawkoB2 = "#4169E1Posiadasz"
    	else
    		prawkoB = "Nie posiadasz"
    		prawkoB2 = "#B92B27Nie posiadasz"
    	end

    	local prawkoC = getElementData(localPlayer, "prawko_c") or 0
    	if prawkoC == 1 then
    		prawkoC = "Posiadasz"
    		prawkoC2 = "#4169E1Posiadasz"
    	else
    		prawkoC = "Nie posiadasz"
    		prawkoC2 = "#B92B27Nie posiadasz"
    	end
        local przynety = getElementData(localPlayer, "przynety") or 0
        local weed1 = getElementData(localPlayer, "weed1") or 0
        local weed2 = getElementData(localPlayer, "weed2") or 0
        
        local meta1 = getElementData(localPlayer, "meta1") or 0
        local meta2 = getElementData(localPlayer, "meta2") or 0

        local koka1 = getElementData(localPlayer, "koka1") or 0
        local koka2 = getElementData(localPlayer, "koka2") or 0
    	dxDrawText("Nick: "..getPlayerName(localPlayer).."\nData rejestracji: "..getElementData(localPlayer, "rejestracja").."", 133*px, 738*py, 481*px, 806*py, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, false, false, false, false)  
    	dxDrawText("#969696Nick: #4169E1"..getPlayerName(localPlayer).."\n#969696Data rejestracji: #4169E1"..getElementData(localPlayer, "rejestracja").."", 132*px, 737*py, 480*px, 805*py, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, true, false)    
        dxDrawText("PID: "..dbid.."\nGotówka przy sobie: "..pieniadze.." $\nBrudna gotówka przy sobie: "..brudnepieniadze.."\nGotówka w bankomacie: "..bankomat.." $\nCzas online: "..mth(minuty)[1].."h "..mth(minuty)[2].."m\nPunkty SP: "..rp.."\n\nPrawo jazdy kat.A: "..prawkoA.."\nPrawo jazdy kat.B: "..prawkoB.."\nPrawo jazdy kat.C: "..prawkoC.."\n\nLiczba przynęt: "..przynety.."\n\nLiczba warnów: "..getElementData(localPlayer, "warny").."/5\nLiscie marichuany: "..weed1.."\nGramy marichuany: "..weed2.."\nRoztwór metamfetaminy: "..meta1.."\nGramy metamfetaminy: "..meta2.."\nLisć kokainy: "..koka1.."\nGramy kokainy: "..koka2.."", 347*px, 299*py, 1108*px, 740*py, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, false, false, false, false)
        dxDrawText("#969696PID: #4169E1"..dbid.."#969696\nGotówka przy sobie: #4169E1"..pieniadze.." $#969696\nBrudna gotówka przy sobie: #B92B27"..brudnepieniadze.."#969696\nGotówka w bankomacie: #4169E1"..bankomat.." $#969696\nCzas online: #4169E1"..mth(minuty)[1].."h "..mth(minuty)[2].."m#969696\nPunkty SP: #4169E1"..rp.."\n\n#969696Prawo jazdy kat.A: "..prawkoA2.."\n#969696Prawo jazdy kat.B: "..prawkoB2.."\n#969696Prawo jazdy kat.C: "..prawkoC2.."\n\n#969696Liczba przynęt: #4169E1"..przynety.."#969696\n\nLiczba warnów: #4169E1"..getElementData(localPlayer, "warny").."/5\n#B92B27Liscie marichuany: "..weed1.."\nGramy marichuany: "..weed2.."\nRoztwór metamfetaminy: "..meta1.."\nGramy metamfetaminy: "..meta2.."\nLisć kokainy: "..koka1.."\nGramy kokainy: "..koka2.."", 346*px, 298*py, 1107*px, 739*py, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, true, false)
        if not myElement or not myObject then return end
        local projPosX, projPosY = guiGetPosition(guiWindow,true)
        local projSizeX, projSizeY = guiGetSize(guiWindow, true)
        exports.object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
    end
    if listaaut == true then
        local x2 = 0 
    	shadowText("Lista twoich pojazdów ("..#pojazdy..")", 581*px, 289*py, 864*px, 369*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
        for i,v in ipairs(pojazdy) do
            if i >= k2 and i <= n2 then 
                x2 = x2 + 1
                local dodatekY = (87*py)*(x2-1)
                local dodatekY2 = (174*py)*(x2-1)

                local model = getVehicleNameFromModel(v.model)

                local lokalizacja = "N/A";
                dxDrawText(tostring(v.przecho), 0, 0);
                if tonumber(v.przecho) == 1 then
    			 lokalizacja = "Przechowalnia pojazdów"
                elseif v.poli == 1 then
                 lokalizacja = "Parking policyjny"
                elseif v.parking ~= 0 then
                 lokalizacja = "Wirtualny parking #"..v.parking
    		    else
    			 for k,p in ipairs(getElementsByType("vehicle")) do
	          		   local id = getElementData(p, "id")
	          		   if id and id == v["id"] then
	            		 local x,y,z = getElementPosition(p)
	            		 lokalizacja = getZoneName(x,y,z,true)..", "..getZoneName(x,y,z,false)
	          		   end
	        	  end
	           end
                dxDrawRectangle(441*px, 353*py + dodatekY, 562*px, 87*py, tocolor(0, 0, 0, 140), false)
                dxDrawLine(441*px, 440*py+dodatekY, 1003*px, 440*py+dodatekY, tocolor(185, 43, 39, 255), 2, false)
                dxDrawImage(screenW * 0.3148, screenH * 0.3828+dodatekY, screenW * 0.0644, screenH * 0.1146, ":smta_base_dashboard/gfx/auta_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
                shadowText(model.." ["..v.id.."]", 567*px, 353*py + dodatekY2, 779*px, 396*py, tocolor(150, 150, 150, 255), 1.00, font, "left", "center", false, false, false, false, false)
                shadowText(lokalizacja, 567*px, 396*py + dodatekY2, 779*px, 439*py, tocolor(150, 150, 150, 255), 1.00, fontsmall, "left", "center", false, false, false, false, false)
                if mysz(screenW * 0.6018, screenH * 0.4206+dodatekY, screenW * 0.0571, screenH * 0.0391) then
                    dxDrawImage(screenW * 0.6018, screenH * 0.4206+dodatekY, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawImage(screenW * 0.6018, screenH * 0.4206+dodatekY, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                end
                shadowText("Namierz", 842*px, 373*py+dodatekY2, 977*px, 418*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            end
       end
    end
        if ustawienia == true then
            shadowText("USTAWIENIA GRY", 347*px, 280*py, 676*px, 336*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            if not getElementData(localPlayer, "poff") then
                dxDrawImage(347*px, 336*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(347*px, 336*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            if not getElementData(localPlayer, "cpoff") then
                dxDrawImage(347*px, 386*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(347*px, 386*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            if getElementData(localPlayer, "shader:fps") then
                dxDrawImage(347*px, 436*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(347*px, 436*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            shadowText("Prywatne wiadomości", 445*px, 336*py, 676*px, 386*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            shadowText("Czat premium", 445*px, 386*py, 676*px, 436*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            shadowText("Licznik FPS", 447*px, 436*py, 678*px, 486*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            shadowText("USTAWIENIA GRAFICZNE", 770*px, 280*py, 1099*px, 336*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            if getElementData(localPlayer, "player:blackwhite") then
                dxDrawImage(770*px, 336*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(770*px, 336*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            if getElementData(localPlayer, "shader:1") then
                dxDrawImage(770*px, 386*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(770*px, 386*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            if getElementData(localPlayer, "shader:3") then
                dxDrawImage(770*px, 436*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(770*px, 436*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            if getElementData(localPlayer, "shader:6") then
                dxDrawImage(770*px, 486*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(770*px, 486*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            if getElementData(localPlayer, "shader:2") then
                dxDrawImage(770*px, 536*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(770*px, 536*py, 100*px, 50*py, ":smta_base_dashboard/gfx/switch_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
            shadowText("Czarno białe", 868*px, 336*py, 1099*px, 386*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            shadowText("Karoseria pojazdów", 868*px, 386*py, 1099*px, 436*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            shadowText("Bloom", 868*px, 436*py, 1099*px, 486*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            shadowText("Żywe kolory", 868*px, 486*py, 1099*px, 536*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
            shadowText("Woda", 868*px, 536*py, 1099*px, 586*py, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
        end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	--statystyki
    if mysz(389*px, 67*py, 107*px, 88*py) and dashboard == true and statystyki == false then
        statystyki = true
        kary = false
        listaaut = false
        osiagniecia = false
        ustawienia = false
        local x1, y1, z1 = getCameraMatrix()
        myElement = createPed(getElementData(localPlayer, "skin"), x1, y1, z1, 0)
        myObject = exports.object_preview:createObjectPreview(myElement, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
        guiWindow = guiCreateWindow(96*px, 163*py, 428*px, 704*py, "", false, false)
        guiSetAlpha(guiWindow, 0)
        local projPosX, projPosY = guiGetPosition(guiWindow,true)
        local projSizeX, projSizeY = guiGetSize(guiWindow, true)
        exports.object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
        exports.object_preview:setRotation(myObject, -10, 0, 200)
    elseif mysz(667*px, 66*py, 107*px, 88*py) and dashboard == true and listaaut == false then
    	triggerServerEvent("pokazPojazdySource", localPlayer)
    	listaaut = true
    	statystyki = false
    	kary = false
        osiagniecia = false
        ustawienia = false
    	if isElement(myElement) then
            destroyElement(myElement)
            destroyElement(guiWindow)
        end
    elseif mysz(948*px, 67*py, 107*px, 88*py) and dashboard == true and ustawienia == false then
        osiagniecia = false
        listaaut = false
        statystyki = false
        kary = false
        ustawienia = true
        if isElement(myElement) then
            destroyElement(myElement)
            destroyElement(guiWindow)
        end
    elseif mysz(770*px, 336*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "player:blackwhite") then
            setElementData(localPlayer, "player:blackwhite", false)
        else
             setElementData(localPlayer, "player:blackwhite", true)
        end
    elseif mysz(770*px, 386*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "shader:1") then
            setElementData(localPlayer, "shader:1", false)
        else
             setElementData(localPlayer, "shader:1", true)
        end
    elseif mysz(770*px, 436*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "shader:3") then
            setElementData(localPlayer, "shader:3", false)
        else
             setElementData(localPlayer, "shader:3", true)
        end
    elseif mysz(770*px, 486*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "shader:6") then
            setElementData(localPlayer, "shader:6", false)
        else
             setElementData(localPlayer, "shader:6", true)
        end
    elseif mysz(770*px, 536*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "shader:2") then
            setElementData(localPlayer, "shader:2", false)
        else
             setElementData(localPlayer, "shader:2", true)
        end

    -- ustawienia gry
    elseif mysz(347*px, 336*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "poff") then
            setElementData(localPlayer, "poff", false)
        else
             setElementData(localPlayer, "poff", true)
        end
    elseif mysz(347*px, 386*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "cpoff") then
            setElementData(localPlayer, "cpoff", false)
        else
             setElementData(localPlayer, "cpoff", true)
        end
    elseif mysz(347*px, 436*py, 100*px, 50*py) and dashboard == true and ustawienia == true then
        if getElementData(localPlayer, "shader:fps") then
            setElementData(localPlayer, "shader:fps", false)
        else
             setElementData(localPlayer, "shader:fps", true)
        end
    end
    -- lista aut
    local x3 = 0
    for i, v in ipairs(pojazdy) do
        if i >= k2 and i <= n2 then 
            x3 = x3 + 1
            local dodatekY = (87*py)*(x3-1)
            if mysz(screenW * 0.6018, screenH * 0.4206+dodatekY, screenW * 0.0571, screenH * 0.0391) and dashboard == true and listaaut == true then
                if v.przecho == 1 then
                    exports["smta_base_notifications"]:noti("Nie można namierzyć tego pojazdu ponieważ znajduje się w przechowalni!", "error")
                else
                    exports["smta_base_notifications"]:noti("Twój pojazd został namierzony!")
                    for k,p in ipairs(getElementsByType("vehicle")) do
                        local id = getElementData(p, "id")
                        if id and id == v.id then
                            local x,y,z = getElementPosition(p)
                            exports["smta_oth_gps"]:namierz(x,y)
                        end
                    end
                end
            end
        end
    end
  end
end)

bindKey("f3","down", function()
	if dashboard == true then
		dashboard = false
		removeEventHandler("onClientRender", root, gui)
		showCursor(false)
        listaaut = false
        statystyki = false
        kary = false
        ustawienia = false
        osiagniecia = false
        setElementData(localPlayer, "hud", false)
        showChat(true)
        setElementData(localPlayer, "player:blackwhite", false)
        if isElement(myElement) then
            destroyElement(myElement)
            destroyElement(guiWindow)
        end
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
	else
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
		dashboard = true
		statystyki = true
		addEventHandler("onClientRender", root, gui)
		showCursor(true)
		setElementData(localPlayer, "hud", true)
        showChat(false)
        setElementData(localPlayer, "player:blackwhite", true)
		local x1, y1, z1 = getCameraMatrix()
        myElement = createPed(getElementData(localPlayer, "skin"), x1, y1, z1, 0)
        myObject = exports.object_preview:createObjectPreview(myElement, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
        guiWindow = guiCreateWindow(96*px, 163*py, 428*px, 704*py, "", false, false)
        guiSetAlpha(guiWindow, 0)
        local projPosX, projPosY = guiGetPosition(guiWindow,true)
        local projSizeX, projSizeY = guiGetSize(guiWindow, true)
        exports.object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
        exports.object_preview:setRotation(myObject, -10, 0, 200)
	end
end)

addEvent("pokazPojazdyClient", true)
addEventHandler("pokazPojazdyClient", root, function(tabelka)
  pojazdy = tabelka
end)

addEvent("pokazOsiagnieciaClient", true)
addEventHandler("pokazOsiagnieciaClient", root, function(tabelka)
  osiagnieciatab = tabelka
end)

bindKey("mouse_wheel_down", "both", function()
    if osiagniecia == true then
        scrollUp()
    elseif listaaut == true then
        scrollUp2()
    end
end)

bindKey("mouse_wheel_up", "both", function()
    if osiagniecia == true then
        scrollDown()
    elseif listaaut == true then
        scrollDown2()
    end
end)

function scrollDown()
    if n == m then return end
    k = k-1
    n = n-1
end

function scrollUp()
    if n >= #osiagnieciatab then return end
    k = k+1
    n = n+1
end

function scrollDown2()
    if n2 == m2 then return end
    k2 = k2-1
    n2 = n2-1
end

function scrollUp2()
    if n2 >= #pojazdy then return end
    k2 = k2+1
    n2 = n2+1
end

function mth(minutes)
    local h = math.floor(minutes/60)
    local m = minutes - (h*60)
    return {h,m}
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
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