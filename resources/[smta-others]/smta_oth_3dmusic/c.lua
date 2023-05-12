--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local muzyka = {
	{-1806.30, 559.84, 43.56, "http://www.rmfon.pl/n/rmffm.pls"},
	{-2113.56, -34.13, 40.44, "http://www.rmfon.pl/n/rmffm.pls"},
{-2281.22, -147.85, 35.01, "http://www.rmfon.pl/n/rmffm.pls"},
{-1903.67, -533.22, 24.38, "http://www.rmfon.pl/n/rmffm.pls"},
}

local sound = { }

for i, v in ipairs(muzyka) do
	sound[i] = playSound3D(v[4], v[1], v[2], v[3], true)
    setSoundMaxDistance(sound[i], 150) 
   	if v[5] then
   		setElementDimension(sound[i], v[5])
   	end
end

addEvent("wylacz:muzyke", true)
addEventHandler("wylacz:muzyke", root, function(liczba)
	if liczba == 2 then
		for i, v in ipairs(sound) do
			if isElement(v) then
				destroyElement(v)
			end
		end
	elseif liczba == 1 then
		for i, v in ipairs(muzyka) do
			sound[i] = playSound3D(v[4], v[1], v[2], v[3], true)
    		setSoundMaxDistance(sound[i], 150) 
   			if v[5] then
   				setElementDimension(sound[i], v[5])
   			end
		end
	end
end)