--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

strefa1 = createColCuboid(-2031.6296386719, 119.7562789917, 28.317405700684, 10.5, 11, 3)
kolor1 = createMarker(-2030.94, 130.76, 28.84-0.95, "cylinder", 1.5, 185, 43, 39, 100)
setElementData(kolor1, "malowanie", true)
setElementData(kolor1, "kolor", 1)
setElementData(kolor1, "cuboid:kolor1", strefa1)

napis = createElement("text")
setElementPosition(napis, -2030.94, 130.76, 28.84)
setElementData(napis, "text", "Zmiana koloru pojazdu")

addEventHandler("onMarkerHit", kolor1, function(hit)
	if getElementType(hit) ~= "player" then return end
	if isPedInVehicle(hit) then return end
	triggerClientEvent(hit, "lakernia:kolor1:gui", hit, source)
end)

addEvent("lakernia:pomaluj1", true)
addEventHandler("lakernia:pomaluj1", root, function(vehicle, r, g, b)
	setVehicleColor(vehicle, r, g, b)
	exports['smta_base_db']:wykonaj("UPDATE smtadb_vehicles SET kolor=? where id=?", ""..r..", "..g..", "..b.."", getElementData(vehicle, "id"))
end)