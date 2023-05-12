--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--
--[[
addCommandHandler("ogloszenie", function(player, _, ...)
	if not getElementData(player, "premium") then return end
	if ... then
		local text = table.concat({...}, " ")
		triggerClientEvent(root, "addOgloszenie", root, player, text)
	else
		exports["smta_base_notifications"]:noti("Poprawne użycie: /ogloszenie [treść]", player)
	end
end)
--]]