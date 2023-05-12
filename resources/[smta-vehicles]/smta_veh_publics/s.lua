--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

timer = {}

function wchodzi(gracz, miejsce)
	if miejsce ~= 0 then return end
	if isTimer(timer[source]) then
		killTimer(timer[source])
	end
	--setElementData(source, "czyjdochuja", getElementData(gracz, "dbid"))
	setElementData(source, "nametag", "Skuter publiczny")
	setElementFrozen(source, false)
end

function wychodzi(gracz, miejsce)
	if miejsce ~= 0 then return end
	local skuter = source
	timer[skuter] = setTimer(function()
		respawnVehicle(skuter)
		setElementFrozen(skuter, true)
		setElementData(skuter, "nametag", "Skuter publiczny")
		--setElementData(skuter, "czyjdochuja", false)
		setVehicleEngineState(skuter, false )
	end, 30000, 1)
end

--[[
addEventHandler("onPlayerQuit", root, function()
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "czyjdochuja") == getElementData(source, "dbid") then
			if isTimer(timer[v]) then
				killTimer(timer[v])
			end
			respawnVehicle(v)
			setElementFrozen(v, true)
			setElementData(v, "nametag", "Skuter publiczny")
			setElementData(v, "czyjdochuja", false)
			setVehicleEngineState(v, false )
		end
	end
end)
]]

--[[
addEventHandler("onVehicleStartEnter", resourceRoot, function(gracz, miejsce)
	if miejsce ~= 0 then return end
	if getElementData(source, "czyjdochuja") then
		if getElementData(gracz, "dbid") ~= getElementData(source, "czyjdochuja") then cancelEvent() end
	end
end)]]


local skuterki = {
--spawnsf
{-1820.22, 532.68, 34.65, 0},
{-1822.60, 532.41, 34.65, 0},
{-1824.76, 532.14, 34.65, 0},
{-1826.95, 533.02, 34.65, 325},
{-1830.01, 534.59, 34.65, 325},
{-1833.32, 538.25, 34.65, 325},
{-1837.69, 541.43, 34.65, 325},
{-1842.54, 544.00, 34.65, 325},
{-1846.98, 548.36, 34.65, 325},
{-1851.66, 552.05, 34.65, 325},
{-1977.94, 171.73, 27.69},
{-1976.55, 171.90, 27.69},
{-1974.45, 171.83, 27.69},
{-1972.23, 171.76, 27.69},
{-1969.75, 171.65, 27.69},
{-1967.88, 171.58, 27.67},
{-1965.95, 171.51, 27.58},
{-1963.73, 171.44, 27.64},
}

for i, v in ipairs(skuterki) do
	skuterek = createVehicle(462, v[1], v[2], v[3], 0, 0, v[4])
	setVehicleColor(skuterek, 185, 43, 39, 255, 255, 255)
	setElementData(skuterek, "nametag", "Skuter publiczny")
	addEventHandler("onVehicleEnter", skuterek, wchodzi)
	addEventHandler("onVehicleExit", skuterek, wychodzi)
	setElementFrozen(skuterek, true)
end