--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function pokazpracownikow()
    local q = exports['smta_base_db']:wykonaj("SELECT * from smtadb_accounts order by fzlecenia desc")
    local topka = {}

    for i = 1,5 do
        table.insert(topka, {nick = q[i]["login"], liczba = q[i]["fzlecenia"]})
    end

    return topka
end

addEvent("pokazTopke:farma:source", true)
addEventHandler("pokazTopke:farma:source", root, function()
    triggerClientEvent(source, "pokazTopke:farma:client", source, pokazpracownikow())
end)

bizon = {}
wozek = {}

addEvent("dajBizon:farma", true)
addEventHandler("dajBizon:farma", root, function()
	bizon[source] = createVehicle(532, -1194.21, -1063.73, 130.19, 0.7, 0.0, 312.3)
    warpPedIntoVehicle(source, bizon[source])
    triggerClientEvent(root, "ghost:vehicle", root, bizon[source])
    setElementData(bizon[source], "kierowca:farma", getElementData(source, "dbid"))
end)

addEvent("dajForklift:farma", true)
addEventHandler("dajForklift:farma", root, function()
    destroyElement(bizon[source])
    wozek[source] = createVehicle(530, -1193.91, -1063.51, 128.98, 359.0, 360.0, 314.9)
    warpPedIntoVehicle(source, wozek[source])
    triggerClientEvent(root, "ghost:vehicle", root, wozek[source])
    setElementData(wozek[source], "kierowca:farma", getElementData(source, "dbid"))
end)


addEvent("usunPojazdy:farma", true)
addEventHandler("usunPojazdy:farma", root, function()
    if isElement(bizon[source]) then
        destroyElement(bizon[source])
    end
    if isElement(wozek[source]) then
        destroyElement(wozek[source])
    end
end)

addEventHandler("onVehicleStartEnter", root, function(gracz, seat)
    if seat ~= 0 then return end
    if getElementData(gracz, "pracuje") == "farma" then
        if getElementData(source, "id") then
            cancelEvent()
        end
        if getElementData(source, "kierowca:farma") ~= getElementData(gracz, "dbid") then
            cancelEvent()
        end
    else
        if getElementData(source, "kierowca:farma") then
            cancelEvent()
        end
    end
end)

addEvent("daj:fzlecenia", true)
addEventHandler("daj:fzlecenia", root, function(player)
    local dbid = getElementData(player, "dbid")
    local ilosc = getElementData(player, "fzlecenia") or 0
    local q = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET fzlecenia=fzlecenia+1 where dbid=?", dbid)
    setElementData(player, "fzlecenia", ilosc+1)
	exports["smta_base_discord"]:connectWeb("["..discordczas.hour..":"..discordczas.minute.."] **FARM** **"..getPlayerName(player).."** wykonał pełen kurs.", "logi-prace")
end)

addEvent("animacja:siania", true)
addEventHandler("animacja:siania", root, function(cos)
    if cos then
        setPedAnimation(source, "BOMBER", "BOM_Plant", -1, false, true, false, false)
    else
        setPedAnimation(source, false)
    end
end)

addEventHandler("onPlayerQuit", root, function()
    if isElement(bizon[source]) then
        destroyElement(bizon[source])
    end
    if isElement(wozek[source]) then
        destroyElement(wozek[source])
    end
end)

kumbajn = createVehicle(532, -1118.2, -1214.5, 130.3, 0, 0, 270)
setElementFrozen(kumbajn, true)
wuzek = createVehicle(530, -1148.4, -1207.5, 129, 0, 0, 120)
setElementFrozen(wuzek, true)

setElementData(kumbajn, "chuj", true)
setElementData(wuzek, "chuj", true)

addEventHandler("onVehicleStartEnter", root, function(gracz, seat)
    if getElementData(source, "chuj") then cancelEvent() end
end)

addEvent("spr:prawko", true)
addEventHandler("spr:prawko", root, function()
    local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE serial=?", getPlayerSerial(client))
    if #spr > 0 then
        triggerClientEvent(client, "praca:moze", client)
    end
end)