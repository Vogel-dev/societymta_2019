--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(2976.29, 1888.36, 13.76-1, 'cylinder', 1.0, 255, 255, 255) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)
local punktzebrania = {
    {2974.72, 1889.24, 14.45},
    {2977.50, 1887.20, 14.63},
    {2977.33, 1884.22, 15.39},
    {2972.89, 1885.48, 14.65},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć przerabianie lisci koki wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
        if getElementData(localPlayer, "koka1") < 1 then 
            --exports["smta_base_notifications"]:noti("Nie posiadasz więcej lisci do przerobienia.")  
                return end
        if getElementData(localPlayer, "koka2") > 199 then 
                    --exports["smta_base_notifications"]:noti("Posiadasz przy sobie za dużo towaru.")  
                    return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktzebrania)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i przerób liscie koki.")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktzebrania[losuj][1], punktzebrania[losuj][2], punktzebrania[losuj][3]-1.0, "checkpoint", 1.5, 255, 255, 255)
        local blip = createBlipAttachedTo(cel, 41)
        
        addEventHandler("onClientMarkerHit", cel, function(el, md)
            if not md or getElementType(el) ~= "player" then return end
            if el ~= localPlayer then return end

            if getPedOccupiedVehicle(el) then
                exports["smta_base_notifications"]:noti("Nie możesz przerabiać w pojeździe.", "error")
                return
            end

            destroyElement(blip)
            setElementFrozen(el, true)
            setTimer(function()
                setElementFrozen(el, false)
                --exports["smta_base_notifications"]:noti("Przyrobiłes liscie na czystą kokaine.")
                destroyElement(cel)
                setElementData(el, "pracuje", false)
                 toggleControl("sprint", true)
                 local dodano = math.random(2,4)
                 setElementData(localPlayer, "koka2", getElementData(localPlayer, "koka2")+dodano)
                 setElementData(localPlayer, "koka1", getElementData(localPlayer, "koka1")-1)
                 setElementData(localPlayer, "pracuje", false)
                 --exports["smta_base_notifications"]:noti("Przerobiłes liscie kokainy.")
            end, 4000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już przerabianie.")
    end
end)