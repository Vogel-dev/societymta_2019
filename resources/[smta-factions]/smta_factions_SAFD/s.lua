--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local frakcja = "SAFD"
local lider = "General_Brygadier"
local vlider = "Nadbrygadier"
local nowyranga = "Podchorazy"

local sluzba = createMarker(-2126.00, 541.77, 44.44-0.95, "cylinder", 1, 200, 50, 10, 100)
setElementInterior(sluzba, 0)
local liderka = createMarker(-2122.99, 546.94, 44.44-0.95, "cylinder", 1, 253, 14, 53, 100)
setElementInterior(liderka, 0)

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
        takeWeapon(source, 42)
        setElementModel(source, getElementData(source, "skin"))
	else
		setElementData(source, "frakcja:sluzba", frakcja)
		setElementData(source, "frakcja:ranga", spr[1].ranga)
		exports["smta_base_notifications"]:noti("Rozpoczynasz służbe", source)
		toggleControl(source, "fire", true)
		toggleControl(source, "aim_weapon", true)
        giveWeapon(source, 42, 9999999)
        setElementModel(source, getElementData(source, "skin"))
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
    {407, -2078.22, 543.52, 34.83, 359.6, 0.0, 182.2, "GBA-01"},
    {407, -2070.25, 544.22, 34.83, 359.6, 0.0, 180.5, "GBA-02"},
    {544, -2061.35, 544.13, 34.82, 359.5, 360.0, 180.4, "Drabiniasta-01"},
    {416, -2052.57, 543.89, 34.82, 359.5, 360.0, 178.6},
    {490, -2044.84, 544.33, 34.82, 359.5, 360.0, 178.8},
    {421, -2021.81, 542.89, 34.82, 359.5, 360.0, 92.4},
    {421, -2020.92, 537.23, 34.82, 359.5, 360.0, 94.1},
    {560, -2021.17, 530.03, 34.82, 359.5, 360.0, 91.6, "N-01"},
    {560, -2021.52, 523.10, 34.82, 359.6, 360.0, 91.5, "N-02 "},
    {552, -2033.57, 521.66, 34.82, 359.6, 360.0, 90.6},
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
    setVehicleColor(auto, 225, 0, 0, 255, 255, 255)
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
    {279, -2121.95, 515.84, 35.16, "Koszarowy", 0},
    {278, -2125.27, 515.20, 35.16, "Strażak 1", 0},
    {277, -2127.12, 521.43, 35.16, "Strażak 2", 0},
    {276, -2126.98, 524.92, 35.16, "Ratownik", 0},
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