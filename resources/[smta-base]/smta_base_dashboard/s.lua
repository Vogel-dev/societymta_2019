--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function pokazpojazdy(plr)
	local q = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_vehicles WHERE wlasciciel=?", getElementData(plr, "dbid"))
	local pojazdy = {}

	for i = 1, #q do
		table.insert(pojazdy, {model = q[i]["model"], id = q[i]["id"], przecho = q[i]["przechowalnia"], poli = q[i]["policyjny"], parking = q[i]["parking"]})
	end

	return pojazdy
end

addEvent("pokazPojazdySource", true)
addEventHandler("pokazPojazdySource", root, function()
	local q = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_vehicles WHERE wlasciciel=?", getElementData(source, "dbid"))
	triggerClientEvent(source, "pokazPojazdyClient", source, pokazpojazdy(source));
end)