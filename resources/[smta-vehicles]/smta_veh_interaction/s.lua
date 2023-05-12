--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("odpalSilnik", true)
addEventHandler("odpalSilnik", root, function()
    local veh = getPedOccupiedVehicle(source)
    local spr = getVehicleEngineState(veh)
	if spr == false then
    	setVehicleEngineState(veh,true)
    	exports["smta_base_notifications"]:noti("Odpalasz silnik w pojeździe.", source)
	else
    	setVehicleEngineState(veh,false)
    	exports["smta_base_notifications"]:noti("Gasisz silnik w pojeździe.", source)
	end
end)

addEvent("zaciagnijReczny", true)
addEventHandler("zaciagnijReczny", root, function()
    local veh = getPedOccupiedVehicle(source)
	if isElementFrozen(veh) == false then
    local sx,sy,sz = getElementVelocity(veh)
    local km = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*155)
	if km > 10 then return end
        setElementFrozen(veh, true)
        exports["smta_base_notifications"]:noti("Zaciągasz ręczny w pojeździe.", source)
	else
        setElementFrozen(veh, false)
        exports["smta_base_notifications"]:noti("Spuszczasz ręczny w pojeździe.", source)
	end
end)

addEvent("wlaczSwiatla",true)
addEventHandler("wlaczSwiatla", root, function()
    local veh = getPedOccupiedVehicle(source)
	if getVehicleOverrideLights(veh) ~= 2 then
    	setVehicleOverrideLights(veh,2)
    	exports["smta_base_notifications"]:noti("Zapalasz światła w pojeździe.", source)
	else
    	setVehicleOverrideLights(veh,1)
    	exports["smta_base_notifications"]:noti("Gasisz światła w pojeździe.", source)
	end
end)

addEvent("zamknijDrzwi",true)
addEventHandler("zamknijDrzwi", root,function()
	local veh = getPedOccupiedVehicle(source)
	if isVehicleLocked(veh) then
     	setVehicleLocked(veh,false)
     	exports["smta_base_notifications"]:noti("Otwierasz zamek w pojeździe.", source)
 	else
     	setVehicleLocked(veh,true)
     	exports["smta_base_notifications"]:noti("Zamykasz zamek w pojeździe.", source)
     	for i = 2,5 do
			setVehicleDoorOpenRatio(veh, i, 0, 500)
		end
	end
end)


addEvent("otworzMaske", true)
addEventHandler("otworzMaske", root, function()
	local veh = getPedOccupiedVehicle(source)
	setVehicleDoorOpenRatio(veh, 0, 1 - getVehicleDoorOpenRatio(veh, 0), 1000)
end)

addEvent("otworzBagaznik", true)
addEventHandler("otworzBagaznik", root, function()
	local veh = getPedOccupiedVehicle(source)
	setVehicleDoorOpenRatio(veh, 1, 1 - getVehicleDoorOpenRatio(veh, 1), 1000)
end)

addEventHandler("onVehicleStartExit", root,function(player)
	local veh = getPedOccupiedVehicle(player)
	if isVehicleLocked(veh) then 
		cancelEvent()
		exports["smta_base_notifications"]:noti("Nie możesz wyjść z zamkniętego pojazdu!", player, "error")
    end
end)

addEvent("regulowaneZawieszenie",true)
addEventHandler("regulowaneZawieszenie", root,function(t)
	local v = getPedOccupiedVehicle(source)
    if t == 1 then
        setVehicleHandling(v, "suspensionLowerLimit", -0.3)
        setElementData(v, "zawieszenielvl", 3)
        --outputChatBox("Najwyżej")
    elseif t == 2 then
        setVehicleHandling(v, "suspensionLowerLimit", -0.15)
        setElementData(v, "zawieszenielvl", 2)
        --outputChatBox("Srednio")
    elseif t == 3 then
        setVehicleHandling(v, "suspensionLowerLimit", -0.03)
        setElementData(v, "zawieszenielvl", 1)
        --outputChatBox("Najniżej")
    end
end)