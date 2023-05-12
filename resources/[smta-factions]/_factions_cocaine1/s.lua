--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--
--[[
addEvent("daj:Koks", true)
addEventHandler("daj:Koks", root, function()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_items WHERE dbid=? AND nick=? AND nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "Lisc kokainy")
	if #spr == 25 then
		exports["smta_base_notifications"]:noti("Posiadasz maksymalną ilosć kokainy przy sobie.", source)
		return end
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "Lisc kokainy")
end)
--]]