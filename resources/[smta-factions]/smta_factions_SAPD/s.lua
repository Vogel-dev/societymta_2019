--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local frakcja = "SAPD"
local lider = "Komendant"
local vlider = "Zastepca_Komendanta"
local nowyranga = "Cadet"

local sluzba = createMarker(297.34, 186.51, 1007.17-0.95, "cylinder", 1, 0, 127, 255, 100)
setElementInterior(sluzba, 3)
local liderka = createMarker(300.88, 187.90, 1007.17-0.95, "cylinder", 1, 253, 14, 53, 100)
setElementInterior(liderka, 3)

addEventHandler("onMarkerHit", sluzba, function(gracz)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_factions WHERE dbid=? and frakcja=?", getElementData(gracz, "dbid"), frakcja)
	if #spr == 1 then
		triggerClientEvent(gracz, "gui:sluzba:"..frakcja.."", gracz, pokaztopke())
	end
end)

function pokaztopke()
	local q = exports['smta_base_db']:wykonaj("select * from smtadb_factions where frakcja = ? order by minuty desc", frakcja)
	local topka = {}
    local ile = #q
    if ile > 5 then
    	ile = 5
    end
	for i = 1, ile do
		table.insert(topka, {nick = q[i]["nick"], minuty = q[i]["minuty"]})
	end

	return topka
end

addEvent("rozpocznijSluzbe:"..frakcja.."", true)
addEventHandler("rozpocznijSluzbe:"..frakcja.."", root, function()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_factions WHERE dbid=? AND frakcja=?", getElementData(source, "dbid"), frakcja)
	if getElementData(source, "frakcja:sluzba") then
		setElementData(source, "frakcja:sluzba", false)
		exports["smta_base_notifications"]:noti("Zakończyłeś służbe", source)
		toggleControl(source, "fire", false)
		toggleControl(source, "aim_weapon", false)
        takeWeapon(source, 3)
        takeWeapon(source, 24)
        takeWeapon(source, 25)
        takeWeapon(source, 31)
        setElementModel(source, getElementData(source, "skin"))
	else
		setElementData(source, "frakcja:sluzba", frakcja)
		setElementData(source, "frakcja:ranga", spr[1].ranga)
		exports["smta_base_notifications"]:noti("Rozpoczynasz służbe", source)
		toggleControl(source, "fire", true)
		toggleControl(source, "aim_weapon", true)
        giveWeapon(source, 3, 9999999)
        giveWeapon(source, 24, 9999999)
        giveWeapon(source, 25, 9999999)
        giveWeapon(source, 31, 9999999)
        setElementModel(source, getElementData(source, "skin"))
        setPlayerArmor(source, 100)
	end
end)

-- liderka

addEventHandler("onMarkerHit", liderka, function(gracz)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_factions WHERE dbid=? AND frakcja=?", getElementData(gracz, "dbid"), frakcja)
    if #spr > 0 then 
    	if spr[1].ranga == lider or spr[1].ranga == vlider then
    		if getElementData(gracz, "frakcja:sluzba") then
				triggerClientEvent(gracz, "gui:lidera:"..frakcja.."", gracz, pokazpracownikow())
			end
		end
	end
end)

function pokazpracownikow()
    local q = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_factions WHERE frakcja=?", frakcja)
    local pracownicy = {}

    for i = 1, #q do
        table.insert(pracownicy, {nick = q[i]["nick"], ranga = q[i]["ranga"], wyplata = q[i]["wyplata"], minuty = q[i]["minuty"]})
    end

    return pracownicy
end

addEvent("usunPracownika:"..frakcja.."", true)
addEventHandler("usunPracownika:"..frakcja.."", root, function(nick)
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_factions WHERE nick=?", nick)
end)

addEvent("edytujPracownika:"..frakcja.."", true)
addEventHandler("edytujPracownika:"..frakcja.."", root, function(nick, wyplata, ranga)
	exports["smta_base_db"]:wykonaj("UPDATE smtadb_factions SET ranga=?, wyplata=? WHERE nick=?", ranga, wyplata, nick)
end)

addEvent("dodajPracownika:"..frakcja.."", true)
addEventHandler("dodajPracownika:"..frakcja.."", root, function(nick)
	local gracz = exports["smta_base_core"]:findPlayer(source, nick)
	if gracz then
		local dbid = getElementData(gracz, "dbid")
    	local nickname = getPlayerName(gracz)
    	local result = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_factions WHERE dbid=?", dbid)
    	if #result > 0 then
    		exports["smta_base_notifications"]:noti(""..nickname.." pracuje w frakcji.", source, "error")
    	return
    	end
    	exports["smta_base_notifications"]:noti("Dodano: "..nickname.." do frakcji", source)
    	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_factions SET dbid=?, frakcja=?, ranga=?, nick=?, wyplata=?", dbid, frakcja, nowyranga, nickname, 300)
    	setElementData(gracz, "frakcja", frakcja)
    else
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza", source, "error")
    end
end)


-- pojazdy 


local auta = {
{596, -1634.45, 651.83, 6.95, 359.7, 0.0, 360.0},
{596, -1627.71, 651.62, 6.89, 359.9, 360.0, 359.0},
{596, -1622.70, 651.40, 6.89, 359.9, 0.0, 359.8},
{596, -1616.87, 651.49, 6.89, 359.9, 0.0, 1.8},
{596, -1611.29, 652.01, 6.89, 359.9, 360.0, 0.8},
{596, -1604.94, 650.96, 6.89, 359.9, 0.0, 357.6},
{596, -1599.84, 650.98, 6.89, 359.9, 0.0, 359.5},
{596, -1593.98, 651.27, 6.89, 359.9, 360.0, 1.8},
{596, -1587.50, 651.33, 6.89, 359.9, 0.0, 359.1},
{579, -1576.71, 674.02, 6.90, 359.9, 360.0, 181.0},
{490, -1582.39, 673.74, 6.89, 359.9, 0.1, 180.6},
{490, -1587.81, 673.68, 6.89, 360.0, 0.0, 181.4},
{427, -1593.87, 673.34, 6.89, 359.9, 360.0, 181.7},
{507, -1599.67, 673.29, 6.89, 359.9, 360.0, 181.4},
{507, -1605.59, 673.87, 6.89, 359.9, 360.0, 180.3},
{560, -1612.18, 673.28, 6.89, 359.9, 0.0, 179.6},
{541, -1581.73, 651.81, 6.89, 359.9, 360.0, 0.4},

}

for _,v in ipairs(auta)do
    auto = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setElementData(auto, "nametag", v[8])
    setElementData(auto, "rodzajpaliwa", "PB95")
    setElementData(auto, "bak", 100)
    setElementData(auto, "cb", 1)
    setElementData(auto, "pojemnosc", 2.8)
    setVehicleHandling(auto, "maxVelocity", 360);
    setVehicleHandling(auto, "driveType", "awd");
    setVehicleHandling(auto, "engineAcceleration", 20)
    setElementData(auto, "przebieg", 1)
    setElementData(auto, "frakcja", frakcja)
    setElementData(auto, "tempomat", 1)
    setElementFrozen(auto, true)
    setVehicleColor(auto, 0, 0, 25, 255, 255, 255)
    addVehicleUpgrade(auto, 1025)
    setVehiclePlateText(auto, frakcja.." ".._)
end


addEventHandler("onVehicleStartEnter", resourceRoot, function(plr, seat, jacked)
    if seat ~= 0 then return end
        if getElementData(plr, "frakcja:sluzba") == frakcja then
    else
        cancelEvent()
        exports["smta_base_notifications"]:noti("Nie możesz wejśc do tego pojazdu", plr, "error")
    end
end)

addEvent("zamknijDrzwi:"..frakcja.."", true)
addEventHandler("zamknijDrzwi:"..frakcja.."", root, function(pojazd)
	setVehicleDoorOpenRatio(pojazd, 4, 0, 4, 1000)
    setVehicleDoorOpenRatio(pojazd, 5, 0, 5, 1000)
end)

--przebieralnia

local skiny = {
    {280, 262.62, 186.84, 1008.17, "Policjant 1", 3},
    {281, 257.46, 186.28, 1008.17, "Policjant 2", 3},
    {282, 251.98, 186.18, 1008.17, "Narkotykowy 1", 3},
    {283, 245.79, 186.19, 1008.17, "Narkotykowy 2", 3},
    {284, 250.37, 192.70, 1008.17, "Narkotykowy 3", 3},
    {285, 261.21, 192.55, 1008.17, "Kadet", 3},
}
     
for i, v in ipairs(skiny) do
    local marker = createMarker(v[2], v[3], v[4]-0.9, "cylinder", 1, 251, 206, 177, 50)
    setElementInterior(marker, v[6])
    setElementData(marker, "skin", v[1])
    napis = createElement("text")
    setElementPosition(napis, v[2], v[3], v[4])
    setElementData(napis, "text", v[5])
    addEventHandler("onMarkerHit", marker, function(gracz)
        if getElementType(gracz) ~= "player" then return end
        if getElementData(gracz, "frakcja:sluzba") == frakcja then
            setElementModel(gracz, getElementData(source, "skin"))
        end
    end)
end


addCommandHandler("blokady", function(player, command)
    if getElementData(player, "frakcja:sluzba") ~= frakcja then return end
    if getElementData(player, "maBlokady") then
        triggerClientEvent(player, "schowaj:blokady", player)
    else
        triggerClientEvent(player, "daj:blokady", player)
    end
end)