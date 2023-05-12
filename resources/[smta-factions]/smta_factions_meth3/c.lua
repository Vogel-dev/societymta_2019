--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(-2518.77, 247.86, 11.09-1, 'cylinder', 1.3, 135, 206, 235, 50) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)

local punktzebrania3 = {
{-2525.41, 246.80, 11.09},
{-2522.70, 242.18, 11.09},
{-2520.96, 237.26, 11.10},
{-2525.48, 232.03, 11.09},
{-2530.35, 229.90, 11.09},
{-2535.13, 225.56, 11.09},
{-2539.74, 219.78, 11.09},
{-2541.53, 214.22, 11.09},
{-2537.72, 210.60, 11.09},
{-2532.63, 212.20, 11.09},
{-2527.27, 215.20, 11.09},
{-2521.76, 218.04, 11.09},
{-2524.08, 222.69, 11.09},
{-2529.00, 228.13, 11.09},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć sprzedaż metamfetaminy wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
        if getElementData(localPlayer, "meta2") < 1 then 
            --exports["smta_base_notifications"]:noti("Nie posiadasz więcej marichuany do sprzedazy.") 
                 return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktzebrania3)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i sprzedaj metamfetamine")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktzebrania3[losuj][1], punktzebrania3[losuj][2], punktzebrania3[losuj][3]-1.0, "checkpoint", 1.5, 135, 206, 235, 50)
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
                 setElementData(localPlayer, "pracuje", false)
                 --local dodano = math.random(1,1)
                 --setElementData(localPlayer, "weed2", getElementData(localPlayer, "weed2")+dodano)
                 setElementData(localPlayer, "meta2", getElementData(localPlayer, "meta2")-1)
                 --exports["smta_base_notifications"]:noti("Sprzedałes metamfetamine.")
                 triggerServerEvent("daj:Meth3", localPlayer)
            end, 2000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już sprzedaż.")
    end
end)