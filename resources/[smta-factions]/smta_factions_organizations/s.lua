--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("zaproszenie:org", true)
addEventHandler("zaproszenie:org", resourceRoot, function(player, org, thisPlayer, oferta)
	if oferta == true then
		exports["smta_base_notifications"]:noti("Odrzuciłeś propozycję dołączenia do grupy przestępczej: "..org.."", player)
		thisPlayer = getPlayerFromName(thisPlayer)
		if thisPlayer then
			exports["smta_base_notifications"]:noti(""..getPlayerName(player).." odrzucił propozycję dołączenia do grupy przestępczej", thisPlayer)
		end
	else
		exports["smta_base_notifications"]:noti("Zaakceptowałeś propozycję dołączenia do grupy przestępczej: "..org.."", player)
		thisPlayer = getPlayerFromName(thisPlayer)
		if thisPlayer then
			exports["smta_base_notifications"]:noti(""..getPlayerName(player).." zaakceptował propozycję dołączenia do grupy przestępczej", thisPlayer)
		end
		setElementData(player, "oname", org)
		setElementData(player, "oranga", 1)
		local q = exports['smta_base_db']:wykonaj("select * from smtadb_organizations where organizacja=?", org)
		setElementData(player, "odata", q)
		exports['smta_base_db']:wykonaj("update smtadb_accounts set org=? where dbid=?", q[1]["id"], getElementData(player, "dbid"))
	end
end)

addEvent("org:addgracz", true)
addEventHandler("org:addgracz", resourceRoot, function(client, nick)
	local q2 = exports['smta_base_db']:wykonaj("select * from smtadb_accounts where login=?", getPlayerName(client))
	if q2[1]["orank"] == 4 or q2[1]["orank"] == 3 then
		local target = findPlayer(client, nick)
		if not target then 
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", client)
			return 
		end
		if getElementData(target, "oname") then
			exports["smta_base_notifications"]:noti(""..getPlayerName(target).." posiada organizacje.", client, "error")
			return
		end
		local org = getElementData(client, "oname")
		exports["smta_base_notifications"]:noti("Wysłano propozycję dołączenia do grupy przestępczej dla gracza: "..getPlayerName(target).."", client)
		triggerClientEvent(target, "zaproszenie:org", resourceRoot, target, org, getPlayerName(client))
	end
end)

addEvent("org:kickgracz", true)
addEventHandler("org:kickgracz", resourceRoot, function(client, nick)
	local q2 = exports['smta_base_db']:wykonaj("select * from smtadb_accounts where login=?", getPlayerName(client))
	if q2[1]["orank"] == 4 or q2[1]["orank"] == 3 then
	
		local q = exports['smta_base_db']:wykonaj("select * from smtadb_accounts where login=?", nick)
	
		if q[1]["orank"] == 4 then
			exports["smta_base_notifications"]:noti("Nie możesz wyrzucić lidera.", client, "error")
			return
		end
	
		if q[1]["orank"] == 3 and q2[1]["orank"] ~= 4 then
			exports["smta_base_notifications"]:noti("Nie możesz wyrzucić vice-lidera nie będąc liderem.", client, "error")
			return
		end
	
		exports['smta_base_db']:wykonaj("update smtadb_accounts set orank=1,org=0 where login=?", nick)
		exports["smta_base_notifications"]:noti(""..nick.." został wyrzucony z grupy przestępczej.", client)
	
		local target = findPlayer(client, nick)
		if target then
			exports["smta_base_notifications"]:noti("Zostałeś wyrzucony z grupy przestępczej "..q2[1]["org"].."", target)
			setElementData(target, "oname", false)
			setElementData(target, "odata", false)
			setElementData(target, "oranga", 1)
		end
	end
end)

addEvent("org:editgracz", true)
addEventHandler("org:editgracz", resourceRoot, function(client, rank, player, rank2)
	local q2 = exports['smta_base_db']:wykonaj("select * from smtadb_accounts where login=?", getPlayerName(client))
	if q2[1]["orank"] == 4 or q2[1]["orank"] == 3 then
	
		local q = exports['smta_base_db']:wykonaj("select * from smtadb_accounts where login=?", player)
		if q[1]["orank"] == 4 then
			exports["smta_base_notifications"]:noti("Nie możesz edytować lidera.", client, "error")
			return
		end
		
		if q2[1]["orank"] == 3 and rank == 3 then
			exports["smta_base_notifications"]:noti("Nie możesz nikomu dać vice-lidera.", client, "error")
			return
		end
		exports['smta_base_db']:wykonaj("update smtadb_accounts set orank=? where login=?", rank, player)
		exports["smta_base_notifications"]:noti("Edytowano gracza "..player.." na rangę "..rank2.."", client)
		local target = findPlayer(client, player)
		if target then
			setElementData(target, "oranga", tonumber(rank))
			exports["smta_base_notifications"]:noti("Twoje informacje w grupie przestępczej zostały zaaktualizowane.", target)
		end
	end
end)

addCommandHandler("opuscgrupe", function(client)
	local rank = exports['smta_base_db']:wykonaj("select * from smtadb_accounts where dbid=?", getElementData(client, "dbid"))
	if rank and #rank > 0 then
		if rank[1]["orank"] ~= 4 then
			exports['smta_base_db']:wykonaj("update smtadb_accounts set org=0,orank=1 where dbid=?", getElementData(client, "dbid"))
			exports["smta_base_notifications"]:noti("Opuściłeś grupe o nazwie "..getElementData(client, "oname").."", client)
			setElementData(client, "oname", false)
			setElementData(client, "odata", false)
			setElementData(client, "oranga", 1)
		end
	end
end)

function orgGetPlayers(org)
	local q2 = exports['smta_base_db']:wykonaj("select * from smtadb_organizations where organizacja=?", org)
	local q1 = exports['smta_base_db']:wykonaj("select * from smtadb_accounts where org=?", q2[1].id)
	triggerClientEvent(source, "uzupelnijListe", source, q1, q2[1])
end
addEvent("orgGetPlayers", true)
addEventHandler("orgGetPlayers", getRootElement(), orgGetPlayers)

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