--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local cuboids = {
	{977.67, -2163.87, 12.82, 5},
}

for i,v in ipairs(cuboids) do
	local cs = createColSphere(v[1], v[2], v[3], v[4])
	setElementData(cs, "vehicle", true)
end

addEventHandler("onColShapeHit", resourceRoot, function(hit)
	if hit and getElementType(hit) ~= "vehicle" then return end
	if not getElementData(source, "vehicle") then return end
	if not getElementData(hit, "id") then return end
	triggerClientEvent(root, "ghost:cuboids", resourceRoot, source, hit, "vehicle", "Hit")
end)

addEventHandler("onColShapeLeave", resourceRoot, function(hit)
	if hit and getElementType(hit) ~= "vehicle" then return end
	if not getElementData(source, "vehicle") then return end
	if not getElementData(hit, "id") then return end
	triggerClientEvent(root, "ghost:cuboids", resourceRoot, source, hit, "vehicle", "Leave")
end)