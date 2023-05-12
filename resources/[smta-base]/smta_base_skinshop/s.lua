--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("zapiszSkin:przebieralnia", true)
addEventHandler("zapiszSkin:przebieralnia", root, function(kto, jaki)
	if not kto and not jaki then return end
	setElementModel(kto, jaki)
	setElementData(kto, "skin", jaki)
end)