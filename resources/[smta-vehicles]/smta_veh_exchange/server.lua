--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local cuboid = {}
local markers = {}

addEvent("kuppojazd:gielda", true)
addEventHandler("kuppojazd:gielda", root, function(pojazd)
	local gracz = source
	local gielda = getElementData(pojazd, "gielda")
	if not gielda then return end
	local kasa = getElementData(gracz, "pieniadze")
	gielda.cena = string.format("%1d", gielda.cena)
	if kasa < tonumber(gielda.cena) then
			exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej ilości pieniędzy!", gracz, "error")
		return
	end
	if getPlayerName(gracz) == gielda.wlasciciel then exports["smta_base_notifications"]:noti("Jest to twój pojazd, nie możesz go zakupić!", gracz, "error") return end
  	for i, v in ipairs(getElementsByType("player")) do
    	if gielda.uwlasciciel == getElementData(v, "dbid") then
     		exports["smta_base_notifications"]:noti("Twój pojazd marki "..getVehicleName(pojazd)..", sprzedał się na giełdzie.", v)
     		setElementData(v, "bankomat", getElementData(v, "bankomat")+gielda.cena)
    	end
  	end
	local model = getVehicleName(pojazd)
	exports["smta_base_notifications"]:noti("Pomyślnie zakupiłeś pojazd "..model.." za cenę:"..gielda.cena.." $ od: "..gielda.wlasciciel, gracz)
	exports["smta_base_db"]:wykonaj("UPDATE smtadb_accounts SET bkasa=bkasa+? WHERE dbid=?", gielda.cena, gielda.uwlasciciel)
	setElementData(gracz, "pieniadze", kasa-gielda.cena)
	setElementData(pojazd, "wlasciciel", getElementData(gracz, "dbid"))
	warpPedIntoVehicle(gracz, pojazd)
	exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET wlasciciel=? WHERE id=?", getElementData(gracz, "dbid"), getElementData(pojazd, "id"))
	exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=NOW()", getPlayerName(gracz), "Kupił "..getVehicleName(pojazd).." ["..getElementData(pojazd, "id").."] za "..gielda.cena.." $ od "..gielda.wlasciciel, getPlayerSerial(gracz), "wystawianiegielda")
	setElementData(pojazd, "gielda", false)
	setElementData(pojazd, "nametag", false)
	if cuboid[pojazd] and isElement(cuboid[pojazd]) then
		destroyElement(cuboid[pojazd])
	end
  	if markers[pojazd] and isElement(markers[pojazd]) then
    	destroyElement(markers[pojazd])
  	end
end)

local cuboides = createColCuboid(-1908.6734619141, -973.68176269531, 31.176921844482, 40.5, 230.5, 3)

addEvent("gielda", true)
addEventHandler("gielda", root, function(pojazd)
	local x,y,z = getElementPosition(pojazd)
	cuboid[pojazd] = createColSphere(x, y, z, 1)
  	attachElements(cuboid[pojazd], pojazd, 0, 3.5, 0)
  	setElementData(cuboid[pojazd], "pojazd", pojazd)
  	markers[pojazd] = createMarker(x, y, z, "cylinder", 1, 26, 177, 133, 50)
  	setElementData(markers[pojazd], "sprzedaz", true)
  	attachElements(markers[pojazd], pojazd, 0, 3.5, -0.55)

  	local gielda = getElementData(pojazd, "gielda")
  	exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=NOW()", getPlayerName(client), "Wystawił "..getVehicleName(pojazd).." ["..getElementData(pojazd, "id").."] za "..gielda.cena.." $", getPlayerSerial(client), "wystawianiegielda")
end)

addEventHandler("onElementDestroy", getRootElement(), function ()
	if getElementType(source) == "vehicle" then
		if getElementData(source, "gielda") then
			if cuboid[source] then
      	destroyElement(cuboid[source])
    	end
      if isElement(markers[source]) then
        destroyElement(markers[source])
      end
    end
	end
end)

addEventHandler("onColShapeHit", resourceRoot, function(hit)
	if getElementType(hit) ~= "player" then return end
  if source == cuboides then return end
  local pojazd = getPedOccupiedVehicle(hit)
  if pojazd then return end
  local auto = getElementData(source, "pojazd")
  triggerClientEvent(hit, "cuboid", hit, auto)
end)

addEventHandler("onColShapeHit", cuboides, function(hit)
  if getElementType(hit) ~= "player" then return end
  local pojazd = getPedOccupiedVehicle(hit)
  if not pojazd then return end
    if isElement(cuboid[pojazd]) then
      destroyElement(cuboid[pojazd])
    end
    if isElement(markers[pojazd]) then
      destroyElement(markers[pojazd])
    end
    if getElementData(pojazd, "gielda") then
    	setElementData(pojazd, "gielda", false)
    	setElementData(pojazd, "nametag", false)
    end
end)

addEventHandler("onColShapeLeave", cuboides, function(pojazd)
  if getElementType(pojazd) ~= "vehicle" then return end
  if not pojazd then return end
    if isElement(cuboid[pojazd]) then
      destroyElement(cuboid[pojazd])
    end
    if isElement(markers[pojazd]) then
      destroyElement(markers[pojazd])
    end
    setElementData(pojazd, "gielda", false)
    setElementData(pojazd, "nametag", false)
end)