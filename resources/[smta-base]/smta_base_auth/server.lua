--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--
local haslo2 = false
local haslo3 = false

addEvent("zaloguj", true)
addEventHandler("zaloguj", root, function(login, haslo)
	haslo = escapeStrings(haslo)
	login = escapeStrings(login)
	haslo2 = haslo
	local spr = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE login=? AND haslo=?", login, haslo)
	if #spr > 1 then
		exports["smta_base_notifications"]:noti("Konto o takim loginie nie istnieje.", client, "error")
	return
	end
	if #spr < 1 then
		exports["smta_base_notifications"]:noti("Podałeś błędne hasło.", client, "error")
	return
	end

	local serial = getPlayerSerial(client)
	if spr[1].serial ~= serial then
		tak=true
		for i,v in ipairs(split(spr[1].whitelist,",")) do
			if v == serial then tak = false end
		end
		if tak then
			triggerClientEvent(client, "zmienPowiadomienie", client, "Nie możesz zalogować się na to konto")
		return
		end
	end

	for _, p in ipairs(getElementsByType("player")) do
		if getElementData(p, "dbid") == spr[1].dbid then
				exports["smta_base_notifications"]:noti("Niestety ale ktoś jest zalogowany na podanym koncie.", client, "error")
			return
		end
	end
	local konto = getAccount(login, haslo2)
	if konto then
		logIn(client, konto, haslo2)
	end
	local spr = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE login=?", login)
	triggerEvent("addOsiagnieciaNew", client, spr[1].dbid)
	triggerClientEvent(client, "usunElementyLogowania", root, "false")
	wczytajDane(client, login)
end)

addEvent("zarejestruj", true)
addEventHandler("zarejestruj", root, function(login, haslo)
	haslo = escapeStrings(haslo)
	login = escapeStrings(login)
	local sprxd = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE serial=?", getPlayerSerial(client))
    if sprxd and #sprxd >= 2 then
       	exports["smta_base_notifications"]:noti("Posiadasz już maksymalną ilość kont na tym serialu (2).", client, "error")
    	return 
	end
	local spr = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE login=?", login)
	if #spr > 0 then
		exports["smta_base_notifications"]:noti("Konto o kombinacji loginu już istnieje.", client, "error")
	return
	end
	local wyk = exports['smta_base_db']:wykonaj("INSERT INTO smtadb_accounts SET login=?, haslo=?, serial=?, rejestracja=NOW(), najedzenie=100, kasa=500", login, haslo, getPlayerSerial(client))
	if wyk then
		local konto = getAccount(login, haslo2)
		if konto then
			logIn(client, konto, haslo2)
		end
		wczytajDane(client, login)
		triggerClientEvent(client, "usunElementyLogowania", root, "true")
		local spr = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE login=?", login)
		triggerEvent("addOsiagnieciaNew", client, spr[1].dbid)
	end
end)

addEvent("spawn", true)
addEventHandler("spawn", root, function(l, x, y, z)
	if not l then return end
	if l == "spawn" then
		spawnPlayer(client, -1806.74, 533.36, 35.17, 0, getElementData(client, "skin"), 0)
	elseif l == "przecho" then
		spawnPlayer(client, -2095.40, -23.39, 35.32, 270, getElementData(client, "skin"), 0)
	elseif l == "pozi" then
		local spr = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE dbid=?", getElementData(client, "dbid"))
		if spr[1].pos:len() > 1 then
			local pozycja = split(spr[1].pos, ",")
			local x2, y2, z2 = pozycja[1], pozycja[2], pozycja[3]
			spawnPlayer(client, x2, y2, z2, 0, getElementData(client, "skin"), 0)
			setElementDimension(client, (pozycja[4] or 0))
			setElementInterior(client, (pozycja[5] or 0))
		else
			spawnPlayer(client, -1806.74, 533.36, 35.17, 0, getElementData(client, "skin"), 0)
		end
	elseif l == "dom" then
		spawnPlayer(client, x, y, z, 0, getElementData(client, "skin"), 0)
	elseif l == "lv" then
		spawnPlayer(client, 2027.92, 1007.99, 10.82, 270, getElementData(client, "skin"), 0)
	end
	setElementData(client, "zalogowany", true)
	setCameraTarget(client, client)
	toggleControl(client, "fire", false)
	toggleControl(client, "aim_weapon", false)
	setPlayerHudComponentVisible(client, "all", true)
	setPlayerHudComponentVisible(client, "money", false)
	setPlayerHudComponentVisible(client, "area_name", false)
	setPlayerHudComponentVisible(client, "ammo", false)
	setPlayerHudComponentVisible(client, "armour", false)
	setPlayerHudComponentVisible(client, "clock", false)
	setPlayerHudComponentVisible(client, "health", false)
	setPlayerHudComponentVisible(client, "radio", false)
	setPlayerHudComponentVisible(client, "breath", false)
	setPlayerHudComponentVisible(client, "weapon", false)
	setPlayerHudComponentVisible(client, "radar", false)
	setPlayerHudComponentVisible(client, "crosshair", true)
	executeCommandHandler("showradar", client)
end)

function getHouses(id)
	local domki = exports['smta_base_db']:wykonaj("select * from smtadb_houses where owner=? and (NOT data=?)", id, id, "0000-00-00")
	return domki
end

function wczytajDane(p, l)
	if not p and not l then return end
	local spr = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE login=?", l)
	setPlayerName(p, spr[1].login)
	setElementData(p, "dbid", spr[1].dbid)
	setElementData(p, "pieniadze", spr[1].kasa)
	setElementData(p, "brudne:pieniadze", spr[1].brudnakasa)
	setElementData(p, "punkty", spr[1].punkty)
	setElementData(p, "bankomat", string.format("%1d", spr[1].bkasa))
	setElementData(p, "online", spr[1].online)
	setElementData(p, "rejestracja", spr[1].rejestracja)
	setElementData(p, "prawko_a", spr[1].prawko_a)
	setElementData(p, "prawko_b", spr[1].prawko_b)
	setElementData(p, "prawko_c", spr[1].prawko_c)
	setElementData(p, "oranga", spr[1].orank)
	setElementData(p, "skin", spr[1].skin)
    setElementData(p, "sluzba", spr[1].wyplata)
    setElementData(p, "najedzenie", spr[1].najedzenie)
    setElementData(p, "warny", spr[1].warny)
    setElementData(p, "przynety", spr[1].przynety)
    setElementData(p, "pp", spr[1].pp)
    setElementData(p, "odkryl_grob", spr[1].odkryl_grob);
    --magazynier
    setElementData(p, "mpunkty", spr[1].mpunkty)
    setElementData(p, "mskrzynki", spr[1].mskrzynki)
    setElementData(p, "magazynier:ulepszenie1", spr[1].mulepszenie1)
    setElementData(p, "magazynier:ulepszenie2", spr[1].mulepszenie2)
    setElementData(p, "magazynier:ulepszenie3", spr[1].mulepszenie3)
    --kurier
    setElementData(p, "kpunkty", spr[1].kpunkty)
    setElementData(p, "kzlecenia", spr[1].kzlecenia)
    setElementData(p, "kurier:ulepszenie1", spr[1].kulepszenie1)
    setElementData(p, "kurier:ulepszenie2", spr[1].kulepszenie2)
    setElementData(p, "kurier:ulepszenie3", spr[1].kulepszenie3)
    --farma
    setElementData(p, "fpunkty", spr[1].fpunkty)
    setElementData(p, "fzlecenia", spr[1].fzlecenia)
    setElementData(p, "farma:ulepszenie1", spr[1].fulepszenie1)
    setElementData(p, "farma:ulepszenie2", spr[1].fulepszenie2)
    setElementData(p, "farma:ulepszenie3", spr[1].fulepszenie3)
    --smieciarki
    setElementData(p, "spunkty", spr[1].spunkty)
    setElementData(p, "szlecenia", spr[1].szlecenia)
    setElementData(p, "smieciarki:ulepszenie1", spr[1].sulepszenie1)
    setElementData(p, "smieciarki:ulepszenie2", spr[1].sulepszenie2)
    setElementData(p, "smieciarki:ulepszenie3", spr[1].sulepszenie3)
    setElementData(p, "smieciarki:ulepszenie4", spr[1].sulepszenie4)
    --kosiarki
    setElementData(p, "kospunkty", spr[1].kospunkty)
    setElementData(p, "koszlecenia", spr[1].koszlecenia)
    setElementData(p, "kosiarki:ulepszenie1", spr[1].sulepszenie1)
    setElementData(p, "kosiarki:ulepszenie2", spr[1].sulepszenie2)
    --kopalnia
    setElementData(p, "kopwykopania", spr[1].kopwykopania)
    setElementData(p, "koppunkty", spr[1].koppunkty)
    setElementData(p, "kopalnia:ulepszenie1", spr[1].kopulepszenie1)
    setElementData(p, "kopalnia:ulepszenie2", spr[1].kopulepszenie2)
    --autobusy
    setElementData(p, "azlecenia", spr[1].azlecenia)
    setElementData(p, "apunkty", spr[1].apunkty)
    setElementData(p, "autobusy:ulepszenie1", spr[1].aulepszenie1)
	setElementData(p, "autobusy:ulepszenie2", spr[1].aulepszenie2)
	--weed
	setElementData(p, "weed1", spr[1].weed1)
    setElementData(p, "weed2", spr[1].weed2)
	
	setElementData(p, "meta1", spr[1].meta1)
	setElementData(p, "meta2", spr[1].meta2)

	setElementData(p, "koka1", spr[1].koka1)
    setElementData(p, "koka2", spr[1].koka2)

    setElementData(p, "block:prawko", false)

	-- Organizacje
	--[[
    local guild_query = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_clubs_members, smtadb_clubs WHERE smtadb_clubs_members.user=? AND smtadb_clubs_members.guild = smtadb_clubs.uid", spr[1].dbid);
    if guild_query and #guild_query > 0 then
    	setElementData(p, "organizacja", {
    		name = guild_query[1].name,
    		dbid = guild_query[1].guild,
    		isleader = guild_query[1].isleader,
    		rank = guild_query[1].rank
    	});
	end
	--]]
	
	local guild_query = exports['smta_base_db']:wykonaj("select * from smtadb_organizations where id=?", spr[1].org)
	if #guild_query > 0 then
		setElementData(p, "oname", guild_query[1].organizacja)
		setElementData(p, "odata", guild_query)
	end

	--[[
	local guild_query = exports["smta_base_db"]:wykonaj("select * from smtadb_organizations where id=?", spr[1].id)
	if guild_query and #guild_query > 0 then
		setElementData(p, "oname", guild_query[1].organizacja)
		setElementData(p, "odata", guild_query[1].organizacja)
	end
	--]]


    -- Hydraulik
    local hydraulik_query = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_jobs_stats WHERE gracz=? AND praca='hydraulik'", spr[1].dbid);
    if hydraulik_query and #hydraulik_query > 0 then
	    setElementData(p, "hydraulik:stats", {
	    	done = hydraulik_query[1].ukonczono,
	    	points = hydraulik_query[1].punkty,
	    	upgrades = fromJSON(hydraulik_query[1].ulepszenia)
	    }, false);

	    if getPlayerName(p) == "madvalue" then
	    	outputConsole( toJSON(getElementData(p, "hydraulik:stats")) );
		end
	end

    --[[local value_njq = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_jobs_stats WHERE gracz=?", spr[1].dbid);
    for i,v in ipairs(value_njq) do
    	setElementData(p, v.praca .. ":stats", {
    		done = v.ukonczono,
    		points = v.punkty,
    		v.upgrades = fromJSON(v.ulepszenia)
    	}, false);

    	if getPlayerName(p) == "madvalue" then
	    	outputConsole( toJSON(getElementData(p, "hydraulik:stats")) );
		end
    end]]



    local sprprawko = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE serial=? AND data>NOW()", getPlayerSerial(p))
	if #sprprawko > 0 then
		outputChatBox("Posiadasz zawieszone prawo jazdy kat. A,B,C od "..sprprawko[1].admin.." do "..sprprawko[1].data, p, 255, 0, 0)
		setElementData(p, "block:prawko", true)
	else
		exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_licences WHERE serial=?", getPlayerSerial(p))
		setElementData(p, "block:prawko", false)
	end

    local frakcje = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_factions WHERE dbid=?", spr[1].dbid)
    if #frakcje > 0 then
    	setElementData(p, "frakcja", frakcje[1].frakcja)
    	setElementData(p, "frakcja:wyplata", frakcje[1].wyplata)
    end

    local sprPREMIUM = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_accounts WHERE dbid=? AND premium<NOW()", spr[1].dbid)
	
	if sprPREMIUM and #sprPREMIUM > 0 and sprPREMIUM[1]["premium"] ~= "0000-00-00" then
			outputChatBox("Twoje konto diamond wygasło.", p, 200, 0, 0)
			exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET premium=? WHERE dbid=?", "0000-00-00", spr[1].dbid)
		return
	end
	
	if spr[1].premium ~= "0000-00-00" then
		setElementData(p, "premium", true)
		setElementData(p, "premium_czas", 0)
		outputChatBox("Twoje konto diamond jest aktywne do: "..spr[1].premium, p, 185, 242, 255)
	end
	local domki = getHouses(spr[1].dbid)
	triggerClientEvent(p, "pokaz:domki", root, domki)
end

addEventHandler("onPlayerQuit", root, function()
	if getElementData(source, "dbid") then
		local kasa = getElementData(source, "pieniadze")
		local brudnakasa = getElementData(source, "brudne:pieniadze")
		local online = tonumber(getElementData(source, "online")) or 0
		local dbid = getElementData(source, "dbid")
		local pkt = getElementData(source, "punkty")
		local skin = getElementData(source, "skin")
		local x, y, z = getElementPosition(source)
		local dim = getElementDimension(source)
		local int = getElementInterior(source)
		local pos = x..", "..y..", "..z..", "..dim..", "..int
        local wyplata = getElementData(source, "sluzba")
        local najedzenie = getElementData(source, "najedzenie") or 1
        local warny = getElementData(source, "warny")
        local bkasa = getElementData(source, "bankomat") or 0
        local przynety = getElementData(source, "przynety") or 0
        local pp = getElementData(source, "pp") or 0
        zapiszPrace(source)
		local wyk = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET kasa=?, brudnakasa=?, online=?, punkty=?, skin=?, pos=?, wyplata=?, najedzenie=?, warny=?, bkasa=?, przynety=?, pp=? WHERE dbid=?", kasa, brudnakasa, online, pkt, skin, pos, wyplata, najedzenie, warny, bkasa, przynety, pp, dbid)
		if not wyk then
			outputDebugString("Nie udalo sie zapisac gracza o dbid "..dbid)
		end
	end
end)

function zapiszPrace(gracz)
	local dbid = getElementData(gracz, "dbid") or 0
	--magazyn
	local mpunkty = getElementData(gracz, "mpunkty") or 0
	local mulepszenie1 = getElementData(gracz, "magazynier:ulepszenie1") or 0
	local mulepszenie2 = getElementData(gracz, "magazynier:ulepszenie2") or 0
	local mulepszenie3 = getElementData(gracz, "magazynier:ulepszenie3") or 0
	--kurier
	local kpunkty = getElementData(gracz, "kpunkty") or 0
	local kulepszenie1 = getElementData(gracz, "kurier:ulepszenie1") or 0
	local kulepszenie2 = getElementData(gracz, "kurier:ulepszenie2") or 0
	local kulepszenie3 = getElementData(gracz, "kurier:ulepszenie3") or 0
	--farma
	local fpunkty = getElementData(gracz, "fpunkty") or 0
	local fulepszenie1 = getElementData(gracz, "farma:ulepszenie1") or 0
	local fulepszenie2 = getElementData(gracz, "farma:ulepszenie2") or 0
	local fulepszenie3 = getElementData(gracz, "farma:ulepszenie3") or 0
	--smieciarki
	local spunkty = getElementData(gracz, "spunkty") or 0
	local sulepszenie1 = getElementData(gracz, "smieciarki:ulepszenie1") or 0
	local sulepszenie2 = getElementData(gracz, "smieciarki:ulepszenie2") or 0
	local sulepszenie3 = getElementData(gracz, "smieciarki:ulepszenie3") or 0
	local sulepszenie4 = getElementData(gracz, "smieciarki:ulepszenie4") or 0
	--kosiarki
	local kospunkty = getElementData(gracz, "kospunkty") or 0
	local kosulepszenie1 = getElementData(gracz, "kosiarki:ulepszenie1") or 0
	local kosulepszenie2 = getElementData(gracz, "kosiarki:ulepszenie2") or 0
	--kopalnia
	local koppunkty = getElementData(gracz, "koppunkty") or 0
	local kopulepszenie1 = getElementData(gracz, "kopalnia:ulepszenie1") or 0
	local kopulepszenie2 = getElementData(gracz, "kopalnia:ulepszenie2") or 0
	--autobusy
	local apunkty = getElementData(gracz, "apunkty") or 0
	local aulepszenie1 = getElementData(gracz, "autobusy:ulepszenie1") or 0
	local aulepszenie2 = getElementData(gracz, "autobusy:ulepszenie2") or 0
	--weed
	local weed1 = getElementData(gracz, "weed1") or 0
	local weed2 = getElementData(gracz, "weed2") or 0
	
	local meta1 = getElementData(gracz, "meta1") or 0
	local meta2 = getElementData(gracz, "meta2") or 0

	local koka1 = getElementData(gracz, "koka1") or 0
	local koka2 = getElementData(gracz, "koka2") or 0

	local wyk = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET mpunkty=?, mulepszenie1=?, mulepszenie2=?, mulepszenie3=?, kpunkty=?, kulepszenie1=?, kulepszenie2=?, kulepszenie3=?, fpunkty=?, fulepszenie1=?, fulepszenie2=?, fulepszenie3=?, spunkty=?, sulepszenie1=?, sulepszenie2=?, sulepszenie3=?, sulepszenie4=?, kospunkty=?, kosulepszenie1=?, kosulepszenie2=?, koppunkty=?, kopulepszenie1=?, kopulepszenie2=?, apunkty=?, aulepszenie1=?, aulepszenie2=?, weed1=?, weed2=?, meta1=?, meta2=?, koka1=?, koka2=? WHERE dbid=?", mpunkty, mulepszenie1, mulepszenie2, mulepszenie3, kpunkty, kulepszenie1, kulepszenie2, kulepszenie3, fpunkty, fulepszenie1, fulepszenie2, fulepszenie3, spunkty, sulepszenie1, sulepszenie2, sulepszenie3, sulepszenie4, kospunkty, kosulepszenie1, kosulepszenie2, koppunkty, kopulepszenie1, kopulepszenie2, apunkty, aulepszenie1, aulepszenie2, weed1, weed2, meta1, meta2, koka1, koka2, dbid)
	if not wyk then
		outputDebugString("Nie udalo sie zapisac postepu prac u pid "..dbid)
	end
end

function data()
	local t = getRealTime()
	local r = t.year
	local m = t.month
	local t = t.monthday
	r = r+1900
	m = m+1
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local c = hours..":"..minutes
	return r.."-"..m.."-"..t.." "..c
end

addEvent("sprawdzBana", true)
addEventHandler("sprawdzBana", root, function()
	local g = source
	local serial = getPlayerSerial(g)
	local spr = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_bans WHERE serial=? AND data>NOW()", serial)
	if #spr > 0 then
		triggerClientEvent(g, "oknoZbanowany", root, g, spr[1].ip, spr[1].serial, spr[1].data, spr[1].admin, spr[1].nick, spr[1].powod)
		triggerClientEvent(g, "bShowedLogin", root)
	else
		exports['smta_base_db']:wykonaj("DELETE FROM smtadb_bans WHERE serial=?", serial)
	end
end)

addEvent("banWyrzuc", true)
addEventHandler("banWyrzuc", root, function()
	kickPlayer(source, "Zostałeś zbanowany na tym serwerze!")
end)

function getKoncowka(time, k1, k2, k3)
	if time == 0 then
		return k1
	elseif time == 1 then
		return k2
	else
		return k3
	end
end

function escapeStrings(str)
 local String = string.gsub(tostring(str),"'","")
 String = string.gsub(String,'"',"")
 String = string.gsub(String,';',"")
 String = string.gsub(String,"\\","")
 String = string.gsub(String,"/*","")
 String = string.gsub(String,"*/","")
 String = string.gsub(String,"'","")
 String = string.gsub(String,"`","")
 String = string.gsub(String," ","")
 return String
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second

    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end

    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function data()
	local t = getRealTime()
	local r = t.year
	local m = t.month
	local t = t.monthday
	r = r+1900
	m = m+1
	if t < 10 then
		t = "0"..t
	end
	return r.."-"..m.."-"..t
end

function czas()
	local t = getRealTime()
	local h = t.hour
	local m = t.minute
	return h..":"..m
end