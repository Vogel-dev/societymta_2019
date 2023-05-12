--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local lokalizacje = {
{2.15, -29.01, 1003.55},
}

for i,v in ipairs(lokalizacje) do
	ped = createPed(20, 2.09, -30.70, 1003.55, 0)
	marker = createMarker(v[1], v[2], v[3]-.95, "cylinder", 1,127, 0, 255, 50)
	setElementData(ped, "name", "Sprzedawca\nGrzechu Kapusta")
	setElementInterior(marker, 10)
	setElementInterior(ped, 10)
	setElementDimension(marker, 0)
	setElementData(marker, "fastfoody", true)
end

addEvent("daj:shop1", true)
addEventHandler("daj:shop1", root, function(nazwa)
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), nazwa)
end)
