--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function sprawdzIloscDni(gracz)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_accounts WHERE dbid=? AND premium>NOW() LIMIT 1", getElementData(gracz, "dbid"))
	if (spr and #spr > 0) then
		return spr[1].premium
	end
	return false
end

function ustawIloscDni(gracz, dni)
	if sprawdzIloscDni(gracz) then
			local wyk = exports["smta_base_db"]:wykonaj(string.format("UPDATE smtadb_accounts SET premium = DATE(premium) + INTERVAL %d DAY WHERE dbid=%d", dni, getElementData(gracz, "dbid")))
		return 
	end
	local wyk = exports["smta_base_db"]:wykonaj(string.format("UPDATE smtadb_accounts SET premium = DATE(curdate()) + INTERVAL %d DAY WHERE dbid=%d", dni, getElementData(gracz, "dbid")))
end

addEvent("sprawdzPremium", true)
addEventHandler("sprawdzPremium", root, function(kod, dni)
	local spr = "http://microsms.pl/api/v2/multi.php?userid=4619&code="..kod.."&serviceid=5212"
	fetchRemote(spr, nadajP, "", false, client, dni)
end)

function nadajP(responseData, errno, playerToReceive, amount)
	if errno == 0 then
	if string.find(responseData, "kod") then
		if string.find(responseData, '"number":"72480"') then
			amount = 1
		elseif string.find(responseData, '"number":"74480"') then
			amount = 3
		elseif string.find(responseData, '"number":"76480"') then
			amount = 7
		elseif string.find(responseData, '"number":"79480"') then
			amount = 14
		elseif string.find(responseData, '"number":"91400"') then
			amount = 30
		end
		exports["smta_base_notifications"]:noti("Zakupiłeś "..amount.." DP", playerToReceive)
		outputChatBox(getPlayerName(playerToReceive).." zakupił "..amount.." punktów diamond, dziękujemy że nas wspierasz!", root, 185, 242, 255)
		--exports["np-discord"]:connectWeb("**"..getPlayerName(playerToReceive).."** zakupił "..amount.."DP! Dziękujemy że nas wspierasz!", "infopremium")
		setElementData(playerToReceive, "pp", (getElementData(playerToReceive, "pp") or 0)+amount)
	else
		exports["smta_base_notifications"]:noti("Podany kod jest nieprawidłowy. ("..responseData..")", playerToReceive)
	end
end
end

addEvent("wymien:pp", true)
addEventHandler("wymien:pp", root, function(ile)
	if (getElementData(client, "pp") or 0) < ile then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej ilości DP", client, "error") return end
	setElementData(client, "pp", (getElementData(client, "pp") or 0)-ile)
	ustawIloscDni(client, (ile))
	setElementData(client, "premium", true)
	setElementData(client, "premium_czas", 1)
	exports["smta_base_notifications"]:noti("Wymieniłeś punkty diamond na "..ile.." dni konta diamond", client)
	exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=NOW()", getPlayerName(client), "Wymienił "..ile.."", getPlayerSerial(client), "wymianapp")
end)

addEvent("pokaz:gieldepp", true)
addEventHandler("pokaz:gieldepp", root, function()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_exchangedp")
	triggerClientEvent(client, "poka:gieldepp", client, spr)
end)

addEvent("kup:pp", true)
addEventHandler("kup:pp", root, function(id)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_exchangedp WHERE id=?", id)
	if #spr > 0 then
		if spr[1].nick == getPlayerName(client) then return end
		if spr[1].cena > getElementData(client, "pieniadze") then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej ilości pieniędzy", client, "error") return end
		exports["smta_base_notifications"]:noti("Zakupujesz "..spr[1].ilosc.." DP za "..spr[1].cena.." $", client)
		setElementData(client, "pp", (getElementData(client, "pp") or 0)+spr[1].ilosc)
		exports["smta_base_db"]:wykonaj("UPDATE smtadb_accounts SET bkasa=bkasa+? WHERE dbid=?", spr[1].cena, spr[1].dbid)
		exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_exchangedp WHERE id=?", id)
		setElementData(client, "pieniadze", getElementData(client, "pieniadze")-spr[1].cena)
		for i, v in ipairs(getElementsByType("player")) do
			if spr[1].dbid == getElementData(v, "dbid") then
				setElementData(v, "bankomat", getElementData(v, "bankomat")+spr[1].cena)
			end
		end
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=NOW()", getPlayerName(client), "Kupil "..spr[1].ilosc.." DP ("..(getElementData(client, "pp") - spr[1].ilosc).." > "..getElementData(client, "pp")..") za "..spr[1].cena.." $", getPlayerSerial(client), "kupnopp")
	else
		exports["smta_base_notifications"]:noti("Niestety ktoś już kupił te punkty diamond", client, "error")
	end
end)

addEvent("usun:pp", true)
addEventHandler("usun:pp", root, function(id)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_exchangedp WHERE id=?", id)
	if #spr > 0 then
		exports["smta_base_notifications"]:noti("Usuwasz swoje punkty diamond z giełdy", client)
		setElementData(client, "pp", (getElementData(client, "pp") or 0)+spr[1].ilosc)
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=NOW()", getPlayerName(client), "Usunał "..spr[1].ilosc.." DP kosztowały "..spr[1].cena.." $", getPlayerSerial(client), "usuwaniepp")
		exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_exchangedp WHERE id=?", id)
	else
		exports["smta_base_notifications"]:noti("Niestety ktoś już kupił te punkty diamond", client, "error")
	end
end)

addEvent("wystaw:pp", true)
addEventHandler("wystaw:pp", root, function(ilosc, cena)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_exchangedp WHERE dbid=?", getElementData(client, "dbid"))
	if #spr >= 4 then exports["smta_base_notifications"]:noti("Maksymalnie możesz dodać 4 oferty na giełde DP", client, "error") return end
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_exchangedp SET nick=?, dbid=?, ilosc=?, cena=?", getPlayerName(client), getElementData(client, "dbid"), string.format("%1d", ilosc), string.format("%1d", cena))
	setElementData(client, "pp", (getElementData(client, "pp") or 0)-string.format("%1d", ilosc))
	exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=NOW()", getPlayerName(client), "Wystawił "..string.format("%1d", ilosc).." DP za "..tonumber(cena).." $", getPlayerSerial(client), "wystawianiepp")
end)

addCommandHandler("ddiamond", function(gracz, _, kgracz, dni)
	if getElementData(gracz, "duty") ~= 4 then return end
	if not kgracz or not dni then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kgracz)
	if not target then return end
	setElementData(target, "premium", true)
	setElementData(target, "premium_czas", 0)
	ustawIloscDni(target, dni)
	setPlayerNametagColor(target, 185, 242, 255)
	exports["smta_base_notifications"]:noti(getPlayerName(gracz).." nadał ci konto diamond na "..dni.." dni", target)
	exports["smta_base_notifications"]:noti("Nadałeś konto diamond gracz "..getPlayerName(target).." na "..dni.." dni", gracz)
end)

addCommandHandler("ddp", function(gracz, _, kgracz, dni)
	if getElementData(gracz, "duty") ~= 4 then return end
	if not kgracz or not dni then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kgracz)
	if not target then return end
	setElementData(target, "pp", (getElementData(target, "pp") or 0)+tonumber(dni))
	exports["smta_base_notifications"]:noti(getPlayerName(gracz).." dał ci "..dni.." DP", target)
	exports["smta_base_notifications"]:noti("Dałeś graczu "..getPlayerName(target).." "..dni.." DP", gracz)
end)