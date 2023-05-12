--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local lokalizacje = {
{-787.49, 2415.26, 157.53},
}

for i,v in ipairs(lokalizacje) do
	ped = createPed(304, -789.07, 2414.53, 157.53, 290)
	marker = createMarker(v[1], v[2], v[3]-.95, "cylinder", 1, 174, 12, 0, 50)
	setElementData(ped, "name", "Sprzedawca\nDaniel Łagocki")
	setElementInterior(marker, 0)
	setElementInterior(ped, 0)
	setElementDimension(marker, 0)
	setElementData(marker, "guns", true)
end

addEvent("daj:bron1", true)
addEventHandler("daj:bron1", root, function(nazwa)
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), nazwa)
end)
