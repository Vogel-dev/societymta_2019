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

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local px, py = screenW/1440, screenH/900
local okno = false
local wyplac = false
local wplac = false
local przelej = false
local niemozesz = false

local czcionka =  dxCreateFont("cz.ttf", 17)
local czcionka2 =  dxCreateFont("cz.ttf", 20)

function bankomat()
	dxDrawImage(360*px, 230*py, 720*px, 440*py, ":smta_base_atms/gfx/tlo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	shadowText(""..getPlayerName(localPlayer)..", konto bankowe wczytane poprawnie!\nDostępne środki na koncie: "..getElementData(localPlayer, "bankomat").." USD", 455*px, 266*py, 983*px, 438*py, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
    if mysz(378*px, 564*py, 84*px, 63*py) then
    	dxDrawImage(378*px, 564*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_on.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
    else
    	dxDrawImage(378*px, 564*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_off.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    dxDrawImage(462*px, 564*py, 167*px, 63*py, ":smta_base_atms/gfx/napis.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Wyloguj", 469*px, 574*py, 619*px, 614*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    if okno == true and wyplac == false and wplac == false and przelej == false then
    	if mysz(978*px, 564*py, 84*px, 63*py) then
        	dxDrawImage(978*px, 564*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(978*px, 564*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(978*px, 501*py, 84*px, 63*py) then
        	dxDrawImage(978*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(978*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(978*px, 438*py, 84*px, 63*py) then
        	dxDrawImage(978*px, 438*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(978*px, 438*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        dxDrawImage(811*px, 564*py, 167*px, 63*py, ":smta_base_atms/gfx/napis.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(811*px, 501*py, 167*px, 63*py, ":smta_base_atms/gfx/napis.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(811*px, 438*py, 167*px, 63*py, ":smta_base_atms/gfx/napis.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Wypłać", 818*px, 574*py, 968*px, 614*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        shadowText("Wpłać", 818*px, 511*py, 968*px, 551*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        shadowText("Przekaż", 818*px, 448*py, 968*px, 488*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    end
    if okno == true and wyplac == false and wplac == true and przelej == false then
	    if mysz(screenW * 0.4051, screenH * 0.4688, screenW * 0.1824, screenH * 0.0469) then
        	dxDrawImage(screenW * 0.4051, screenH * 0.4688, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4051, screenH * 0.4688, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(649*px, 499*py, 146*px, 53*py) then
        	dxDrawImage(649*px, 499*py, 146*px, 53*py, ":smta_veh_paintshop/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(649*px, 499*py, 146*px, 53*py, ":smta_veh_paintshop/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Potwierdź", 648*px, 499*py, 795*px, 552*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if mysz(378*px, 501*py, 84*px, 63*py) then
        	dxDrawImage(378*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_on.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(378*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_off.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        dxDrawImage(462*px, 501*py, 167*px, 63*py, ":smta_base_atms/gfx/napis.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Wycofaj", 469*px, 511*py, 619*px, 551*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    end
   	if okno == true and wyplac == true and wplac == false and przelej == false then
	    if mysz(screenW * 0.4051, screenH * 0.4688, screenW * 0.1824, screenH * 0.0469) then
        	dxDrawImage(screenW * 0.4051, screenH * 0.4688, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4051, screenH * 0.4688, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(649*px, 499*py, 146*px, 53*py) then
        	dxDrawImage(649*px, 499*py, 146*px, 53*py, ":smta_veh_paintshop/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(649*px, 499*py, 146*px, 53*py, ":smta_veh_paintshop/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Potwierdź", 648*px, 499*py, 795*px, 552*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if mysz(378*px, 501*py, 84*px, 63*py) then
        	dxDrawImage(378*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_on.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(378*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_off.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        dxDrawImage(462*px, 501*py, 167*px, 63*py, ":smta_base_atms/gfx/napis.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Wycofaj", 469*px, 511*py, 619*px, 551*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    end
    if okno == true and wyplac == false and wplac == false and przelej == true then
		if mysz(screenW * 0.4088, screenH * 0.4362, screenW * 0.1824, screenH * 0.0469) then
        	dxDrawImage(screenW * 0.4088, screenH * 0.4362, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4088, screenH * 0.4362, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.4088, screenH * 0.4961, screenW * 0.1824, screenH * 0.0469) then
        	dxDrawImage(screenW * 0.4088, screenH * 0.4961, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4088, screenH * 0.4961, screenW * 0.1824, screenH * 0.0469, ":smta_base_atms/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(649*px, 520*py, 146*px, 53*py) then
        	dxDrawImage(649*px, 520*py, 146*px, 53*py, ":smta_veh_paintshop/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(649*px, 520*py, 146*px, 53*py, ":smta_veh_paintshop/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Potwierdź", 648*px, 520*py, 795*px, 572*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
        if mysz(378*px, 501*py, 84*px, 63*py) then
        	dxDrawImage(378*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_on.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(378*px, 501*py, 84*px, 63*py, ":smta_base_atms/gfx/klawisz_off.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        dxDrawImage(462*px, 501*py, 167*px, 63*py, ":smta_base_atms/gfx/napis.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Wycofaj", 469*px, 511*py, 619*px, 551*py, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(378*px, 564*py, 84*px, 63*py) and okno == true then
    	removeEventHandler("onClientRender", root, bankomat)
    	okno = false
    	wplac = false
    	wyplac = false
    	przelej = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    	exports["smta_oth_editbox"]:editbox_destroy("wplata")
    	exports["smta_oth_editbox"]:editbox_destroy("wyplata")
    	exports["smta_oth_editbox"]:editbox_destroy("nick")
    	exports["smta_oth_editbox"]:editbox_destroy("suma")
    elseif mysz(378*px, 501*py, 84*px, 63*py) and okno == true then
    	wplac = false
    	wyplac = false
    	przelej = false
    	exports["smta_oth_editbox"]:editbox_destroy("wplata")
    	exports["smta_oth_editbox"]:editbox_destroy("wyplata")
    	exports["smta_oth_editbox"]:editbox_destroy("nick")
    	exports["smta_oth_editbox"]:editbox_destroy("suma")
    elseif mysz(978*px, 501*py, 84*px, 63*py) and okno == true and wyplac == false and wplac == false and przelej == false then
    	wplac = true
    	exports["smta_oth_editbox"]:editbox_create("", "Suma wpłaty", 595*px, 420*py, 846*px, 462*py, 592*px, 413*py, 254*px, 49*py, "wplata")
    elseif mysz(978*px, 564*py, 84*px, 63*py) and okno == true and wyplac == false and wplac == false and przelej == false then
    	wyplac = true
    	exports["smta_oth_editbox"]:editbox_create("", "Suma wypłaty", 595*px, 420*py, 846*px, 462*py, 592*px, 413*py, 254*px, 49*py, "wyplata")
    elseif mysz(978*px, 438*py, 84*px, 63*py) and okno == true and wyplac == false and wplac == false and przelej == false then
    	przelej = true
    	exports["smta_oth_editbox"]:editbox_create("", "Nick odbiorcy",  594*px, 397*py, 850*px, 433*py, 596*px, 398*py, 254*px, 40*py, "nick")
    	exports["smta_oth_editbox"]:editbox_create("", "Suma przekazu", 596*px, 459*py, 851*px, 478*py, 596*px, 449*py, 254*px, 49*py, "suma")
    elseif mysz(644*px, 502*py, 152*px, 47*py) and okno == true and przelej == true then
        if niemozesz == true then return end
    	local gracz = exports["smta_oth_editbox"]:editbox_text("nick")
    	local suma = exports["smta_oth_editbox"]:editbox_text("suma")
    	if not gracz then return end
    	local bank = getElementData(localPlayer, "bankomat") or 0
    	if tonumber(suma) > tonumber(bank) then
    		exports["smta_base_notifications"]:noti("Nie posiadasz takie sumy w bankomacie!", "error")
    	return end
    	if tonumber(suma) <= 0 then
    		exports["smta_base_notifications"]:noti("Suma wypłaty musi być większa od 0!", "error")
    	return end
        suma = string.format("%1d", suma)
    	triggerServerEvent("przelej:bankomat", localPlayer, localPlayer, gracz, suma)
        niemozesz = true
        setTimer(function()
            niemozesz = false
        end, 500, 1)
    elseif mysz(643*px, 480*py, 148*px, 45*py) and okno == true and wplac == true then
    	local ilosc = exports["smta_oth_editbox"]:editbox_text("wplata")
    	if string.find(ilosc, 'E') then return end
    	if string.find(ilosc, 'e') then return end
  		if string.find(ilosc, 'r') then return end
    	if tonumber(ilosc) > getElementData(localPlayer, "pieniadze") then
    		exports["smta_base_notifications"]:noti("Nie posiadasz takie sumy przy sobie!", "error")
    	return end
    	if tonumber(ilosc) <= 1 then
    		exports["smta_base_notifications"]:noti("Suma wpłaty musi być większa od 0!", "error")
    	return end
        ilosc = string.format("%1d", ilosc)
    	setElementData(localPlayer, "bankomat", getElementData(localPlayer, "bankomat")+tonumber(ilosc))
    	setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-tonumber(ilosc))
        triggerServerEvent("logiWplaty:bankomat", localPlayer, ilosc)
    elseif mysz(643*px, 480*py, 148*px, 45*py) and okno == true and wyplac == true then
    	local ilosc = exports["smta_oth_editbox"]:editbox_text("wyplata")
    	if string.find(ilosc, 'E') then return end
    	if string.find(ilosc, 'e') then return end
  		if string.find(ilosc, 'r') then return end
  		local bank = getElementData(localPlayer, "bankomat") or 0
    	if tonumber(ilosc) > tonumber(bank) then
    		exports["smta_base_notifications"]:noti("Nie posiadasz takie sumy w bankomacie!", "error")
    	return end
    	if tonumber(ilosc) <= 1 then
    		exports["smta_base_notifications"]:noti("Suma wypłaty musi być większa od 0!", "error")
    	return end
        ilosc = string.format("%1d", ilosc)
    	setElementData(localPlayer, "bankomat", getElementData(localPlayer, "bankomat")-tonumber(ilosc))
    	setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+tonumber(ilosc))
        triggerServerEvent("logiWyplaty:bankomat", localPlayer, ilosc)
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

addEvent("bankomat:pokaz", true)
addEventHandler("bankomat:pokaz", root, function(cos)
    if cos == true then
       okno = false
       removeEventHandler("onClientRender", root, bankomat)
       showCursor(false)
	   setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    else
	   okno = true
	   addEventHandler("onClientRender", root, bankomat)
	   showCursor(true)
	   setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
		setElementData(localPlayer, "player:blackwhite", true)
    end
end)