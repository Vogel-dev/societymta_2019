--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(-2213.89, 617.92, 35.16-1, 'cylinder', 1.3, 80, 125, 42, 50) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)

local blip = createBlip(-2213.89, 617.92, 35.16, 25)
setBlipVisibleDistance(blip, 300)

local punktzebrania3 = {
    {-2212.88, 616.02, 35.16},
    {-2213.37, 614.32, 35.16},
    {-2215.28, 613.68, 35.16},
    {-2214.45, 612.47, 35.16},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć sprzedaż marichuany wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
        if getElementData(localPlayer, "weed2") < 1 then 
            --exports["smta_base_notifications"]:noti("Nie posiadasz więcej marichuany do sprzedazy.") 
                 return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktzebrania3)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i sprzedaj marichuane")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktzebrania3[losuj][1], punktzebrania3[losuj][2], punktzebrania3[losuj][3]-1.0, "checkpoint", 1.5, 80, 125, 42, 50)
        local blip = createBlipAttachedTo(cel, 41)
        
        addEventHandler("onClientMarkerHit", cel, function(el, md)
            if not md or getElementType(el) ~= "player" then return end
            if el ~= localPlayer then return end

            if getPedOccupiedVehicle(el) then
                exports["smta_base_notifications"]:noti("Nie możesz sprzedawać w pojeździe.", "error")
                return
            end

            destroyElement(blip)
            setElementFrozen(el, true)
            setTimer(function()
                setElementFrozen(el, false)
                destroyElement(cel)
                setElementData(el, "pracuje", false)
                 toggleControl("sprint", true)
                 --local dodano = math.random(1,1)
                 --setElementData(localPlayer, "weed2", getElementData(localPlayer, "weed2")+dodano)
                 setElementData(localPlayer, "weed2", getElementData(localPlayer, "weed2")-1)
                 setElementData(localPlayer, "pracuje", false)
                -- exports["smta_base_notifications"]:noti("Sprzedałes marichuane.")
                 triggerServerEvent("daj:Weed3", localPlayer)
            end, 2000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już sprzedaż.")
    end
end)