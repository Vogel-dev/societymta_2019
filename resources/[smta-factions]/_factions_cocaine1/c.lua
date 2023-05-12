--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(-1813.33, 2516.84, 82.06-1, 'cylinder', 1.0, 255, 255, 255) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)
local punktzebrania = {
    {-1814.48, 2512.57, 81.84},
    {-1815.50, 2508.91, 81.54},
    {-1813.27, 2506.11, 81.77},
    {-1809.71, 2509.62, 82.44},
    {-1807.64, 2512.51, 82.87},
    {-1805.98, 2515.90, 83.15},
    {-1803.48, 2514.48, 83.52},
    {-1800.87, 2513.85, 83.91},
    {-1799.03, 2512.17, 84.15},
    {-1797.18, 2510.60, 84.37},
    {-1797.19, 2507.79, 84.26},
    {-1798.14, 2504.43, 83.98},
    {-1800.09, 2502.73, 83.62},
    {-1801.91, 2500.75, 83.27},
    {-1804.61, 2498.78, 82.78},
    {-1808.15, 2499.82, 82.32},
    {-1810.57, 2500.80, 82.04},
    {-1812.04, 2502.53, 81.81},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć zbieranie lisci koki wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
    if getElementData(localPlayer, "koka1") == 25 then 
        --exports["smta_base_notifications"]:noti("Posiadasz maksymalną ilosć lisci kokainy przy sobie.")  
        return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktzebrania)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i zbierz lisć koki.")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktzebrania[losuj][1], punktzebrania[losuj][2], punktzebrania[losuj][3]-1.0, "checkpoint", 1.5, 255, 255, 255)
        local blip = createBlipAttachedTo(cel, 41)
        
        addEventHandler("onClientMarkerHit", cel, function(el, md)
            if not md or getElementType(el) ~= "player" then return end
            if el ~= localPlayer then return end

            if getPedOccupiedVehicle(el) then
                exports["smta_base_notifications"]:noti("Nie możesz zbierać w pojeździe.", "error")
                return
            end

            destroyElement(blip)
            setElementFrozen(el, true)
            setTimer(function()
                setElementFrozen(el, false)
                destroyElement(cel)
                setElementData(el, "pracuje", false)
				 toggleControl("sprint", true)
                 local dodano = math.random(1,1)
                 setElementData(localPlayer, "koka1", getElementData(localPlayer, "koka1")+dodano)
                 setElementData(localPlayer, "pracuje", false)
                 --exports["smta_base_notifications"]:noti("Zebrałes lisć kokainy.")
            end, 8000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już zbieranie.")
    end
end)