--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local markers = {
{-2280.15, -169.30, 35.32},
}

local timer = {}

addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in ipairs(markers) do
		if i and i > 0 then
			local marker = createMarker(v[1],v[2],v[3]-1.95,"cylinder",2.3,50,100,200,50,root)
			setElementData(marker,"tuning",true)
			setElementData(marker,"tuning:i",i)
			napis = createElement("text")
    		setElementPosition(napis, v[1], v[2], v[3])
    		setElementData(napis, "text", "Tuning wizualny")
		end
	end
end)

addEventHandler("onMarkerHit",resourceRoot,function(plr)
	if plr and isElement(plr) and getElementType(plr) == "player" then
		if isPedInVehicle(plr) then
			if getPedOccupiedVehicle(plr) then
				if getVehicleController(getPedOccupiedVehicle(plr)) and getVehicleController(getPedOccupiedVehicle(plr)) == plr then
					if getElementData(getPedOccupiedVehicle(plr),"id") then
						if getElementData(getPedOccupiedVehicle(plr),"wlasciciel") == getElementData(plr,"dbid") then
							local markertysieczny = createColCuboid(-2283.4506835938, -178.75564575195, 34.3203125, 7.25, 12.5, 3)
							local pojazdy = getElementsWithinColShape(markertysieczny,"vehicle")
							if #pojazdy > 1 then
								exports["smta_base_notifications"]:noti("Na stanowisku do tuningu pojazdu znajduje się więcej niż jeden pojazd!", plr, "error")
								if markertysieczny and isElement(markertysieczny) then
									destroyElement(markertysieczny)
								end
								return
							end
							if markertysieczny and isElement(markertysieczny) then
								destroyElement(markertysieczny)
							end
							setElementFrozen(plr,false)
							setElementFrozen(getPedOccupiedVehicle(plr),true)
							setElementData(getPedOccupiedVehicle(plr),"tuning:veh",true)
							timer[plr] = setTimer(function(plr)
								if plr and isElement(plr) then
									triggerClientEvent(plr,"tuning:otworzGUI",plr,plr)
								end
							end,100,1,plr)
							else
								exports["smta_base_notifications"]:noti("Ten pojazd nie należy do Ciebie!", plr, "error")
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onVehicleStartEnter",resourceRoot,function(plr,seat)
	if seat == 0 then
		cancelEvent()
	end
end)

addEventHandler("onMarkerLeave",resourceRoot,function(veh)
	if veh and isElement(veh) and getElementType(veh) == "vehicle" then
		if getElementData(veh,"tuning:veh") == true then
			if getElementData(veh,"id") then
				setElementData(veh,"tuning:veh",false)
				--setVehicleHeadLightColor(veh,getElementData(veh,"veh:r") or 255,getElementData(veh,"veh:g") or 255,getElementData(veh,"veh:b") or 255)
			end
		end
	end
end)

addEvent("tuning:tuningujPojazd",true)
addEventHandler("tuning:tuningujPojazd",root,function(plr,kategoria_id,id,cena)
	if plr and isElement(plr) and getPedOccupiedVehicle(plr) then
		if kategoria_id then
			if id and tonumber(id) and tonumber(id) > 1000 and tonumber(id) < 2000 then
				if cena then
					local veh = getPedOccupiedVehicle(plr)
					if veh and isElement(veh) then
						if getVehicleUpgradeOnSlot(veh, tonumber(kategoria_id)) ~= 0 then
							local upgrades = getVehicleUpgrades(getPedOccupiedVehicle(plr))
							for _,v in ipairs(upgrades) do
								if v == tonumber(id) then
									removeVehicleUpgrade(veh,id)
									setElementData(plr, "pieniadze", getElementData(plr, "pieniadze")+cena)
									local id_pojazdu = getElementData(veh, "id") or 0
									exports["smta_base_notifications"]:noti("Zdemontowałeś część o id "..id..". Otrzymujesz "..cena.." $", plr)
									--triggerClientEvent(plr,"tuning:zamknijGUI",plr,plr)
								end
							end
						else
							if getElementData(plr, "pieniadze") >= tonumber(cena) then
								addVehicleUpgrade(veh,id)
								setElementData(plr, "pieniadze", getElementData(plr, "pieniadze")-cena)
								local id_pojazdu = getElementData(veh, "id") or 0
								exports["smta_base_notifications"]:noti("Zamontowałeś część o id "..id.." za "..cena.." $", plr)
							else
								exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej ilości pieniędzy na swoim koncie, by móc zamontować tą część!", plr, "error")
							end
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onVehicleStartExit", root, function(kierowca)
	if getElementData(getPedOccupiedVehicle(kierowca), "tuning:veh") then cancelEvent() end
end)