--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(-2206.24, -22.07, 35.32-1, 'cylinder', 1.0, 255, 255, 255) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)
local punktzebrania = {
    {-2207.62, -22.38, 35.32},
    {-2209.96, -22.20, 35.32},
    {-2210.36, -20.40, 35.32},
    {-2209.17, -18.98, 35.32},
    {-2207.27, -18.23, 35.32},
    {-2208.08, -16.94, 35.32},
    {-2210.55, -17.25, 35.32},
    {-2211.94, -17.36, 35.32},
    {-2215.01, -18.87, 35.32},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć sprzedaż kokainy wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
        if getElementData(localPlayer, "koka2") < 1 then 
            --exports["smta_base_notifications"]:noti("Nie posiadasz więcej kokainy do sprzedazy.")  
                return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktzebrania)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i sprzedaj kokaine")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktzebrania[losuj][1], punktzebrania[losuj][2], punktzebrania[losuj][3]-1.0, "checkpoint", 1.5, 255, 255, 255)
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
                --exports["smta_base_notifications"]:noti("Sprzedałes 25g czystej kokainy.")
                destroyElement(cel)
                setElementData(el, "pracuje", false)
                 toggleControl("sprint", true)
                 setElementData(localPlayer, "koka2", getElementData(localPlayer, "koka2")-1)
                 setElementData(localPlayer, "pracuje", false)
                 --exports["smta_base_notifications"]:noti("Sprzedałes marichuane.")
                 triggerServerEvent("daj:Koks3", localPlayer)
            end, 2000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już sprzedaż.")
    end
end)