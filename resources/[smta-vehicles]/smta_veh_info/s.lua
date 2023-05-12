--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local cuboid = createColCuboid(-2056.6979980469, 150.76135253906, 28.837596893311-1, 10, 16.5, 3)
local marker=createMarker(-2052.43, 157.81, 28.84-2, "cylinder", 3, 93, 57, 84, 50)
setElementData(marker, "przechowalnia2", true)
local text = createElement("text")
setElementData(text, "text", "Diagnoza pojazdu")
setElementPosition(text, -2052.43, 157.81, 28.84)

function ktory(id,model)
	local q = exports["smta_base_db"]:wykonaj("select * from smtadb_vehicles where model=?", model)
	for i,v in ipairs(q) do
		if v.id == id then
			return i
		end
	end
	return 0
end

addEventHandler("onColShapeHit", cuboid, function(player)
	if getElementType(player) ~= "player" then return end
	local veh = getPedOccupiedVehicle(player)
	if not veh then return end
	if not getElementData(veh, "id") then return end
	local modules = {}
	if getElementData(veh, "ms1") == 1 then
		table.insert(modules, "SB 1")
	end
	if getElementData(veh, "ms2") == 1 then
		table.insert(modules, "SB 2")
	end
	if getElementData(veh, "ms3") == 1 then
		table.insert(modules, "SB 3")
	end
	modules = table.concat(modules, ", ")
	if #modules < 1 then
		modules = "Brak"
	end
	local upgrades = getVehicleUpgrades(veh)
	local tune = table.concat(upgrades, " ,")
	local poj = getElementData(veh, "pojemnosc")
	local rodzaj = getElementData(veh, "rodzajpaliwa")
	local q = ktory(getElementData(veh, "id"), getVehicleModel(veh))
	local txt = "Diagnoza pojazdu:\n\n"..q.." pojazd o tej marce na serwerze\nID pojazdu: "..(getElementData(veh, "id") or 0).."\nPrzebieg pojazdu: "..(string.format("%01d", getElementData(veh, "przebieg")) or 0).."km\nTuning auta (ID): "..tune.."\nUlepszenia silnika: "..modules.."\nPojemność silnika: "..poj.."dm³\nRodzaj paliwa: "..rodzaj
	setElementData(veh, "diagz", txt)
	setElementData(veh, "nametag", txt)
end)

addEventHandler("onColShapeLeave", cuboid, function(player)
	if getElementType(player) ~= "player" then return end
	local veh = getPedOccupiedVehicle(player)
	if not veh then return end
	setElementData(veh, "diagz", false)
	setElementData(veh, "nametag", false)
end)