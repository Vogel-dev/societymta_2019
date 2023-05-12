--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local lokalizacje = {
{-1996.23, 172.04, 27.69, 270},
{-1757.54, 940.58, 24.89, 180},
{-2627.96, -36.00, 4.34, 180},
}

for i,v in ipairs(lokalizacje) do
	foodtruck = createVehicle(588, v[1], v[2], v[3], 0, 0, v[4]+90)
	--budka = createObject(1340, v[1], v[2], v[3], 0, 0, v[4]+90)
	marker = createMarker(v[1], v[2], v[3]-.95, "cylinder", 1.7, 93, 137, 186, 50)
	setElementData(marker, "fastfoody", true)
	createBlipAttachedTo(marker, 10)
	ped = createPed(155, v[1], v[2], v[3], v[4])
	setElementData(ped, "name", "Sprzedawca")
	attachElements(marker, foodtruck, 2.5, 0, -.95)
	warpPedIntoVehicle(ped, foodtruck)
	setElementFrozen(foodtruck, true)
	setVehicleLocked(foodtruck, true)
end

addEvent("daj:fastfoody", true)
addEventHandler("daj:fastfoody", root, function(nazwa)
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), nazwa)
end)
