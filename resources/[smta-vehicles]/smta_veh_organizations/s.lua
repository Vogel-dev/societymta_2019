--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local marker = createMarker(361.86, 173.69, 1008.38-1, "cylinder", 1.2, 204, 78, 92, 100)
setElementData(marker, "przechowalnia2", true)
setElementInterior(marker, 3)
local text = createElement("text")
setElementData(text, "text", "Przepisywanie pojazdów na grupę przestępczą")
setElementPosition(text, 361.86, 173.69, 1008.38)

addEventHandler("onMarkerHit", marker, function(hit)
	if getElementType(hit) ~= "player" then return end
	local oname = getElementData(hit, "oname")

	local q = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_vehicles WHERE wlasciciel=?", getElementData(hit, "dbid"))
	if #q < 1 then
		exports["smta_base_notifications"]:noti("Nie posiadasz pojazdów.", player)
		return
	end
	triggerClientEvent(hit, "showOrgWindow", hit, q)
end)

addEventHandler("onMarkerLeave", marker, function(hit)
	triggerClientEvent(hit, "destroyOrgWindow", hit)
end)

addEvent("przepisz", true)
addEventHandler("przepisz", getRootElement(), function(player,id)
	local oname = getElementData(player, "oname")
	local query = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_vehicles WHERE id=?", id)
	if query[1].organizacja == "" then
		if not oname then
			exports["smta_base_notifications"]:noti("Nie posiadasz grupy przestępczej.", player)
	    	return
		end
		exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET organizacja=? WHERE id=?", oname, id)
		exports["smta_base_notifications"]:noti("Pomyślnie przepisałeś pojazd o id "..id.." na grupę przestępczą.", player)
	else
		exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET organizacja=? WHERE id=?", "", id)
		exports["smta_base_notifications"]:noti("Pomyślnie wypisałeś pojazd o id "..id.." z grupy przestępczej", player)
	end
end)