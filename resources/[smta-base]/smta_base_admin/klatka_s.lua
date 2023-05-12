--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local kratki={}
klatka = {}
local komenda = "klatka"

addCommandHandler(komenda, function(plr, cmd, target)
	if not getElementData(plr, "duty") then return false end
	if not target then return end

	local cel = findPlayer(plr,target)
	if not cel then
		return outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
	end

	local x,y,z=getElementPosition(cel)
	local dim=getElementDimension(cel)
	local int=getElementInterior(cel)

	if kratki[cel] then
		for i=1, #kratki[cel] do
			if isElement(kratki[cel][i]) then
				destroyElement(kratki[cel][i])
			end
		end
		kratki[cel]=nil
	end

	kratki[cel]={}
	kratki[cel][1]=createObject(971, x, y, z-0.9, 270, 0, 180.0)
	kratki[cel][2]=createObject(971, x, y, z+6, 270, 0, 180)
	kratki[cel][3]=createObject(971, x, y+3.5, z+2.5, 0, 0, 0)
	kratki[cel][4]=createObject(971, x-4.5, y, z+2.5, 0, 0, 270)
	kratki[cel][5]=createObject(971, x, y-3.5, z+2.5, 0, 0, 180)
	kratki[cel][6]=createObject(971, x+4, y, z+2.5, 0, 0, 270) 
	table.insert ( klatka, kratki[cel][1] )
	table.insert ( klatka, kratki[cel][2] )
	table.insert ( klatka, kratki[cel][3] )
	table.insert ( klatka, kratki[cel][4] )
	table.insert ( klatka, kratki[cel][5] )
	table.insert ( klatka, kratki[cel][6] )
	

	setElementInterior(kratki[cel][1], int)
	setElementDimension(kratki[cel][1], dim)
	setElementInterior(kratki[cel][2], int)
	setElementDimension(kratki[cel][2], dim)
	setElementInterior(kratki[cel][3], int)
	setElementDimension(kratki[cel][3], dim)
	setElementInterior(kratki[cel][4], int)
	setElementDimension(kratki[cel][4], dim)
	setElementInterior(kratki[cel][5], int)
	setElementDimension(kratki[cel][5], dim)
	setElementInterior(kratki[cel][6], int)
	setElementDimension(kratki[cel][6], dim)
	outputChatBox("Stworzono klatke na graczu " .. getPlayerName(cel), plr)
end)

function zabezpieczenie()
	if kratki[source] then
		for i=1, #kratki[source] do
			if isElement(kratki[source][i]) then
				destroyElement(kratki[source][i])
			end
		end
		kratki[source]=nil
	end
end
addEventHandler("onPlayerQuit", root, zabezpieczenie)

addCommandHandler ( "usunklatke", function(plr, cmd, target)
	if not getElementData(plr, "duty") then outputChatBox("*Brak uprawnien", plr) return end
	if not target then 
		return
	end

	local cel = findPlayer(plr,target)
	if not cel then
		outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
		return
	end
	if kratki[cel] then
		for i=1, #kratki[cel] do
			if isElement(kratki[cel][i]) then
				destroyElement(kratki[cel][i])
			end
		end
		kratki[cel]=nil
	end
end)

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