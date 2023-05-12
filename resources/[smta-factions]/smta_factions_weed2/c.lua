--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(-535.62, -177.48, 78.40-1, 'cylinder', 1.3, 80, 125, 42, 50) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)

local blip = createBlip(-535.62, -177.48, 78.40, 25)
setBlipVisibleDistance(blip, 300)

local punktzebraniaWeed2 = {
    {-533.15, -180.40, 78.40},
    {-535.81, -182.55, 78.41},
    {-540.07, -177.97, 78.40},
    {-538.56, -174.11, 78.41},
    {-533.45, -173.80, 78.40},
    {-530.72, -176.49, 78.40},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć przerabianie lisci marichuany wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
        if getElementData(localPlayer, "weed1") < 1 then 
            --exports["smta_base_notifications"]:noti("Nie posiadasz więcej towaru do przerobienia.")  
                return end
         if getElementData(localPlayer, "weed2") > 119 then 
                --exports["smta_base_notifications"]:noti("Posiadasz przy sobie za dużo towaru.")  
                return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktzebraniaWeed2)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i przerób liscie marichuany.")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktzebraniaWeed2[losuj][1], punktzebraniaWeed2[losuj][2], punktzebraniaWeed2[losuj][3]-1.0, "checkpoint", 1.5, 80, 125, 42, 50)
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
                destroyElement(cel)
                setElementData(el, "pracuje", false)
                 toggleControl("sprint", true)
                 local dodano = math.random(2,4)
                 setElementData(localPlayer, "weed2", getElementData(localPlayer, "weed2")+dodano)
                 setElementData(localPlayer, "weed1", getElementData(localPlayer, "weed1")-1)
                 setElementData(localPlayer, "pracuje", false)
                 --exports["smta_base_notifications"]:noti("Przerobiłes liscie marichuany.")
            end, 4000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już przerabianie.")
    end
end)