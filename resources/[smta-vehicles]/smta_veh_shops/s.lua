--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local pojazd = false
local discordczas = getRealTime()

local pojazdy = {
--CYGAN:
--DOHERTY AUTA:
{445, -1946.70, 257.13, 35.34, 360.0, 0.0, 46.1, 17500, "salon", 3, 2.6, 1, "PB95", -1947.45, 255.59, 35.47}, -- admiral
{540, -1945.11, 262.89, 35.33, 359.8, 359.9, 51.9, 9560, "salon", 3, 2.4, 1, "ON", -1945.75, 261.19, 35.47}, -- wincent
{421, -1945.55, 269.25, 35.47, 360.0, 360.0, 46.3, 11050, "salon", 3, 2.6, 1, "PB95",  -1946.46, 267.92, 35.47}, -- Washington
{546,  -1953.64, 293.38, 35.19, 0.0, 0.0, 119.2, 7950, "salon", 3, 1.9, 1, "ON", -1952.20, 291.54, 35.47}, -- Intruder
{402, -1946.08, 272.36, 40.88, 360.0, 0.2, 47.5, 85000, "salon", 3, 2.2, 1, "PB95", -1946.64, 270.51, 41.05}, -- Buffalo
{405, -1954.73, 299.30, 35.34, 0.0, 360.0, 124.9, 21000, "salon", 3, 2.6, 1, "ON", -1953.42, 298.29, 35.47}, -- sentinel
{559, -1947.40, 259.45, 40.70, 360.0, 360.0, 47.1, 55050, "salon", 3, 2.8, 1, "ON", -1948.56, 258.05, 41.05}, -- Jester
{561, -1946.02, 266.11, 40.86, 0.2, 359.9, 63.9, 26800, "salon", 3, 2.4, 1, "ON", -1946.41, 264.39, 41.05}, -- Stratum
{555, -1959.93, 304.39, 35.16, 360.0, 359.9, 140.2, 21000, "salon", 3, 2.4, 1, "PB95", -1958.23, 303.86, 35.47}, -- windsor
{477, -1958.18, 259.03, 35.22, 359.7, 0.1, 56.4, 53860, "salon", 3, 2.8, 1, "ON", -1958.53, 257.17, 35.47}, -- Zr-350
{541, -1959.01, 272.39, 35.09, 359.5, 0.0, 47.6, 85000, "salon", 3, 1.2, 1, "ON", -1959.62, 270.80, 35.47}, -- bullet

--MOTORY:
{581, -1956.65, 304.62, 40.64, 359.4, 0.0, 145.0, 24500, "salon", 1.5, 2.8, 1, "ON", -1956.26, 303.76, 41.05}, -- Bf-400
{462, -1956.58, 299.41, 40.64, 359.5, 0.0, 138.1, 450, "salon", 1.5, 2.8, 1, "ON", -1955.95, 299.13, 41.05}, -- faggio
{521, -1956.80, 293.94, 40.62, 359.2, 360.0, 138.8, 32800, "salon", 2.8, 2.2, 1, "PB95", -1956.12, 293.36, 41.05}, -- FCR-900
{463, -1952.38, 291.81, 40.59, 360.0, 0.0, 127.5, 26060, "salon", 2.8, 2.2, 1, "ON", -1951.63, 291.54, 41.05}, -- Freeway
{468, -1951.71, 297.08, 40.72, 359.7, 360.0, 135.9, 15420, "salon", 2.8, 2.2, 1, "ON", -1951.11, 296.47, 41.05}, -- Sanchez

--CYGAN:
{404, -1909.33, -541.59, 24.33, 359.7, 360.0, 236.4, 1850, "cygan", 3, 1.9, 120900, "ON", -1908.47, -539.12, 24.59}, -- perennial
{458, -1908.60, -535.25, 24.47, 360.0, 360.0, 236.6, 3750, "cygan", 3, 1.6, 238915, "ON", -1907.14, -532.91, 24.59}, -- Solair
{589, -1908.98, -527.64, 24.31, 359.6, 360.0, 235.9, 4750, "cygan", 3, 2.2, 310231, "PB95", -1907.49, -524.75, 24.68}, -- Club
{478, -1909.05, -520.14, 24.73, 358.9, 360.0, 240.1, 320, "cygan", 3, 1.2, 123125, "ON", -1907.93, -517.42, 24.77}, -- Walton
{527, -1909.46, -513.35, 24.61, 359.0, 1.5, 237.1, 1750, "cygan", 3, 1.4, 203911, "ON", -1908.02, -510.90, 24.97}, -- Cadrona
{491, -1897.32, -540.42, 24.35, 360.0, 360.0, 135.5, 5820, "cygan", 3, 2.4, 392951, "PB95", -1899.04, -538.08, 24.59}, -- Virgo
{550, -1898.02, -533.96, 24.41, 359.4, 359.8, 124.8, 3820, "cygan", 3, 1.6, 101922, "ON", -1899.19, -531.47, 24.61}, -- Sunrise

--SALONLUX:
{451, -1661.14, 1214.21, 6.96, 359.5, 360.0, 258.6, 320000, "Luxury", 3, 2.4, 1, "ON", -1660.65, 1216.27, 7.25}, -- Turismo
{541, -1664.14, 1222.50, 13.30, 359.5, 359.9, 183.3, 268000, "Luxury", 3, 2.2, 1, "PB95", -1662.03, 1222.44, 13.67}, -- Bullet
--{415, -1659.48, 1218.91, 13.44, 0.3, 0.0, 175.8, 240000, "Luxury", 3, 2.6, 1, "PB95", -1657.71, 1219.00, 13.67}, -- Cheetah
--{480, -1654.67, 1215.37, 13.45, 359.7, 0.0, 177.0, 185000, "Luxury", 3, 2.6, 1, "PB95", -1652.48, 1215.02, 13.67}, -- Comet
{562, -1648.75, 1206.86, 13.33, 359.4, 360.0, 54.5, 120000, "Luxury", 3, 2.6, 1, "PB95", -1649.47, 1205.03, 13.67}, -- Elegy
--{560, -1656.08, 1205.42, 20.86, 0.0, 0.0, 29.0, 135000, "Luxury", 3, 2.4, 1, "ON", -1658.30, 1204.43, 21.16}, -- Sultan
{506, -1663.32, 1205.25, 20.86, 360.0, 360.0, 29.7, 95600, "Luxury", 3, 2.4, 1, "ON", -1665.19, 1203.74, 21.16}, -- Super GT
--IMPORT:
{579, -31.66, -296.63, 5.40, 2.7, 0.0, 268.5, 745060, "Import", 3, 2.8, 1, "PB95", -32.04, -295.04, 5.43}, -- G-Class 65 AMG
{565, -31.52, -292.97, 5.11, 2.4, 0.0, 270.5, 255000, "Import", 3, 2.8, 1, "ON", -31.29, -291.65, 5.43}, -- Golf MK5 GTI
{411, -31.44, -289.97, 5.11, 2.5, 0.0, 269.3, 2650000, "Import", 3, 2.8, 1, "PB95", -31.42, -288.63, 5.43}, -- Huragan
{429, -31.39, -286.65, 5.11, 2.5, 359.9, 271.7, 525000, "Import", 3, 2.8, 1, "ON", -31.19, -285.30, 5.43}, -- M3 E46
{480, -31.28, -282.65, 5.11, 2.6, 0.0, 271.3, 960000, "Import", 3, 2.8, 1, "PB95", -31.22, -281.17, 5.43}, -- Panamera
{426,  -31.09, -278.99, 5.11, 2.6, 0.0, 268.7, 1260000, "Import", 3, 2.8, 1, "PB95", -30.99, -277.44, 5.42}, -- M6
{560,  -30.99, -275.66, 5.11, 2.6, 0.0, 269.1, 1375000, "Import", 3, 2.8, 1, "PB95", -30.95, -274.35, 5.42}, -- RS7
{507,  1.15, -285.75, 5.12, 2.3, 0.0, 89.3, 1410000, "Import", 3, 2.8, 1, "PB95",0.59, -287.14, 5.43}, -- S500 W222 AMG
{494, 1.29, -289.40, 5.12, 2.4, 0.0, 91.7, 1325000, "Import", 3, 2.8, 1, "PB95",1.46, -290.83, 5.43}, -- Cayenne Turbo S
{602, 1.25, -293.40, 5.12, 2.3, 0.0, 88.7, 925000, "Import", 3, 2.8, 1, "PB95",1.36, -294.86, 5.43}, -- V12 Vantage S
{502, 1.22, -298.07, 5.12, 2.4, 0.0, 92.8, 1355000, "Import", 3, 2.8, 1, "PB95", 1.07, -299.33, 5.42}, -- G-Class 65 AMG
{503, 1.14, -302.73, 5.12, 2.2, 359.9, 88.8, 755000, "Import", 3, 2.8, 1, "ON", 0.93, -304.21, 5.43}, -- Golf MK5 GTI
{400, 1.10, -306.07, 5.12, 2.4, 0.0, 89.2, 1150000, "Import", 3, 2.8, 1, "PB95", 1.27, -307.47, 5.43}, -- Huragan

}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(pojazdy) do
		pojazd = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
		local cena = v[8]
		local cenap = v[8]
		local pojemnosc = v[11]
		local przebieg = v[12]
		local model = getModelHandling(tonumber(v[1]))
		local naped = model["driveType"]
		if naped == "rwd" then naped = "RWD" elseif naped == "fwd" then naped = "FWD" elseif naped == "awd" then naped = "AWD" end
		setElementData(pojazd, "nametag", "Model: "..getVehicleName(pojazd).."\nCena: "..cena.." USD\nAby dowiedzieć się więcej o samochodzie\npodejdz do niego")
		setElementFrozen(pojazd, true)
		setVehicleDamageProof(pojazd, true)
		setElementData(pojazd, "salon", v[9])
		setVehicleColor(pojazd, 235, 235, 235, 255, 255, 255)
		local shape = createColSphere(v[14], v[15], v[16], 1)
		local marker = createMarker(v[14], v[15], v[16]-0.95, "cylinder", 1, 237, 201, 175, 100)
		setElementData(marker, "sprzedaz", true)
		--attachElements(shape, pojazd, 0, 4, 0)
		--attachElements(marker, pojazd, 0, 4, -0.6)
		setElementData(shape, "i", i)
		setElementData(shape, "salon", pojazd)
		setElementData(shape, "cena", cenap)
		setElementData(shape, "size", v[10])
		setElementData(shape, "pojemnoscnowa", v[11])
		setElementData(shape, "przebieg", przebieg)
		setElementData(shape, "nazwa", getVehicleName(pojazd))
		setElementData(shape, "naped", naped)
		setElementData(shape, "rodzajpaliwa", v[13])
		addEventHandler("onColShapeHit", shape, function(gracz)
			if getElementType(gracz) ~= "player" then return end
			if getPedOccupiedVehicle(gracz) then return end
			local shape = cuboid(gracz)
			local veh = getElementData(shape, "salon")
			local cena = getElementData(shape, "cena")
			local pojemnosc = getElementData(shape, "pojemnoscnowa")
			local nazwa = getElementData(shape, "nazwa")
			local przebieg = getElementData(shape, "przebieg")
			local naped = getElementData(shape, "naped")
			local rodzaj = getElementData(shape, "rodzajpaliwa")
			local model = getVehicleModel(veh)
			triggerClientEvent(gracz, "oknoKupnaSalon", source, nazwa, przebieg, cena, pojemnosc, naped, rodzaj, model)
		end)
		addEventHandler("onColShapeLeave", shape, function(gracz)
			if getElementType(gracz) ~= "player" then return end
			triggerClientEvent(gracz, "oknoKupnaSalon:close", source)
		end)
	end
end)

addEventHandler("onVehicleStartEnter", resourceRoot, function(plr, seat, jacked)
	if seat ~= 0 then return end
	cancelEvent()
end)

addEvent("zakupPojazdSalon", true)
addEventHandler("zakupPojazdSalon", root, function(gracz, kolor)
	local shape = cuboid(gracz)
	if shape then
		local veh = getElementData(shape, "salon")
		if not veh then return end
		if getElementData(shape, "size") == 3 and getElementData(gracz, "prawko_b") ~= 1 then
			exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy kategorii B.", gracz)
			return
		end
		if getElementData(shape, "size") == 1.5 and getElementData(gracz, "prawko_a") ~= 1 then
			exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy kategorii A.", gracz)
			return
		end
		local cenap = getElementData(shape, "cena")
		local hajs = getElementData(gracz, "pieniadze")
		cenap = tonumber(cenap)
		if hajs < cenap then
			exports["smta_base_notifications"]:noti("Brak funduszy na zakup tego pojazdu.", gracz)
		else
			if getElementData(gracz, "prawko_b") ~= 1 then
				exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy.", gracz)
				return
			end
			local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE serial=?", getPlayerSerial(gracz))
			if #spr > 0 then
				exports["smta_base_notifications"]:noti("Posiadasz zawieszone prawo jazdy kat. A,B,C do "..spr[1].data.." zabrane przez "..spr[1].admin, gracz)
				return
			end
			setElementData(gracz, "pieniadze", hajs-cenap)
			local model = getVehicleModel(veh)
			local dbid = getElementData(gracz, "dbid")
			local pojemnosc2 = getElementData(shape, "pojemnoscnowa")
			pojemnosc2 = string.format("%.1f", pojemnosc2)
			local przebieg = getElementData(shape, "przebieg")
			local rodzaj = getElementData(shape, "rodzajpaliwa")
			local k = getElementData(veh, "salon")
			if k == "salon" then
				x, y, z, r, z2, yx = -1936.24, 271.97, 40.72, 0.2, 360.0, 179.9
			elseif k == "cygan" then
				x, y, z, r, z2, yx = -1906.44, -553.62, 24.26, 0.4, 360.0, 179.3
			elseif k == "Luxury" then
				x, y, z, r, z2, yx = -1631.96, 1203.03, 6.78, 0.1, 354.6, 221.3
			elseif k == "Import" then
				x, y, z, r, z2, yx = -27.48, -314.24, 5.13, 2.4, 0.1, 173.7
			elseif k == "salon4" then
				x, y, z, r, z2, yx = -1594.12, 73.53, 3.65, 359.7, 0.0, 135.5
			end
			local pozycja = x..", "..y..", "..z..", "..r..", "..z2..", "..yx
			if kolor == "Czerwony" then
				kolor = "185, 43, 39"
			elseif kolor == "Niebieski" then
				kolor = "21, 101, 192"
			elseif kolor == "Zielony" then
				kolor = "28, 172, 120"
			elseif kolor == "Żółty" then
				kolor = "252, 232, 131"
			elseif kolor == "Turkusowy" then
				kolor = "0, 147, 175"
			elseif kolor == "Różowy" then
				kolor = "255, 192, 203"
			elseif kolor == "Biały" then
				kolor = "255, 255, 255"
			elseif kolor == "Czarny" then
				kolor = "5, 5, 5"
			elseif kolor == "Pomarańczowy" then
				kolor = "255, 117, 56"
			elseif kolor == "Fioletowy" then
				kolor = "16,5,28"
			end
			local wyk, _, id = exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_vehicles SET model=?, wlasciciel=?, pozycja=?, paliwo=50, bak=50, przebieg=?, pojemnosc=?, rodzajpaliwa=?, kolor=?, przeglad=NOW()", model, dbid, pozycja, przebieg, pojemnosc2, rodzaj, kolor)
			local q = exports["smta_base_db"]:wykonaj("select * from smtadb_vehicles where id=?", id)
			local pojazd = exports["smta_veh_base"]:stworzPojazdy(q[1], x, y, z, r, z2, yx)
			warpPedIntoVehicle(gracz, pojazd)
			exports["smta_base_notifications"]:noti("Zakupiłeś pojazd "..getVehicleName(pojazd).." za cene "..cenap.." USD", gracz)
			exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **SHOP** - **"..getPlayerName(gracz).."** zakupil pojazd **"..getVehicleName(pojazd).."** za cene **"..cenap.."** $", "logi-pojazdy")
		end
	end
end)

function cuboid(gracz)
 for i, v in ipairs(getElementsByType("colshape", resourceRoot)) do
	 if isElementWithinColShape(gracz, v) then
		return v
	end
 end
 return false
end