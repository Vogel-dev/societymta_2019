--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(821.32, -640.16, 16.34-1, 'cylinder', 1.3, 135, 206, 235, 50) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)

local punktmeta2 = {
{832.15, -642.64, 16.34},
{827.87, -641.61, 16.34},
{823.43, -642.97, 16.34},
{818.49, -641.38, 16.34},
{814.11, -642.69, 16.34},
{809.61, -641.50, 16.34},
{805.28, -641.65, 16.34},
{800.67, -641.78, 16.34},
{796.56, -642.39, 16.34},
{792.05, -641.77, 16.34},
{787.76, -641.90, 16.34},
{782.38, -640.94, 16.34},
{779.98, -635.17, 16.34},
{781.16, -627.87, 16.34},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć przerabianie roztworu metamfetaminy wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
        if getElementData(localPlayer, "meta1") < 1 then 
            --exports["smta_base_notifications"]:noti("Nie posiadasz więcej lisci do przerobienia.")  
                return end
        if getElementData(localPlayer, "meta2") > 159 then 
                    --exports["smta_base_notifications"]:noti("Posiadasz przy sobie za dużo towaru.")  
                    return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktmeta2)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i przerób roztwór metamfetaminy.")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktmeta2[losuj][1], punktmeta2[losuj][2], punktmeta2[losuj][3]-1.0, "checkpoint", 1.5, 135, 206, 235, 50)
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
                 setElementData(localPlayer, "pracuje", false)
                 local dodanometa2 = math.random(2,4)
                 setElementData(localPlayer, "meta2", getElementData(localPlayer, "meta2")+dodanometa2)
                 setElementData(localPlayer, "meta1", getElementData(localPlayer, "meta1")-1)
                 --exports["smta_base_notifications"]:noti("Przerobiłes roztwór metamfetaminy")
            end, 4000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już przerabianie.")
    end
end)