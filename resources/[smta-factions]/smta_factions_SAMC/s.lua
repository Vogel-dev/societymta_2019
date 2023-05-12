--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local frakcja = "SAMC"
local lider = "Lider"
local vlider = "V-Lider"
local nowyranga = "Praktykant"

local sluzba = createMarker(1598.86, 1719.50, -33.73-0.95, "cylinder", 1, 0, 48, 143, 100)
setElementInterior(sluzba, 1)
local liderka = createMarker(1598.31, 1724.33, -33.73-0.95, "cylinder", 1, 253, 14, 53, 100)
setElementInterior(liderka, 1)

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
        takeWeapon(source, 41)
        setElementModel(source, getElementData(source, "skin"))
	else
		setElementData(source, "frakcja:sluzba", frakcja)
		setElementData(source, "frakcja:ranga", spr[1].ranga)
		exports["smta_base_notifications"]:noti("Rozpoczynasz służbe", source)
		toggleControl(source, "fire", true)
		toggleControl(source, "aim_weapon", true)
        giveWeapon(source, 41, 9999999)
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

local eq = { }
local nosze = { }

local auta = {
{416, -2588.79, 622.19, 14.61, 0.0, 359.6, 270.4, 'K1'},
{416, -2589.23, 627.06, 14.28, 359.6, 360.0, 269.7, 'P1'},
{416, -2589.07, 632.65, 14.28, 359.6, 360.0, 268.9, 'P2'},
{416, -2589.32, 637.94, 14.27, 359.6, 360.0, 269.0, 'S1'},
{416, -2589.86, 642.78, 14.27, 359.6, 360.0, 269.0, 'S2'},
{416, -2588.43, 652.67, 14.27, 359.6, 0.0, 271.4, 'T1'},
{507, -2589.21, 657.83, 14.27, 359.6, 360.0, 269.5, 'DYSP'},
{489, -2572.44, 632.31, 14.28, 359.6, 360.0, 269.2, 'DYR AM'},
{437, -2543.03, 599.03, 14.27, 359.6, 360.0, 178.9, 'SZK'},
{554, -2545.68, 622.53, 14.27, 359.6, 360.0, 88.7, 'DOWÓDCA'},
{445, -2546.32, 627.59, 14.27, 359.6, 360.0, 89.1, 'RD1'},
{445, -2545.88, 632.63, 14.27, 359.6, 360.0, 87.5, 'RD2'},
{445, -2545.72, 637.61, 14.27, 359.6, 360.0, 90.1, 'RD3'},
{560, -2545.75, 647.35, 14.28, 359.6, 0.0, 87.7, 'ZARZĄD'},
{560, -2546.33, 652.82, 14.28, 359.6, 360.0, 92.0, 'PZARZĄD'},
{579, -2571.52, 658.56, 14.27, 359.6, 360.0, 270.5, 'PAT1'},
{579, -2571.72, 647.72, 14.27, 359.6, 360.0, 269.7, 'PAT2'},
}

for _,v in ipairs(auta)do
    auto = createVehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setElementData(auto, "nametag", v[8])
    setElementData(auto, "rodzajpaliwa", "PB95")
    setElementData(auto, "bak", 100)
    setElementData(auto, "cb", 1)
    setElementData(auto, "pojemnosc", 2.8)
    setElementData(auto, "przebieg", 1)
    setElementData(auto, "frakcja", frakcja)
	setElementFrozen(auto, true)
	setVehicleColor(auto,  0, 150, 255, 255, 255, 255)
	--setVehiclePlateText(auto, v[8])
	setVehiclePlateText(auto, frakcja.." ".._)
	if v[1] == 442 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
	end

	if v[1] == 431 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
	end

if v[1] == 487 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
	end

	if v[1] == 426 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
	end

	if v[1] == 507 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
	end

if v[1] == 516 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
	end

	if v[1] == 586 then
		setElementData(auto, "ms1", 1)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
    end

	if v[1] == 560 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
    end

    if v[1] == 490 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
    end

    if v[1] == 502 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
    end
	
	if v[1] == 470 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
    end
	
	if v[1] == 468 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
    end

	if v[1] == 471 then
		setElementData(auto, "ms1", 1)
		addVehicleUpgrade(auto, 1025)
        setVehicleHandling(auto, "engineAcceleration", getVehicleHandling(auto).engineAcceleration+5)
        setVehicleHandling(auto, "driveType", "awd")
    end

    if v[1] == 416 then
    	setElementData(auto, "ms1", 1)
    	setElementData(auto, "ms2", 1)
		addVehicleUpgrade(auto, 1025)
       	local eq = createMarker(0,0,0, "corona", 1, 255, 0, 0, 0)
    	attachElements(eq, auto, 0, -4, 0)
    	local nosze = createObject(1997, 0, 0, 0, 0, 0, 0)
    	attachElements(nosze, auto, 0, -1.5, -0.5)
    	setElementCollisionsEnabled(nosze, false)
    	setElementData(eq, "nosze", nosze)
    	setElementData(eq, "pojazd", auto)
    	setElementData(auto, "nosze", true)
    	addEventHandler("onMarkerHit", eq, function(gracz)
    		if getElementType(gracz) ~= "player" then return end
    		if isPedInVehicle(gracz) then return end
    		if getElementData(gracz, "frakcja") == frakcja and getElementData(gracz, "frakcja:sluzba") then
    			triggerClientEvent(gracz, "pokazBagaznik:"..frakcja.."", gracz, source)
    			setVehicleDoorOpenRatio(getElementData(source, "pojazd"), 4, 1, 4, 1000)
    			setVehicleDoorOpenRatio(getElementData(source, "pojazd"), 5, 1, 5, 1000)
    		end 
    	end)
    	addEventHandler("onMarkerLeave", eq, function(gracz)
    		if getElementType(gracz) ~= "player" then return end
    		if isPedInVehicle(gracz) then return end
    		if getElementData(gracz, "frakcja") == frakcja and getElementData(gracz, "frakcja:sluzba") then
    			triggerClientEvent(gracz, "usunBagaznik:"..frakcja.."", gracz)
    		end
    	end)
    end
end

addEventHandler("onVehicleStartEnter", resourceRoot, function(plr, seat, jacked)
    if seat ~= 0 then return end
        if getElementData(plr, "frakcja:sluzba") == frakcja then
    else
        cancelEvent()
        exports["smta_base_notifications"]:noti("Nie możesz wejśc do tego pojazdu", plr, "error")
    end
end)

-- bagaznik

local timer = { }

addEvent("wezNosze:"..frakcja.."", true)
addEventHandler("wezNosze:"..frakcja.."", root, function(nosze, pojazd, marker)
	if not getElementData(source, "nosze") then
		if getElementData(pojazd, "nosze") then
			detachElements(nosze, pojazd)
			attachElements(nosze, source, 0, 1.5, -1)
			setElementData(pojazd, "nosze", false)
			setElementData(source, "nosze", nosze)
			exports["smta_base_notifications"]:noti("Wyciągasz nosze z karetki", client)
		else
			exports["smta_base_notifications"]:noti("W pojezdzie nie ma noszy!", source, "error")
		end
	else
		if not getElementData(pojazd, "nosze") then
			attachElements(nosze, pojazd, 0, -1.5, -0.5)
			setElementData(source, "nosze", false)
			setElementData(pojazd, "nosze", true)
			setElementData(marker, "nosze", nosze)
			exports["smta_base_notifications"]:noti("Chowasz nosze do karetki", client)
		else
			exports["smta_base_notifications"]:noti("W pojezdzie są nosze!", source, "error")
		end
	end
end)

addCommandHandler("pnosze", function(gracz)
	if not getElementData(gracz, "nosze") then return end
	local nosze = getElementData(gracz, "nosze")
	local rx, ry, rz = getElementRotation(gracz)
    detachElements(nosze, gracz)
    setElementRotation(nosze, rx, ry, rz)
    setElementData(gracz, "nosze", false)
end)


addCommandHandler("pnosze2", function(gracz)
	if getElementData(gracz, "frakcja:sluzba") ~= frakcja then return end
	if getElementData(gracz, "nosze") then return end
	local x, y, z = getElementPosition(gracz)
	local strefa = createColSphere(x, y, z, 2)
	local nosze = getElementsWithinColShape(strefa, "object" )
	destroyElement(strefa)
	if #nosze < 1 then return end
	if #nosze > 1 then return end
	attachElements(nosze[1], gracz, 0, 1.5, -1)
	setElementData(gracz, "nosze", nosze[1])
end)


addCommandHandler("nanosze", function(gracz, _, kogo)
	if not kogo then return end
	if not getElementData(gracz, "nosze") then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kogo)
	if not target then exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracz", gracz, "error") return end
	local x1, y1, z1 = getElementPosition(target)
	local x2, y2, z2 = getElementPosition(gracz)
	local dystans = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	if dystans > 5 then exports["smta_base_notifications"]:noti("Podany gracz jest za daleko", gracz, "error") return end
	attachElements(target, getElementData(gracz, "nosze"), 0, 0, 2)
	setElementCollisionsEnabled(target, false)
	setPedAnimation(target, "CRACK", "crckidle4", -1, true, false )
	setElementData(target, "nanoszach", true)
	setTimer(function()
		triggerClientEvent(target, "nosze:rotacja", root, target, getElementData(gracz, "nosze"), true)
	end, 100, 1)
end)

addCommandHandler("znosze", function(gracz, _, kogo)
	if not kogo then return end
	if not getElementData(gracz, "nosze") then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kogo)
	if not target then exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracz", gracz, "error") return end
	local x1, y1, z1 = getElementPosition(target)
	local x2, y2, z2 = getElementPosition(gracz)
	local dystans = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	if dystans > 5 then exports["smta_base_notifications"]:noti("Podany gracz jest za daleko", gracz, "error") return end
	if not getElementData(target, "nanoszach") then return end
	detachElements(target, getElementData(gracz, "nosze"))
	setElementCollisionsEnabled(target, true)
	setPedAnimation(target, false)
	setElementData(target, "nanoszach", false)
	triggerClientEvent(target, "nosze:usunRotacje", root)
end)

addEvent("zamknijDrzwi:"..frakcja.."", true)
addEventHandler("zamknijDrzwi:"..frakcja.."", root, function(pojazd)
	setVehicleDoorOpenRatio(pojazd, 4, 0, 4, 1000)
    setVehicleDoorOpenRatio(pojazd, 5, 0, 5, 1000)
end)

addEvent("wezTorbe:"..frakcja.."", true)
addEventHandler("wezTorbe:"..frakcja.."", root, function()
	if not getElementData(client, "torbawreku") then
		local torba = createObject(1210, 0, 0, 0)
		exports.bone_attach:attachElementToBone(torba, client, 12, 0, 0.05, 0.27, 0, 180, 90)
		setElementData(client, "torbawreku", true)
		setElementData(client, "torba", torba)
		exports["smta_base_notifications"]:noti("Wyciągasz torbe R1", client)
		bindKey(client, "z", "down", postawtorbe)
	else
		unbindKey(client, "z", "down", postawtorbe)
		exports.bone_attach:detachElementFromBone(getElementData(client, "torba"))
		destroyElement(getElementData(client, "torba"))
		setElementData(client, "torbawreku", false)
		setElementData(client, "torba", false)
		exports["smta_base_notifications"]:noti("Chowasz torbe R1", client)
	end
end)

addEvent("wezLP:"..frakcja.."", true)
addEventHandler("wezLP:"..frakcja.."", root, function()
	if not getElementData(client, "lpwreku") then
		local lp = createObject(2035, 0, 0, 0)
		exports.bone_attach:attachElementToBone(lp, client, 12, 0, 0.05, 0.27, 270, 180, 0)
		setElementData(client, "lpwreku", true)
		setElementData(client, "lp", lp)
		exports["smta_base_notifications"]:noti("Wyciągasz LifePack", client)
	else
		exports.bone_attach:detachElementFromBone(getElementData(client, "lp"))
		destroyElement(getElementData(client, "lp"))
		setElementData(client, "lpwreku", false)
		setElementData(client, "lp", false)
		exports["smta_base_notifications"]:noti("Chowasz LifePack", client)
	end
end)

addEvent("wezSzyny:"..frakcja.."", true)
addEventHandler("wezSzyny:"..frakcja.."", root, function()
	if not getElementData(client, "szynywreku") then
		local szyna = createObject(2880, 0, 0, 0)
		exports.bone_attach:attachElementToBone(szyna, client, 12, 0, 0.05, 0.22, 0, 180, 90)
		setElementData(client, "szynywreku", true)
		setElementData(client, "szyna", szyna)
		exports["smta_base_notifications"]:noti("Wyciągasz torbe szyn Kramera", client)
		bindKey(client, "z", "down", postawszyny)
	else
		unbindKey(client, "z", "down", postawszyny)
		exports.bone_attach:detachElementFromBone(getElementData(client, "szyna"))
		destroyElement(getElementData(client, "szyna"))
		setElementData(client, "szynywreku", false)
		setElementData(client, "szyna", false)
		exports["smta_base_notifications"]:noti("Chowasz torbe szyn Kramera", client)
	end
end)

function postawtorbe(gracz)
	unbindKey(gracz, "z", "down", postawtorbe)
	setPedAnimation(gracz, "CAMERA", "camstnd_to_camcrch", -1, false, false )
	setElementData(gracz, "torbawreku", false)
	setTimer(function()
		destroyElement(getElementData(gracz, "torba"))
		setElementData(gracz, "torba", false)
		local rotx, roty, rotz = getElementRotation(gracz)
		local torba = createObject(1210, 0, 0, 0)
		attachElements(torba, gracz, 0, 0.5, -0.8, 0, 0, rotz)
		detachElements(torba, gracz)
		setElementRotation(torba, 0, 0, rotz)
		setPedAnimation(gracz, false)
		local x, y, z = getElementPosition(torba)
		cuboid = createColSphere(x, y, z, 1)
		setElementData(cuboid, "torba", torba)
		addEventHandler("onColShapeHit", cuboid, function(hit)
			if getElementData(hit, "frakcja:sluzba") ~= frakcja then return end
			if getElementData(hit, "torbawreku") then return end
			destroyElement(getElementData(source, "torba"))
			destroyElement(source)
			bindKey(hit, "z", "down", postawtorbe)
			local torba = createObject(1210, 0, 0, 0)
			exports.bone_attach:attachElementToBone(torba, hit, 12, 0, 0.05, 0.27, 0, 180, 90)
			setElementData(hit, "torbawreku", true)
			setElementData(hit, "torba", torba)
			exports["smta_base_notifications"]:noti("Podnosisz torbe R1", hit)
		end)
	end, 700, 1)
end

function postawszyny(gracz)
	unbindKey(gracz, "z", "down", postawszyny)
	setPedAnimation(gracz, "CAMERA", "camstnd_to_camcrch", -1, false, false )
	setElementData(gracz, "szynywreku", false)
	setTimer(function()
		destroyElement(getElementData(gracz, "szyna"))
		setElementData(gracz, "szyna", false)
		local rotx, roty, rotz = getElementRotation(gracz)
		local szyna = createObject(2880, 0, 0, 0)
		attachElements(szyna, gracz, 0, 0.5, -0.8, 0, 0, rotz)
		detachElements(szyna, gracz)
		setElementRotation(szyna, 0, 0, rotz)
		setPedAnimation(gracz, false)
		local x, y, z = getElementPosition(szyna)
		cuboid = createColSphere(x, y, z, 1)
		setElementData(cuboid, "szyna", szyna)
		addEventHandler("onColShapeHit", cuboid, function(hit)
			if getElementData(hit, "frakcja:sluzba") ~= frakcja then return end
			if getElementData(hit, "szynywreku") then return end
			destroyElement(getElementData(source, "szyna"))
			destroyElement(source)
			bindKey(hit, "z", "down", postawszyny)
			local szyna = createObject(2880, 0, 0, 0)
			exports.bone_attach:attachElementToBone(szyna, hit, 12, 0, 0.05, 0.27, 0, 180, 90)
			setElementData(hit, "szynywreku", true)
			setElementData(hit, "szyna", szyna)
			exports["smta_base_notifications"]:noti("Podnosisz torbe szyne ", hit)
		end)
	end, 700, 1)
end


addEvent("dajSpray:"..frakcja.."", true)
addEventHandler("dajSpray:"..frakcja.."", root, function()
	giveWeapon(client, 41, 9999)
end)

--przebieralnia

local skiny = {
    {274, 1602.92, 1722.63, -33.73, "Pielęgniarz", 1},
    {275, 1602.80, 1726.14, -33.73, "Medyk", 1},
	{70, 1607.05, 1727.84, -33.73, "Doktor", 1},
	{276, 1611.25, 1726.92, -33.73, "Ratownik", 1},
}
     
for i, v in ipairs(skiny) do
    local marker = createMarker(v[2], v[3], v[4], "cylinder", 1, 251, 206, 177, 50)
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