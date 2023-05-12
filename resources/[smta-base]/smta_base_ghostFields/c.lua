--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("ghost:cuboids", true)
addEventHandler("ghost:cuboids", resourceRoot, function(colshape,player,type,on)
	if type == "vehicle" then
		if on == "Leave" then
			for i,v in ipairs(getElementsByType("vehicle")) do
				setElementCollidableWith(player, v, true)
			end
		else
			for i,v in ipairs(getElementsByType("vehicle")) do
				setElementCollidableWith(player, v, false)
			end
		end
	else
		if on == "Leave" then
			for i,v in ipairs(getElementsByType("player")) do
				setElementCollidableWith(player, v, true)
			end
		else
			for i,v in ipairs(getElementsByType("player")) do
				setElementCollidableWith(player, v, false)
			end
		end
	end
end)