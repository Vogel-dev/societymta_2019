--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local lokalizacje = {
{1967.18, -1692.99, 990.03},
}

for i,v in ipairs(lokalizacje) do
	marker = createMarker(v[1], v[2], v[3]-.95, "cylinder", 1, 150, 113, 23, 100)
	setElementInterior(marker, 1)
	setElementDimension(marker, 0)
	setElementData(marker, "fastfoody", true)
end

addEvent("daj:rest", true)
addEventHandler("daj:rest", root, function(nazwa)
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), nazwa)
end)
