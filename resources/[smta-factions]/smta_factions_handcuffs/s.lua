local kaj = { }
local timer = { }

function zalozkaj(plr, cmd, target)
	if getElementData(plr, "frakcja:sluzba") == "SAPD" or getElementData(plr, "oname") then
	local gracz = exports["smta_base_core"]:findPlayer(plr, target)
	if not getElementData(plr, "kajdanki") then
		local gracz = getPlayerName(gracz)
		local gracz = getPlayerFromName(gracz)
		local x2,y2,z2 = getElementPosition(gracz)
		local x,y,z = getElementPosition(plr)
		if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<20) then
			toggleControl(gracz, "enter_exit", false)
			toggleControl(gracz, "enter_passenger", false)
			attachElements(gracz, plr, 0,1.1,0)
			setElementPosition(gracz, x,y,z)
			local graczz = getPlayerName(gracz)
			kaj[plr] = {}
			kaj[plr] = {graczz}
			setElementData(plr, "kajdanki", true)
			setElementData(gracz, "kajdanki", true)
			exports["smta_base_notifications"]:noti(""..getPlayerName(plr).." zakuwa cię w kajdanki.", gracz)
			exports["smta_base_notifications"]:noti("Zakładasz kajdanki graczowi "..graczz..".", plr)
			end
		end
	else
		exports["smta_base_notifications"]:noti("Nie możesz założyć kajdanek dwóm osobom na raz.", plr, "error")
	end
end
addCommandHandler("z", zalozkaj)

addEventHandler("onVehicleEnter", root, function(plr)
	if getElementData(plr, "kajdanki") then
		local peds = kaj[plr][1]
		local ped = getPlayerFromName(peds)
		local veh = getPedOccupiedVehicle(plr)
		local atta = getAttachedElements(plr)
		for i,v in pairs(atta)do
			detachElements(v, plr)
		end
		warpPedIntoVehicle(ped, veh, 3)
		exports["smta_base_notifications"]:noti(getPlayerName(plr).." wsadza cię do pojazdu.", ped)
		exports["smta_base_notifications"]:noti("Wsadzasz do pojazdu gracza "..getPlayerName(ped)..".", plr)
	end
end)

addEventHandler("onVehicleStartExit", root, function(plr)
	if getElementData(plr, "kajdanki") then
		local ped = kaj[plr][1]
		local ped = getPlayerFromName(ped)
		local x,y,z = getElementPosition(plr)
		removePedFromVehicle(ped)
		attachElements(ped, plr, 0,1.1,0)
		exports["smta_base_notifications"]:noti(getPlayerName(plr).." wyciąga cię z pojazdu.", ped)
		exports["smta_base_notifications"]:noti("Wyciągasz z pojazdu gracza "..getPlayerName(ped)..".", plr)
	end
end)

function sciagnijkaj(plr, cmd, target)
	local gracz = exports["smta_base_core"]:findPlayer(plr, target)
	if getElementData(plr, "kajdanki") then
		local gracz = getPlayerName(gracz)
		local gracz = getPlayerFromName(gracz)
		local x2,y2,z2 = getElementPosition(gracz)
		local x,y,z = getElementPosition(plr)
		if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<20) then
			local atta = getAttachedElements(plr)
			toggleControl(gracz, "enter_exit", true)
			toggleControl(gracz, "enter_passenger", true)
			for i,v in pairs(atta)do
				detachElements(v, plr)
			end
			setElementPosition(gracz, x+2.5,y,z)
			setElementData(plr, "kajdanki", false)
			setElementData(gracz, "kajdanki", false)
			kaj[plr] = {}
			exports["smta_base_notifications"]:noti(""..getPlayerName(plr).." odkuwa cię.", gracz)
			exports["smta_base_notifications"]:noti("Ściągasz kajdanki graczowi "..getPlayerName(gracz)..".", plr)
		end
	else
		exports["smta_base_notifications"]:noti("Nie załozyłeś nikomu kajdanek.", plr, "error")
	end
end
addCommandHandler("oz",sciagnijkaj)

addEventHandler("onPlayerQuit", root, function()
	if getElementData(source, "kajdanki") then
		exports["smta_base_db"]:wykonaj("INSERT INTO smtadb_bans SET nick=?, serial=?, ip=?, data=(NOW() + INTERVAL 15 MINUTE), admin=?, powod=?", getPlayerName(source), getPlayerSerial(source), getPlayerIP(source), "Kajdanki_CONSOLE", "Wyjście podczas bycia skutym")
	end
end)