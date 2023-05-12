--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--
--[[
addEvent("daj:Weed", true)
addEventHandler("daj:Weed", root, function()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_items WHERE dbid=? AND nick=? AND nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "Lisc marichuany")
	if #spr == 15 then
		exports["smta_base_notifications"]:noti("Posiadasz maksymalną ilosć marichuany przy sobie.", source)
		return end
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "Lisc marichuany")
end)
--]]