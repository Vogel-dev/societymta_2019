--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local zablokowane_seriale = 
{ 
['989FF72AF3DE033FDC661DF3CEDC03F2'] = true, 
['A328198ECCCE3DF5F40EF2B39C805F44'] = true, 
['B2AF2A7E79CE9BAFEA7A2BEB8516C7B3'] = true, 
} 

addEventHandler("onPlayerConnect",root,function(_,_,_,serial) 
if zablokowane_seriale[serial] then cancelEvent(true,"Szkodnik") end 
end) 

addCommandHandler("skin", function(plr,cmd,cel,id)
	if getElementData(plr, "duty") > 2 then
		   local id = tonumber(id)
		   if not cel or not id then
				  exports["smta_base_notifications"]:noti("Użycie: /skin id/nick id skina", plr, "error")
			   return
		   end
			   local target = findPlayer(plr, cel)
		   if not target then
					exports["smta_base_notifications"]:noti("Nie znaleziono podanego przez ciebie gracza", plr, "error")
			   return
		   end
		   if id < 0 or id > 311 then
				  exports["smta_base_notifications"]:noti("Użycie: /skin id/nick id skina", plr, "error")
				   return end
		   setElementModel(target,id)
		   setElementData(target, "skin",id)
		   exports["smta_base_notifications"]:noti("Zmieniono skin graczowi "..getPlayerName(target).." na skina id: "..id.."", plr)
		   exports["smta_base_notifications"]:noti("Twój skin został zmieniony przez "..getPlayerName(plr).." na skina id: "..id.."", target)
		   exports["smta_base_discord"]:connectWeb("SKIN - **"..getPlayerName(plr).."** zmienił skin graczowi "..getPlayerName(target).." na id "..id.."", "logi-komend-adm")
	   end
   end)

addCommandHandler("rfix", function(plr, cmd, range)
     if getElementData(plr, "duty") > 1 then
        if (not range) then
			exports["smta_base_notifications"]:noti("Użycie: /rfix zasieg.", plr, "error")
        return end
		if not tonumber(range) then
		exports["smta_base_notifications"]:noti("Użycie: /rfix zasieg.", plr, "error")
		return end
		range = tonumber(range)
		if range <= 0 then
		exports["smta_base_notifications"]:noti("Za mała odległość.", plr, "error")
		return end
		if range > 100 then
		exports["smta_base_notifications"]:noti("Za duża odległość.", plr, "error")
		return end
		local x,y,z = getElementPosition(plr)
		local cub = createColSphere(x,y,z,range)
		local pojazdy = getElementsWithinColShape( cub, "vehicle")
		if #pojazdy == 0 then
		exports["smta_base_notifications"]:noti("Brak pojazdów w pobliżu.", plr, "error")
		return end
		exports["smta_base_discord"]:connectWeb("rFIX - **"..getPlayerName(plr).."** naprawił wszystkie pojazdy w promieniu **"..range.."** ", "logi-komend-adm")
		for i,pojazd in ipairs(pojazdy) do
			fixVehicle(pojazd)
		end
		setTimer(destroyElement,5000,1,cub)
	end
end)

addCommandHandler("rfuel", function(plr, cmd, range)
     if getElementData(plr, "duty") > 1 then
        if (not range) then
		exports["smta_base_notifications"]:noti("Użycie: /rfuel zasieg.", plr, "error")
        return end
		if not tonumber(range) then
		exports["smta_base_notifications"]:noti("Użycie: /rfuel zasieg.", plr, "error")
		return end
		range = tonumber(range)
		if range <= 0 then
		exports["smta_base_notifications"]:noti("Za mała odległość.", plr, "error")
		return end
		if range > 100 then
		exports["smta_base_notifications"]:noti("Za duża odległość.", plr, "error")
		return end
		local x,y,z = getElementPosition(plr)
		local cub = createColSphere(x,y,z,range)
		local pojazdy = getElementsWithinColShape( cub, "vehicle")
		if #pojazdy == 0 then
		exports["smta_base_notifications"]:noti("Brak pojazdów w pobliżu.", plr, "error")
		return end
		exports["smta_base_discord"]:connectWeb("rFUEL - **"..getPlayerName(plr).."** zatankował wszystkie pojazdy w promieniu **"..range.."** ", "logi-komend-adm")
		for i,pojazd in ipairs(pojazdy) do
			setElementData(pojazd, "paliwo", 50)
		end
		setTimer(destroyElement,5000,1,cub)
	end
end)

 addCommandHandler("rgb", function(plr,cmd,cel,value,value2,value3)
	if getElementData(plr, "duty") > 2 then
		if not cel or not tonumber(value) or not tonumber(value2) or not tonumber(value3) then
		exports["smta_base_notifications"]:noti("Użycie: /rgb <nick/ID> <r g b>", plr, "error")
			return
		end
		local target=findPlayer(plr, cel)
		if not target then
		exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", plr, "error")
			return
		end
		local veh=getPedOccupiedVehicle(target)
		setVehicleColor(veh,value,value2,value3,value,value2,value3)
		exports["smta_base_notifications"]:noti("Twojemu pojazdowi zmieniono kolor.", target)
		exports["smta_base_notifications"]:noti("Zmieniłeś(aś) kolor pojazdu graczu: "..getPlayerName(target).."", plr)
		exports["smta_base_discord"]:connectWeb("RGB - **"..getPlayerName(plr).."** > **"..getPlayerName(target).."** > "..value.." "..value2.." "..value3.." ", "logi-komend-adm")
	end

end)

addCommandHandler("vopis", function(plr,cmd,...)
	if getElementData(plr, "duty") > 2 then
	local desc=table.concat(arg, " ")
	local veh=getPedOccupiedVehicle(plr)
	if not veh then
			exports["smta_base_notifications"]:noti("Musisz siedzieć w pojeździe którego opis chcesz zmienić.", plr, "error")
		return
	end
	if getElementData(veh, "nametag") then
		setElementData(veh, "nametag", false)
	return end
	if string.len(desc) < 2 then
		exports["smta_base_notifications"]:noti("Użycie: /vopis <opis min 2 znaki>", plr, "error")
		return
	end

	descc=string.format("%s", desc)
	setElementData(veh,"nametag",descc)
	exports["smta_base_discord"]:connectWeb("VOPIS - **"..getPlayerName(plr).."** > **"..desc.."** ", "logi-komend-adm")
end
end)

addCommandHandler("sserial", function(plr,cmd,cel)
	if getElementData(plr, "duty") then
		if not cel then
			exports["smta_base_notifications"]:noti("Użycie: /sserial id", plr, "error")
			return
		end
		local target=findPlayer(plr, cel)
		if not target then
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza", plr, "error")
			return
		end
		outputChatBox("Serial gracza  "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." to "..getPlayerSerial(target), plr)
		exports["smta_base_discord"]:connectWeb("SSERIAL - **"..getPlayerName(plr).."** > **"..getPlayerName(target).."** ", "logi-komend-adm")
	end
end)

local zapisane_pozycje = {}
addCommandHandler("sp", function(plr,cmd)
	if getElementData(plr, "duty") then
    local pos={}
    pos[1],pos[2],pos[3]=getElementPosition(plr)
    pos[4]=getElementInterior(plr)
    pos[5]=getElementDimension(plr)
	local uid = getElementData(plr,"dbid")
    zapisane_pozycje[uid] = pos
	exports["smta_base_notifications"]:noti("Pozycja została zapisana.", plr)
	end
end)

addCommandHandler("lp", function(plr,cmd)
	if getElementData(plr, "duty") then
	local uid = getElementData(plr,"dbid")
    local pos=zapisane_pozycje[uid]
    if (not pos) then
	exports["smta_base_notifications"]:noti("Nie masz żadnej zapisanej pozycji.", plr, "error")
    return
    end
	local veh = getPedOccupiedVehicle(plr)
	if veh then plr = veh end
    setElementPosition(plr,pos[1],pos[2],pos[3])
    setElementInterior(plr,pos[4])
    setElementDimension(plr,pos[5])
	exports["smta_base_notifications"]:noti("Wczytano pozycję.", plr)
	end
	end)

addCommandHandler("tppos", function(plr,cmd,x,y,z)
if getElementData(plr, "duty") > 1 then
	x,y,z=tonumber(x),tonumber(y),tonumber(z)
	if not x or not y or not z then
		exports["smta_base_notifications"]:noti("Podaj pozycje x y z!", plr, "error")
		return
	end
	setElementPosition(plr,x,y,z)
	exports["smta_base_notifications"]:noti("Przeniesiono!", plr)
end
end)

addCommandHandler("zajebkola",function(plr,cmd)
	if getElementData(plr, "duty") > 3 then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			exports["smta_base_notifications"]:noti("Nie znajdujesz się w pojeździe.", plr, "error")
			return
		end
	x = getElementData(veh,"zajebane:kola")
	if not x then setVehicleWheelStates(veh,2,2,2,2) setElementData(veh,"zajebane:kola",true)  else setVehicleWheelStates(veh,0,0,0,0);  setElementData(veh,"zajebane:kola",false) end
	end
end)

addCommandHandler("suszarka",function(plr,cmd)
	if getElementData(plr, "duty") then
	giveWeapon (plr, 22, 200 )
	end
end)


addCommandHandler("przepisz", function(plr,cmd,value)
	if getElementData(plr, "duty") > 3 then
		local veh = getPedOccupiedVehicle(plr)
		if not veh then
			exports["smta_base_notifications"]:noti("Nie znajdujesz się w pojeździe.", plr, "error")
			return
		end
		setElementData(veh,"wlasciciel",tonumber(value))
		exports["smta_base_notifications"]:noti("Przepisałeś pojazd do gracza: "..value, plr)
	end
end)

addCommandHandler("fixall", function(plr)
	if getElementData(plr, "duty") > 3 then
		for i,v in ipairs(getElementsByType("vehicle")) do
				fixVehicle(v)
			end
		end
		exports["smta_base_notifications"]:noti("Administrator RCON naprawił każdy pojazd na mapie.", plr)
end)

addCommandHandler("healall", function(plr)
	if getElementData(plr, "duty") > 3 then
		for i,v in ipairs(getElementsByType("player")) do
				setElementHealth(v, 100)
			end
		end
		exports["smta_base_notifications"]:noti("Administrator RCON uleczył każdego gracza na serwerze.", plr)
end)

addCommandHandler("djall", function(plr)
	if getElementData(plr, "duty") > 3 then
		for i,v in ipairs(getElementsByType("player")) do
			local zarcie = getElementData(v, "najedzenie")
				setElementData(v, "najedzenie", 100)
			end
		end
		exports["smta_base_notifications"]:noti("Administrator RCON dał każdemu graczowi na serwerze 100% najedzenia.", plr)
end)

addCommandHandler("zprzebieg", function(plr,cmd,tonumber)
	if getElementData(plr, "duty") > 3 then
		local veh = getPedOccupiedVehicle(plr)
		if not veh then
			exports["smta_base_notifications"]:noti("Nie znajdujesz się w pojeździe.", plr, "error")
			return
		end
		setElementData(veh, "przebieg", tonumber)
		exports["smta_base_notifications"]:noti("Przebieg został zmieniony pomyślnie", plr)
	end
end)

addCommandHandler("idwep",function(plr,cmd)
for i = 0,46 do
outputChatBox(""..i.." : "..getWeaponNameFromID(i),plr)
end
end)

addCommandHandler("dajbron", function(plr,cmd,cel,bron,amunicja)
	if getElementData(plr, "duty") > 3 then
		if not cel or not bron then
			exports["smta_base_notifications"]:noti("Użycie: /dajbron <nick/ID> <bron > <amunicja>", plr, "error")
			return
		end
		if not tonumber(bron) then
			exports["smta_base_notifications"]:noti("Użycie: /dajbron <nick/ID> <bron > <amunicja>", plr, "error")
			return
		end
		if not amunicja then local amunicja = 10 end
		local target = findPlayer(plr,cel)
		if not target then
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", plr, "error")
			return
		end
		if giveWeapon(target,bron,amunicja,true) then
		exports["smta_base_notifications"]:noti("Nadałeś broń ("..getWeaponNameFromID(bron)..") dla "..getPlayerName(target).."", plr)
		exports["smta_base_notifications"]:noti("Otrzymałeś broń ("..getWeaponNameFromID(bron)..") od "..getPlayerName(plr).."", target)
		else
		exports["smta_base_notifications"]:noti("Podałeś niepoprawne id broni.", plr, "error")
		end
	end
end)

addCommandHandler("aclreload", function(plr, cmd)
	if not getPlayerSerial(plr) == "F5686A30BDBAB03643105204222F28F3" then return end
	aclReload()
	outputChatBox("SMTA/ADMINISTRATION - Plik ACL został poprawnie przeładowany!", plr, 0, 225, 0)
end)

addCommandHandler("liczbaaut", function(gracz)
	if getElementData(gracz, "duty") ~= 4 then return end
	local auto = 0
	for i, v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") then
			auto = auto+1
		end
	end
	outputChatBox(auto, gracz)

end)

addCommandHandler("up", function(plr, cmd, value)
    if getElementData(plr, "duty") then
        if (tonumber(value)==nil) then
            outputChatBox("* * Użycie: /up <ile>", plr, "error")
            return
        end

        local e = plr

        if (isPedInVehicle(plr)) then
            e = getPedOccupiedVehicle(plr)
        end

        local x,y,z = getElementPosition(e)
        setElementPosition(e, x, y, z+tonumber(value))
    end
end)

addCommandHandler("thru", function(plr, cmd, value)
    if getElementData(plr, "duty") > 2 then
        if (tonumber(value)==nil) then
            outputChatBox("* * Użycie: /thru <ile>", plr, "error")
            return
        end

        local e = plr

        if getCameraTarget(plr) ~= plr then
            e = getCameraTarget(plr)
        end

        if (isPedInVehicle(plr)) then
            e = getPedOccupiedVehicle(e)
        end

        local x,y,z = getElementPosition(e)
        local _,_,rz = getElementRotation(e)

        local rrz = math.rad(rz)
        local x = x + (value * math.sin(-rrz))
        local y = y + (value * math.cos(-rrz))

        setElementPosition(e, x, y, z)
    end
end)

function doprzecho(player, command, auto)
	if not getElementData(player, "duty") then return end

	if not auto then return false; end
	auto = tonumber(auto);
	iprint(auto);
	if not auto then return false; end

	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") and getElementData(v, "id") == auto then
			local id = getElementData(v, "id")
			exports["smta_veh_base"]:zapiszPojazdy(v);
			destroyElement(v);
			outputChatBox("* Pojazd o id "..id.." został schowany do przechowalni.", player)
		end
	end

	local wyk = exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET przechowalnia=1 WHERE id=?", auto);
end
addCommandHandler("dp", doprzecho);

function doprzechoall(player, command)
	if not getElementData(player, "duty") == 4 then return end

	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") then
			exports["smta_veh_base"]:zapiszPojazdy(v);
			destroyElement(v);
			outputChatBox("* Wszystkie pojazdy graczy zostały schowane do przechowalni", player)
		end
		end

	local wyk = exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET przechowalnia=1");
end
addCommandHandler("dpall", doprzechoall);

function dajhajs(player, cmd, ile)
	if not ile then return false; end
	ile = tonumber(ile);
	iprint(ile);
	if not ile then return false; end

	if getElementData(player, "duty") == 4 or getPlayerName(player) == "Vogel" then
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "pieniadze") then
				setElementData(v, "pieniadze", getElementData(v, "pieniadze") + ile);
				outputChatBox("#B9272BAdministrator RCon " .. getPlayerName(player) .. " przekazał wszystkim graczom " .. ile .. " $", v, 255, 255, 255, true);
				exports["smta_base_discord"]:connectWeb("GIVEALL - **"..getPlayerName(player).."** rozdzał wszystkim graczom **"..ile.."** $", "logi-komend-adm")
			end
		end
	end
end
addCommandHandler("giveall", dajhajs);

function ninjazbanuj(plr, cmd, target, t2, t1, ...)
	if getElementData(plr, "duty") > 2 then
	if not target or not t1 or not t2 or not ... then
		return
	end

	local player = findPlayer(plr, target)
	if not player then return end
		if getElementData(player, "duty") == 4 or getPlayerName(player) == "Vogel" then outputChatBox("Nie możesz zbanować tej osoby!", plr, 255, 0, 0) return end
		local text = table.concat({...}, " ")
		local ts_start = getTimestamp()
		if t1 == "m" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*60
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." minut z powodu: "..text
			--triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." min", "Ban")
			kickPlayer(player, "Zostałeś zbanowany! Po więcej informacji wejdź ponownie na serwer!")
			exports["smta_base_discord"]:connectWeb("BAN - **"..getPlayerName(player).."** zbanował gracza **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." minut", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
		elseif t1 == "h" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*3600
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." godzin z powodu: "..text
			--triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." h", "Ban")
			kickPlayer(player, "Zostałeś zbanowany! Po więcej informacji wejdź ponownie na serwer!")
			exports["smta_base_discord"]:connectWeb("BAN - **"..getPlayerName(player).."** zbanował gracza **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." godzin", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
		elseif t1 == "d" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*86400
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." dni z powodu: "..text
			--triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." dni", "Ban")
			kickPlayer(player, "Zostałeś zbanowany! Po więcej informacji wejdź ponownie na serwer!")
			exports["smta_base_discord"]:connectWeb("BAN - **"..getPlayerName(player).."** zbanował gracza **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." dni", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
			end
	end
end


function zbanuj(plr, cmd, target, t2, t1, ...)
	if getElementData(plr, "duty") > 2 then
	if not target or not t1 or not t2 or not ... then
		return
	end

	local player = findPlayer(plr, target)
	if not player then return end
		if getElementData(player, "duty") == 4 or getPlayerName(player) == "Vogel" then outputChatBox("Nie możesz zbanować tej osoby!", plr, 255, 0, 0) return end
		local text = table.concat({...}, " ")
		local ts_start = getTimestamp()
		if t1 == "m" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*60
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." minut z powodu: "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." min", "Ban")
			kickPlayer(player, "Zostałeś zbanowany! Po więcej informacji wejdź ponownie na serwer!")
			exports["smta_base_discord"]:connectWeb("BAN - **"..getPlayerName(player).."** zbanował gracza **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." minut", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
		elseif t1 == "h" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*3600
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." godzin z powodu: "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." h", "Ban")
			kickPlayer(player, "Zostałeś zbanowany! Po więcej informacji wejdź ponownie na serwer!")
			exports["smta_base_discord"]:connectWeb("BAN - **"..getPlayerName(player).."** zbanował gracza **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." godzin", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
		elseif t1 == "d" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*86400
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." został zbanowany przez "..getPlayerName(plr).." na czas "..t2.." dni z powodu: "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." dni", "Ban")
			kickPlayer(player, "Zostałeś zbanowany! Po więcej informacji wejdź ponownie na serwer!")
			exports["smta_base_discord"]:connectWeb("BAN - **"..getPlayerName(player).."** zbanował gracza **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." dni", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
			end
	end
end

function kicknij(gracz, _, graczhere, ...)
	if graczhere and ... and getElementData(gracz, "duty") then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
			return
		end
		local tresc = table.concat({...}, " ")
		local txt = getPlayerName(graczhere).." został wyrzucony przez "..getPlayerName(gracz).." z powodu "..tresc
		exports["smta_base_discord"]:connectWeb("KICK - **"..getPlayerName(gracz).."** wyrzucił gracza **"..getPlayerName(graczhere).."**, powód: "..tresc, "logi-komend-adm")
		kickPlayer(graczhere, gracz, tresc)
		outputConsole(txt)
		triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
		outputChatBox(("* Gracz został wyrzucony z serwera."),gracz)
	end
end

function warnij(gracz, _, graczhere, ...)
	if graczhere and ... and getElementData(gracz, "duty") then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz, "error")
			return
		end
		if getElementData(graczhere, "warn") then exports["smta_base_notifications"]:noti("Gracz posiada nałożonego warna", gracz, "error") return end
		local tresc = table.concat({...}, " ")
		local txt = ""..getPlayerName(graczhere).." został ostrzeżony przez "..getPlayerName(gracz).." z powodu: "..tresc
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Otrzymałeś ostrzeżenie od "..getPlayerName(gracz), graczhere, 255, 0, 0)
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Powód: "..tresc, graczhere, 255, 255, 255)
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Nie stosowanie się do ostrzeżenia, może skutkować kickiem lub banem.", graczhere, 0, 131, 255)
		outputConsole(txt)
		exports["smta_base_discord"]:connectWeb("WARN - **"..getPlayerName(gracz).."** ostrzegł gracza **"..getPlayerName(graczhere).."**. powód: "..tresc, "logi-komend-adm")
		triggerClientEvent(root, "notiAdmin", root, txt)
		outputChatBox(("* Gracz został ostrzeżony."),gracz)
		triggerClientEvent(graczhere, "warnPlayer", root, {
			["powod"] = tresc,
			["kto"] = getPlayerName(gracz),
		})
	end
end

function swarnij(gracz, _, graczhere, ...)
	if graczhere and ... and getElementData(gracz, "duty") then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz, "error")
			return
		end
		if getElementData(graczhere, "warn") then exports["smta_base_notifications"]:noti("Gracz posiada nałożonego warna", gracz, "error") return end
		local tresc = table.concat({...}, " ")
		local txt = ""..getPlayerName(graczhere).." został ostrzeżony przez "..getPlayerName(gracz).." z powodu: "..tresc
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("(S) Otrzymałeś ostrzeżenie od "..getPlayerName(gracz), graczhere, 255, 0, 0)
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Powód: "..tresc, graczhere, 255, 255, 255)
		outputChatBox(" ", graczhere, 255, 0, 0)
		outputChatBox("Nie stosowanie się do ostrzeżenia, może skutkować kickiem lub banem.", graczhere, 0, 131, 255)
		outputConsole(txt)
		exports["smta_base_discord"]:connectWeb("**(S)**WARN - **"..getPlayerName(gracz).."** ostrzegł (s) gracza **"..getPlayerName(graczhere).."**. powód: "..tresc, "logi-komend-adm")
		--triggerClientEvent(root, "notiAdmin", root, txt)
		outputChatBox(("* Gracz został ostrzeżony (S)."),gracz)
		triggerClientEvent(graczhere, "swarnPlayer", root, {
			["powod"] = tresc,
			["kto"] = getPlayerName(gracz),
		})
	end
end

addEvent("posiadacz5warnow", true)
addEventHandler("posiadacz5warnow", root, function()
	setElementData(source, "warny", 0)
	local txt = getPlayerName(source).." został zbanowany przez CONSOLE na czas 2h z powodu: Posiadacz 5 warnów"
	outputConsole(txt)
	triggerClientEvent(root, "notiAdmin", root, txt)
	local ts_start = getTimestamp()
	local czaswh = 2
	local ts_final = ts_start + czaswh*3600+3600
	local time = getRealTime(ts_final)
	local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour)..":"..(time.minute)..":"..(time.second)
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(source), getPlayerSerial(source), getPlayerIP(source), final_date, "CONSOLE", "Posiadacz 5 warnów")
	exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(source), getPlayerSerial(source), "CONSOLE", "Posiadacz 5 warnów", "2 h", "Ban")
	kickPlayer(source, "Zostałeś zbanowany! Po więcej informacji wejdź ponownie na serwer!")
	exports["smta_base_discord"]:connectWeb("**CONSOLE** zbanował gracza **"..getPlayerName(source).."**, powód: 5 WARNÓW na czas 2 h", "logi-komend-adm")
end)

function admininfo(gracz, _, ...)
	if not getElementData(gracz, "duty") then return end
	if not ... then return end
	local tresc = table.concat({...}, " ")
	outputConsole(tresc)
	triggerClientEvent(root, "infoAdm", root, tresc)
	exports["smta_base_discord"]:connectWeb("AINFO - **"..getPlayerName(gracz).."** napisał, tresc: "..tresc, "logi-komend-adm")
end

function prawko(plr, cmd, target, t2, t1, ...)
	if getElementData(plr, "duty") > 1 then
	if not target or not t1 or not t2 or not ... then
		return
	end
	local player = findPlayer(plr, target)
	if not player then return end
		local text = table.concat({...}, " ")
		local ts_start = getTimestamp()
		if t1 == "m" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*60
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." otrzymał zakaz prowadzenia pojazdów kat. A,B,C od "..getPlayerName(plr).." na czas "..t2.." minut z powodu: "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			removePedFromVehicle(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." m", "Prawo jazdy")
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_licences SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_discord"]:connectWeb("ZPJ - **"..getPlayerName(player).."** zawiesił prawo jazdy **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." minut.", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
		elseif t1 == "h" then
			local t2 = tonumber(t2)
			local ts_final = ts_start + t2*3600
			local time = getRealTime(ts_final)
			removePedFromVehicle(player)
			local txt = getPlayerName(player).." otrzymał zakaz prowadzenia pojazdów kat. A,B,C od "..getPlayerName(plr).." na czas "..t2.." godzin z powodu: "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." h", "Prawo jazdy")
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_licences SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_discord"]:connectWeb("ZPJ - **"..getPlayerName(player).."** zawiesił prawo jazdy **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." godzin.", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
		elseif t1 == "d" then
			local t2 = tonumber(t2)
			removePedFromVehicle(player)
			local ts_final = ts_start + t2*86400
			local time = getRealTime(ts_final)
			local txt = getPlayerName(player).." otrzymał zakaz prowadzenia pojazdów kat. A,B,C od "..getPlayerName(plr).." na czas "..t2.." dni z powodu: "..text
			triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
			outputConsole(txt)
			local user_id = getElementData(player, "dbid")
			local user_serial = getPlayerSerial(player)
			local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." d", "Prawo jazdy")
			exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_licences SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
			exports["smta_base_discord"]:connectWeb("ZPJ - **"..getPlayerName(player).."** zawiesił prawo jazdy **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." godzin.", "logi-komend-adm")
			outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
			end
	end
end

function mute(plr, cmd, target, t2, t1, ...)
	if getElementData(plr, "duty") > 1 then
	if not target or not t1 or not t2 or not ... then
		return
	end
	local player = findPlayer(plr, target)
	if not player then return end
	local text = table.concat({...}, " ")
	local ts_start = getTimestamp()
	--exports["smta_base_discord"]:connectWeb("**"..getPlayerName(plr).."** wyciszył gracza **"..getPlayerName(player).."**.", "logi-komend-adm")
	if t1 == "m" then
		local t2 = tonumber(t2)
		local ts_final = ts_start + t2*60
		local time = getRealTime(ts_final)
		local txt = getPlayerName(player).." został wyciszony przez "..getPlayerName(plr).." na czas "..t2.." minut z powodu: "..text
		triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
		outputConsole(txt)
		local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." min", "Wyciszenie")
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_mute SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
		exports["smta_base_discord"]:connectWeb("MUTE - **"..getPlayerName(player).."** wyciszył **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." minut.", "logi-komend-adm")
		outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
	elseif t1 == "h" then
		local t2 = tonumber(t2)
		local ts_final = ts_start + t2*3600
		local time = getRealTime(ts_final)
		local txt = getPlayerName(player).." został wyciszony przez "..getPlayerName(plr).." na czas "..t2.." godzin z powodu: "..text
		triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
		outputConsole(txt)
		local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." h", "Wyciszenie")
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_mute SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
		exports["smta_base_discord"]:connectWeb("MUTE - **"..getPlayerName(player).."** wyciszył **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." godzin.", "logi-komend-adm")
		outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
	elseif t1 == "d" then
		local t2 = tonumber(t2)
		local ts_final = ts_start + t2*86400
		local time = getRealTime(ts_final)
		local txt = getPlayerName(player).." został wyciszony przez "..getPlayerName(plr).." na czas "..t2.." dni z powodu: "..text
		triggerClientEvent(getRootElement(), "notiAdmin", getRootElement(), txt)
		outputConsole(txt)
		local final_date = (time.year+1900).."-"..(time.month+1).."-"..(time.monthday).." "..(time.hour+1)..":"..(time.minute)..":"..(time.second)
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_punishments SET nick=?, serial=?, admin=?, powod=?, czas=?, rodzaj=?, data=NOW()", getPlayerName(player), getPlayerSerial(player), getPlayerName(plr), text, ""..t2.." dni", "Wyciszenie")
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_mute SET nick=?, serial=?, ip=?, data=?, admin=?, powod=?", getPlayerName(player), getPlayerSerial(player), getPlayerIP(player), final_date, getPlayerName(plr), text)
		exports["smta_base_discord"]:connectWeb("MUTE - **"..getPlayerName(player).."** wyciszył **"..getPlayerName(plr).."**, powód: "..text.." na czas "..t2.." dni.", "logi-komend-adm")
		outputChatBox(("* Kara została prawidłowo wprowadzona do bazy danych."),plr)
		end
	end
end
--[[
function oprawko(plr, _, nick)
	if not getElementData(plr, "duty") then return end
	if not nick then
		outputChatBox("Użycie: /oprawko <nick>", plr, 255, 255, 255, true)
		return
	end
	local result = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE nick=?", nick)
	if nick and #result > 0 then
		if result[1].admin ~= getPlayerName(plr) then exports["smta_base_notifications"]:noti("Nie możesz oddać prawa jazdy temu graczowi", plr, "error") return end
	    outputChatBox("Oddałeś prawo jazdy graczowi: "..nick, plr, 255, 255, 0)
		exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_licences WHERE nick=?", nick)
		--exports["smta_base_discord"]:connectWeb("**"..getPlayerName(plr).."** oddał prawo jazdy graczu **"..nick.."**.", "logi-komend-adm")
	end
end
--]]
function globalChat(gracz, _, ...)
	if getElementData(gracz, "duty") and ... then
		local tekst = table.concat({...}, " ")
		local duty = getElementData(gracz, "duty")
		local c1, c2, c3 = 255, 255, 255
		if duty == 1 then
			c1, c2, c3 = 65,105,225
		elseif duty == 2 then
			c1, c2, c3 = 34,139,34
		elseif duty == 3 then
			c1, c2, c3 = 153,50,204
		elseif duty == 4 then
			c1, c2, c3 = 255, 0, 0
		end

		outputChatBox(">> "..tekst.." #ffffff- "..getPlayerName(gracz), root, c1, c2, c3, true)
		exports["smta_base_discord"]:connectWeb("GLOBAL - **"..getPlayerName(gracz).."** > "..tekst, "logi-komend-adm")
	end
end

function jp(gracz)
	if getElementData(gracz, "duty") then
		if doesPlayerHaveJetPack(gracz) then
			removePlayerJetPack(gracz)
			exports["smta_base_discord"]:connectWeb("**"..getPlayerName(gracz).."** wyłączył jetpack.", "logi-komend-adm")
		else
			givePlayerJetPack(gracz)
			exports["smta_base_discord"]:connectWeb("**"..getPlayerName(gracz).."** włączył jetpack.", "logi-komend-adm")
		end
	end
end

function tpTo(gracz, _, graczhere)
	if getElementData(gracz, "duty") and graczhere then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		local x, y, z = getElementPosition(graczhere)
		removePedFromVehicle(gracz)
		setElementInterior(gracz,getElementInterior(graczhere))
		setElementDimension(gracz,getElementDimension(graczhere))
		setElementPosition(gracz, x, y+1, z+1)
		if (isPedInVehicle (graczhere) ) then
			local vehicle = getPedOccupiedVehicle ( graczhere )
					local seats = getVehicleMaxPassengers ( vehicle ) + 1
					warpPlayerIntoVehicle(gracz, vehicle, 1)
					end
		exports["smta_base_notifications"]:noti("Teleportowałeś się do \n"..getPlayerName(graczhere), gracz)
		exports["smta_base_discord"]:connectWeb("TT - **"..getPlayerName(gracz).."** > **"..getPlayerName(graczhere).."**", "logi-komend-adm")
	end
end

function dusd(gracz, _, graczhere, ile)
	if getElementData(gracz, "duty") == 4 and graczhere and ile then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		setElementData(graczhere, "pieniadze", getElementData(graczhere, "pieniadze")+ile)
		exports["smta_base_notifications"]:noti("Dałeś "..ile.." USD graczu "..getPlayerName(graczhere), gracz)
		exports["smta_base_notifications"]:noti("Otrzymałeś "..ile.." USD od "..getPlayerName(gracz), graczhere)
		exports["smta_base_discord"]:connectWeb("DUSD - **"..getPlayerName(gracz).."** > **"..getPlayerName(graczhere).."** "..ile, "logi-komend-adm")
	end
end

function dusdbrudne(gracz, _, graczhere, ile)
	if getElementData(gracz, "duty") == 4 and graczhere and ile then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		setElementData(graczhere, "brudne:pieniadze", getElementData(graczhere, "brudne:pieniadze")+ile)
		exports["smta_base_notifications"]:noti("Dałeś "..ile.." brudnych USD graczu "..getPlayerName(graczhere), gracz)
		exports["smta_base_notifications"]:noti("Otrzymałeś "..ile.." brudnych USD od "..getPlayerName(gracz), graczhere)
		exports["smta_base_discord"]:connectWeb("DUSD/BRUDNE - **"..getPlayerName(gracz).."** > **"..getPlayerName(graczhere).."** "..ile, "logi-komend-adm")
	end
end


function dsp(gracz, _, graczhere, ile)
	if getElementData(gracz, "duty") == 4 and graczhere and ile then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		setElementData(graczhere, "punkty", getElementData(graczhere, "punkty")+ile)
		exports["smta_base_notifications"]:noti("Dałeś "..ile.." SocietyPoints graczu "..getPlayerName(graczhere), gracz)
		exports["smta_base_notifications"]:noti("Otrzymałeś "..ile.." SocietyPoints od "..getPlayerName(gracz), graczhere)
		exports["smta_base_discord"]:connectWeb("DSP - **"..getPlayerName(gracz).."** > **"..getPlayerName(graczhere).."** "..ile, "logi-komend-adm")
	end
end

function paliwo(gracz)
	if getElementData(gracz, "duty") > 2 and isPedInVehicle(gracz) then
		local pojazd = getPedOccupiedVehicle(gracz)
		if not pojazd then return end
		local bak = getElementData(pojazd, "bak") or 100
		setElementData(pojazd, "paliwo", bak)
		exports["smta_base_notifications"]:noti("Zatankowałeś pojazd.", gracz)
		exports["smta_base_discord"]:connectWeb("PALIWO - **"..getPlayerName(gracz).."** zatankował pojazd **("..getElementData(pojazd, "id")..")**", "logi-komend-adm")
	end
end

function tpToHere(gracz, _, graczhere)
	if getElementData(gracz, "duty") and graczhere then
		local graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		local x, y, z = getElementPosition(gracz)
		removePedFromVehicle(graczhere)
		setElementPosition(graczhere , x, y+1, z)
		setElementInterior(graczhere ,getElementInterior(gracz))
		setElementDimension(graczhere ,getElementDimension(gracz))		
		exports["smta_base_notifications"]:noti("Teleportowałeś do siebie \n"..getPlayerName(graczhere), gracz)
		exports["smta_base_discord"]:connectWeb("TH - **"..getPlayerName(gracz).."** > **"..getPlayerName(graczhere).."**", "logi-komend-adm")
	end
end

function tpv(gracz, _, id)
	if getElementData(gracz, "duty") and id then
		id = tonumber(id)
		for i,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v, "id") and getElementData(v, "id") == id then
				local x, y, z = getElementPosition(v)
				setElementPosition(gracz, x, y, z)
				exports["smta_base_discord"]:connectWeb("TTV - **"..getPlayerName(gracz).."** teleportował się do pojazdu **("..id..")**.", "logi-komend-adm")
			end
		end
	end
end

function tpvh(gracz, _, id)
	if getElementData(gracz, "duty") and id then
		id = tonumber(id)
		for i,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v, "id") and getElementData(v, "id") == id then
				local x, y, z = getElementPosition(gracz)
				setElementPosition(v, x, y, z)
				exports["smta_base_discord"]:connectWeb("THV - **"..getPlayerName(gracz).."** przeteleportował do siebie pojazd **("..id..")**.", "logi-komend-adm")
			end
		end
	end
end

function aChat(gracz, _, ...)
	if ... and getElementData(gracz, "duty") then
		local tekst = table.concat({...}, " ")
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "duty") then
				outputChatBox("#a32638AC>#ffffff "..getPlayerName(gracz)..": "..tekst, v, 255, 255, 255, true)
			end
		end
		exports["smta_base_discord"]:connectWeb("AC - **"..getPlayerName(gracz).."**: "..tekst, "logi-chat-administracji")
	end
end

function inv(gracz)
	if getElementData(gracz, "duty") then
		if getElementAlpha(gracz) == 255 then
			setElementAlpha(gracz, 0)
	        exports["smta_base_discord"]:connectWeb("INV - **"..getPlayerName(gracz).."** aktywował tryb ninja (invisible)", "logi-komend-adm")
		else
	        exports["smta_base_discord"]:connectWeb("INV - **"..getPlayerName(gracz).."** dezaktywował tryb ninja (invisible)", "logi-komend-adm")
			setElementAlpha(gracz, 255)
		end
	end
end

function spec(gracz, _, graczhere)
	if graczhere and getElementData(gracz, "duty") then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then return end
		if getCameraTarget(gracz) == graczhere then
			setCameraTarget(gracz, gracz)
		else
			setCameraTarget(gracz, graczhere)
			setElementDimension(gracz, getElementDimension(graczhere))
			setElementInterior(gracz, getElementInterior(graczhere))
			if getElementData(graczhere, "duty") > 3 then outputChatBox("Jestes specowany przez "..getPlayerName(gracz).."", graczhere)
			exports["smta_base_discord"]:connectWeb("SPEC - **"..getPlayerName(gracz).."** rozpoczął podglądanie gracza **"..getPlayerName(graczhere).."**", "logi-komend-adm")
		end
	end
	end
end

function specoff(gracz)
	if getElementData(gracz, "duty") then
		removePedFromVehicle(gracz)
		setCameraTarget(gracz, gracz)
		setElementDimension(gracz, 0)
		setElementInterior(gracz, 0)
		setElementPosition(gracz, -1805.40, 946.95, 73.94)
		exports["smta_base_discord"]:connectWeb("SPECOFF - **"..getPlayerName(gracz).."** przestaje podglądać.", "logi-komend-adm")
	end
end

function ilenarko(plr, cmd, target)
	if getElementData(plr, "duty") then
		if not target then return end
		local player = findPlayer(plr, target)
		if player then
	   		outputChatBox(getPlayerName(player).." posiada "..getElementData(player, "weed1").." WEED1 "..getElementData(player, "weed2").." WEED2 "..getElementData(player, "meta1").." META1 "..getElementData(player, "meta2").." META2 "..getElementData(player, "koka1").." KOKA1 "..getElementData(player, "koka2").." KOKA2", plr, 85, 143, 39)
	    	exports["smta_base_discord"]:connectWeb("NARKO - **"..getPlayerName(plr).."** sprawdził narkotyki gracza **"..getPlayerName(player).."**", "logi-komend-adm")
		end
	end
end

function ilekasy(plr, cmd, target)
	if getElementData(plr, "duty") then
		if not target then return end
		local player = findPlayer(plr, target)
		local brudne = getElementData(player, "brudne:pieniadze") or 0
		if player then
	   		outputChatBox(getPlayerName(player).." posiada "..getElementData(player, "pieniadze").." $, w bankomacie: "..getElementData(player, "bankomat").." $ i "..brudne.." brudnych $", plr, 185, 43, 39)
	    	exports["smta_base_discord"]:connectWeb("STAN - **"..getPlayerName(plr).."** sprawdził konto gracza **"..getPlayerName(player).."**", "logi-komend-adm")
		end
	end
end

function iledp(plr, cmd, target)
	if getElementData(plr, "duty") then
		if not target then return end
		local player = findPlayer(plr, target)
		local pp = getElementData(player, "pp") or 0
		if player then
	   	outputChatBox(getPlayerName(player).." posiada "..pp.." DP ", plr, 185, 43, 39)
	    	exports["smta_base_discord"]:connectWeb("STAN - **"..getPlayerName(plr).."** sprawdził konto gracza **"..getPlayerName(player).."**", "logi-komend-adm")
		end
	end
end


function kasaszukaj(plr, cmd, target)
	if getElementData(plr, "oname") or getElementData(plr, "frakcja:sluzba") == "SAPD" then
		if not target then return end
		local player = findPlayer(plr, target)
		local x, y, z = getElementPosition(plr)
		local tx, ty, tz = getElementPosition(player)
		local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
		local brudne = getElementData(player, "brudne:pieniadze") or 0
		if distance < 10 then
		if player then
			   outputChatBox(getPlayerName(player).." posiada "..getElementData(player, "pieniadze").." $ i "..brudne.." brudnych $", plr, 185, 43, 39)
			   outputChatBox(getPlayerName(player).." posiada "..getElementData(player, "weed1").." WEED1 "..getElementData(player, "weed2").." WEED2 "..getElementData(player, "meta1").." META1 "..getElementData(player, "meta2").." META2 "..getElementData(player, "koka1").." KOKA1 "..getElementData(player, "koka2").." KOKA2", plr, 85, 143, 39)
			exports["smta_base_discord"]:connectWeb("PRZESZUKAJ - **"..getPlayerName(plr).."** sprawdził gracza **"..getPlayerName(player).."**", "logi-komend-adm")
			triggerEvent("odegrajRp:eq", player, player, "#4343ff*"..getPlayerName(plr).." przeszukał gracza "..getPlayerName(player).."")
			triggerClientEvent("dLogi", root, "PRZESZUKAJ> "..getPlayerName(plr).." ["..getElementData(plr, "id").."] przeszukał gracza "..getPlayerName(player).." ["..getElementData(player, "id").."]")
		end
	end
else
	exports["smta_base_notifications"]:noti("Gracz znajduje się za daleko.", plr, "error")
	end
end

function fix(admin, cmd, komu)
	if getElementData(admin, "duty") then
		if not komu then return end
		local gracz = findPlayer(admin, komu)
		if gracz then
			local veh = getPedOccupiedVehicle(gracz)
			if not veh then return end
			fixVehicle(veh)
			exports["smta_base_notifications"]:noti(getPlayerName(admin).." naprawił ci pojazd.", gracz)
	    	exports["smta_base_discord"]:connectWeb("FIX - **"..getPlayerName(admin).."** naprawił pojazd **("..(getElementData(veh, "id") or 0)..")** graczowi **"..getPlayerName(gracz).."**.", "logi-komend-adm")
		end
	end
end

local teleporty = {
{"spawn", -1806.62, 537.14, 35.17},
{"przecho", -2095.47, -21.83, 35.32},
{"prawko", -2026.87, -95.29, 35.16},
{"salondoh", -1982.99, 280.96, 34.95},
{"nurek", -1481.21, 692.02, 1.32},
{"gielda", -1913.51, -864.62, 32.17},
{"tunersf", -2267.95, -156.80, 35.32},
{"salonlux", -1640.22, 1207.40, 7.18},
{"cygan", -1898.17, -568.33, 24.59},
{"import", -1689.58, 18.08, 3.55},
{"kasyno", -1804.04, 900.55, 24.88},
{"tramwaje", -1755.10, 946.07, 24.88},
{"farma", -1199.04, -1075.66, 129.18},
{"samc", -2662.49, 634.96, 14.45},
{"sapd", -1610.63, 718.37, 12.90},
{"safd", -2081.54, 526.75, 35.16},
{"pralnia", -2765.61, 778.22, 52.78},

}

function teleportuj(gracz, _, gdzie)
	if not getElementData(gracz, "duty") then return end
	if not gdzie then
		tepki = { }
		for i, v in ipairs(teleporty) do
			table.insert(tepki, v[1])
		end
			outputChatBox("Dostępne teleporty: "..table.concat(tepki, ", ").."", gracz)
		return
	end
	for i, v in ipairs(teleporty) do
		if gdzie == v[1] then
			if getPedOccupiedVehicle(gracz) then
				setElementPosition(getPedOccupiedVehicle(gracz), v[2], v[3], v[4])
			else
				setElementPosition(gracz, v[2], v[3], v[4])
				setElementInterior(gracz,0)
				setElementDimension(gracz,0)
			end
		end
	end
end

function unbw(gracz, _, kogo)
	if not getElementData(gracz, "duty") then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kogo)
	if not target then exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza", gracz, "error") return end
	if not getElementData(target, "bw") then exports["smta_base_notifications"]:noti("Dany gracz nie posiada bw", gracz, "error") return end
	triggerClientEvent(target, "usunBw", target)
	--exports["smta_base_notifications"]:noti(""..getPlayerName(gracz).." zdjął ci bw.", target)
	exports["smta_base_discord"]:connectWeb("UNBW - **"..getPlayerName(gracz).."** zdjął bw graczu **"..getPlayerName(target).."**.", "logi-komend-adm")
end

function samcunbw(gracz, _, kogo)
	if not getElementData(gracz, "frakcja:sluzba") == "SAMC" then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kogo)
	if not target then exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza", gracz, "error") return end
	if not getElementData(target, "bw") then exports["smta_base_notifications"]:noti("Dany gracz nie posiada bw", gracz, "error") return end
	triggerClientEvent(target, "usunBw", target)
	exports["smta_base_notifications"]:noti(""..getPlayerName(gracz).." zdjął ci bw.", target)
	exports["smta_base_discord"]:connectWeb("SAMC/UNBW - **"..getPlayerName(gracz).."** zdjął bw graczu **"..getPlayerName(target).."**.", "logi-komend-adm")
end


function bw(gracz, _, kogo)
	if not getElementData(gracz, "duty") or not kogo then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kogo)
	if not target then exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza", gracz, "error") return end
	if getElementData(target, "bw") then exports["smta_base_notifications"]:noti("Dany gracz aktualnie posiada bw", gracz, "error") return end
	killPlayer(target, target)
	--exports["smta_base_notifications"]:noti(""..getPlayerName(gracz).." nakłada ci bw.", target)
	exports["smta_base_discord"]:connectWeb("BW - **"..getPlayerName(gracz).."** nadał bw graczu **"..getPlayerName(target).."**.", "logi-komend-adm")
end


function duty(gracz)
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_admins WHERE gracz=? AND serial=?", getPlayerName(gracz), getPlayerSerial(gracz))
	if #spr > 0 then
		local el = getPlayerName(gracz)
		if getElementData(gracz, "duty") then
			exports["smta_base_discord"]:connectWeb("**"..el.."** wylogował się z służbę.", "logi-komend-adm")
			setElementData(gracz, "duty", false)
			setElementData(gracz, "hex", false)
			setElementData(gracz, "ranga", false)
	        outputChatBox("* Wylogowano z służby administracyjnej.", gracz, 185, 43, 39)
		else
			exports["smta_base_discord"]:connectWeb("**"..el.."** zalogował się na służby.", "logi-komend-adm")
			setElementData(gracz, "duty", spr[1].tranga)
			setElementData(gracz, "ranga", spr[1].ranga)
			setElementData(gracz, "hex", spr[1].hex)
			outputChatBox("* Zalogowano na służbe administracyjną.", gracz, 21, 101, 192)
		end
	end
end

addCommandHandler("admins", function(plr)
	outputChatBox("Administracja ONLine:", plr, 255, 0, 0)
	for i,v in ipairs(getElementsByType("player")) do
		local ranga = getElementData(v, "ranga")
		if ranga then
			local hex = getElementData(v, "hex") or "#ffffff"
			outputChatBox("["..getElementData(v,"id").."] "..getPlayerName(v).." - "..hex..ranga.."#ffffff", plr, 255, 255, 255, true)
		end
	end
end)


function auto(plr, cmd, id)
        if getElementData(plr, "duty") > 1 then
                if not id then return end
                local x, y, z = getElementPosition(plr)
                local dim = getElementDimension(plr);
                local int = getElementInterior(plr);
                local veh = createVehicle(id, x+5, y, z)
                setElementInterior(veh, int);
                setElementDimension(veh, dim);
                local el = getPlayerName(plr)
                exports["smta_base_discord"]:connectWeb("AUTO - **"..el.."** stworzył pojazd tymczasowy.", "logi-komend-adm")
                setElementData(veh, "usuwanie", true)
        end
end

function pojazdy(plr, cmd, id)
	if not getElementData(plr, "duty") then return false; end
	if not id then return false; end

	local target = getElementByID("p"..id);
	if not target then return false; end

	local dbid = getElementData(target, "dbid");
	if not dbid then return false; end

	local pojazdy = exports['smta_base_db']:wykonaj("SELECT id, model FROM smtadb_vehicles WHERE wlasciciel=?", dbid);
	if #pojazdy < 1 then
		exports['smta_base_notifications']:noti("Ten gracz nie posiada pojazdów", plr, "error");
		return false;
	end

	local string = "";
	for k,v in ipairs(pojazdy) do
		string = string .. getVehicleNameFromModel(v.model) .. " [" .. v.id .. "], ";
	end

	outputChatBox("* Pojazdy gracza " .. getPlayerName(target), plr, 150, 123, 182);
	outputChatBox(string, plr, 181, 126, 220);
end
addCommandHandler("pojazdy", pojazdy);

function dim(plr, cmd, value)
	if getElementData(plr, "duty") then
        if (not value) then
            outputChatBox("Użycie:: /dim <ilość>", plr, "error")
            return
        end
        setElementDimension(plr, value)
        exports["smta_base_discord"]:connectWeb("DIM - **"..getPlayerName(plr).."** zmienił swój dimension na "..value..".", "logi-komend-adm")
    end
end

function usun(plr)
	local veh = getPedOccupiedVehicle(plr)
	if not getElementData(plr, "duty") then return end
	if veh and getElementData(veh, "usuwanie") then
		destroyElement(veh)
		local el = getPlayerName(plr)
		exports["smta_base_discord"]:connectWeb("USUN - **"..el.."** usunął pojazd tymczasowy.", "logi-komend-adm")
	end
end

function najedz(gracz, _, kogo)
	if not getElementData(gracz, "duty") then return end
	if not kogo then return end
	local target = exports["smta_base_core"]:findPlayer(gracz, kogo)
	if not target then
		exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz, "error")
		return
	end
	setElementData(target, "najedzenie", 100)
	exports["smta_base_notifications"]:noti(""..getPlayerName(gracz).." dał ci 100% najedzenia.", target)
	exports["smta_base_discord"]:connectWeb("JEDZ - **"..getPlayerName(gracz).."** nadał 100% najedzenia graczu **"..getPlayerName(target).."**.", "logi-komend-adm")
end

function flip(admin, cmd, komu)
	if getElementData(admin, "duty") then
		if not komu then return end
		local gracz = findPlayer(admin, komu)
		if gracz then
			local veh = getPedOccupiedVehicle(gracz)
			if not veh then return end
			--fixVehicle(veh)
			setElementRotation(veh, 0, 0, 0)
			exports["smta_base_notifications"]:noti(getPlayerName(admin).." obrócił ci pojazd.", gracz)
	    	exports["smta_base_discord"]:connectWeb("FLIP - **"..getPlayerName(admin).."** obrócił pojazd **("..(getElementData(veh, "id") or 0)..")** graczowi **"..getPlayerName(gracz).."**.", "logi-komend-adm")
		end
	end
end


function ulecz(plr, cmd, value)
	if getElementData(plr, "duty") then
		if not value then
			outputChatBox("Użycie:: /heal <id/nick>", plr, "error")
			return
		end
		local target = findPlayer(plr,value)
		if not target then
			exports["smta_base_notifications"]:noti("Nie ma takiego gracza!", plr, "error")
			return
		end
		setElementHealth(target, 100)
		local el = getPlayerName(plr)
		exports["smta_base_notifications"]:noti("* Uleczyłeś(aś) gracza " ..getPlayerName(target):gsub("#%x%x%x%x%x%x",""), plr)
		exports["smta_base_notifications"]:noti("* Zostałeś uleczony(a) przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), target)
		exports["smta_base_discord"]:connectWeb("HEAL - **"..el.."** uleczył gracza **"..getPlayerName(target).."**.", "logi-komend-adm")
    end
end

function dajprzedmiot(plr, _, gracz, ...)
	if getElementData(plr, "duty") == 4 then
		if not ... then
			outputChatBox("Użycie:: /pdaj <gracz> <nazwa przedmiotu>", plr, "error")
			return
		end
		local nazwa = table.concat({...}, " ")
		local target=findPlayer(plr, gracz)
		if not target then
			exports["smta_base_notifications"]:noti("Nie ma takiego gracza!", plr, "error")
			return
		end
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_items SET dbid=?, nick=?, nazwa=?", getElementData(target, "dbid"), getPlayerName(target), nazwa)
		exports["smta_base_notifications"]:noti(getPlayerName(plr).." dał ci "..nazwa, target)
		exports["smta_base_notifications"]:noti("Dajesz "..nazwa.." graczu "..getPlayerName(target), plr)
	end
end


local komendy = {
	{"gc", globalChat},
	{"tt",	tpTo},
	{"th",	tpToHere},
	{"dusd", dusd},
	{"paliwo", paliwo},
	{"ttv", tpv},
	{"thv", tpvh},
	{"ac", aChat},
	{"b", zbanuj},
	{"nb", ninjazbanuj},
	{"k", kicknij},
	{"warn", warnij},
	{"swarn", swarnij},
	{"zpj", prawko},
	{"jp", jp},
	{"spec", spec},
	{"inv", inv},
	{"dsp", dsp},
	{"dusdb", dusdbrudne},
	{"specoff", specoff},
	{"stan", ilekasy},
	{"iledp", iledp},
	{"narko", ilenarko},
	{"przeszukaj", kasaszukaj},
	{"fix", fix},
	{"ainfo", admininfo},
	{"tp", teleportuj},
	{"unbw", unbw},
	{"podnies", samcunbw},
	{"bw", bw},
	{"mt", mute},
	{"duty", duty},
	{"auto", auto},
	{"dim", dim},
	{"usun", usun},
	{"flip", flip},
	{"heal", ulecz},
	--{"oprawko", oprawko},
	{"dj", najedz},
	{"pdaj", dajprzedmiot},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(komendy) do
		addCommandHandler(v[1], v[2])
	end
end)

addEventHandler("onVehicleExit", resourceRoot, function(player, seat)
	if seat ~= 0 then return end
	if getElementData(source, "usuwanie") then
		destroyElement(source)
	end
end)

function reporty()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_reports")
	return spr
end

addEvent("poka:reporty", true)
addEventHandler("poka:reporty", root, function()
	triggerClientEvent(source, "pokaz:reporty", source, reporty())
end)

addEvent("usunReporta", true)
addEventHandler("usunReporta", root, function(id, gracz)
	if #exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_reports WHERE id=?", id) == 0 then return end
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_reports WHERE id=?", id)
	exports["smta_base_db"]:wykonaj("UPDATE smtadb_admins SET rapsy=rapsy+1 WHERE serial=?", getPlayerSerial(client))
	exports["smta_base_discord"]:connectWeb("DEL-RAPORT - **"..getPlayerName(client).."** usunął raport gracza **"..getPlayerName(client).."**", "logi-raporty")
	setElementData(client, "pieniadze", getElementData(client, "pieniadze")+150)
	if getPlayerFromName(gracz) then
		exports["smta_base_notifications"]:noti(""..getPlayerName(client).." zajął się twoim raportem", getPlayerFromName(gracz))
	end
	for i, v in ipairs(getElementsByType("player")) do
		if getElementData(v, "duty") then
			local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_admins WHERE serial=?", getPlayerSerial(client))
			outputChatBox("R "..getPlayerName(client).." ["..spr[1].rapsy.."] usuwa raporta od gracza "..getPlayerName(getPlayerFromName(gracz)), v, 185, 43, 39)
		end
	end
end)

function muty()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute")
	return spr
end

addEvent("poka:muty", true)
addEventHandler("poka:muty", root, function()
	triggerClientEvent(source, "pokaz:muty", source, muty())
end)

addEvent("usun:muta", true)
addEventHandler("usun:muta", root, function(id)
	if #exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE id=?", id) == 0 then return end
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE id=?", id)
end)

function bany()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_bans")
	return spr
end

addEvent("poka:bany", true)
addEventHandler("poka:bany", root, function()
	triggerClientEvent(source, "pokaz:bany", source, bany())
end)

addEvent("usun:bana", true)
addEventHandler("usun:bana", root, function(id)
	if #exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_bans WHERE id=?", id) == 0 then return end
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_bans WHERE id=?", id)
end)

function prawka()
	local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences")
	return spr
end

addEvent("poka:prawka", true)
addEventHandler("poka:prawka", root, function()
	triggerClientEvent(source, "pokaz:prawka", source, prawka())
end)

addEvent("usun:prawko", true)
addEventHandler("usun:prawko", root, function(id)
	if #exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE id=?", id) == 0 then return end
	exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_licences WHERE id=?", id)
end)

function report(gracz, cmd, graczhere, ...)
	if ... and graczhere then
		graczhere = findPlayer(gracz, graczhere)
		if not graczhere then
			exports["smta_base_notifications"]:noti("Nie znaleziono podanego gracza.", gracz)
			return
		end
		local tekst = table.concat({...}, " ")
		exports["smta_base_notifications"]:noti("Pomyślnie wysłano zgłoszenie na gracza "..getPlayerName(graczhere).." o treści "..tekst, gracz)
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_reports SET kto=?, kogo=?, kiedy=NOW(), powod=?", getPlayerName(gracz), getPlayerName(graczhere), tekst)
		exports["smta_base_discord"]:connectWeb("RAPORT - **"..getPlayerName(gracz).."** napisał zgłoszenie na gracza **"..getPlayerName(graczhere).."**, treść: "..tekst, "logi-raporty")
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "duty") then
				exports["smta_base_notifications"]:noti("Nowy raport na gracza "..getPlayerName(graczhere), v)
			end
		end
	else
		exports["smta_base_notifications"]:noti("* Użycie: /"..cmd.." [id/nick] [powód]", gracz, "error")
	end
end
addCommandHandler("report", report)
addCommandHandler("raport", report)



--opcje


function findPlayer(p, ph)
	for i,v in ipairs(getElementsByType("player")) do
		if tonumber(ph) then
			if getElementData(v, "id") == tonumber(ph) then
				return getPlayerFromName(getPlayerName(v))
			end
		else
			if string.find(string.gsub(getPlayerName(v):lower(),"#%x%x%x%x%x%x", ""), ph:lower(), 1, true) then
				return getPlayerFromName(getPlayerName(v))
			end
		end
	end
end

local serials = {
	["F5686A30BDBAB03643105204222F28F3"] = true,
}

addEventHandler("onPlayerCommand", root, function(cmd)
	if cmd == "shutdown" then cancelEvent() end
	if cmd == "runcode" then cancelEvent() end
	if cmd == "refreshall" then cancelEvent() end
	if cmd == "logout" then cancelEvent() end
	if cmd == "msg" then cancelEvent() end
	if cmd == "nick" then cancelEvent() end
	if cmd == "chgmypass" then cancelEvent() end
	if cmd == "ver" then cancelEvent() end
	if cmd == "whowas" then cancelEvent() end
	if cmd == "whois" then cancelEvent() end
	if cmd == "sver" then cancelEvent() end
	if cmd == "openports" then cancelEvent() end
	if cmd == "help" then cancelEvent() end
	if cmd == "debugdb" then cancelEvent() end
	if cmd == "ase" then cancelEvent() end
	if cmd == "stopall" then cancelEvent() end
	if cmd == "refreshall" then cancelEvent() end
	if not serials[getPlayerSerial(source)] then
		if cmd == "aexec" then cancelEvent() end
		if cmd == "login" then cancelEvent() end
		if cmd == "register" then cancelEvent() end
		if cmd == "reloadmodule" then cancelEvent() end
		if cmd == "unloadmodule" then cancelEvent() end
		if cmd == "loadmodule" then cancelEvent() end
		if cmd == "delaccount" then cancelEvent() end
		if cmd == "addaccount" then cancelEvent() end
		if cmd == "aclrequest" then cancelEvent() end
		if cmd == "upgrade" then cancelEvent() end
		if cmd == "list" then cancelEvent() end
		if cmd == "check" then cancelEvent() end
		if cmd == "refreshall" then cancelEvent() end
		if cmd == "maps" then cancelEvent() end
		if cmd == "zarejestruj" then cancelEvent() end
	end
end)

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




function worek(plr, cmd, ...)
	if getElementData(plr, "duty") > 2 then
	if not ... then
		exports['smta_base_notifications']:noti("Użycie:: /worek [podpowiedź]", plr, "error");
		return false;
	end
	local text = table.concat({...}, " ");

	local x,y,z = getElementPosition(plr);
	local worek = createPickup(x+4, y, z, 3, 1550);
	setElementData(worek, "autor", plr);
	local txt = "Administrator " .. getPlayerName(plr) .. " porzucił worek pełen pieniędzy! Podpowiedź: "..text
	triggerClientEvent(getRootElement(), "notiAdmin4", getRootElement(), txt)
	addEventHandler("onPickupHit", worek, podniesworek);
	end
end
addCommandHandler("worek", worek);

function podniesworek(hitElement, matchDimensions)
	cancelEvent();
	if getElementData(source, "autor") == hitElement then return false; end

	local r = math.random(1000, 5000);
	setElementData(hitElement, "pieniadze", getElementData(hitElement, "pieniadze") + r);
	destroyElement(source);
	--local txt = getPlayerName(hitElement).." odnalazł worek z #ff0000"..r.." USD "
	triggerClientEvent(getRootElement(), "notiAdmin4", getRootElement(), ""..getPlayerName(hitElement).." odnalazł worek z kwotą: "..r.." USD ")
end
