--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local discordczas = getRealTime()

--[[
addEvent("zabierzKoke2", true)
addEventHandler("zabierzKoke2", root, function()
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_items WHERE dbid=? AND nick=? AND nazwa=?", getElementData(source, "dbid"), getPlayerName(source), "100g czystej kokainy")
end)
--]]
addEvent("daj:Koks3", true)
addEventHandler("daj:Koks3", root, function()
	local cena = math.random(300, 400)
	if getElementData(source, "premium") then
		cena = cena + cena*0.50
	end
	local hajs = getElementData(source, "brudne:pieniadze") or 0
    setElementData(source, "brudne:pieniadze", hajs+cena)
	exports["smta_base_notifications"]:noti("Za sprzedaż 1g kokainy otrzymujesz "..cena.." $", source)
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **COCAINE** "..getPlayerName(client).." //COCAINE otrzymał "..cena.." $", "logi-prace")
end)