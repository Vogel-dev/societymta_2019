--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


local start = createMarker(612.10, -1085.66, 58.83-1, 'cylinder', 1.3, 135, 206, 235, 50) --Miejsce rozpoczęcia pracy
setElementData(start, "narkotyki", true)

local punktMeth = {
{613.81, -1084.19, 58.83},
{616.39, -1081.58, 58.83},
{616.82, -1078.94, 58.83},
{613.99, -1077.47, 58.83},
{612.40, -1079.98, 58.83},
{607.69, -1083.62, 58.83},
{604.15, -1081.45, 59.21},
{602.35, -1073.78, 61.41},
{599.75, -1068.38, 63.38},
{592.63, -1068.30, 65.97},
{590.58, -1067.15, 66.97},
{589.72, -1061.52, 68.36},
{590.12, -1057.30, 69.00},
{589.84, -1052.49, 70.01},
{585.82, -1052.51, 71.54},
{580.95, -1055.85, 72.78},
}

addEventHandler("onClientMarkerHit", start, function(el, md)  
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    exports["smta_base_notifications"]:noti("Aby rozpocząć zbieranie roztworu metamfetaminy wcisnij 'E'")
end)


bindKey("e", "down", function() -- Klawisz, którym rozpoczynamy prace
    if getElementData(localPlayer, "online") > 300 then
    else
        exports["smta_base_notifications"]:noti("Nie posiadasz 5 godzin przegranych na serwerze.") 
        return end
    if getElementData(localPlayer, "meta1") == 20 then 
        --exports["smta_base_notifications"]:noti("Posiadasz maksymalną ilosć marichuany przy sobie.")  
        return end
    if not isElementWithinMarker(localPlayer, start) then return end
    if not getElementData(localPlayer, "pracuje") then
        local losuj = math.random(2, #punktMeth)
        setElementData(localPlayer, "pracuje", true)
        --exports["smta_base_notifications"]:noti("Podejdź do punktu i zbierz roztwór metamfetaminy.")
        toggleControl("sprint", false)
        
        local cel = createMarker(punktMeth[losuj][1], punktMeth[losuj][2], punktMeth[losuj][3]-1.0, "checkpoint", 1.5, 135, 206, 235, 50)
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
                 setElementData(localPlayer, "pracuje", false)
                 local meta1 = getElementData(el, "meta1")
                 local dod = math.random(1,1)
                 setElementData(el, "meta1", getElementData(el, "meta1")+dod)
                 --exports["smta_base_notifications"]:noti("Zebrałes roztwór metamfetaminy.")
            end, 8000, 1)
        end)
    else
        exports["smta_base_notifications"]:noti("Rozpocząłes już zbieranie.")
    end
end)