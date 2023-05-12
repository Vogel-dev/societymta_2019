--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--
--[[
addEvent("zabierzKoke", true)
addEventHandler("zabierzKoke", root, function()
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_items WHERE dbid=? AND nick=? AND nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "Lisc kokainy")
end)

addEvent("daj:Koks2", true)
addEventHandler("daj:Koks2", root, function()
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "100g czystej kokainy")
end)
--]]