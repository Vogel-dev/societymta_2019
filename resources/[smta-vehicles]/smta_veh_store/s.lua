--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local odbieranie = {
{-2123.86, -18.29, 35.32},
}

local text = createElement("text")
local moddwanie = false
local modbieranie = false

addEventHandler("onResourceStart", resourceRoot, function()
	for _, m in ipairs(odbieranie) do
		modbieranie = createMarker(m[1], m[2], m[3]-0.95, "cylinder", 1.5, 185, 43, 39, 50)
		setElementData(text, "text", "Odbieranie pojazdu z przechowalni")
		setElementPosition(text, m[1], m[2], m[3])
	end
end)

local oCuboid = createMarker(-2118.01, -31.82, 35.32-1.95, "cylinder", 3, 255, 255, 255, 50)
local wCuboid = createColCuboid(-2109.8771972656, -34.20735168457, 34.3203125, 12.25,13.5,3)

addEventHandler("onMarkerHit", oCuboid, function(player)
	if not player or not isElement(player) then return end
	if getElementType(player) ~= "player" then return end
	if not isPedInVehicle(player) then return end
	local veh = getPedOccupiedVehicle(player)
	local wyk = exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET przechowalnia=1 WHERE id=?",getElementData(veh, "id"))
        if getElementData(veh,"id") then
	if wyk then
		exports["smta_base_notifications"]:noti("Pojazd został zaparkowany na parkingu.", player)
		exports["smta_veh_base"]:zapiszPojazdy(veh)
		destroyElement(veh)
	else
		outputChatBox("SMTA_VEH_STORE - #01 - Zgłoś błąd.", g, 255, 0, 0)
	end
    end
end)

function sprawdzPrzechowalnie(gracz)
	return exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_vehicles WHERE wlasciciel=? AND przechowalnia=1", getElementData(gracz, "dbid"))
end

addEventHandler("onMarkerHit", resourceRoot, function(hit)
	if source == modbieranie then
	if getElementType(hit) ~= "player" then return end
	if getPedOccupiedVehicle(hit) then return end
	local spr = sprawdzPrzechowalnie(hit)
		if #spr < 1 then
			exports["smta_base_notifications"]:noti("Nie posiadasz pojazdów w przechowalni.", hit)
			return
		end
		triggerClientEvent(hit, "pojazdy", hit)
	end
end)


addEventHandler("onMarkerLeave", resourceRoot, function(hit)
	if source == modbieranie then
		if getElementType(hit) ~= "player" then return end
		triggerClientEvent(hit, "pojazdy", hit, true)
	end
end)

addEvent("wyjmij", true)
addEventHandler("wyjmij", root, function(gracz, id)
	local vehicles = getElementsWithinColShape(wCuboid, "vehicle")
	for _, veh in ipairs(vehicles) do  
		if not getVehicleController(veh) then
			if getElementData(veh, "id") then
				exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET przechowalnia=1 WHERE id=?", getElementData(veh, "id"))
			end
			destroyElement(veh)
		end
	end
	if #getElementsWithinColShape(wCuboid, "vehicle") > 0 then 
		exports["smta_base_notifications"]:noti("Wyjazd z parkingu jest zastawiony, spróbuj później.", gracz)
		return
	end
 	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE serial=? AND data>NOW()", getPlayerSerial(gracz))
	if #spr > 0 then
			exports["smta_base_notifications"]:noti("Posiadasz zawieszone prawo jazdy kat. A,B,C od "..spr[1].admin.." do "..spr[1].data, gracz, "error")
		return
	else
	    exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_licences WHERE serial=?", getPlayerSerial(gracz))
	end
	if getElementData(gracz, "prawko_b") ~= 1 then
		exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy.", gracz)
		return
	end
	local q = exports["smta_base_db"]:wykonaj("select * from smtadb_vehicles where id=?", id)
	exports["smta_base_db"]:wykonaj("update smtadb_vehicles set przechowalnia=0 where id=?", id)
	local pojazd = exports["smta_veh_base"]:stworzPojazdy(q[1], -2102.00, -28.86, 35.01, 0.4, 0.1, 358.3)
	if pojazd then
		warpPedIntoVehicle(gracz, pojazd)
	end
end)

function pokazpojazdy()
	local q = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_vehicles WHERE wlasciciel=? and przechowalnia=1", getElementData(source, "dbid"))
	local pojazdy = {}

	for i = 1, #q do
		table.insert(pojazdy, {model = q[i]["model"], id = q[i]["id"], kolor = q[i]["kolor"], swiatla = q[i]["swiatla"], paliwo = q[i]["paliwo"], bak = q[i]["bak"], przebieg = q[i]["przebieg"], pojemnosc = q[i]["pojemnosc"], stan = q[i]["zdrowie"], neon = q[i]["neon"], ms1 = q[i]["ms1"], ms2 = q[i]["ms2"], ms3 = q[i]["ms3"], tuning = q[i]["tuning"]})
	end

	return pojazdy
end

addEvent("pokazPojazdy:przechowalnia", true)
addEventHandler("pokazPojazdy:przechowalnia", root, function()
	triggerClientEvent(source, "pokazPojazdy:przechowalni", source, pokazpojazdy())
end)