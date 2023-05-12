--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

setWeaponProperty(22, "pro", "weapon_range", 300)
setWeaponProperty(22, "pro", "accuracy", 300)
setWeaponProperty(28, "pro", "weapon_range", 300)

addEvent("suszarka", true)
addEventHandler("suszarka", root, function(wybrane,el)
	wybrane = wybrane-1
	if getElementData(source, "duty") then
  		if wybrane == 1 and getElementData(source, "duty") then
  			local id = getElementData(el, "id")
        	fixVehicle(el)
			exports["smta_base_notifications"]:noti("Pojazd został naprawiony.", source)
			exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: napraw pojazd id: "..id.."", "logi-suszarka")
		elseif wybrane == 2 then
			local id = getElementData(el, "id")
			local _, _, rz = getElementRotation(el)
			setElementRotation(el, 0, 0, rz)
			exports["smta_base_notifications"]:noti("Pojazd został postawiony na koła.", source)
			exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: postaw pojazd id: "..id.."", "logi-suszarka")
		elseif wybrane == 3 then			
			if getElementData(el, "id") then
				local id = getElementData(el, "id")
		local spr = exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET przechowalnia=1 WHERE id=?", getElementData(el, "id"))
        if spr then
            exports["smta_veh_base"]:zapiszPojazdy(el)
            destroyElement(el)
            exports["smta_base_notifications"]:noti("Pojazd został przeniesiony do przechowalni.", source)
				exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: oddaj pojazd id: "..id.."", "logi-suszarka")
        	elseif getElementData(el, "veh:job") or getElementData(el, "veh:prawko") then
        		destroyElement(el)
        	else
        		destroyElement(el)
				exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: usuń pojazd", "logi-suszarka")
				exports["smta_base_notifications"]:noti("Pojazd został usunięty.", source)
        	end
    	elseif wybrane == 4 and getElementData(source, "duty") > 1 then
				local id = getElementData(el, "id")
				setElementData(el, "paliwo", 50)
				exports["smta_base_notifications"]:noti("Pojazd został zatankowany.", source)
				exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: tankuj pojazd id: "..id.."", "logi-suszarka")
			end
		elseif wybrane == 5 then
			local id = getElementData(el, "id")
			if isElementFrozen(el) then
				setElementFrozen(el, false)
				exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: spuść reczny id: "..id.."", "logi-suszarka")
				exports["smta_base_notifications"]:noti("Spuszczono ręczny w pojeździe.", source)
			else
				local id = getElementData(el, "id")
				setElementFrozen(el, true)
				exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: zaciągnij reczny id: "..id.."", "logi-suszarka")
				exports["smta_base_notifications"]:noti("Zaciągnięto ręczny w pojeździe.", source)
			end
		elseif wybrane == 6 then
			local id = getElementData(el, "id")
			local x,y,z = getElementPosition(source)
			setElementPosition(source, x,y,z+1)
			setElementPosition(el, x,y,z+0.3)
			exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: thv id: "..id.."", "logi-suszarka")
			exports["smta_base_notifications"]:noti("Przeniesiono pojazd do siebie.", source)
		elseif wybrane == 7 and getElementData(source, "duty") > 2 then
			local id = getElementData(el, "id")
			local x,y,z = getElementPosition(el)
			warpPedIntoVehicle(source, el)
			setElementPosition(source, x,y,z)
			exports["smta_base_discord"]:connectWeb("**DRYER** "..getPlayerName(source).." Akcja: ttv id: "..id.."", "logi-suszarka")
			exports["smta_base_notifications"]:noti("Przeniesiono do pojazdu.", source)
		end
	else
		if wybrane == 1 then
			local id = getElementData(el,"id")
			graczwpojezdzie=getVehicleOccupant(el)
	  		local h = getVehicleHandling(el)
			local sx,sy,sz = getElementVelocity(el)
			local speed = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*165)
			if speed<50 then
			return outputChatBox("Pojazd porusza się mniej niż 30km/h!",client,255,0,0)
			end	
			local cena = (speed/2)
			local cena2 = (speed/8)
			local money = getPlayerMoney(graczwpojezdzie)
			if money >= cena then
			takePlayerMoney(graczwpojezdzie, cena)
			givePlayerMoney(client, cena/4)
			outputChatBox("Chyba trochę za szybko się zapierdala "..speed.." Cena "..cena.." ",graczwpojezdzie,255,0,0)
			triggerClientEvent(source, "createNotif",source,"Zmierzono prędkość pojazdu: "..speed.."km/h" ..cena.. "USD" ..cena2.."",6,"info")
		else
			outputChatBox("Gracz nie ma hajsu", client,255,0,0)
			outputChatBox("nie masz hajsu", graczwpojezdzie,255,0,0)
		end
		elseif wybrane == 2 then
			if isElementFrozen(el) then
				setElementFrozen(el, false)
				triggerClientEvent(source, "createNotif",source,"Spuszczono ręczny w pojeździe.",6,"info")
			else
				setElementFrozen(el, true)
				triggerClientEvent(source, "createNotif",source,"Zaciągnięto ręczny w pojeździe.",6,"info")
			end
		end
	end    
end)

