--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local discordczas = getRealTime()
local forbidden = {"4life", "pylife", "pyl", "newplace", "new", "place"};
--local forbidden = {"cholera", "cholernie", "spierdalaj", "jebac", "pizda", "pierdolona", "pierdolony", "wypierdalaj", "wypierdalam", "wypierdalamy", "wypierdala", "wypierdalają", "chuj", "chujowo", "chujnia", "huj", "hujowo", "hujnia", "chujostwo", "hujostwo", "chuje", "huje", "ciota", "cipa", "ciul", "cwel", "kurwa", "kurwy", "kurwo", "zjeb", "zjebie", "zjebało", "zajebał", "zjebał", "zjebała", "zajebało", "jebany", "zajebała", "pierdolić", "pierdole", "pierdolę", "zajebala", "pierdolic"};

function checkForBadWords(message)
	for k,v in ipairs(forbidden) do
		local fakeMessage = utf8.lower(message);
		local startPosition, endPosition = utf8.find(fakeMessage, v);
		if startPosition and endPosition then
			local word = utf8.sub(message, startPosition, endPosition);
			message = utf8.gsub(message, word, string.rep("*", word:len()));
		end
	end
	return message;
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

addCommandHandler("getdata", function(gracz, _, jaka)
	if getElementData(gracz, "duty") ~= 4 then return end
	if not jaka then return end
	if not getElementData(gracz, jaka) then outputChatBox("Nie posiadasz takiej eldaty", gracz, 255, 0, 0) return end
	tekst = getElementData(gracz, jaka)
	if getElementData(gracz, jaka) == false then tekst = "false" end
	if getElementData(gracz, jaka) == true then tekst = "true" end
	outputChatBox("[GET] "..jaka..": "..tekst, gracz, 0, 255, 0)
end)

addCommandHandler("setdata", function(gracz, _, jaka, wartosc)
	if getPlayerSerial(gracz) == "F5686A30BDBAB03643105204222F28F3" then
	if not jaka or not wartosc then return end
	if getElementData(gracz, jaka) then
		outputChatBox("[SET] "..jaka..": "..getElementData(gracz, jaka).." > "..wartosc, gracz, 0, 255, 0)
	else
		outputChatBox("[SET] "..jaka..": "..wartosc, gracz, 0, 255, 0)
	end
	setElementData(gracz, jaka, wartosc)
	end
end)

addCommandHandler("sa", function(gracz)
	--if getElementData(gracz, "duty") < 0 then return end
	outputChatBox(getPlayerName(gracz).." - zapisano graczy.", gracz, 0, 150, 50)
	for i,v in ipairs(getElementsByType("player")) do
	if getElementData(v, "dbid") then
		local kasa = getElementData(v, "pieniadze")
		local brudnakasa = getElementData(v, "brudne:pieniadze")
		local online = tonumber(getElementData(v, "online"))
		local dbid = getElementData(v, "dbid")
		local pkt = getElementData(v, "punkty")
		local skin = getElementData(v, "skin")
		local x, y, z = getElementPosition(v)
		local pos = x..", "..y..", "..z
        local wyplata = getElementData(v, "sluzba")
        local najedzenie = getElementData(v, "najedzenie") or 1
        local warny = getElementData(v, "warny")
        local bkasa = getElementData(v, "bankomat") or 0
        zapiszPrace(v)
		local wyk = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET kasa=?, brudnakasa=?, online=?, punkty=?, skin=?, pos=?, wyplata=?, najedzenie=?, warny=?, bkasa=? WHERE dbid=?", kasa, brudnakasa, online, pkt, skin, pos, wyplata, najedzenie, warny, bkasa, dbid)
		if not wyk then
			outputDebugString("SMTA_BASE_CORE - Nie udalo sie zapisac gracza o pid: "..dbid)
		end
	end
end
end)

setTimer(function(gracz)
	--if getElementData(gracz, "duty") < 0 then return end
	--outputChatBox(getPlayerName(gracz)..".", gracz, 0, 150, 50)
	outputDebugString("SMTA_BASE_CORE/SAVE - Zapisano graczy")
	for i,v in ipairs(getElementsByType("player")) do
	if getElementData(v, "dbid") then
		local kasa = getElementData(v, "pieniadze")
		local brudnakasa = getElementData(v, "brudne:pieniadze")
		local online = tonumber(getElementData(v, "online"))
		local dbid = getElementData(v, "dbid")
		local pkt = getElementData(v, "punkty")
		local skin = getElementData(v, "skin")
		local x, y, z = getElementPosition(v)
		local pos = x..", "..y..", "..z
        local wyplata = getElementData(v, "sluzba")
        local najedzenie = getElementData(v, "najedzenie") or 1
        local warny = getElementData(v, "warny")
		local bkasa = getElementData(v, "bankomat") or 0
		local weed1 = getElementData(v, "weed1") or 0
		local weed2 = getElementData(v, "weed2") or 0
		local meth1 = getElementData(v, "meta1") or 0
		local meth2 = getElementData(v, "meta2") or 0
		local coca1 = getElementData(v, "koka1") or 0
		local coca2 = getElementData(v, "koka2") or 0
		local lvlpkt = getElementData(v, "level") or 0
		local lvl = getElementData(v, "levelpkt") or 0
        zapiszPrace(v)
		local wyk = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET kasa=?, brudnakasa=?, online=?, punkty=?, skin=?, pos=?, wyplata=?, najedzenie=?, warny=?, bkasa=?, weed1=?, weed2=?, meta1=?, meta2=?, koka1=?, koka2=?, level=?, levelpkt=? WHERE dbid=?", kasa, brudnakasa, online, pkt, skin, pos, wyplata, najedzenie, warny, bkasa, weed1, weed2, meth1, meth2, coca1, coca2, level, levelpkt, dbid)
		if not wyk then
			outputDebugString("SMTA_BASE_CORE - Nie udalo sie zapisac gracza o pid: "..dbid)
		end
	end
end
end, 10000, 0)

addCommandHandler("rozdajall", function(gracz, _, ilosc)
	if getElementData(gracz, "duty") ~= 4 then return end
	outputChatBox(getPlayerName(gracz).." dał każdemu "..ilosc.." $", root, 255, 0, 0)
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v, "dbid") then
			setElementData(v, "pieniadze", getElementData(v, "pieniadze")+ilosc)
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
	--tramwaj
	local trampkt = getElementData(gracz, "apunkty") or 0
	local tramulepszenie1 = getElementData(gracz, "autobusy:ulepszenie1") or 0
	local tramulepszenie2 = getElementData(gracz, "autobusy:ulepszenie2") or 0

	local wyk = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET mpunkty=?, mulepszenie1=?, mulepszenie2=?, mulepszenie3=?, kpunkty=?, kulepszenie1=?, kulepszenie2=?, kulepszenie3=?, fpunkty=?, fulepszenie1=?, fulepszenie2=?, fulepszenie3=?, spunkty=?, sulepszenie1=?, sulepszenie2=?, sulepszenie3=?, sulepszenie4=?, kospunkty=?, kosulepszenie1=?, kosulepszenie2=?, apunkty=?, aulepszenie1=?, aulepszenie2=? WHERE dbid=?", mpunkty, mulepszenie1, mulepszenie2, mulepszenie3, kpunkty, kulepszenie1, kulepszenie2, kulepszenie3, fpunkty, fulepszenie1, fulepszenie2, fulepszenie3, spunkty, sulepszenie1, sulepszenie2, sulepszenie3, sulepszenie4, kospunkty, kosulepszenie1, kosulepszenie2, trampkt, tramulepszenie1, tramulepszenie2, dbid)
	if not wyk then
		outputDebugString("SMTA_BASE_CORE - Nie udalo sie zapisac postepu prac u pid: "..dbid)
	end
end

function czas()
	local t = getRealTime()
	local h = t.hour
	local m = t.minute
	return h..":"..m
end

addEventHandler("onVehicleStartEnter", root, function(g, s)
	if s ~= 0 then return end
	if getVehicleController(source) and getVehicleController(source) ~= g then
		cancelEvent()
	end
end)

addEvent("kick:spamer", true)
addEventHandler("kick:spamer", root, function()
	kickPlayer(client, "Spam myszką (autoclicker)")
end)

addEventHandler("onPlayerCommand", root, function(c)
	if not getElementData(source, "zalogowany") then
		if c == "Toggle" then return end
		cancelEvent()
	end
end)

local commandSpam = {}

addEventHandler("onPlayerCommand", root, function()
	if (not commandSpam[source]) then
		commandSpam[source] = 1
	elseif (commandSpam[source] == 7) then
	    cancelEvent()
        kickPlayer(source, "Console", "Spam komendami")
	else
		commandSpam[source] = commandSpam[source] + 1
	end
end)
setTimer(function() commandSpam = {} end, 1000, 0)

antiSpam = {}
function antiChatSpam()
if getElementData(source, "user:mute") then return end
	if isTimer(antiSpam[source]) then
		cancelEvent()
		setElementData(source, "user:mute",true)
		setTimer ( autoUnmute, 500, 1, source)
	else
		antiSpam[source] = setTimer(function(source) antiSpam[source] = nil end, 1000, 1, source)
	end
end
addEventHandler("onPlayerChat", root, antiChatSpam)

function autoUnmute ( player,plr,... )
	if getElementData(player, "user:mute") then
		setElementData(player, "user:mute",false)
	end
end

addEventHandler("onResourceStart", resourceRoot, function()
	setGameType("RP / RPG")
	setRuleValue("gamemode", "Society MTA")
	setRuleValue("author", "Vogel")
	setMaxPlayers(200)
	local time = getRealTime()
	setTime(time.hour, time.minute)
	setMinuteDuration(60000)
end)

addEventHandler("onPlayerWasted", root, function()
	if getElementData(source, "bijewringu") then return end
	if getElementData(source, "strefadm") then return end
	triggerClientEvent(source, "oknoNieprzytomnosci", source)
end)

addEvent("zrespZmarlego", true)
addEventHandler("zrespZmarlego", root, function()
	local skin = getElementData(source, "skin")
	local x, y, z = getElementPosition(source)
	spawnPlayer(source, x, y, z, 0, skin, 0, 0)
end)

function idRanga(g)
  local ranga = getElementData(g, "duty")
  local premium = getElementData(g, "premium")
  if ranga then
	return getElementData(g, "hex")
  end
  if premium then
    return "#b9f2ff"
  else
    return "#939393"
  end
end

addEventHandler("onPlayerChat", root, function(wiadomosc, typ)
	if typ == 0 then
		cancelEvent()
		if getElementData(source, "user:mute") then return end
		if getElementData(source, "bw") then exports["smta_base_notifications"]:noti("Jesteś nieprzytomny nie możesz pisać na czacie.", source, "error") return end
		local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(source))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, source, 255, 0, 0)
			setElementData(source, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(source))
			setElementData(source, "mute", false)
		end
		if getElementData(source, "mute") then return end
		local nick = getPlayerName(source)
		local id = getElementData(source, "id") or 0
		local kolor = idRanga(source)
		local frakcja = getElementData(source, "frakcja:sluzba") or ""
		--local adm = getElementData(source, "ranga")
		if frakcja == "SAPD" then
			finfo = "#0000ffSAPD#ffffff"
		elseif frakcja == "SAMC" then
			finfo = "#0096ffSAMC#ffffff"
		elseif frakcja == "SAFD" then
			finfo = "#ff0000SAFD#ffffff"
		--elseif adm then
			--finfo = "["..getElementData(source, "hex")..""..getElementData(source, "ranga").."#ffffff]"
		else
			finfo = ""
		end
		wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
		local info = ""..nick.." ["..kolor..""..id.."#ffffff] mówi: "..removeColorCodeFromString(wiadomosc)
		local info2 = "SAY> "..nick.." ["..id.."]: "..(wiadomosc)
		triggerClientEvent("dLogi", root, info2)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **LOCAL** "..nick..": "..wiadomosc, "logi-local")
		if finfo ~= "" then
			info = finfo.." "..nick.." ["..kolor..""..id.."#ffffff] mówi: "..removeColorCodeFromString(wiadomosc)
		end
		local posX1, posY1, posZ1 = getElementPosition( source )
		for id, player in ipairs(getElementsByType ( "player" ) ) do
            local posX2, posY2, posZ2 = getElementPosition( player )
			if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= 50 then
                outputChatBox(checkForBadWords(info), player, 255, 255, 255, true)
            end
        end
		--triggerClientEvent("dLogi:czat", root, "SAY", source, wiadomosc)
		--triggerClientEvent(root, "onDebugMessage", resourceRoot, getPlayerName(source)..": "..wiadomosc, 1, "CZAT")
		--setPedAnimation ( source, "GANGS", "prtial_gngtlkG", 2000, false, false )
		--setTimer(function () setPedAnimation(source,false) end,2000,1)
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(source), wiadomosc, getPlayerSerial(source), "CZAT", data().." "..czas())
	elseif typ == 1 then
		cancelEvent()
		local nick = getPlayerName(source)
		local id = getElementData(source, "id") or 0
		local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(source))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, source, 255, 0, 0)
			setElementData(source, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(source))
			setElementData(source, "mute", false)
		end
		if getElementData(source, "mute") then return end
		local x, y, z = getElementPosition(source)
		local cuboid = createColSphere(x, y, z, 50)
		wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
		local wCuboid = getElementsWithinColShape(cuboid, "player")
		local info2 = "ME> "..nick.." ["..id.."]: "..wiadomosc
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **ME** "..nick..": "..wiadomosc, "logi-akcjirp")
		triggerClientEvent("dLogi", root, info2)
		destroyElement(cuboid)
		for _, p in ipairs(wCuboid) do
			local nick = getPlayerName(source)
			wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
			local info = "#4343ffME * "..nick.." "..wiadomosc
			outputChatBox(checkForBadWords(info), p, 255, 255, 255, true)
		end
	end
end)

addCommandHandler("do", function(g, _, ...)
	if not ... then return end
	local nick = getPlayerName(g)
	local id = getElementData(g, "id") or 0
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(g))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, g, 255, 0, 0)
			setElementData(g, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(g))
			setElementData(g, "mute", false)
		end
		if getElementData(g, "mute") then return end
	local wiadomosc = table.concat({...}, " ")
	local x, y, z = getElementPosition(g)
	local cuboid = createColSphere(x, y, z, 50)
	local wCuboid = getElementsWithinColShape(cuboid, "player")		
	local info2 = "DO> "..nick.." ["..id.."]: "..wiadomosc
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **DO** "..nick..": "..wiadomosc, "logi-akcjirp")
	triggerClientEvent("dLogi", root, info2)
	destroyElement(cuboid)
	for _, p in ipairs(wCuboid) do
		local nick = getPlayerName(g)
		wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
		local info = "#8243ffDO * "..checkForBadWords(wiadomosc).." ("..nick..")"
		outputChatBox(info, p, 255, 255, 255, true)
	end
end)

addCommandHandler("ooc", function(g, _, ...)
	if not ... then return end
	local nick = getPlayerName(g)
	local id = getElementData(g, "id") or 0
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(g))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, g, 255, 0, 0)
			setElementData(g, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(g))
			setElementData(g, "mute", false)
		end
		if getElementData(g, "mute") then return end
	local wiadomosc = table.concat({...}, " ")
	local x, y, z = getElementPosition(g)
	local cuboid = createColSphere(x, y, z, 50)
	local wCuboid = getElementsWithinColShape(cuboid, "player")	
	wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
	local info2 = "OOC> "..nick.." ["..id.."]: "..wiadomosc
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **OOC** "..nick..": "..wiadomosc, "logi-local")
	triggerClientEvent("dLogi", root, info2)
	destroyElement(cuboid)
	for _, p in ipairs(wCuboid) do
		local nick = getPlayerName(g)
		wiadomosc = string.gsub(wiadomosc, "#%x%x%x%x%x%x", "")
		local info = "#969696OOC "..nick..": (("..checkForBadWords(wiadomosc).."))"
		outputChatBox(info, p, 255, 255, 255, true)
	end
end)


function przelej(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przelej <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przelać sobie pieniędzy.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przelać sobie pieniędzy.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "pieniadze")
	local kasa = getElementData(kgracz, "pieniadze")
	if hajs >= ilosc then
		setElementData(gracz, "pieniadze", hajs-ilosc)
		setElementData(kgracz, "pieniadze", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #ffffff"..ilosc2.." $#1566c3 graczowi #ffffff"..getPlayerName(kgracz), gracz, 21, 102, 195, true)
		outputChatBox("✔ Gracz #ffffff"..getPlayerName(gracz).."#1566c3 przekazał ci #ffffff"..ilosc2.." $.", kgracz, 21, 102, 195, true)
		triggerClientEvent("dLogi:przelewy", root, gracz, kgracz, ilosc2)
		triggerClientEvent("dLogi", root, "PRZELEW> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." USD")
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." USD", "logi-transfer")
		--triggerClientEvent("dodajLogi", resourceRoot, getPlayerName(gracz).." > "..getPlayerName(kgracz)..": "..ilosc2.." USD", 1, "PRZELEWY")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." USD", getPlayerSerial(gracz), "Przelew", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff*"..getPlayerName(gracz).." podaje pieniądze człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz wystarczających funduszy.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("dajkase", przelej)
addCommandHandler("zaplac", przelej)
addCommandHandler("przelej", przelej)

function dajbrudne(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przelej.brudne <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie brudnych pieniędzy.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie brudnych pieniędzy.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "brudne:pieniadze")
	local kasa = getElementData(kgracz, "brudne:pieniadze")
	if hajs >= ilosc then
		setElementData(gracz, "brudne:pieniadze", hajs-ilosc)
		setElementData(kgracz, "brudne:pieniadze", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #a32638"..ilosc2.." brudnych $ #a32638graczowi #a32638"..getPlayerName(kgracz), gracz, 163, 38, 56, true)
		outputChatBox("✔ Gracz #a32638"..getPlayerName(gracz).."#a32638 przekazał ci #a32638"..ilosc2.." brudnych $.", kgracz, 163, 38, 56, true)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." brudnych pieniedzy", "logi-transfer")
		triggerClientEvent("dLogi", root, "PRZELEW/BRUDNE$> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." brudnych $")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." brudnych $", getPlayerSerial(gracz), "NARKO", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff*"..getPlayerName(gracz).." podaje brudne pieniądze człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz tyle brudnych pieniedzy.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("przelej.brudne", dajbrudne)

function dajkoke1(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przekaz.coca1 <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie kokainy.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie kokainy.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "koka1")
	local kasa = getElementData(kgracz, "koka1")
	if hajs >= ilosc then
		setElementData(gracz, "koka1", hajs-ilosc)
		setElementData(kgracz, "koka1", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #a32638"..ilosc2.." lisci kokainy #a32638graczowi #a32638"..getPlayerName(kgracz), gracz, 163, 38, 56, true)
		outputChatBox("✔ Gracz #a32638"..getPlayerName(gracz).."#a32638 przekazał ci #a32638"..ilosc2.." lisci kokainy.", kgracz, 163, 38, 56, true)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." KOKAINY", "logi-transfer")
		triggerClientEvent("dLogi", root, "PRZELEW/COCA1> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." kokainy")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." KOKAINY", getPlayerSerial(gracz), "NARKO", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff* "..getPlayerName(gracz).." podaje woreczek z podejrzaną zawartoscią człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz tyle kokainy.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("przekaz.coca1", dajkoke1)

function dajmete1(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przekaz.meth1 <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie metamfetaminy.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie metamfetaminy.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "meta1")
	local kasa = getElementData(kgracz, "meta1")
	if hajs >= ilosc then
		setElementData(gracz, "meta1", hajs-ilosc)
		setElementData(kgracz, "meta1", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #a32638"..ilosc2.." roztworu metamfetaminy #a32638graczowi #a32638"..getPlayerName(kgracz), gracz, 163, 38, 56, true)
		outputChatBox("✔ Gracz #a32638"..getPlayerName(gracz).."#a32638 przekazał ci #a32638"..ilosc2.." roztworu metamfetaminy.", kgracz, 163, 38, 56, true)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." METAMFETAMINY", "logi-transfer")
		triggerClientEvent("dLogi", root, "PRZELEW/METH1> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." metamfetaminy")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." METAMFETAMINY", getPlayerSerial(gracz), "NARKO", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff* "..getPlayerName(gracz).." podaje woreczek z podejrzaną zawartoscią człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz tyle metamfetaminy.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("przekaz.meth1", dajmete1)

function dajweed1(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przekaz.weed1 <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie marichuany.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie marichuany.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "weed1")
	local kasa = getElementData(kgracz, "weed1")
	if hajs >= ilosc then
		setElementData(gracz, "weed1", hajs-ilosc)
		setElementData(kgracz, "weed1", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #a32638"..ilosc2.." lisci marichuany #a32638graczowi #a32638"..getPlayerName(kgracz), gracz, 163, 38, 56, true)
		outputChatBox("✔ Gracz #a32638"..getPlayerName(gracz).."#a32638 przekazał ci #a32638"..ilosc2.." lisci marichuany.", kgracz, 163, 38, 56, true)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." MARICHUANY", "logi-transfer")
		triggerClientEvent("dLogi", root, "PRZELEW/WEED1> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." marichuany")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." MARICHUANY", getPlayerSerial(gracz), "NARKO", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff* "..getPlayerName(gracz).." podaje woreczek z podejrzaną zawartoscią człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz tyle marichuany.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("przekaz.weed1", dajweed1)

function dajkoke2(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przekaz.coca2 <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie kokainy.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie kokainy.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "koka2")
	local kasa = getElementData(kgracz, "koka2")
	if hajs >= ilosc then
		setElementData(gracz, "koka2", hajs-ilosc)
		setElementData(kgracz, "koka2", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #a32638"..ilosc2.." gramów kokainy #a32638graczowi #a32638"..getPlayerName(kgracz), gracz, 163, 38, 56, true)
		outputChatBox("✔ Gracz #a32638"..getPlayerName(gracz).."#a32638 przekazał ci #a32638"..ilosc2.." gramów kokainy.", kgracz, 163, 38, 56, true)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." KOKAINY", "logi-transfer")
		triggerClientEvent("dLogi", root, "PRZELEW/COCA> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." kokainy")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." KOKAINY", getPlayerSerial(gracz), "NARKO", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff* "..getPlayerName(gracz).." podaje woreczek z podejrzaną zawartoscią człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz tyle kokainy.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("przekaz.coca2", dajkoke2)

function dajmete2(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przekaz.meth2 <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie metamfetaminy.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie metamfetaminy.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "meta2")
	local kasa = getElementData(kgracz, "meta2")
	if hajs >= ilosc then
		setElementData(gracz, "meta2", hajs-ilosc)
		setElementData(kgracz, "meta2", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #a32638"..ilosc2.." gramów metamfetaminy #a32638graczowi #a32638"..getPlayerName(kgracz), gracz, 163, 38, 56, true)
		outputChatBox("✔ Gracz #a32638"..getPlayerName(gracz).."#a32638 przekazał ci #a32638"..ilosc2.." gramów metamfetaminy.", kgracz, 163, 38, 56, true)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." METAMFETAMINY", "logi-transfer")
		triggerClientEvent("dLogi", root, "PRZELEW/METH2> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." metamfetaminy")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." METAMFETAMINY", getPlayerSerial(gracz), "NARKO", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff* "..getPlayerName(gracz).." podaje woreczek z podejrzaną zawartoscią człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz tyle metamfetaminy.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("przekaz.meth2", dajmete2)

function dajweed2(gracz, _, kgracz, ilosc)
    if not gracz or not kgracz or not ilosc then
    	exports["smta_base_notifications"]:noti("Poprawne użycie: /przekaz.weed2 <id nick> <kwota>", gracz)
	    return
	end
	kgracz = findPlayer(gracz, kgracz)
	if not kgracz then
    	exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
	    return
	end
	local x, y, z = getElementPosition(gracz)
	local tx, ty, tz = getElementPosition(kgracz)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
	if distance < 10 then
	
	if kgracz == gracz then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie marichuany.", gracz, "error")
		return
	end
	if getElementData(gracz, "dbid") == getElementData(kgracz, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz przekazać sobie marichuany.", gracz, "error")
		return
	end
 	if not tonumber(ilosc) then
   		exports["smta_base_notifications"]:noti("Wprowadzana wartość nie jest liczbą.",gracz)
   		return
  	end
	local ile = tonumber(ilosc)
	if ile == 0 or ile < 0 then
		exports["smta_base_notifications"]:noti("Wpisana wartość musi być większa od 0",gracz)
		return
	end
	
  	ilosc = math.abs(ilosc)
  	ilosc = tonumber(ilosc)
	local hajs = getElementData(gracz, "weed2")
	local kasa = getElementData(kgracz, "weed2")
	if hajs >= ilosc then
		setElementData(gracz, "weed2", hajs-ilosc)
		setElementData(kgracz, "weed2", kasa+ilosc)
        local ilosc2 = string.format("%1d", ilosc)
		outputChatBox("✔ Przekazałeś #a32638"..ilosc2.." gramów marichuany #a32638graczowi #a32638"..getPlayerName(kgracz), gracz, 163, 38, 56, true)
		outputChatBox("✔ Gracz #a32638"..getPlayerName(gracz).."#a32638 przekazał ci #a32638"..ilosc2.." gramów marichuany.", kgracz, 163, 38, 56, true)
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **TRANSFER** "..getPlayerName(gracz).." > "..getPlayerName(kgracz).." : "..ilosc2.." MARICHUANY", "logi-transfer")
		triggerClientEvent("dLogi", root, "PRZELEW/WEED2> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(kgracz).." ["..getElementData(kgracz, "id").."] : "..ilosc2.." marichuany")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." >> "..getPlayerName(kgracz)..": "..ilosc.." MARICHUANY", getPlayerSerial(gracz), "NARKO", data().." "..czas())
		triggerEvent("odegrajRp:eq", gracz, gracz, "#4343ff* "..getPlayerName(gracz).." podaje woreczek z podejrzaną zawartoscią człowiekowi obok.")
	else
		exports["smta_base_notifications"]:noti("Nie posiadasz tyle marichuany.", gracz)
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", gracz, "error")
end
end
addCommandHandler("przekaz.weed2", dajweed2)

function pm(gracz, _, graczhere, ...)
	if not getElementData(gracz, "zalogowany") then return end
	if graczhere and ... then
		local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(gracz))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, gracz, 255, 0, 0)
			setElementData(gracz, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(gracz))
			setElementData(gracz, "mute", false)
		end
		if getElementData(gracz, "mute") then return end
		local tresc = table.concat({...}, " ")
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
			return
		end
		if getElementData(graczhere, "poff") then
			exports["smta_base_notifications"]:noti("Podana osoba posiada wyłączone prywatne wiadomości z powodu "..getElementData(graczhere, "poff"), gracz)
			return
		end
		local idh = getElementData(graczhere, "id")
		local id = getElementData(gracz, "id")
		outputChatBox("#1566c3>>#ffffff "..getPlayerName(graczhere).."#1566c3(#ffffff"..idh.."#1566c3)#ffffff: "..checkForBadWords(tresc), gracz, 255, 255, 255, true)
		outputChatBox("#1566c3<<#ffffff "..getPlayerName(gracz).."#1566c3(#ffffff"..id.."#1566c3)#ffffff: "..checkForBadWords(tresc), graczhere, 255, 255, 255, true)
		triggerClientEvent("dLogi:pmy", root, gracz, graczhere, tresc)
		triggerClientEvent("dLogi", root, "PM> "..getPlayerName(gracz).." ["..getElementData(gracz, "id").."] > "..getPlayerName(graczhere).." ["..getElementData(graczhere, "id").."] : "..tresc.."")
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **PM** "..getPlayerName(gracz).." > "..getPlayerName(graczhere)..": "..tresc, "logi-pm")
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(gracz), getPlayerName(gracz).." > "..getPlayerName(graczhere)..": "..tresc.."", getPlayerSerial(gracz), "PM", data().." "..czas())
	end
end
addCommandHandler("pm", pm)
addCommandHandler("pw", pm)

function pmoff(gracz, _, ...)
	if not getElementData(gracz, "poff") then
		local powod = table.concat({...}, " ")
		if not ... then 
			powod = "brak powodu"
		end
		exports["smta_base_notifications"]:noti("Wyłączyłeś prywatne wiadomości z powodu "..powod, gracz)
		setElementData(gracz, "poff", powod)
	end
end
addCommandHandler("pmoff", pmoff)
addCommandHandler("pwoff", pmoff)

function pmon(gracz, _)
	if getElementData(gracz, "poff") then
		exports["smta_base_notifications"]:noti("Włączyłeś prywatne wiadomości", gracz)
		setElementData(gracz, "poff", false)
	end
end
addCommandHandler("pmon", pmon)
addCommandHandler("pwon", pmon)


function removeColorCodeFromString(str)
	repeat
		local temp = str
		str = string.gsub(str,'#%x%x%x%x%x%x','')
		if str == temp then
			return temp
		end
	until(false)
end

--[[
	System ID graczy
	@author Lukasz Biegaj <wielebny@bestplay.pl>
]]

local function findFreeValue(tablica_id)
	table.sort(tablica_id)
	local wolne_id=1
	for i,v in ipairs(tablica_id) do
		if (v==wolne_id) then wolne_id=wolne_id+1 end
		if (v>wolne_id) then return wolne_id end
	end
	return wolne_id
end

function assignPlayerID(plr)
	local gracze=getElementsByType("player")
	local tablica_id = {}
	for i,v in ipairs(gracze) do
		local lid=getElementData(v, "id")
		if (lid) then
			table.insert(tablica_id, tonumber(lid))
		end
	end
	local free_id=findFreeValue(tablica_id)

	setElementData(plr,"id", free_id)
	setElementID(plr, "p" .. free_id)
	return free_id
end

function getPlayerID(plr)
	if not plr then return "" end
	local id=getElementData(plr,"id")
	if (id) then
		return id
	else
		return assignPlayerID(plr)
	end

end

addEventHandler ("onPlayerJoin", getRootElement(), function()
	assignPlayerID(source)
end)

function pChat(g, _, ...)
	if not getElementData(g, "premium") then return end
	if not ... then
		if getElementData(g, "cpoff") then
			setElementData(g, "cpoff", false)
			exports["smta_base_notifications"]:noti("Włączyłeś czat diamond.", g)
		else
			setElementData(g, "cpoff", true)
			exports["smta_base_notifications"]:noti("Wyłączyłeś czat diamond.", g)
		end
	else
		local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(g))
		if #spr > 0 then
			exports["smta_base_notifications"]:noti("Jesteś wyciszony przez "..spr[1].admin.." do "..spr[1].data, g, "error")
			cancelEvent()
			setElementData(g, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(g))
			setElementData(g, "mute", false)
		end
		if getElementData(g, "mute") then return end
		if getElementData(g, "cpoff") then return end
		local t = table.concat({...}, " ")
		triggerClientEvent("dLogi", root, "D> "..getPlayerName(g).." ["..getElementData(g, "id").."] : "..t.."")
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **DIAMOND** "..getPlayerName(g)..": "..t, "logi-local")
		local hex =  getElementData(g, "hex") or "#ffffff"
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "premium") and not getElementData(v, "cpoff") then
				outputChatBox("D> "..hex..""..getPlayerName(g).."#ffffff: "..removeColorCodeFromString(checkForBadWords(t)), v, 185, 242, 255, true)
			end
		end
	end
end
addCommandHandler("d", pChat)

function dwChat(g, _, ...)
	if not ... then
		if getElementData(g, "dwoff") then
			setElementData(g, "dwoff", false)
			exports["smta_base_notifications"]:noti("Włączyłeś darkweb.", g)
		else
			setElementData(g, "dwoff", true)
			exports["smta_base_notifications"]:noti("Wyłączyłeś darkweb.", g)
		end
	else
		local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(g))
		if #spr > 0 then
			exports["smta_base_notifications"]:noti("Jesteś wyciszony przez "..spr[1].admin.." do "..spr[1].data, g, "error")
			cancelEvent()
			setElementData(g, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(g))
			setElementData(g, "mute", false)
		end
		if getElementData(g, "pieniadze") < 5000 then exports["smta_base_notifications"]:noti("Wiadomosć na darkweb'ie kosztuje 5000$, nie stać Cię.", g) return end
		if getElementData(g, "mute") then return end
		if getElementData(g, "dwoff") then return end
		if getElementData(g, "frakcja:sluzba") == "SAPD" then return end
		setElementData(g, "pieniadze", getElementData(g, "pieniadze")-5000)
		local t = table.concat({...}, " ")
		triggerClientEvent("dLogi", root, "DARKWEB> "..getPlayerName(g).." ["..getElementData(g, "id").."] : "..t.."")
		exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **DARKWEB** "..getPlayerName(g)..": "..t, "logi-local")
		local hex =  getElementData(g, "hex") or "#ffffff"
		for i,v in ipairs(getElementsByType("player")) do
			if not getElementData(v, "dwoff") then
				outputChatBox("DW> *ANONIM*: #741827"..removeColorCodeFromString(checkForBadWords(t)), v, 132, 27, 45, true)
			end
		end
	end
end
addCommandHandler("dw", dwChat)


function krotkofalowkachat(plr, cmd, ...)
	local frakcja = getElementData(plr, "frakcja")
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(plr))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, plr, 255, 0, 0)
			setElementData(plr, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(plr))
			setElementData(plr, "mute", false)
		end
		if getElementData(plr, "mute") then return end
	if not frakcja then return end
	local msg = table.concat ( { ... }, " " )
	triggerClientEvent("dLogi", root, "FRAKCJA/"..frakcja.."> "..getPlayerName(plr).." ["..getElementData(plr, "id").."] : "..msg.."")
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **FRAKCJA** "..getPlayerName(plr).." ["..frakcja.."]: "..msg, "logi-local")

	if string.find(msg, "#", 1) == 1 then
		for i,v in pairs(getElementsByType("player")) do
			if getElementData(v, "frakcja") then
				local msg = string.sub(msg, 2, #msg)
				outputChatBox("#5d8aa8FRAKCJA "..frakcja..">#ffffff "..getPlayerName(plr).." ["..getElementData(plr, "id").."] :#ffffff "..msg, v, 255, 0, 0, true)
			end
		end
	else
		for i,v in pairs(getElementsByType("player")) do
			if getElementData(v, "frakcja") == getElementData(plr, "frakcja") then
				outputChatBox("#5d8aa8FRAKCJA "..frakcja..">#ffffff "..getPlayerName(plr).." ["..getElementData(plr, "id").."] :#ffffff "..msg, v, 255, 0, 0, true)
			end
		end
	end
end
addCommandHandler("frakcja", krotkofalowkachat)

function allkrotkofalowkachat(plr, cmd, ...)
	local frakcja = getElementData(plr, "frakcja")
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(plr))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, plr, 255, 0, 0)
			setElementData(plr, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(plr))
			setElementData(plr, "mute", false)
		end
		if getElementData(plr, "mute") then return end
	if not frakcja then return end
	local msg = table.concat ( { ... }, " " )
	triggerClientEvent("dLogi", root, "SŁUŻBY> "..getPlayerName(plr).." ["..getElementData(plr, "id").."] ["..frakcja.."] : "..msg.."")
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **SŁUŻBY** "..getPlayerName(plr).." ["..frakcja.."]: "..msg, "logi-local")

	if string.find(msg, "#", 1) == 1 then
		for i,v in pairs(getElementsByType("player")) do
			if getElementData(v, "frakcja") then
				local msg = string.sub(msg, 2, #msg)
				outputChatBox("#00ff7fSŁUŻBY>#ffffff "..getPlayerName(plr).." ["..getElementData(plr, "id").."] ["..frakcja.."]:#ffffff "..msg, v, 255, 0, 0, true)
			end
		end
	else
		for i,v in pairs(getElementsByType("player")) do
			if getElementData(v, "frakcja") then
				outputChatBox("#00ff7fSŁUŻBY>#ffffff "..getPlayerName(plr).." ["..getElementData(plr, "id").."] ["..frakcja.."]:#ffffff "..msg, v, 255, 0, 0, true)
			end
		end
	end
end
addCommandHandler("sluzby", allkrotkofalowkachat)

function orgchat(plr, cmd, ...)
	local org = getElementData(plr, "oname")
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(plr))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, plr, 255, 0, 0)
			setElementData(plr, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(plr))
			setElementData(plr, "mute", false)
		end
		if getElementData(plr, "mute") then return end
	if not org then return end
	local msg = table.concat ( { ... }, " " )
	triggerClientEvent("dLogi", root, "ORG/"..org.."> "..getPlayerName(plr).." ["..getElementData(plr, "id").."] : "..msg.."")
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **ORG** "..getPlayerName(plr).." ["..org.."]: "..msg, "logi-local")

	if string.find(msg, "#", 1) == 1 then
		for i,v in pairs(getElementsByType("player")) do
			if getElementData(v, "oname") then
				local msg = string.sub(msg, 2, #msg)
				outputChatBox("#100c08ORG "..org..">#ffffff "..getPlayerName(plr).." ["..getElementData(plr, "id").."] :#ffffff "..msg, v, 255, 0, 0, true)
			end
		end
	else
		for i,v in pairs(getElementsByType("player")) do
			if getElementData(v, "oname") == getElementData(plr, "oname") then
				outputChatBox("#100c08ORG "..org..">#ffffff "..getPlayerName(plr).." ["..getElementData(plr, "id").."] :#ffffff "..msg, v, 255, 0, 0, true)
			end
		end
	end
end
addCommandHandler("org", orgchat)

addEventHandler("onResourceStart", root, function()
	local players = getElementsByType("player")
	for _, p in pairs(players) do
		bindKey(p, "y", "down", "chatbox", "frakcja")
		bindKey(p, "u", "down", "chatbox", "sluzby")
		bindKey(p, "o", "down", "chatbox", "ooc")
		bindKey(p, "q", "down", "chatbox", "org")
	end
end)

addEventHandler( "onPlayerSpawn", getRootElement(), function()
	bindKey(source, "y", "down", "chatbox", "frakcja")
	bindKey(source, "u", "down", "chatbox", "sluzby")
	bindKey(source, "o", "down", "chatbox", "ooc")
	bindKey(source, "q", "down", "chatbox", "org")
end)

function findPlayer(player, toPlayer)
	for i,v in ipairs(getElementsByType("player")) do
		if tonumber(toPlayer) then
			if getElementData(v, "id") == tonumber(toPlayer) then
				return v
			end
		else
			if string.find(string.gsub(getPlayerName(v):lower(),"#%x%x%x%x%x%x", ""), toPlayer:lower(), 1, true) then
				return v
			end
		end
	end
end


addCommandHandler("sprCMD", function(player)
	if getElementData(player, "dbid") ~= 1 then return end
      local commandsList = {}
      for _, subtable in pairs( getCommandHandlers() ) do
     	local commandName = subtable[1]
     	local theResource = subtable[2]
            
        if not commandsList[theResource] then
        	commandsList[theResource] = {}
      	end
          
      	table.insert( commandsList[theResource], commandName )
      end
      for theResource, commands in pairs( commandsList ) do
      	local resourceName = getResourceInfo( theResource, "name" ) or getResourceName( theResource ) 
      	outputChatBox( "== "..resourceName.. " ==", player, 21, 102, 195 )
            
      	for _, command in pairs( commands ) do
        	outputChatBox( "/"..command, player, 255, 255, 255 )
      	end
      end
end)
--[[
addCommandHandler("org", function (plr, cmd, ...)
	local org = getElementData(plr, "oname");
	if not org then
		exports['smta_base_notifications']:wykonaj("Nie należsz do żadnej organizacji", plr, "error");
		return false;
	end
	
	local guild_query = exports['smta_base_db']:wykonaj("select * from smtadb_organizations where id=?", spr[1].org)
	local msg = table.concat({...}, " ");
	msg = checkForBadWords(msg);
	triggerClientEvent("dLogi", root, "ORG-"..org.."> "..getPlayerName(plr).." ["..getElementData(plr, "id").."]: "..msg.."")
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **ORG-"..org.."** "..getPlayerName(plr)..": "..msg, "logi-local")

	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v, "oname") and getElementData(v, "oname").id == org.id then
			outputChatBox("#16A77D"..org..">#ffffff " .. getPlayerName(plr) .. ": " .. msg, v, 255, 255, 255, true);
		end
	end
end);
--]]