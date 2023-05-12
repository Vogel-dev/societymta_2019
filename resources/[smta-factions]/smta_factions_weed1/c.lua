--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(-1364.80, 440.88, 7.19-1, 'cylinder', 1.3, 80, 125, 42, 50) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)

local blip = createBlip(-1364.80, 440.88, 7.19, 25)
setBlipVisibleDistance(blip, 300)

local punktzebraniaWeed = {
    {-1366.91, 437.31, 7.19},
    {-1369.85, 437.38, 7.19},
    {-1371.92, 437.09, 7.19},
    {-1374.51, 437.36, 7.19},
    {-1376.89, 436.92, 7.19},
    {-1378.48, 437.10, 7.19},
    {-1367.99, 438.43, 7.19},
    {-1364.54, 437.12, 7.19},
    {-1362.02, 437.43, 7.19},
    {-1360.18, 436.63, 7.19},
    {-1358.48, 436.44, 7.19},
    {-1356.08, 436.59, 7.19},
    {-1353.82, 437.42, 7.19},
    {-1351.88, 437.38, 7.19},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć zbieranie lisci marichuany wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
    if getElementData(localPlayer, "weed1") == 15 then 
        exports["smta_base_notifications"]:noti("Posiadasz maksymalną ilosć towaru przy sobie.")  return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktzebraniaWeed)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i zbierz lisć marichuany.")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktzebraniaWeed[losuj][1], punktzebraniaWeed[losuj][2], punktzebraniaWeed[losuj][3]-1.0, "checkpoint", 1.5, 80, 125, 42, 50)
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
                 toggleControl("sprint", true)
                 local dodano = math.random(1,1)
                 setElementData(localPlayer, "weed1", getElementData(localPlayer, "weed1")+dodano)
                 setElementData(localPlayer, "pracuje", false)
                 --exports["smta_base_notifications"]:noti("Zebrałes lisć marichuany.")
                 --triggerServerEvent("daj:Weed", localPlayer)
                 --setElementData(localPlayer, "dobry", true)
            end, 8000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już zbieranie.")
    end
end)