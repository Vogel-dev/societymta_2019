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
local font = dxCreateFont("cz.ttf", 13)
local font2 = dxCreateFont("cz.ttf", 18)
--local font = dxCreateFont("cz2.ttf", 25)
local font2 = dxCreateFont("cz2.ttf", 21)

local eq = false
local branie = false
local usuwanie = false

function info(tekst, rodzaj)
	exports["smta_base_notifications"]:noti(tekst, rodzaj)
end

local przedmioty = {}

local width = screenW * 0.1852
local height = screenH * 0.2083
local scrollPos = 0
local scrollOffset = 38*py

local maxRender = dxCreateRenderTarget(width, height, true) -- True daje alphe / false - nie daje

function gui()
	dxDrawImage(screenW * 0.0146, screenH * 0.4518, screenW * 0.1947, screenH * 0.2539, ":smta_base_eq/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxSetRenderTarget(maxRender, true)
    for i, v in ipairs(przedmioty) do
    	local dodatekY = (38*py)*(i-1)
    	local dodatekY2 = (76*py)*(i-1)
    	local scroll = scrollPos * scrollOffset
    	local scroll2 = (scrollPos * scrollOffset) * 2

    	if v.nazwa == "Hamburger" then
    		grafika = ":smta_base_eats/gfx/1.png"
    	else
    		grafika = ":smta_base_eats/gfx/1.png"
    	end
      --dxDrawRectangle(0*px, (0*py+dodatekY)-scroll, 380*px, 57*py, tocolor(0, 0, 0, 180), false)
	    --dxDrawImage(10*px, (0*py+dodatekY)-scroll, 372*px, 63*py, ":smta_base_eq/gfx/bgitem.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
      --dxDrawImage(15*px, (7*py+dodatekY)-scroll, 50*px, 50*py, grafika, 0, 0, 0, tocolor(255, 255, 255, 255), false)
      dxDrawImage(240*px, (7*py+dodatekY)-scroll, 20*px, 20*py, ":smta_base_admin/kosz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
      shadowText(v.nazwa, 0*px, (0*py+dodatekY2)-scroll2, 286*px, 30*py, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
    end
    dxSetRenderTarget(false)
	dxDrawImage(screenW * 0.0242, screenH * 0.4974, width, height, maxRender)
end

function branieitka()
	dxDrawImage(screenW * 0.0146, screenH * 0.3307, screenW * 0.1947, screenH * 0.1081, ":smta_base_eq/gfx/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText(przedmiot_nazwa, screenW * 0.0190, screenH * 0.3542, screenW * 0.2094, screenH * 0.3919, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    shadowText(przedmiot_corobic, screenW * 0.0447, screenH * 0.3919, screenW * 0.1018, screenH * 0.4310, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
    shadowText("ANULUJ", screenW * 0.1201, screenH * 0.3919, screenW * 0.1772, screenH * 0.4310, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
end

function usuwanieitka()
  dxDrawImage(screenW * 0.0146, screenH * 0.3307, screenW * 0.1947, screenH * 0.1081, ":smta_base_eq/gfx/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  shadowText("Potwierdź wyrzucenie: "..przedmiot_nazwa, screenW * 0.0190, screenH * 0.3542, screenW * 0.2094, screenH * 0.3919, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
  	if mysz(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) then
        	dxDrawImage(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391, ":smta_base_eq/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
  shadowText("WYRZUĆ", screenW * 0.0447, screenH * 0.3919, screenW * 0.1018, screenH * 0.4310, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
  shadowText("ANULUJ", screenW * 0.1201, screenH * 0.3919, screenW * 0.1772, screenH * 0.4310, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
  	for i,v in ipairs(przedmioty) do
  		local dodatekY = (38*py)*(i-1)
  		local scroll = scrollPos * scrollOffset
  		if mysz(screenW * 0.0176, (screenH * 0.4948+dodatekY)-scroll, screenW * 0.1728, screenH * 0.0443) and mysz(screenW * 0.0146, screenH * 0.4518, screenW * 0.1947, screenH * 0.2539) and eq == true and branie == false and usuwanie == false then
  			setTimer(function()
  			przedmiot_nazwa = v.nazwa
  			przedmiot_id = v.id
  			branie = true
  			eq = false
  			addEventHandler("onClientRender", root, branieitka)
  			removeEventHandler("onClientRender", root, gui)
  			if przedmiot_nazwa == "Hamburger" or przedmiot_nazwa == "Hotdog" or przedmiot_nazwa == "Kebab" or przedmiot_nazwa == "Kotlet Schabowy" or przedmiot_nazwa == "Pasta Gringciosso" or przedmiot_nazwa == "Pizza Gringolonni" or przedmiot_nazwa == "Gringamisu" then
  				przedmiot_corobic = "ZJEDŹ"
  			elseif przedmiot_nazwa == "Papieros 'Marlboro Red'" then
  				przedmiot_corobic = "ZAPAL"
        elseif przedmiot_nazwa == "Woda" or przedmiot_nazwa == "Cola" or przedmiot_nazwa == "Gringola" then
          przedmiot_corobic = "WYPIJ"
        elseif przedmiot_nazwa == "Wędka drewniana" or przedmiot_nazwa == "Wędka plastikowa" or przedmiot_nazwa == "Wędka aluminiowa" or przedmiot_nazwa == "Wędka metalowa" then
          if getElementData(localPlayer, "wedka") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Kij baseballowy" then
          if getElementData(localPlayer, "kij") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Noz wojskowy" then
          if getElementData(localPlayer, "noz") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Deagle" then
          if getElementData(localPlayer, "deagle") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Uzi" then
          if getElementData(localPlayer, "uzi") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "AK-47" then
          if getElementData(localPlayer, "ak47") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Kastet" then
          if getElementData(localPlayer, "kastet") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Obrzyn" then
          if getElementData(localPlayer, "obrzyn") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Karabin snajperski" then
          if getElementData(localPlayer, "sniper") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Wyrzutnia rakiet" then
          if getElementData(localPlayer, "rakieta") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Molotov" then
          if getElementData(localPlayer, "molotov") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
        elseif przedmiot_nazwa == "Bomba" then
          if getElementData(localPlayer, "bomba") then
            przedmiot_corobic = "SCHOWAJ"
          else
            przedmiot_corobic = "WYCIĄGNIJ"
          end
  			else
  				przedmiot_corobic = "UŻYJ"
  			end
  			end, 50, 1)
      elseif mysz(screenW * 0.1925, (screenH * 0.5065+dodatekY)-scroll, screenW * 0.0124, screenH * 0.0260) and mysz(screenW * 0.0146, screenH * 0.4518, screenW * 0.1947, screenH * 0.2539) and eq == true and branie == false and usuwanie == false then
        setTimer(function()
          usuwanie = true
          eq = false
          przedmiot_nazwa = v.nazwa
          przedmiot_id = v.id
          addEventHandler("onClientRender", root, usuwanieitka)
          removeEventHandler("onClientRender", root, gui)
        end, 50, 1)
  		end
  	end
    if mysz(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) and branie == true and eq == false and usuwanie == false then
    	removeEventHandler("onClientRender", root, branieitka)
    	branie = false
    	addEventHandler("onClientRender", root, gui)
    	eq = true
    elseif mysz(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) and branie == true and eq == false and usuwanie == false then
    	uzyjPrzedmiot(przedmiot_nazwa, przedmiot_id)
    	removeEventHandler("onClientRender", root, branieitka)
    	branie = false
    	addEventHandler("onClientRender", root, gui)
    	eq = true
    	triggerServerEvent("pokazPrzedmioty:eq", localPlayer)
    elseif mysz(screenW * 0.1201, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) and usuwanie == true and eq == false and branie == false then
      removeEventHandler("onClientRender", root, usuwanieitka)
      usuwanie = false
      addEventHandler("onClientRender", root, gui)
      eq = true
    elseif mysz(screenW * 0.0447, screenH * 0.3919, screenW * 0.0571, screenH * 0.0391) and usuwanie == true and eq == false and branie == false then
      triggerServerEvent("usunPrzedmiot:eq", localPlayer, przedmiot_id)
      removeEventHandler("onClientRender", root, usuwanieitka)
      usuwanie = false
      addEventHandler("onClientRender", root, gui)
      eq = true
      triggerServerEvent("pokazPrzedmioty:eq", localPlayer)
    end
  end
end)

function uzyjPrzedmiot(nazwa, id)
  if nazwa == "Hamburger" then
    jeszCos(22)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je hamburgera.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Kebab" then
    jeszCos(25)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je kebaba.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Hotdog" then
    jeszCos(15)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je hotdoga.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Kotlet Schabowy" then
    jeszCos(51)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je kotleta schabowego.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Pasta Gringciosso" then
    jeszCos(39)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je paste gringciosso.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Pizza Gringolonni" then
    jeszCos(65)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je pizze gringolonni.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Gringamisu" then
    jeszCos(18)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je gringamisu.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "'Srickers'" then
    jeszCos(18)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je srickersa.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Chipsy 'Stolarvalue'" then
    jeszCos(18)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." je chipsy 'Stolarvalue'.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("wpierdalaj:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Woda" then
    jeszCos(10)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." pije wode.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijPuszka:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Cola" then
    jeszCos(13)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera puszkę coli.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijPuszka:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Piwo 'Kuflowe'" then
    jeszCos(13)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera Kuflowe.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijButla:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Piwo 'Zubr'" then
    jeszCos(13)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera Żubra.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijButla:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Piwo 'Desperados'" then
    jeszCos(13)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera Desperadosa.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijButla:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "'Moet&Chandon'" then
    jeszCos(13)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera 'Moet&Chandon'.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijButla:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "'Jack Daniels'" then
    jeszCos(13)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera Jack Daniels'a")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijButla:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "'Finlandia'" then
    jeszCos(13)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera Finlandie.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijPuszka:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
  elseif nazwa == "Gringola" then
    jeszCos(15)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." otwiera puszkę gringoli.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("pijPuszka:eq", localPlayer, localPlayer)
    end
    triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
	elseif nazwa == "Papieros 'Marlboro Red'" then
		info("Aby strzepnąć papierosa kliknij 'prawy przycisk myszy'")
    --triggerServerEvent("zapalPapierosa:eq", localPlayer, localPlayer)
    setPedAnimation ( localPlayer, "SMOKING", "M_smk_in", 5400, false, false )
	  setTimer(function () setPedAnimation(localPlayer,false) end,5400,1)
    triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." odpala papierosa Marlboro Red.")
    if not isPedInVehicle(localPlayer) then
      triggerServerEvent("palPeta:eq", localPlayer, localPlayer)
    end
		triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)

  elseif nazwa == "Wędka drewniana" then
    if getElementData(localPlayer, "wedka") then
      setElementData(localPlayer, "wedka", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer, true)
    else
      setElementData(localPlayer, "wedka", "drewniana")
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga i rozkłada wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer)
    end
  elseif nazwa == "Wędka plastikowa" then
    if getElementData(localPlayer, "wedka") then
      setElementData(localPlayer, "wedka", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer, true)
    else
      setElementData(localPlayer, "wedka", "plastikowa")
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga i rozkłada wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer)
    end
  elseif nazwa == "Wędka aluminiowa" then
    if getElementData(localPlayer, "wedka") then
      setElementData(localPlayer, "wedka", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer, true)
    else
      setElementData(localPlayer, "wedka", "aluminiowa")
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga i rozkłada wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer)
    end
  elseif nazwa == "Wędka metalowa" then
    if getElementData(localPlayer, "wedka") then
      setElementData(localPlayer, "wedka", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer, true)
    else
      setElementData(localPlayer, "wedka", "metalowa")
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga i rozkłada wędkę.")
      triggerServerEvent("dajWedke:eq", localPlayer)
    end
  elseif nazwa == "Kij baseballowy" then
    if getElementData(localPlayer, "kij") then
      setElementData(localPlayer, "kij", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa kij baseballowy.")
      triggerServerEvent("dajKij:eq", localPlayer, true)
    else
      setElementData(localPlayer, "kij", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga kij baseballowy.")
      triggerServerEvent("dajKij:eq", localPlayer)
    end
  elseif nazwa == "Noz wojskowy" then
    if getElementData(localPlayer, "noz") then
      setElementData(localPlayer, "noz", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa Noz wojskowy.")
      triggerServerEvent("dajNoz:eq", localPlayer, true)
    else
      setElementData(localPlayer, "noz", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga Noz wojskowy.")
      triggerServerEvent("dajNoz:eq", localPlayer)
    end
  elseif nazwa == "Deagle" then
    if getElementData(localPlayer, "deagle") then
      setElementData(localPlayer, "deagle", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa Deagle'a.")
      triggerServerEvent("dajDeagle:eq", localPlayer, true)
    else
      setElementData(localPlayer, "deagle", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga Deagle'a.")
      triggerServerEvent("dajDeagle:eq", localPlayer)
    end
  elseif nazwa == "Uzi" then
    if getElementData(localPlayer, "uzi") then
      setElementData(localPlayer, "uzi", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa Uzi.")
      triggerServerEvent("dajUzi:eq", localPlayer, true)
    else
      setElementData(localPlayer, "uzi", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga Uzi.")
      triggerServerEvent("dajUzi:eq", localPlayer)
    end
  elseif nazwa == "AK-47" then
    if getElementData(localPlayer, "ak47") then
      setElementData(localPlayer, "ak47", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa AK-47.")
      triggerServerEvent("dajAK47:eq", localPlayer, true)
    else
      setElementData(localPlayer, "ak47", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga AK-47.")
      triggerServerEvent("dajAK47:eq", localPlayer)
    end
  elseif nazwa == "Kastet" then
    if getElementData(localPlayer, "kastet") then
      setElementData(localPlayer, "kastet", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa kastet.")
      triggerServerEvent("dajKastet:eq", localPlayer, true)
    else
      setElementData(localPlayer, "kastet", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga kastet.")
      triggerServerEvent("dajKastet:eq", localPlayer)
    end
  elseif nazwa == "Obrzyn" then
    if getElementData(localPlayer, "obrzyn") then
      setElementData(localPlayer, "obrzyn", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa obrzyna.")
      triggerServerEvent("dajObrzyn:eq", localPlayer, true)
    else
      setElementData(localPlayer, "obrzyn", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga obrzyna.")
      triggerServerEvent("dajObrzyn:eq", localPlayer)
    end
  elseif nazwa == "Karabin snajperski" then
    if getElementData(localPlayer, "sniper") then
      setElementData(localPlayer, "sniper", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa karabin snajperski.")
      triggerServerEvent("dajSniper:eq", localPlayer, true)
    else
      setElementData(localPlayer, "sniper", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga karabin snajperski.")
      triggerServerEvent("dajSniper:eq", localPlayer)
    end
  elseif nazwa == "Wyrzutnia rakiet" then
    if getElementData(localPlayer, "rakieta") then
      setElementData(localPlayer, "rakieta", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa wyrzutnie rakiet.")
      triggerServerEvent("dajWyrzutnia:eq", localPlayer, true)
    else
      setElementData(localPlayer, "rakieta", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga wyrzutnie rakiet.")
      triggerServerEvent("dajWyrzutnia:eq", localPlayer)
    end
  elseif nazwa == "Molotov" then
    if getElementData(localPlayer, "molotov") then
      setElementData(localPlayer, "molotov", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa koktajl molotov'a.")
      triggerServerEvent("dajMolotov:eq", localPlayer, true)
    else
      setElementData(localPlayer, "molotov", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga koktajl molotov'a.")
      triggerServerEvent("dajMolotov:eq", localPlayer)
    end
  elseif nazwa == "Bomba" then
    if getElementData(localPlayer, "bomba") then
      setElementData(localPlayer, "bomba", false)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." chowa bombe przylepną.")
      triggerServerEvent("dajBomba:eq", localPlayer, true)
    else
      setElementData(localPlayer, "bomba", true)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." wyciąga bombe przylepną.")
      triggerServerEvent("dajBomba:eq", localPlayer)
    end
  elseif nazwa == "Zestaw naprawczy" then
    if isPedInVehicle(localPlayer) then
      local auto = getPedOccupiedVehicle(localPlayer)
      triggerServerEvent("odegrajRp:eq", localPlayer, localPlayer, "#4343ff*"..getPlayerName(localPlayer).." używa podręczny zestaw naprawczy.")
      setElementRotation(auto, 0, 0, 0)
      fixVehicle(auto)
      end
      triggerServerEvent("usunPrzedmiot:eq", localPlayer, id)
	end
	triggerServerEvent("pokazPrzedmioty:eq", localPlayer)
end


addEvent("pokazPrzedmioty:eq:client", true)
addEventHandler("pokazPrzedmioty:eq:client", root, function(tabelka)
  przedmioty = tabelka
end)

function jeszCos(ile)
  local najedzenie = getElementData(localPlayer, "najedzenie") or 0
  setElementData(localPlayer, "najedzenie", tonumber(najedzenie)+tonumber(ile))
  if tonumber(najedzenie) >= 99 then
    setElementData(localPlayer, "najedzenie", 99)
  end
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

bindKey("i","down", function()
  if not getElementData(localPlayer, "dbid") then return end
  if getElementData(localPlayer, "pracuje") == "smieciarki" then return end
  if getElementData(localPlayer, "bw") then return end
	if eq == true then
		eq = false
		removeEventHandler("onClientRender", root, gui)
		branie = false
		removeEventHandler("onClientRender", root, branieitka)
		showCursor(false)
	else
		eq = true
		addEventHandler("onClientRender", root, gui)
		showCursor(true)
		triggerServerEvent("pokazPrzedmioty:eq", localPlayer)
	end
end)

bindKey("mouse_wheel_up", "down", function()
	if eq == true then
    	if scrollPos > 0 then
           	scrollPos = scrollPos-1
   		end
   	end
end)

bindKey("mouse_wheel_down", "down", function()
	if eq == true then
	   --if scrollPos >= #przedmioty-7 then return end
       scrollPos = scrollPos+1
    end
end)

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end