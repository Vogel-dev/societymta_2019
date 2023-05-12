--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local mysql = false

function polacz()
	mysql = dbConnect("mysql", "dbname=db_38419;host=137.74.0.12", "db_38419", "JgtS40tKGEME", "share=1")
	if not mysql then
		outputDebugString("SMTA_DB - Łączenie z bazą - niepoprawne.")
	else
		outputDebugString("SMTA_DB - Łączenie z bazą - poprawne.")
	end
end
addEventHandler("onResourceStart", resourceRoot, polacz)

function wykonaj(...)
	local qh = dbQuery(mysql, ...)
	if not qh then return false end
	local result, num_affected_rows, last_insert_id = dbPoll(qh, -1)
	return result, num_affected_rows, last_insert_id
end
