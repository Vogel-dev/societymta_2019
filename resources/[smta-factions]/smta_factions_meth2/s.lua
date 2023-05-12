--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--
--[[
addEvent("zabierzWeed", true)
addEventHandler("zabierzWeed", root, function()
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_items WHERE dbid=? AND nick=? AND nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "Lisc marichuany")
end)

addEvent("daj:Weed2", true)
addEventHandler("daj:Weed2", root, function()
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "40g marichuany")
end)
--]]