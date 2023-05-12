--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("ulecz", true)
addEventHandler("ulecz",resourceRoot,function(gracz)
	if getElementData(gracz, "frakcja:sluzba") == "SAMC" then
		local x,y,z=getElementPosition(gracz)
		if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))>2)then return end
		tick=client:getData("leczenie_tick")
		if(tick and tick+1000*60*2>getTickCount())then
			gracz:outputChat("Pomyślnie uleczyłeś: "..client.name:gsub("#%x%x%x%x%x%x","").."!",0,255,0)
		else
			client:setData("leczenie_tick", getTickCount(), false)
			--gracz:outputChat("Pomyślnie uleczyłeś: "..client.name:gsub("#%x%x%x%x%x%x","").."! (+150 $)",0,255,0)
			--gracz:setData("pieniadze", gracz:getData("pieniadze")+150)
		end
	end
end)