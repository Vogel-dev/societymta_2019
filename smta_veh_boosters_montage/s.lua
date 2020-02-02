--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local czas = getRealTime()

local montaze = {
{-2292.37, -127.37, 35.32},
}

for i, v in ipairs(montaze) do
	marker = createMarker(v[1], v[2], v[3]-1.5, "cylinder", 2.5, 59, 122, 87, 50)
	napis = createElement("text")
    setElementPosition(napis, v[1], v[2], v[3])
    setElementData(napis, "text", "Montaż ulepszeń silnika")
	setElementData(marker, "tuning", true)
end

addEvent("mont:ms", true)
addEventHandler("mont:ms", root, function(jaki)
	local veh = getPedOccupiedVehicle(client)
	local pieniadze = getElementData(client, "pieniadze")
	if jaki == 1 then
		if getElementData(veh, "ms1") == 1 then
			exports["smta_base_notifications"]:noti("Zdemontowano SB 1 otrzymujesz 12.500 $", client)
			setElementData(veh, "ms1", 0)
			setElementData(client, "pieniadze", pieniadze+12500)
			exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET ms1=0 WHERE id=?", getElementData(veh, "id"))
			exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] **BOOSTERS** - **"..getPlayerName(client).."** zdemontował **SB 1** z pojazdu id **"..getElementData(veh, "id").."**", "logi-pojazdy")
		else
			if pieniadze < 25000 then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", client, "error") return end
			exports["smta_base_notifications"]:noti("Zamontowano SB 1 za 25.000 $", client)
			setElementData(veh, "ms1", 1)
			setElementData(veh, "ms1:tryb", 1)
			setElementData(client, "pieniadze", pieniadze-25000)
			exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET ms1=1 WHERE id=?", getElementData(veh, "id"))
			exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] **BOOSTERS** - **"..getPlayerName(client).."** zamontował **SB 1** do pojazdu id **"..getElementData(veh, "id").."**", "logi-pojazdy")
		end
	elseif jaki == 2 then
		if getElementData(veh, "ms2") == 1 then
			exports["smta_base_notifications"]:noti("Zdemontowano SB 2 otrzymujesz 25.000 $", client)
			setElementData(veh, "ms2", 0)
			setElementData(client, "pieniadze", pieniadze+25000)
			exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET ms2=0 WHERE id=?", getElementData(veh, "id"))
			exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] **BOOSTERS** - **"..getPlayerName(client).."** zdemontował **SB 2** z pojazdu id **"..getElementData(veh, "id").."**", "logi-pojazdy")
		else
			if pieniadze < 50000 then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", client, "error") return end
			exports["smta_base_notifications"]:noti("Zamontowano SB 2 za 50.000 $", client)
			setElementData(veh, "ms2", 1)
			setElementData(veh, "ms2:tryb", 1)
			setElementData(client, "pieniadze", pieniadze-50000)
			exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET ms2=1 WHERE id=?", getElementData(veh, "id"))
			exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] **BOOSTERS** - **"..getPlayerName(client).."** zamontował **SB 2** do pojazdu id **"..getElementData(veh, "id").."**", "logi-pojazdy")
		end
	elseif jaki == 3 then
		if getElementData(veh, "ms3") == 1 then
			exports["smta_base_notifications"]:noti("Zdemontowano SB 3 otrzymujesz 5.000 $", client)
			setElementData(veh, "ms3", 0)
			setElementData(client, "pieniadze", pieniadze+5000)
			exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET ms3=0 WHERE id=?", getElementData(veh, "id"))
			exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] **BOOSTERS** - **"..getPlayerName(client).."** zdemontował **SB 3** z pojazdu id **"..getElementData(veh, "id").."**", "logi-pojazdy")
		else
			if pieniadze < 10000 then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", client, "error") return end
			exports["smta_base_notifications"]:noti("Zamontowano SB 3 za 10.000 $", client)
			setElementData(veh, "ms3", 1)
			setElementData(veh, "ms3:tryb", 1)
			setElementData(client, "pieniadze", pieniadze-10000)
			exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET ms3=1 WHERE id=?", getElementData(veh, "id"))
			exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] **BOOSTERS** - **"..getPlayerName(client).."** zamontował **SB 3** do pojazdu id **"..getElementData(veh, "id").."**", "logi-pojazdy")
		end
	end
end)