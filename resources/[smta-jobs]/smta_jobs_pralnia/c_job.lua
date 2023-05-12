--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local missionBlip
local missionPickup
local missionVehicle
local missionPoints = {
    {-2316.91, -160.94, 35.32},
    {-2171.07, -43.08, 35.18},
    {-2033.32, -97.75, 35.16},
    {-2051.77, 142.21, 28.84},
    {-1990.59, 201.30, 27.68},
    {-1920.14, 300.67, 41.05},
    {-1676.08, 438.27, 7.18},
    {-1704.69, 1379.12, 7.19},
    {-2065.29, 1430.70, 7.10},
    {-1802.57, 899.23, 24.88},
    {-1739.66, 951.08, 24.74},
    {-2211.71, 604.38, 35.16},
}

local function finishJob(missionValue)
    if isElement(missionBlip) then
        destroyElement(missionBlip)
        missionBlip=nil
    end
    if isElement(missionMarker) then
        destroyElement(missionMarker)
        missionMarker=nil
    end
    if missionValue then
        setElementData(localPlayer,"pracuje",false)
        triggerServerEvent("pralnia:stopJOB", localPlayer, missionVehicle)
        missionVehicle=nil
        missionMarker=nil
        missionBlip=nil
    end
end

addEventHandler("onClientVehicleExit",root,function (plr,seat)
if plr == localPlayer and seat == 0 and source == missionVehicle then
local vh = missionVehicle
finishJob(missionVehicle)
exports["smta_base_notifications"]:noti("Wysiadłes z pojazdu, kończysz pranie pieniędzy.")
end
end)


function showMarker()
    el=localPlayer -- testing to job
    veh=getPedOccupiedVehicle(el)
    if not getPedOccupiedVehicle(el) then return end
    if getVehicleController(veh) == el then
        rnd=missionPoints[math.random(#missionPoints)]
        missionMarker=createMarker(rnd[1], rnd[2], rnd[3], "checkpoint", 3.5, 50, 71, 255, 100)
        missionBlip=createBlip(rnd[1], rnd[2], rnd[3], 41)
        addEventHandler("onClientMarkerHit", missionMarker, function(el,md)
            if el~=localPlayer then return end
            if getElementData(localPlayer, "brudne:pieniadze") < 5000 then exports["smta_base_notifications"]:noti("Posiadasz zbyt mało brudnych pieniędzy do wyprania.", "error") return end
            zarobek = math.random(1000,5000)
            setElementData(localPlayer, "brudne:pieniadze", getElementData(localPlayer, "brudne:pieniadze")-zarobek)
            setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+zarobek*0.8)
            zarobek = zarobek*0.8
            exports["smta_base_notifications"]:noti("Wyprałes "..zarobek.." $ w tym miejscu.")
            finishJob(false)
            showMarker()
        end)
    end
end

addEvent("pralnia:startJOB", true)
addEventHandler("pralnia:startJOB", resourceRoot, function(veh)
    missionVehicle=veh
    showMarker()
    exports["smta_base_notifications"]:noti("Rozpoczynasz pranie pieniędzy, udaj się do miejsca na mapie.")
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
    if getElementData(localPlayer,"pracuje") and getElementData(localPlayer,"pracuje") == "Pralnia" then
        setElementData(localPlayer,"pracuje",false)
    end
end)