--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()

local frakcja = "SAPD"
local lider = "Komendant"
local vlider = "Zastepca_Komendanta"

local sx, sy = guiGetScreenSize()
local px, py = sx/1440, sy/900
local topka = { }
local pracownicy = { }
local font1 = dxCreateFont("cz.ttf", 14)
local font2 = dxCreateFont("cz.ttf", 14)

local okno1 = false
local okno2 = false
local lista = false
local edytowanie = false
local dodawanie = false

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end

function gsluzby()
	dxDrawImage(screenW * 0.3821, screenH * 0.2604, screenW * 0.2365, screenH * 0.4805, ":smta_factions_SAPD/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    if mysz(screenW * 0.4714, screenH * 0.6888, screenW * 0.0571, screenH * 0.0391) then
    	dxDrawImage(screenW * 0.4714, screenH * 0.6888, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
    	dxDrawImage(screenW * 0.4714, screenH * 0.6888, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    if getElementData(localPlayer, "frakcja:sluzba") then
        shadowText("Zakończ", screenW * 0.4722, screenH * 0.6888, screenW * 0.5286, screenH * 0.7279, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    else
        shadowText("Rozpocznij", screenW * 0.4722, screenH * 0.6888, screenW * 0.5286, screenH * 0.7279, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    end
    if mysz(screenW * 0.6018, screenH * 0.2734, screenW * 0.0110, screenH * 0.0247) then
    	dxDrawImage(screenW * 0.6018, screenH * 0.2734, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
    	dxDrawImage(screenW * 0.6018, screenH * 0.2734, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    for i, v in ipairs(topka) do
    	local dodatekY = (scale_y(43))*(i-1)
    	local czas = ""..mth(v.minuty)[1].."h "..mth(v.minuty)[2].."m"
    	shadowText(v.nick, screenW * 0.4019, screenH * 0.4531+(dodatekY*2), screenW * 0.5190, screenH * 0.4857, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
    	shadowText(czas, screenW * 0.5249, screenH * 0.4518+(dodatekY*2), screenW * 0.5944, screenH * 0.4870, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
    end
end

addEvent("gui:sluzba:"..frakcja.."", true)
addEventHandler("gui:sluzba:"..frakcja.."", root, function(tabelka)
	topka = tabelka
	addEventHandler("onClientRender", root, gsluzby)
	okno1 = true
    showCursor(true)
    setElementData(localPlayer, "hud", true)
    showChat(false)
    executeCommandHandler("radar")
    setElementData(localPlayer, "player:blackwhite", true)
end)


addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.4714, screenH * 0.6888, screenW * 0.0571, screenH * 0.0391) and okno1 == true then
        triggerServerEvent("rozpocznijSluzbe:"..frakcja.."", localPlayer)
        removeEventHandler("onClientRender", root, gsluzby)
        showCursor(false)
        setElementData(localPlayer, "hud", false)
        showChat(true)
        executeCommandHandler("radar")
        setElementData(localPlayer, "player:blackwhite", false)
        okno1 = false
    elseif mysz(screenW * 0.6018, screenH * 0.2734, screenW * 0.0110, screenH * 0.0247) and okno1 == true then
        removeEventHandler("onClientRender", root, gsluzby)
        showCursor(false)
        setElementData(localPlayer, "hud", false)
        showChat(true)
        executeCommandHandler("radar")
        setElementData(localPlayer, "player:blackwhite", false)
        okno1 = false
    end
  end
end)

-- panel lidera

local k = 1
local n = 5
local m = 5

edit1 = guiCreateEdit(0.443, 0.52, 0.11, 0.04, "", true)
edit2 = guiCreateEdit(0.443, 0.57, 0.11, 0.04, "", true)  
guiSetVisible(edit1, false) 
guiSetVisible(edit2, false) 

function glidera()
    dxDrawImage(screenW * 0.2789, screenH * 0.2682, screenW * 0.4429, screenH * 0.4635, ":smta_factions_SAMC/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    if mysz(screenW * 0.6545, screenH * 0.6719, screenW * 0.0571, screenH * 0.0391) then
    	dxDrawImage(screenW * 0.6545, screenH * 0.6719, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
    	dxDrawImage(screenW * 0.6545, screenH * 0.6719, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    if lista == true then
        shadowText("Dodawanie", screenW * 0.6552, screenH * 0.6719, screenW * 0.7116, screenH * 0.7109, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    elseif edytowanie ~= false then
        shadowText("Edytuj", screenW * 0.6552, screenH * 0.6719, screenW * 0.7116, screenH * 0.7109, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    elseif dodawanie == true then
        shadowText("Dodaj", screenW * 0.6552, screenH * 0.6719, screenW * 0.7116, screenH * 0.7109, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    end
    if mysz(screenW * 0.7035, screenH * 0.2813, screenW * 0.0110, screenH * 0.0247) then
    	dxDrawImage(screenW * 0.7035, screenH * 0.2813, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    else
    	dxDrawImage(screenW * 0.7035, screenH * 0.2813, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    
    if lista == true then
    	local x = 0
        for i, v in ipairs(pracownicy) do
        	if i >= k and i <= n then 
        		x = x+1
                local dodatekY = (60*py)*(x-1)
                local dodatekY2 = (120*py)*(x-1)
            	local czas = ""..mth(v.minuty)[1].."h "..mth(v.minuty)[2].."m"

        		dxDrawText(v.nick, screenW * 0.2899, screenH * 0.3438+(dodatekY*2), screenW * 0.4334, screenH * 0.3867, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        		dxDrawText(v.ranga, screenW * 0.4407, screenH * 0.3438+(dodatekY*2), screenW * 0.5586, screenH * 0.3867, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        		dxDrawText(v.wyplata, screenW * 0.5659, screenH * 0.3438+(dodatekY*2), screenW * 0.6332, screenH * 0.3867, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        		dxDrawText(czas, screenW * 0.6471, screenH * 0.3438+(dodatekY*2), screenW * 0.6991, screenH * 0.3867, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        		dxDrawImage(screenW * 0.6969, screenH * 0.3477+dodatekY, screenW * 0.0146, screenH * 0.0260, ":smta_base_admin/kosz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawImage(screenW * 0.6969, screenH * 0.3477+dodatekY, screenW * 0.0146, screenH * 0.0260, ":smta_base_admin/kosz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                if mysz(screenW * 0.7321, screenH * 0.3477+dodatekY, screenW * 0.0571, screenH * 0.0391) then
                    dxDrawImage(screenW * 0.7321, screenH * 0.3477+dodatekY, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawImage(screenW * 0.7321, screenH * 0.3477+dodatekY, screenW * 0.0571, screenH * 0.0391, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                end
                shadowText("Edytuj", screenW * 0.7291, screenH * 0.3424+dodatekY2, screenW * 0.7921, screenH * 0.3906, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        	end
        end
    end
    if edytowanie ~= false then
        shadowText("Edytujesz pracownika: "..edytowanie.."", scale_x(401), scale_y(288), scale_x(1038), scale_y(455), tocolor(255, 255, 255, 255), 1.00, font2, "center", "bottom", false, false, false, false, false)
        shadowText("Wypłata (300-500 $):", scale_x(488), scale_y(464), scale_x(621), scale_y(501), tocolor(255, 255, 255, 255), 1.00, font2, "right", "center", false, false, false, false, false)
        shadowText("Ranga:", scale_x(488), scale_y(510), scale_x(621), scale_y(547), tocolor(255, 255, 255, 255), 1.00, font2, "right", "center", false, false, false, false, false)
    end
    if dodawanie == true then
        shadowText("Dodawanie nowych pracowników do frakcji", scale_x(401), scale_y(288), scale_x(1038), scale_y(455), tocolor(255, 255, 255, 255), 1.00, font2, "center", "bottom", false, false, false, false, false)
        shadowText("Nazwa użytkownika: ", scale_x(488), scale_y(464), scale_x(621), scale_y(501), tocolor(255, 255, 255, 255), 1.00, font2, "right", "center", false, false, false, false, false)
    end
end

addEvent("gui:lidera:"..frakcja.."", true)
addEventHandler("gui:lidera:"..frakcja.."", root, function(tab)
    pracownicy = tab
    addEventHandler("onClientRender", root, glidera)
    okno2 = true
    lista = true
    showCursor(true)
    setElementData(localPlayer, "hud", true)
    showChat(false)
    executeCommandHandler("radar")
    setElementData(localPlayer, "player:blackwhite", true)
end)

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	local x = 0
    for i,v in ipairs(pracownicy) do
        if i >= k and i <= n then 
           x = x+1
            local dodatekY = (60*py)*(x-1)
            if mysz(screenW * 0.7321, screenH * 0.3477+dodatekY, screenW * 0.0571, screenH * 0.0391) and okno2 == true and lista == true then
                if getElementData(localPlayer, "frakcja:ranga") == vlider then 
                    if v.ranga == lider or v.ranga == vlider then
                        exports["smta_base_notifications"]:noti("Nie możesz edytować vlidera/lidera", "error")
                    return end
                end
                lista = false
                edytowanie = v.nick
                guiSetVisible(edit1, true)
                guiSetVisible(edit2, true)
                guiSetText(edit1, v.wyplata)
                guiSetText(edit2, v.ranga)
            elseif mysz(screenW * 0.6969, screenH * 0.3477+dodatekY, screenW * 0.0146, screenH * 0.0260) and okno2 == true and lista == true then
                if v.ranga == lider then exports["smta_base_notifications"]:noti("Nie możesz usunąć lidera z frakcji.", "error") return end
                if v.ranga == vlider then
                    if getElementData(localPlayer, "frakcja:ranga") == lider then
                        triggerServerEvent("usunPracownika:"..frakcja.."", localPlayer, v.nick)
                        exports["smta_base_notifications"]:noti("Usunięto "..v.nick.." z frakcji.")
                        table.remove(pracownicy, i)
                    else
                        exports["smta_base_notifications"]:noti("Nie możesz usunąć vlidera z frakcji.", "error")
                        return end
                end
                triggerServerEvent("usunPracownika:"..frakcja.."", localPlayer, v.nick)
                exports["smta_base_notifications"]:noti("Usunięto "..v.nick.." z frakcji.")
                table.remove(pracownicy, i)
            end
        end
    end         
    if mysz(scale_x(1015), scale_y(256), scale_x(16), scale_y(16)) and okno2 == true then
        removeEventHandler("onClientRender", root, glidera)
        showCursor(false)
        setElementData(localPlayer, "hud", false)
        showChat(true)
        executeCommandHandler("radar")
        setElementData(localPlayer, "player:blackwhite", false)
        okno1 = false
        lista = false
        edytowanie = false
        dodawanie = false
        guiSetVisible(edit1, false)
        guiSetVisible(edit2, false)
    elseif mysz(screenW * 0.6545, screenH * 0.6719, screenW * 0.0571, screenH * 0.0391) and okno2 == true and edytowanie ~= false then
        if not tonumber(guiGetText(edit1)) then exports["smta_base_notifications"]:noti("Wypłata nie jest liczbą!", "error") return end
        if tonumber(guiGetText(edit1)) > 500 or tonumber(guiGetText(edit1)) < 300 then 
            --exports["smta_base_notifications"]:noti("Wypłata musi być wieksza niż 300 $ i mniejsza niż 500 $", "error") 
        return end
        triggerServerEvent("edytujPracownika:"..frakcja.."", localPlayer, edytowanie, guiGetText(edit1), guiGetText(edit2))
        --exports["smta_base_notifications"]:noti("Edytowano pracownika: "..edytowanie..".")
    elseif mysz(screenW * 0.6545, screenH * 0.6719, screenW * 0.0571, screenH * 0.0391) and okno2 == true and lista == true then
        lista = false
        dodawanie = true
        guiSetText(edit1, "")
        guiSetVisible(edit1, true)
    elseif mysz(screenW * 0.6545, screenH * 0.6719, screenW * 0.0571, screenH * 0.0391) and okno2 == true and dodawanie == true then
        triggerServerEvent("dodajPracownika:"..frakcja.."", localPlayer, guiGetText(edit1))
    end
  end
end)

bindKey("mouse_wheel_down", "both", function()
	if okno2 ~= true then return end
	if n >= #pracownicy then return end
	k = k+1
	n = n+1
end)

bindKey("mouse_wheel_up", "both", function()
	if okno2 ~= true then return end
	if n == m then return end
	k = k-1
	n = n-1
end)



--opcje

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