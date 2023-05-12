--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local akt = createElement("updates")

function updates()
	local text = {}
	local q = exports.smta_base_db:wykonaj("select * from smtadb_updates")
	for i,v in ipairs(q) do
		table.insert(text, v.text.." - "..v.admin.." ("..v.date..")")
	end
	setElementData(akt, "text", table.concat(text, "\n"))
end

updates()

addCommandHandler("updatef1", function(player, _, ...)
	--if not getElementData(player, "duty") == 4 then return end
	if not ... then
		--triggerClientEvent(player, "createNotif",player,"Użycie: /aktualizuj <text>",6,"info")
		return
	end
	local text = table.concat({...}, " ")
	exports.smta_base_db:wykonaj("insert into smtadb_updates set text=?, admin=?, date=NOW()", text, getPlayerName(player))
	updates()
end)