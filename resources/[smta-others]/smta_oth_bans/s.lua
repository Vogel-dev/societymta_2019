--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addCommandHandler("bany", function(g)
	if getElementData(g, "duty") > 3 then
		local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_bans")
		triggerClientEvent(g, "lBanow", g, spr)
	end
end)

addEvent("zdejmijBana", true)
addEventHandler("zdejmijBana", root, function(id)
	if not id then return end
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_bans WHERE id=?", id)
	if #spr < 1 then
		triggerClientEvent(source, "createNotif",source,"Podany ban został już zdjęty.",6,"error")
		return
	end
	triggerClientEvent(source, "createNotif",source,"Zdjąłeś bana o id: "..id.." na serial "..spr[1].serial.."",6,"success")
	exports["smta_base_notifications"]:noti("Zdjąłeś bana o id: "..id.." na serial "..spr[1].serial.."", source)
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_bans WHERE id=?", id)
	local spr2 = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_bans")
	triggerClientEvent(source, "lBanow", source, spr2)
end)