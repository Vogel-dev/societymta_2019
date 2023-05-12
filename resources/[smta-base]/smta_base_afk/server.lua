--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEvent("kickPlayer",true)
addEventHandler("kickPlayer",root,function(plr)
	if plr then
		exports["smta_base_discord"]:connectWeb("KICK-AFK - **"..getPlayerName(plr).."** został wyrzucony za AFK.", "logi-wejscwyjsc")
		kickPlayer(plr,"","Zostajesz wyrzucony z powodu AFK!")
	end
end)