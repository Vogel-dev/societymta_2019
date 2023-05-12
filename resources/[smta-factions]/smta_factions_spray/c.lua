--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEventHandler("onClientPlayerDamage", root, function(attacker, weapon)
	if (weapon==41) then cancelEvent() end
	if ((weapon==41)and attacker) then
		local x,y,z=getElementPosition(localPlayer)
		if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(attacker))>2)then return end
		local health=getElementHealth(localPlayer)+1
		if(health<100)then
			setElementHealth(localPlayer, health)
			if(math.floor(health)==99)then
				setElementHealth(localPlayer,100)
				triggerServerEvent("ulecz",resourceRoot,attacker)
			end
		end
	end
end)