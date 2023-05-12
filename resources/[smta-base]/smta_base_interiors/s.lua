--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

exports.smta_base_db:wykonaj("set names utf8")
local query = exports["smta_base_db"]:wykonaj("select * from smtadb_interiors")
--local query = exports.smta_base_db:wykonaj("select * from smtadb_interiors")

for i,v in ipairs(query) do
	--join
	local join_pos = split(v.en_marker, ",")
	local join = createMarker(join_pos[1], join_pos[2], join_pos[3]+0.7, "arrow", 1.1, 62, 180, 137, 50)
	local tw=createElement("text")
	setElementData(tw, "text", v.name)
	setElementPosition(tw, join_pos[1], join_pos[2], join_pos[3])
	setElementPosition(text, join_pos[1], join_pos[2], join_pos[3])
	setElementData(join, "text", v.name)
	setElementData(join, "data", v)
	setElementData(join, "type", "join")
	setElementData(join, "drzwi", true)
	setElementInterior(join, join_pos[4])
	setElementDimension(join, join_pos[5])
	--exit
	local exit_pos = split(v.ex_marker, ",")
	local exit = createMarker(exit_pos[1], exit_pos[2], exit_pos[3]+0.7, "arrow", 1.1, 173, 223, 173, 50)
	local text = createElement("text")
	setElementData(text, "text", "Wyjście")
	setElementPosition(text, exit_pos[1], exit_pos[2], exit_pos[3])
	--setElementData(exit, "text", "Wyjście")
	setElementData(exit, "data", v)
	setElementData(exit, "type", "exit")
	setElementData(exit, "drzwi", true)
	setElementInterior(exit, exit_pos[4])
	setElementDimension(exit, exit_pos[5])
end

function xGet(player,marker)
	local d1 = getElementDimension(player)
	local d2 = getElementDimension(marker)
	local i1 = getElementInterior(player)
	local i2 = getElementInterior(marker)
	if tonumber(d1) == tonumber(d2) and tonumber(i1) == tonumber(i2) then
		return true
	end
	return false
end

addEventHandler("onMarkerHit", resourceRoot, function(hit)
	if getElementType(hit) ~= "player" then return end
	if isPedInVehicle(hit) then return end
	if not xGet(hit,source) then return end
	local data = getElementData(source, "data")
	local type = getElementData(source, "type")
	if type == "join" and data.locked ~= 1 then
		triggerClientEvent(hit, "interiors:obj", hit, 0, 1)
		fadeCamera(hit, false)
		setElementFrozen(hit, true)
		exports["smta_base_notifications"]:noti("Wchodzisz do pomieszczenia.", hit)
		setTimer(function()
			if hit and isElement(hit) then
				local pos = split(data.en_tp, ",")
				setElementPosition(hit, pos[1], pos[2], pos[3])
				setElementInterior(hit, pos[4])
				setElementDimension(hit, pos[5])
			end
		end, 1000, 1)
		setTimer(function()
			if hit and isElement(hit) then
				fadeCamera(hit, true)
				setElementFrozen(hit, false)
			end
		end, 2000, 1)
	elseif type == "exit" then
		setTimer(function()
			if hit and isElement(hit) and getElementDimension(hit) == 0 then
				triggerClientEvent(hit, "interiors:obj", hit, 0, 0)
			end
		end, 60000, 1)
		fadeCamera(hit, false)
		setElementFrozen(hit, true)
		exports["smta_base_notifications"]:noti("Wychodzisz z pomieszczenia.", hit)
		setTimer(function()
			if hit and isElement(hit) then
				local pos = split(data.ex_tp, ",")
				setElementPosition(hit, pos[1], pos[2], pos[3])
				setElementInterior(hit, pos[4])
				setElementDimension(hit, pos[5])
			end
		end, 1000, 1)
		setTimer(function()
			if hit and isElement(hit) then
				fadeCamera(hit, true)
				setElementFrozen(hit, false)
			end
		end, 2000, 1)
	end
end)