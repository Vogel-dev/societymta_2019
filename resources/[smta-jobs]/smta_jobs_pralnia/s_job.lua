--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local m=createMarker(-2767.20, 788.91, 52.78-1, "cylinder", 1.8, 0, 71, 255, 50)
--createBlipAttachedTo(m, 46, 2, 255,0,0,255,0,400)

addEvent("pralnia:stopJOB", true)
addEventHandler("pralnia:stopJOB", root, function(veh)
	if not veh then return end
	destroyElement(veh)
end)

addEventHandler("onMarkerHit", m, function(el,md)
	if getElementType(el) == "player" and md then
		if getElementData(el,"pracuje") then
			exports["smta_base_notifications"]:noti("* Posiadasz aktywną pracę: "..getElementData(el,"pracuje").."", el, "error")
			return
		end
		local veh=createVehicle(609, -2792.45, 790.06, 49.54, 355.4, 354.6, 359.0)
  		setElementData(veh,"temporary", true)
  		setElementData(veh,"ostatnikierowca", el)
		setElementData(veh,"przebieg",0)
		setElementData(veh,"paliwo",100)
		warpPedIntoVehicle(el,veh)
		setElementData(el,"pracuje","Pralnia")
		triggerClientEvent(el, "pralnia:startJOB", resourceRoot, veh)
	end
end)

local function respawn()
  for i,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
    if not getVehicleController(v) then
    	destroyElement(v)
    end
  end
end
setTimer(respawn, 3000, 0)