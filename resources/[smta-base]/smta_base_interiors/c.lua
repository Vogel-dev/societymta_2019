--[[
@Author: Carter
@Copyright: Carter / SocietyMTA // 2018-2019
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("interiors:obj", true)
addEventHandler("interiors:obj", root, function(int,dim)
	if dim == 0 then
		for i,v in ipairs(getElementsByType("player")) do
			setElementCollidableWith(source, v, true)
		end
 	else
		for i,v in ipairs(getElementsByType("player")) do
			setElementCollidableWith(source, v, false)
		end
	end
end)

addEvent("ghost:vehicle", true)
addEventHandler("ghost:vehicle", root, function(vv)
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "veh:prawko") or getElementData(v, "veh:job") then
			setElementCollidableWith(vv, v, false)
		end
	end
end)