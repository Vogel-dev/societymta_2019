--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("napraw:czesc", true)
addEventHandler("napraw:czesc", root, function(veh, czesc)
	if czesc == 1 then 
		setElementHealth(veh, 10000) 
	end
	if czesc == 2 then 
		setVehicleDoorState(veh, 0, 0) 
	end
	if czesc == 3 then 
		setVehicleDoorState(veh, 1, 0) 
	end
	if czesc == 4 then 
		setVehicleDoorState(veh, 2, 0) 
	end
	if czesc == 5 then 
		setVehicleDoorState(veh, 3, 0)
	end
	if czesc == 6 then 
		setVehicleDoorState(veh, 4, 0) 
	end
	if czesc == 7 then 
		setVehicleDoorState(veh, 5, 0) 
	end
	if czesc == 8 then 
		setVehiclePanelState(veh, 4, 0) 
	end
	if czesc == 9 then 
		setVehiclePanelState(veh, 5, 0) 
	end
	if czesc == 10 then 
		setVehiclePanelState(veh, 6, 0) 
	end
	if czesc == 11 then 
		setVehicleLightState(veh, 0, 0) 
	end
	if czesc == 12 then 
		setVehicleLightState(veh, 1, 0) 
	end
	if czesc == 13 then 
		setVehicleLightState(veh, 2, 0) 
	end
	if czesc == 14 then 
		setVehicleLightState(veh, 3, 0) 
	end
end)