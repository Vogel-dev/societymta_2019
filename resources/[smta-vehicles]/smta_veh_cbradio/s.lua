--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addCommandHandler("cb", function (player, command, ...)
	--if not getElementData(player,"duty") then outputChatBox("@ Skrypt dostępny wyłącznie dla osób upoważnionych.",player) return end
    local veh = getPedOccupiedVehicle(player)
    if not veh then
		exports["smta_base_notifications"]:noti("Musisz znajdować się w pojeździe.", player)
        return
    end
    if not ... then
        local chat = getElementData(player, "account:cboff")
        if chat == true then -- CB jest wyłączone
            exports["smta_base_notifications"]:noti("Włączasz radio CB.", player)
            setElementData(player, "account:cboff", false)
        else -- CB jest włączony
            exports["smta_base_notifications"]:noti("Wyłączasz radio CB.", player)
            setElementData(player, "account:cboff", true)
        end  
        return
    end
    local text = table.concat({...}, " ")
    local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_mute WHERE serial=? AND data>NOW()", getPlayerSerial(player))
		if #spr > 0 then
			outputChatBox("Jesteś wyciszony przez "..spr[1].admin.." z powodu '"..spr[1].powod.."' do "..spr[1].data, player, 255, 0, 0)
			setElementData(player, "mute", true)
		else
			exports["smta_base_db"]:wykonaj("DELETE FROM smtadb_mute WHERE serial=?", getPlayerSerial(player))
			setElementData(player, "mute", false)
		end
		if getElementData(player, "mute") then return end
    triggerClientEvent("dLogi", root, "CB> "..getPlayerName(player).." ["..getElementData(player, "id").."]: "..text.."")
    for i,v in ipairs(getElementsByType("player")) do
        if isPedInVehicle(v) and not getElementData(v, "account:cboff") then
            outputChatBox("#004225CB>#ffffff "..getPlayerName(player).." ["..getElementData(player, "id").."]: "..text, v, 255, 255, 255,true)
        end
    end
end)