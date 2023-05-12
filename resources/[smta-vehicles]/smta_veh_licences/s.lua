--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local discordczas = getRealTime()

pojazd = {}

addEvent("stworzPojazd:a", true)
addEventHandler("stworzPojazd:a", root, function()
	pojazd[source] = createVehicle(586, -2047.41, -96.59, 34.69, 359.9, 0.0, 4.6)
	setVehicleHandling(pojazd[source], "maxVelocity", 90)
	warpPedIntoVehicle(source, pojazd[source])
	setElementInterior(source, 0)
	setElementDimension(source, 0)
	setVehicleColor(pojazd[source], 255, 255, 255)
	setVehiclePlateText(pojazd[source], "LICENCE")
	setElementData(pojazd[source], "pj:user", source)
	setElementData(source, "pj:veh", pojazd[source])
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(source).."** rozpoczyna kurs **(kat.A)** ", "logi-pojazdy")
	triggerClientEvent(root, "ghost:vehicle", root, pojazd[source])
	addEventHandler("onVehicleStartExit", pojazd[source], przerwijEgzamin1)
	addEventHandler("onVehicleExit", pojazd[source], przerwijEgzamin1)
	addEventHandler("onVehicleDamage", pojazd[source], przerwijEgzamin2)
end)

addEvent("usunPojazd:a", true)
addEventHandler("usunPojazd:a", root, function()
	local veh = getElementData(source, "pj:veh")
	if isElement(veh) then
		removeEventHandler("onVehicleExit", veh, przerwijEgzamin1)
		removePedFromVehicle(source)
		destroyElement(veh)
		setElementData(source, "pj:veh", false)
	end
end)

addEvent("stworzPojazd:b", true)
addEventHandler("stworzPojazd:b", root, function()
	pojazd[source] = createVehicle(527, -2047.41, -96.59, 34.69, 359.9, 0.0, 4.6)
	setVehicleHandling(pojazd[source], "maxVelocity", 90)
	warpPedIntoVehicle(source, pojazd[source])
	setElementInterior(source, 0)
	setElementDimension(source, 0)
	setVehicleColor(pojazd[source], 255, 255, 255)
	setVehiclePlateText(pojazd[source], "LICENCE")
	setElementData(pojazd[source], "pj:user", source)
	setElementData(source, "pj:veh", pojazd[source])
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(source).."** rozpoczyna kurs **(kat.B)** ", "logi-pojazdy")
	triggerClientEvent(root, "ghost:vehicle", root, pojazd[source])
	addEventHandler("onVehicleStartExit", pojazd[source], przerwijEgzamin1)
	addEventHandler("onVehicleExit", pojazd[source], przerwijEgzamin1)
	addEventHandler("onVehicleDamage", pojazd[source], przerwijEgzamin2)
end)

addEvent("usunPojazd:b", true)
addEventHandler("usunPojazd:b", root, function()
	local veh = getElementData(source, "pj:veh")
	if isElement(veh) then
		removeEventHandler("onVehicleExit", veh, przerwijEgzamin1)
		removePedFromVehicle(source)
		destroyElement(veh)
		setElementData(source, "pj:veh", false)
	end
end)

addEvent("stworzPojazd:c", true)
addEventHandler("stworzPojazd:c", root, function()
	pojazd[source] = createVehicle(456, -2047.41, -96.59, 34.69, 359.9, 0.0, 4.6)
	setVehicleHandling(pojazd[source], "maxVelocity", 90)
	warpPedIntoVehicle(source, pojazd[source])
	setElementInterior(source, 0)
	setElementDimension(source, 0)
	setVehicleColor(pojazd[source], 255, 255, 255)
	setVehiclePlateText(pojazd[source], "LICENCE")
	setElementData(pojazd[source], "pj:user", source)
	setElementData(source, "pj:veh", pojazd[source])
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(source).."** rozpoczyna kurs **(kat.C)** ", "logi-pojazdy")
	triggerClientEvent(root, "ghost:vehicle", root, pojazd[source])
	addEventHandler("onVehicleStartExit", pojazd[source], przerwijEgzamin1)
	addEventHandler("onVehicleExit", pojazd[source], przerwijEgzamin1)
	addEventHandler("onVehicleDamage", pojazd[source], przerwijEgzamin2)
end)

addEvent("usunPojazd:c", true)
addEventHandler("usunPojazd:c", root, function()
	local veh = getElementData(source, "pj:veh")
	if isElement(veh) then
		removeEventHandler("onVehicleExit", veh, przerwijEgzamin1)
		removePedFromVehicle(source)
		destroyElement(veh)
		setElementData(source, "pj:veh", false)
	end
end)

addEvent("dajPrawko", true)
addEventHandler("dajPrawko", root, function(jakie)
	przeniesDoBudynku(source)
	if jakie == "a" then
		setElementData(source, "prawko_a", 1)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(source).."** zdał prawo jazdy **(kat.A)** ", "logi-pojazdy")
		exports["smta_base_db"]:wykonaj("UPDATE smtadb_accounts SET prawko_a=1 WHERE dbid=?", getElementData(source, "dbid"))
	elseif jakie == "b" then
		setElementData(source, "prawko_b", 1)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(source).."** zdał prawo jazdy **(kat.B)** ", "logi-pojazdy")
		exports["smta_base_db"]:wykonaj("UPDATE smtadb_accounts SET prawko_b=1 WHERE dbid=?", getElementData(source, "dbid"))
	elseif jakie == "c" then
		setElementData(source, "prawko_c", 1)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(source).."** zdał prawo jazdy **(kat.C)** ", "logi-pojazdy")
		exports["smta_base_db"]:wykonaj("UPDATE smtadb_accounts SET prawko_c=1 WHERE dbid=?", getElementData(source, "dbid"))
	end
end)

function przeniesDoBudynku(gracz)
	if getElementData(gracz, "zdaje:prawko") == "a" then
		setElementPosition(gracz, 2438.03, -1648.24, 1016.14)
		setElementInterior(gracz, 1)
	elseif getElementData(gracz, "zdaje:prawko") == "b" then
		setElementPosition(gracz, 2455.24, -1655.96, 1016.14)
		setElementInterior(gracz, 1)
	elseif getElementData(gracz, "zdaje:prawko") == "c" then
		setElementPosition(gracz, 2438.96, -1663.89, 1016.14)
		setElementInterior(gracz, 1)
	end
end


function przerwijEgzamin1(plr, seat)
	if seat ~= 0 then return end
	local veh = getElementData(plr, "pj:veh")
	if isElement(veh) then
		removeEventHandler("onVehicleExit", veh, przerwijEgzamin1)
		removePedFromVehicle(plr)
		destroyElement(veh)
	end
	przeniesDoBudynku(plr)
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(plr).."** niezdał kursu **(opuszczenie)** ", "logi-pojazdy")
	exports["smta_base_notifications"]:noti("Opuszczasz swój pojazd, oblewasz egzamin", plr)
	triggerClientEvent(plr, "destroyPunkt", plr)
	setElementData(plr, "zdaje", false)
	setElementData(plr, "pj:veh", false)
	setElementData(plr, "zdaje:prawko", false)
end

function przerwijEgzamin2(loss)
	if loss < 100 then return end
	local plr = getElementData(source, "pj:user")
	removePedFromVehicle(plr)
	local veh = getElementData(plr, "pj:veh")
	if isElement(veh) then
		destroyElement(veh)
	end
	przeniesDoBudynku(plr)
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LICENCE** - **"..getPlayerName(plr).."** niezdał kursu **(uszkodzenie)** ", "logi-pojazdy")
	exports["smta_base_notifications"]:noti("Uszkadzasz swój pojazd zbyt mocno, oblewasz egzamin", plr)
	triggerClientEvent(plr, "destroyPunkt", plr)
	setElementData(plr, "zdaje", false)
	setElementData(plr, "pj:veh", false)
	setElementData(plr, "zdaje:prawko", false)
end

addEventHandler("onPlayerQuit", root, function()
	if getElementData(source, "pj:veh") and isElement(getElementData(source, "pj:veh")) then
		destroyElement(getElementData(source, "pj:veh"))
	end
end)