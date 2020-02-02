--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEventHandler("onVehicleEnter", root, function(plr, seat)
if seat ~= 0 then return end
local kto = getPlayerName(plr)
setElementData(source, "ostatnikierowca", kto)
end)

-- system odsylania pojazdow do przechowalni po okreslonym czasie

addEventHandler("onVehicleExit", resourceRoot, function(gracz, tryb)
	if tryb ~= 0 then return end
	setElementData(source, "naliczanie", true)
	local pojazd = source
	setTimer(function()
		if pojazd and isElement(pojazd) then
			if getElementData(pojazd, "naliczanie") then
				exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET przechowalnia=1 WHERE id=?", getElementData(pojazd, "id"))
				destroyElement(pojazd)
			end
		end
	end, 259200000, 1)
end)

addEventHandler("onVehicleEnter", resourceRoot, function(gracz, tryb)
	if tryb ~= 0 then return end
	setElementData(source, "naliczanie", false)
end)


-- koniec

addEventHandler("onResourceStart", resourceRoot, function()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_vehicles WHERE przechowalnia=0 and policyjny=0 and parking=0")
	for _, p in ipairs(spr) do
		stworzPojazdy(p)
	end
end)

addEventHandler("onResourceStop", resourceRoot, function()
	for _, p in ipairs(getElementsByType("vehicle")) do
		zapiszPojazdy(p)
	end
end)

function stworzPojazdy(p,x,y,z,rx,ry,rz)
	local pozycja = split(p.pozycja, ",")
	local kolor = split(p.kolor, ",")
	if not x and not y and not z then
		pojazd = createVehicle(p.model, pozycja[1], pozycja[2], pozycja[3], pozycja[4], pozycja[5], pozycja[6])
	end
	if x and y and z then
		pojazd = createVehicle(p.model, x,y,z,rx,ry,rz)
	end
	setVehicleColor(pojazd, kolor[1], kolor[2], kolor[3], kolor[4], kolor[5], kolor[6])
	setElementData(pojazd, "wlasciciel", p.wlasciciel)
	setElementData(pojazd, "id", p.id)
	setElementData(pojazd, "przebieg", p.przebieg)
	setElementData(pojazd, "paliwo", p.paliwo)
	setElementData(pojazd, "bak", p.bak)
	setElementData(pojazd, "pojemnosc", p.pojemnosc)
	setElementData(pojazd, "rodzajpaliwa", p.rodzajpaliwa)
	setElementData(pojazd, "zawieszenie", p.zawieszenie)
	setElementData(pojazd, "przeglad", p.przeglad)
	--setElementData(pojazd, "tempomat", 1)
    setVehiclePlateText(pojazd, "MTA "..p.id)
    setElementFrozen(pojazd, true)
	setElementHealth(pojazd, p.zdrowie)

	if (p.panelstates~="0,0,0,0,0,0,0") then
    	p.panelstates=split(p.panelstates,",")
		for i,v in ipairs(p.panelstates) do
		  setVehiclePanelState(pojazd,i-1, tonumber(v))
		end
	else
    	p.panelstates=split(p.panelstates,",")
	end

	local tuning = split(p.tuning, ",")
	for i=1,#tuning do
		addVehicleUpgrade(pojazd, tuning[i])
	end

	if p.zawieszenie == 1 then
		setElementData(pojazd, "zawieszenielvl", 2)
	end

	if p.neon ~= 0 then
		setElementData(pojazd, "neon", p.neon)
	end
	
	if p.lpg == 1 then
		setElementData(pojazd, "lpg", "tak")
	else
		setElementData(pojazd, "lpg", "nie")
	end
	
	if p.ms1 == 1 then
		setElementData(pojazd, "ms1", 1)
		setElementData(pojazd, "ms1:tryb", 1)
	end

	if p.ms2 == 1 then
		setElementData(pojazd, "ms2", 1)
		setElementData(pojazd, "ms2:tryb", 1)
	end

	if p.ms3 == 1 then
		setElementData(pojazd, "ms3", 1)
		setElementData(pojazd, "ms3:tryb", 1)
	end

	if p.organizacja:len() > 2 then
		setElementData(pojazd, "oname", p.organizacja)
	else
		setElementData(pojazd, "oname", false)
	end

	if p.swiatla:len() > 1 then
		local swiatla = split(p.swiatla, ",")
		setVehicleHeadLightColor(pojazd, swiatla[1], swiatla[2], swiatla[3])
	end

	if tonumber(p.pojemnosc) == 1.2 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity-15)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration-1.5)
	elseif tonumber(p.pojemnosc) == 1.4 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity-10)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration-1)
	elseif tonumber(p.pojemnosc) == 1.6 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+5)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+0.5)
	elseif tonumber(p.pojemnosc) == 1.8 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+15)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+1.5)
	elseif tonumber(p.pojemnosc) == 1.9 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+25)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+2.5)
	elseif tonumber(p.pojemnosc) == 2.2 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+55)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+5.5)
	elseif tonumber(p.pojemnosc) == 2.4 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(veh).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+65)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+6.5)
	elseif tonumber(p.pojemnosc) == 2.6 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+75)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+7.5)
	elseif tonumber(p.pojemnosc) == 2.8 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+85)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+8.5)
	elseif tonumber(p.pojemnosc) == 5.0 then
		local acceleration = getVehicleHandling(pojazd).engineAcceleration
		local velocity = getVehicleHandling(pojazd).maxVelocity
		setVehicleHandling(pojazd, "maxVelocity", velocity+150)
		setVehicleHandling(pojazd, "engineAcceleration", acceleration+15.5)
		setVehicleHandling(pojazd, "driveType", "awd")
	end
	--setVehicleHandling(pojazd, "maxVelocity", 219)


	return pojazd
end

function zapiszPojazdy(p)
	local id = getElementData(p, "id")
	if not id then return end
	local x, y, z = getElementPosition(p)
	local model = getVehicleModel(p)
	local rx, ry, rz = getElementRotation(p)
	local r1,g1,b1, r2,g2,b2 = getVehicleColor(p, true)
	local pozycja = x..", "..y..", "..z..", "..rx..", "..ry..", "..rz
	local kolor = r1..", "..g1..", "..b1..", "..r2..", "..g2..", "..b2
	local zdrowie = getElementHealth(p)
	local paliwo = getElementData(p, "paliwo")
	local przebieg = getElementData(p, "przebieg")
    local pojemnosc = getElementData(p, "pojemnosc")
	local panelstates={}
	for i=0,6 do
		table.insert(panelstates, getVehiclePanelState(p,i))
	end
	panelstates=table.concat(panelstates,",")
	local r3, g3, b3 = getVehicleHeadLightColor(p)
	local swiatla = r3..", "..g3..", "..b3
	local tuning = getVehicleUpgrades(p)
	if not tuning then
		tuning = {}
	end
	tuning = table.concat(tuning, ",")
	local wyk = exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET pozycja=?, model=?, kolor=?, panelstates=?, zdrowie=?, paliwo=?, przebieg=?, swiatla=?, pojemnosc=?, tuning=? WHERE id=?", pozycja, model, kolor, panelstates, zdrowie, paliwo, przebieg, swiatla, pojemnosc, tuning, id)
	if not wyk then
		outputDebugString("SMTA_VEHICLES_BASE - Nie udalo sie zapisac pojazdu o id "..id)
	end
end

addEventHandler("onVehicleStartEnter", root, function(gracz, seat)
	if seat ~= 0 then return end
	if getElementData(source, "id") then
		if getElementData(source, "keys") and getElementData(source, "keys") == getElementData(gracz, "dbid") then return end
		if getElementData(source, "oname") and getElementData(source, "oname") == getElementData(gracz, "oname") then return end
		if getElementData(source, "wlasciciel") ~= getElementData(gracz, "dbid") then
			cancelEvent()
			exports["smta_base_notifications"]:noti("Ten pojazd nie należy do ciebie.", gracz, "error")
		end
	end
end)
--[[
addEventHandler("onVehicleEnter", root, function(gracz, seat)
	if seat ~= 0 then return end
	if getElementData(source, "id") then
		local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_vehicles WHERE id=? AND (przeglad + INTERVAL 7 DAY)<NOW()", getElementData(source, "id"))
		if #spr > 0 then
			exports["smta_base_notifications"]:noti("Twój pojazd posiada nie ważny przegląd", gracz, "error")
		end
	end
end)
--]]
local motory = {
{"Freeway"},
{"FCR-900"},
{"Faggio"},
{"Pizzaboy"},
{"BF-400"},
{"NRG-500"},
{"PCJ-600"},
{"HPV-1000"},
{"Wayfarer"},
{"Sanchez"},
{"Quadbike"},
}

addEventHandler("onVehicleStartEnter", root, function(g, typ)
	if typ ~= 0 then return end
	local serial = getPlayerSerial(g)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE serial=? AND data>NOW()", serial)
	if #spr > 0 then
		exports["smta_base_notifications"]:noti("Posiadasz zawieszone prawo jazdy kat. A,B,C od "..spr[1].admin.." do "..spr[1].data, g, "error")
		cancelEvent()
		setElementData(g, "block:prawko", true)
	else
		exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_licences WHERE serial=?", serial)
		setElementData(g, "block:prawko", false)
	end
end)

addEventHandler("onVehicleStartEnter", root, function(gracz, seat)
	if seat ~= 0 then return end
	if not getElementData(source, "id") then return end
 	for i,v in ipairs(motory) do
 		if v[1] == getVehicleName(source) then 
 			if getElementData(gracz, "prawko_a") ~= 1 then
 				cancelEvent()
				exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy kategorii A.", gracz, "error")
 				return 
 			end
 		end
	 end
	if getElementData(gracz, "prawko_b") ~= 1 then
		cancelEvent()
		exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy kategorii B.", gracz, "error")
	end
end)

-- anty wybuch pojazdow


setTimer(function()
for _, vehicle in pairs(getElementsByType("vehicle")) do
if getElementHealth(vehicle) < 300 then
setVehicleDamageProof(vehicle, true)
elseif getElementHealth(vehicle) > 301 then
if getVehicleController (vehicle) then
setVehicleDamageProof(vehicle, false)
end
end
end
end, 500, 0)
--[[
setTimer(function()
for _, vehicle in pairs(getElementsByType("vehicle")) do
if not getVehicleController(vehicle) then
setVehicleDamageProof(vehicle, true)
end
end
end, 500, 0)
--]]
addEventHandler("onVehicleEnter", resourceRoot, function(gracz, tryb)
  if tryb ~= 0 then return end
  local pojazd = source
  if getElementData(pojazd, "kara") then
    triggerClientEvent(gracz, "oknoKary", source)
  end
end)

addEvent("wybralnieplace", true)
addEventHandler("wybralnieplace",root, function()
removePedFromVehicle(source)
end)

