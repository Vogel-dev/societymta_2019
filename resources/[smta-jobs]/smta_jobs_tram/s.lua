--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local discordczas = getRealTime()

function pokazpracownikow()
	local q = exports['smta_base_db']:wykonaj("SELECT * from smtadb_accounts order by azlecenia desc")
	local topka = {}

	for i = 1,5 do
		table.insert(topka, {nick = q[i]["login"], liczba = q[i]["azlecenia"]})
	end

	return topka
end

tablica = pokazpracownikow()

setTimer(function()
	tablica = pokazpracownikow()
end, 600000, 0)

addEvent("pokazTopke:autobusy:source", true)
addEventHandler("pokazTopke:autobusy:source", root, function()
	triggerClientEvent(source, "pokazTopke:autobusy:client", source, tablica)
end)

addEvent("daj:azlecenia", true)
addEventHandler("daj:azlecenia", root, function(player)
    local dbid = getElementData(player, "dbid")
    local ilosc = getElementData(player, "azlecenia") or 0
    local q = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET azlecenia=azlecenia+1 where dbid=?", dbid)
    setElementData(player, "azlecenia", ilosc+1)
    exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRAM** **"..getPlayerName(player).."** wykonał pełen kurs.", "logi-prace")
end)

bus = { }

addEvent("dajAutobus:autobusy", true)
addEventHandler("dajAutobus:autobusy", root, function()
	if getElementData(source, "autobusy:ulepszenie1") == 1 then
		bus[source] = createVehicle(570, -1941.68, 184.51, 27.11, 0.1, 0.0, 175.6)
	else
		bus[source] = createVehicle(449, -1756.91, 921.13, 25.12, 0.0, 0.0, 90.0)
    end
    warpPedIntoVehicle(source, bus[source])
    setElementDimension(bus[source], 0)
    setVehicleDamageProof(bus[source], true)
    triggerClientEvent(root, "ghost:vehicle", root, bus[source])
    setElementData(bus[source], "kierowca:autobusy", getElementData(source, "dbid"))
    setVehicleColor(bus[source], 255, 255, 255, 255, 255, 255)
    setVehicleHandling(bus[source], maxVelocity, 20)
end)

addEvent("usunAutobus:autobusy", true)
addEventHandler("usunAutobus:autobusy", root, function()
	if isElement(bus[client]) then
		destroyElement(bus[client])
	end
end)

addEventHandler("onVehicleStartExit", resourceRoot, function(gracz)
	if getElementData(gracz, "pracuje") ~= "autobusy" then return end
	triggerClientEvent(gracz, "zakonczPrace:autobusy", gracz, true)
end)

addEventHandler("onVehicleStartEnter", root, function(gracz, seat)
    if getElementData(gracz, "pracuje") == "autobusy" then
        if getElementData(source, "id") then
            cancelEvent()
        end
        if getElementData(source, "kierowca:autobusy") ~= getElementData(gracz, "dbid") then
            cancelEvent()
        end
    else
        if getElementData(source, "kierowca:autobusy") then
            cancelEvent()
        end
    end
end)

addEventHandler("onPlayerQuit", root, function()
	if isElement( bus[source] ) then
		destroyElement( bus[source] )
	end
end)