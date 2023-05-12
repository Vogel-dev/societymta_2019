--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local discordczas = getRealTime()

addEvent("zamontuj:lampki", true)
addEventHandler("zamontuj:lampki", root, function(r, g, b)
	local veh = getPedOccupiedVehicle(client)
	setVehicleHeadLightColor(veh, r, g, b)
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **COMPONENTS** - **"..getPlayerName(client).."** zmienił światła w pojeździe: **"..getElementData(veh, "id").."** / **"..r.." "..g.." "..b.."**", "logi-pojazdy")
end)

addEvent("zamontuj:neony", true)
addEventHandler("zamontuj:neony", root, function(r, g, b)
	local veh = getPedOccupiedVehicle(client)
	setElementData(veh, "neon", r..","..g..","..b)
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **COMPONENTS** - **"..getPlayerName(client).."** zamontował neon w pojeździe: **"..getElementData(veh, "id").."** / **"..r.." "..g.." "..b.."**", "logi-pojazdy")
end)

addEvent("zmien:tablice", true)
addEventHandler("zmien:tablice", root, function(tab)
	local veh = getPedOccupiedVehicle(client)
	setVehiclePlateText(veh, tab)
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **COMPONENTS** - **"..getPlayerName(client).."** zmienił tablice w pojeździe: **"..getElementData(veh, "id").."** / **"..tab.."**", "logi-pojazdy")
end)