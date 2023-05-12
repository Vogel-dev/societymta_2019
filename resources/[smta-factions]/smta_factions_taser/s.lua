--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function taser(atakujacy, bron, cialo, starciles)
	if atakujacy and (bron == 23) then
		exports["smta_base_notifications"]:noti("Zostałeś trafiony paralizatorem przez "..getPlayerName(atakujacy), source)
		setElementFrozen(source,true)
		setPedAnimation(source, "CRACK", "crckdeth2", -1, true, false)
		setTimer(setElementFrozen,180000,1,source,false)		
		setTimer(setPedAnimation,180000,1,source,false)		
	elseif atakujacy and (bron == 4) then
		exports["smta_base_notifications"]:noti("Zostałeś trafiony nożem przez "..getPlayerName(atakujacy), source)
		setElementFrozen(source,true)
		setPedAnimation(source, "CRACK", "crckdeth2", -1, true, false)
		setTimer(setElementFrozen,180000,1,source,false)		
		setTimer(setPedAnimation,180000,1,source,false)		
	elseif atakujacy and (bron == 5) then
		exports["smta_base_notifications"]:noti("Zostałeś trafiony kijem przez "..getPlayerName(atakujacy), source)
		setElementFrozen(source,true)
		setPedAnimation(source, "CRACK", "crckdeth2", -1, true, false)
		setTimer(setElementFrozen,180000,1,source,false)		
		setTimer(setPedAnimation,180000,1,source,false)		
	elseif atakujacy and (bron == 3) then
	exports["smta_base_notifications"]:noti("Zostałeś trafiony pałką przez "..getPlayerName(atakujacy), source)
	setElementFrozen(source,true)
	setPedAnimation(source, "CRACK", "crckdeth2", -1, true, false)
	setTimer(setElementFrozen,180000,1,source,false)		
	setTimer(setPedAnimation,180000,1,source,false)		
end
end
addEventHandler ( "onPlayerDamage", getRootElement (), taser)
