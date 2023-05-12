--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addCommandHandler("postaw",function(source, cmd)
	local tabelka = getElementData(source, "gracz:objekty") or {}
	if not getElementData(source, "co") then return end
	local co = getElementData(source, "co")
	if co == "pacholek" then
		local rotX,rotY,rotZ = getElementRotation(source)
		local x,y,z = getElementPosition(source)
		pacholek = createObject(1238, x, y, z-0.65,0,0, rotZ)
		attachElements(pacholek, source, 0, 1, -0.65)
		detachElements(pacholek, source)
		table.insert(tabelka, pacholek)
		setElementData(source, "gracz:objekty", tabelka)
		--setElementPosition ( source, x, y, z+1 )
		setElementFrozen(pacholek , true)
		setElementData(pacholek, "postawil", getElementData(source, "dbid"))
		triggerClientEvent("niedozniszczenia",pacholek)
	elseif co == "barierka" then
		local x,y,z = getElementPosition(source)
		local rotX,rotY,rotZ = getElementRotation(source)
		barierka = createObject(1228, x, y, z-0.65, 0, 0, rotZ+90)
		attachElements(barierka, source, 0, 1, -0.65, 0, 0, rotZ+90)
		detachElements(barierka, source)
		table.insert(tabelka, barierka)
		setElementData(source, "gracz:objekty", tabelka)
		setElementFrozen(barierka, true)
		setElementData(barierka, "postawil", getElementData(source, "dbid"))
		triggerClientEvent("niedozniszczenia",barierka)
	elseif co == "linnia" then
		--stworz_linnie(source)
	end
end)

addCommandHandler("usun", function(plr)
	if getElementData(plr, "gracz:objekty") then
		for key, value in ipairs(getElementData(plr, "gracz:objekty")) do
			if isElement(value) then
				destroyElement(value)
			end
		end
		removeElementData(plr, "gracz:objekty")
		usun_linnie(plr)
	end
end)

addEvent("usunBlokady", true)
addEventHandler("usunBlokady", root, function(plr)
	if getElementData(plr, "gracz:objekty") then
	for key, value in ipairs(getElementData(plr, "gracz:objekty")) do
		if isElement(value) then
			destroyElement(value)
		end
	end
	removeElementData(plr, "gracz:objekty")
	end
end)

addEvent("usunTaBlokade", true)
addEventHandler("usunTaBlokade", root, function(element)
	destroyElement(element)
end)

-- do linni

data = {}
data.start = not true

function stworz_linnie(plr)
	if not data.start then
		triggerClientEvent(getRootElement(), "createLine",getRootElement(),plr,false)
		data.start = not false
	else
		triggerClientEvent(getRootElement(),"createLine",getRootElement(),plr,true)
		data.start = not true
	end
end

function usun_linnie(plr)
		triggerClientEvent(getRootElement(), "destroyLine",getRootElement(),plr)
end

addEventHandler("onPlayerQuit",getRootElement(),function()
		triggerClientEvent(getRootElement(), "destroyLine",getRootElement(),source)
end)


-- wypłaty zajebane

setTimer(function()
	local time = getRealTime()
	if time.hour == 23 and time.minute == 59 and time.weekday == 0 then
		exports["smta_base_Db"]:wykonaj("UPDATE smtadb_factions SET minuty=0")
		for i, v in ipairs(getElementsByType("player")) do
			setElementData(v, "fminuty", 0)
		end
	end
end, 60000, 0)

addEvent("minuty:frakcji", true)
addEventHandler("minuty:frakcji", root, function()
	exports["smta_base_Db"]:wykonaj("UPDATE smtadb_factions SET minuty=minuty+1 WHERE dbid=?", getElementData(client, "dbid"))
end)

local id = 0

addCommandHandler("sara", function(gracz)
	if getElementDimension(gracz) > 0 then return end
	exports["smta_base_notifications"]:noti("Wzywasz", gracz)
	id = id+1
	for i, v in ipairs(getElementsByType("player")) do
		if getElementData(v, "frakcja:sluzba") == "SARA" then
			local x,y,z = getElementPosition(gracz)
			outputChatBox("-----------", v, 255, 0, 0)
			outputChatBox(getPlayerName(gracz).." wzywa cię! "..getZoneName(x, y, z, true)..", "..getZoneName(x, y, z, false), v, 0, 255, 0)
			outputChatBox("-----------", v, 255, 0, 0)
			triggerClientEvent(v, "stworz:wezwanie:oz", v, x, y, z, id, gracz)
		end
	end
end)

addCommandHandler("taxi", function(gracz)
	if getElementDimension(gracz) > 0 then return end
	exports["smta_base_notifications"]:noti("Wzywasz taxi", gracz)
	id = id+1
	for i, v in ipairs(getElementsByType("player")) do
		if getElementData(v, "frakcja:sluzba") == "SATC" then
			local x,y,z = getElementPosition(gracz)
			outputChatBox("-----------", v, 255, 0, 0)
			outputChatBox(getPlayerName(gracz).." wzywa cię! "..getZoneName(x, y, z, true)..", "..getZoneName(x, y, z, false), v, 0, 255, 0)
			outputChatBox("-----------", v, 255, 0, 0)
			triggerClientEvent(v, "stworz:wezwanie:oz", v, x, y, z, id, gracz)
		end
	end
end)

addEvent("usun:marker:zglo", true)
addEventHandler("usun:marker:zglo", root, function(id)
	triggerClientEvent(root, "usun:markerek:zglo", root, id)
end)