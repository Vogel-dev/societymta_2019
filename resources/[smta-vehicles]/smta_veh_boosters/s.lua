--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("ms:hand", true)
addEventHandler("ms:hand", root, function(veh, mk, tryb, ntryb)
	if mk == 1 then
		if tryb == 1 and ntryb == 2 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration+0.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity+10)
		end
		if tryb == 1 and ntryb == 3 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration+1.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity+15)
		end
		if tryb == 2 and ntryb == 3 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration+0.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity+10)
		end
		if tryb == 2 and ntryb == 1 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration-0.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity-10)
		end
		if tryb == 3 and ntryb == 1 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration-1.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity-15)
		end
		if tryb == 3 and ntryb == 2 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration-0.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity-10)
		end
	elseif mk == 2 then
		if tryb == 1 and ntryb == 2 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration+1.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity+15)
		end
		if tryb == 1 and ntryb == 3 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration+3)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity+30)
		end
		if tryb == 2 and ntryb == 3 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration+1.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity+15)
		end
		if tryb == 2 and ntryb == 1 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration-1.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity-15)
		end
		if tryb == 3 and ntryb == 1 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration-3)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity-30)
		end
		if tryb == 3 and ntryb == 2 then
			setVehicleHandling(veh, "engineAcceleration", getVehicleHandling(veh).engineAcceleration-1.5)
			setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh).maxVelocity-15)
		end
	elseif mk == 3 then
		if ntryb == 1 then
			setVehicleHandling(veh, "driveType", "fwd")
		end
		if ntryb == 2 then
			setVehicleHandling(veh, "driveType", "awd")
		end
		if ntryb == 3 then
			setVehicleHandling(veh, "driveType", "rwd")
		end
	end
end)