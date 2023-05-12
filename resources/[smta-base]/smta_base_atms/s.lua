--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local bankomaty = {
{-2270.52, -139.63, 35.32,270},
{-2177.44, -52.44, 35.31, 90},
{-1980.80, 167.79, 27.69, 270},
{-1838.95, 565.05, 35.17, 300},
{-1806.34, 871.00, 24.89, 90},
{-1690.17, 1252.82, 7.23, 230},
{-1892.43, -592.74, 24.59, 180},
{-1943.89, -866.40, 32.22, 180},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i,v in ipairs(bankomaty) do
		local bankomat = createObject(2942, v[1], v[2], v[3]-0.4, 0, 0, v[4])
		local marker = createMarker(v[1], v[2], v[3]+0.5, "cylinder", 1.3, 255, 255, 255, 0)
		local cuboid = createColSphere(v[1], v[2], v[3], 1.3)
		local blip = createBlipAttachedTo(bankomat, 17)
		setBlipVisibleDistance(blip, 150)
		setElementData(marker, "bankomat", true)
		addEventHandler("onColShapeHit", cuboid, pokazokno)
		addEventHandler("onColShapeLeave", cuboid, usunokno)
	end
end)

function pokazokno(gracz)
	triggerClientEvent(gracz, "bankomat:pokaz", gracz)
end

function usunokno(gracz)
	triggerClientEvent(gracz, "bankomat:pokaz", gracz, true)
end

addEvent("przelej:bankomat", true)
addEventHandler("przelej:bankomat", root, function(kto, komu, ile)
	local gracz = exports["smta_base_core"]:findPlayer(kto, komu)
    if not gracz then return end 
    if gracz == kto then exports["smta_base_notifications"]:noti("Nie możesz przelać sobie pieniędzy!", kto, "error") return end
    if getElementData(kto, "bankomat") <= 0 then return end
	setElementData(kto, "bankomat", getElementData(kto, "bankomat")-ile)
    setElementData(gracz, "bankomat", getElementData(gracz, "bankomat")+ile)
    exports["smta_base_notifications"]:noti("Przelawsz "..ile.." $ do gracza "..getPlayerName(gracz).."", kto)
    exports["smta_base_notifications"]:noti(getPlayerName(kto)..", przelał ci "..ile.." $ na konto bankowe", gracz)
    exports["smta_base_discord"]:connectWeb("**ATM**  **"..getPlayerName(kto).."** przelał do gracza **"..getPlayerName(gracz).."** *"..ile.." $* na konto bankowe.", "logi-transfer")
    triggerClientEvent("dLogi", root, "[B-TRANSFER] "..getPlayerName(kto).." > "..getPlayerName(gracz).." : "..ile.." $")
end)

addEvent("logiWplaty:bankomat", true)
addEventHandler("logiWplaty:bankomat", root, function(ile)
	exports["smta_base_discord"]:connectWeb("**ATM** **"..getPlayerName(client).."** wpłacił "..ile.." $ do bankomatu", "logi-transfer")
end)

addEvent("logiWyplaty:bankomat", true)
addEventHandler("logiWyplaty:bankomat", root, function(ile)
	exports["smta_base_discord"]:connectWeb("**ATM** **"..getPlayerName(client).."** wypłacił "..ile.." $ z bankomatu", "logi-transfer")
end)