--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local okno1 = false
local niesie = false
local ulepszenia = false
local czas = 10000
 
local blip = createBlip(-2426.68, -184.28, 35.18, 52)
setBlipVisibleDistance(blip, 300)

local pracodawca = createPed(123, 6.70, -2.91, 1003.55, 180)
setElementData(pracodawca, "name", "Pracodawca\nWiktor Stolarek")
setElementInterior(pracodawca, 10)
local rozpoczecie = createMarker(6.69, -4.00, 1003.55-0.9, "cylinder", 1, 124, 185, 232, 100)
setElementData(rozpoczecie, "sprzedaz", true)
setElementInterior(rozpoczecie, 10)
 
--od brania skrzynek
local x, y, z = -2.41, -2.70, 1003.55
 
 
addEventHandler("onClientMarkerHit", rozpoczecie, function(gracz)
    if gracz ~= localPlayer then return end
    if getElementData(localPlayer, "pracuje") then
        if getElementData(localPlayer, "pracuje") ~= "magazyn" then exports["smta_base_notifications"]:noti("Posiadasz inną aktywną prace!", "error") return end
    end
    addEventHandler("onClientRender", root, guistart)
    okno1 = true
    showCursor(true)
    setElementData(localPlayer, "hud", true)
    showChat(false)
    executeCommandHandler("radar")
    setElementData(localPlayer, "player:blackwhite", true)
    triggerServerEvent("pokazTopke:magazynier:source", localPlayer)
end)
 
 
 
local font = dxCreateFont("cz.ttf", 14)
local font2 = dxCreateFont("cz.ttf", 14)
 
local pracownicy = { }
 
local listaulepszen = {
    {"Zwinne ręce", "", 200, "sprint.png"},
    {"Sprinter", "", 100, "sprint.png"},
    {"Zarobek +25%", "", 300, "dolar.png"},
}
 
 
function guistart()
    if ulepszenia == false then
	   local punkty = getElementData(localPlayer, "mpunkty") or 0
	   local zlecenia = getElementData(localPlayer, "mskrzynki") or 0
	    dxDrawImage(screenW * 0.2592, screenH * 0.2839, screenW * 0.4824, screenH * 0.4323, ":smta_jobs_shop/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Odłożone skrzynki: "..zlecenia.."\nPunkty: "..punkty.."", screenW * 0.2701, screenH * 0.5924, screenW * 0.3843, screenH * 0.6445, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        if mysz(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443) then
    	   dxDrawImage(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443, ":smta_jobs_tram/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
    	   dxDrawImage(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443, ":smta_jobs_tram/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443) then
    	   dxDrawImage(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443, ":smta_jobs_tram/gfx/button_on2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
    	   dxDrawImage(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443, ":smta_jobs_tram/gfx/button_off2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247) then
			dxDrawImage(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 else
			dxDrawImage(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 end

        for i, v in ipairs(pracownicy) do
    	   local dodatekY2 = (scale_y(87))*(i-1)

    	   dxDrawText(v.nick, screenW * 0.5300, screenH * 0.4766 + dodatekY2, screenW * 0.6537, screenH * 0.5091, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
           dxDrawText(v.liczba, screenW * 0.6428, screenH * 0.4766+ dodatekY2, screenW * 0.7269, screenH * 0.5091, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        end
    else
		local punkty = getElementData(localPlayer, "mpunkty") or 0
		dxDrawImage(screenW * 0.2855, screenH * 0.2734, screenW * 0.4297, screenH * 0.3789, ":smta_jobs_shop/gfx/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if mysz(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247) then
			dxDrawImage(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 else
			dxDrawImage(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 end
        dxDrawText("Posiadasz "..punkty.." punktów pracy jako inwentaryzator.", screenW * 0.2928, screenH * 0.5599, screenW * 0.7079, screenH * 0.6393, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        for i, v in ipairs(listaulepszen) do
            local dodatekY = (scale_y(68))*(i-1)
            if mysz(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443) then
                dxDrawImage(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443, ":smta_jobs_tram/gfx/button_on3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443, ":smta_jobs_tram/gfx/button_off3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443) and okno1 == true and ulepszenia == false then
    	if getElementData(localPlayer, "pracuje") == "magazyn" then
    		zakonczprace()
    	else
    		rozpocznijprace()
    	end
    elseif mysz(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443) and okno1 == true and ulepszenia == false then
    	ulepszenia = true
    elseif mysz(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247) and okno1 == true and ulepszenia == false then
    	removeEventHandler("onClientRender", root, guistart)
		okno1 = false
        showCursor(false)
        setElementData(localPlayer, "hud", false)
        showChat(true)
        executeCommandHandler("radar")
        setElementData(localPlayer, "player:blackwhite", false)
    elseif mysz(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247) and okno1 == true and ulepszenia == true then
        ulepszenia = false
    end
    for i, v in ipairs(listaulepszen) do
        local dodatekY = (scale_y(72))*(i-1)
        if mysz(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443) and okno1 == true and ulepszenia == true then
            local punkty = getElementData(localPlayer, "mpunkty") or 0
            if punkty < tonumber(v[3]) then exports["smta_base_notifications"]:noti("Posiadasz za mało punktów by zakupić to ulepszenie", "error") return end
            if v[1] == "Zwinne ręce" then
                if getElementData(localPlayer, "magazynier:ulepszenie2") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już to ulepszenie", "error") return end
                setElementData(localPlayer, "magazynier:ulepszenie2", 1)
            elseif v[1] == "Sprinter" then
                if getElementData(localPlayer, "magazynier:ulepszenie1") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już to ulepszenie", "error") return end
                setElementData(localPlayer, "magazynier:ulepszenie1", 1)
            elseif v[1] == "Zarobek +25%" then
                if getElementData(localPlayer, "magazynier:ulepszenie3") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już to ulepszenie", "error") return end
                setElementData(localPlayer, "magazynier:ulepszenie3", 1)
            end
            exports["smta_base_notifications"]:noti("Zakupujesz ulepszenie: "..v[1])
            setElementData(localPlayer, "mpunkty", punkty-tonumber(v[3]))
        end
    end
  end
end)

addEvent("pokazTopke:magazynier:client", true)
addEventHandler("pokazTopke:magazynier:client", root, function(tabelka)
  pracownicy = tabelka
end)
 
-- praca
 
local punkty = {
    {2.79, -2.37, 1003.55},
    {-4.41, -2.70, 1003.55},
    {-7.66, -2.70, 1003.55},
    {-10.98, -3.62, 1003.55},
    {-9.67, -5.96, 1003.55},
    {-9.68, -8.91, 1003.55},
    {-9.67, -12.98, 1003.55},
    {-9.65, -18.18, 1003.55},
    {-11.02, -21.50, 1003.55},
    {-9.65, -26.10, 1003.55},
    {-11.00, -28.94, 1003.55},
    {-5.36, -26.66, 1003.55},
    {-5.37, -21.30, 1003.55},
    {-5.37, -14.26, 1003.55},
    {-5.35, -5.96, 1003.55},
    {-3.02, -10.38, 1003.55},
    {-3.01, -17.55, 1003.55},
    {-3.01, -22.94, 1003.55},
    {-1.65, -25.67, 1003.55},
    {-1.65, -18.59, 1003.55},
    {-1.65, -11.92, 1003.55},
    {0.99, -8.04, 1003.55},
    {2.64, -14.05, 1003.55},
    {0.98, -22.26, 1003.55},
    {8.32, -27.41, 1003.55},
    {8.33, -19.97, 1003.55},
    {8.33, -13.75, 1003.55},
}
 
function loadcircle()
    if getElementData(localPlayer, "magazynier:ulepszenie2") then
        czas = 5000
    else
        czas = 10000
    end
    local load = interpolateBetween(0, 0, 0, 360, 0, 0, (getTickCount() - tick)/czas, "Linear")
    dxDrawCircle(scale_x(160), scale_y(550), scale_x(50), scale_x(5), nil, nil, load, tocolor(185, 43, 39, 255))
    shadowText("Wykładasz piwa na półki...", screenW * 0.0154, screenH * 0.6849, screenW * 0.2072, screenH * 0.7227, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
end
 
function rozpocznijprace()
    setElementData(localPlayer, "pracuje", "magazyn")
    toggleControl("crouch", false)
    toggleControl("sprint", false)
    exports["smta_base_notifications"]:noti("Rozpoczynasz pracę.")
    branie = createMarker(x, y, z-0.95, "checkpoint", 1, 159, 43, 104, 50)
    setElementInterior(branie, 10)
    setElementData(branie, "skrzynki", true)
    zakoncz = createMarker(98.44, -288.60, 36.88, "corona", 1.5, 0, 0, 0, 0)
    setElementInterior(zakoncz, 10)
    addEventHandler("onClientMarkerHit", zakoncz, function(gracz)
        if gracz ~= localPlayer then return end
        if getElementData(localPlayer, "pracuje") == "magazyn" then
            zakonczprace()
        end
    end)
    addEventHandler("onClientMarkerHit", branie, function(gracz)
        if gracz ~= localPlayer then return end
        if niesie == false and isPedOnGround(localPlayer) then
            niesie = true
            exports["smta_base_notifications"]:noti("Bierzesz skrzynie, wyłóż piwa na wskazany regał.")
            triggerServerEvent("dajSkrzynke:magazynier", localPlayer, localPlayer)
            local los = punkty[math.random(#punkty)]
            oddanie = createMarker(los[1], los[2], los[3]-.95, "checkpoint", 1, 185, 43, 39, 100)
            oddanieblip = createBlipAttachedTo(oddanie, 41)
            setElementData(oddanie, "skrzynki", true)
            setElementInterior(oddanie, 10)
            setElementInterior(oddanieblip, 10)
            setElementFrozen(localPlayer, true)
            setTimer(function()
                setElementFrozen(localPlayer, false)
            end, 1000, 1)
            addEventHandler("onClientMarkerHit", oddanie, function(gracz)
                if gracz ~= localPlayer then return end
                tick = getTickCount( )
                addEventHandler("onClientRender", root, loadcircle)
                setElementFrozen(localPlayer, true)
                if getElementData(localPlayer, "magazynier:ulepszenie2") then
                    czas2 = 5000
                else
                    czas2 = 10000
                end
                setTimer(function()
                    triggerServerEvent("daj:mskrzynki", localPlayer, localPlayer)
                    triggerServerEvent("usunSkrzynke:magazynier", localPlayer, localPlayer)
                    removeEventHandler("onClientRender", root, loadcircle)
                    setElementFrozen(localPlayer, false)
                    if isElement(oddanie) then
                        destroyElement(oddanie)
                    end
                    if isElement(oddanieblip) then
                        destroyElement(oddanieblip)
                    end
                    local zarobek = math.random(100, 120)
                    if getElementData(localPlayer, "premium") then
                        zarobek = zarobek + zarobek*0.50
                    end

                    if getElementData(localPlayer, "magazynier:ulepszenie3") == 1 then
                        zarobek = zarobek * 1.25;
                    end

                    local nagroda = math.random(1, 10)
                    if tonumber(nagroda) == 5 then
                        local los2 = math.random(1,3)
                        if getElementData(localPlayer, "premium") then
                            los2 = math.random(2, 6)
                        end
                        setElementData(localPlayer, "punkty", getElementData(localPlayer, "punkty")+los2)
                        exports["smta_base_notifications"]:noti("Za dobrą prace otrzymujesz "..los2.." SP")
                    end

                    local lp = math.random(1,4)
                    local hajs = getElementData(localPlayer, "pieniadze") or 0
                    local punkty = getElementData(localPlayer, "mpunkty") or 0
                    local skrzynki = getElementData(localPlayer, "mskrzynki") or 0
                    setElementData(localPlayer, "pieniadze", hajs+zarobek)
                    setElementData(localPlayer, "mpunkty", punkty+lp)
                    setElementData(localPlayer, "mskrzynki", skrzynki+1)
                    exports["smta_base_notifications"]:noti("Wyłożyłes piwa na regał, zarabiasz: "..zarobek.." $")
                    niesie = false
                end, czas2, 1)
            end)
        elseif niesie == true and isPedOnGround(localPlayer) then
            if isElement(oddanie) then
                destroyElement(oddanie)
            end
            if isElement(oddanieblip) then
                destroyElement(oddanieblip)
            end
            niesie = false
            --exports["smta_base_notifications"]:noti("Odkładasz skrzynie")
            triggerServerEvent("usunSkrzynke:magazynier", localPlayer, localPlayer)
        end
 
    end)
end
 
function zakonczprace()
    setElementData(localPlayer, "pracuje", false)
    toggleControl("crouch", true)
    exports["smta_base_notifications"]:noti("Kończysz pracę.")
    if isElement(branie) then
        destroyElement(branie)
    end
    if isElement(oddanie) then
        destroyElement(oddanie)
    end
    if isElement(oddanieblip) then
        destroyElement(oddanieblip)
    end
    if isElement(zakoncz) then
        destroyElement(zakoncz)
    end
    niesie = false
    triggerServerEvent("usunSkrzynke:magazynier", localPlayer, localPlayer)
end
 
setTimer(function()
    if getElementData(localPlayer, "pracuje") == "magazyn" then
        setElementHealth(localPlayer, 100)
    end
end, 50, 0)
 
-- opcje
 --[[
addEventHandler('onClientResourceStart', resourceRoot, function()
    local shader = dxCreateShader('shader.fx')
    local grafika = dxCreateTexture('grafiki/skrzyniatxt.png')
    dxSetShaderValue(shader, 'gTexture', grafika)
    engineApplyShaderToWorldTexture(shader, 'cheerybox01')
end)
--]]
 
function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
    dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end
 
function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end
 
function scale_x(value)
    local result = (value / 1440) * sx
 
    return result
end
 
function scale_y(value)
    local result = (value / 900) * sy
 
    return result
end
 
function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
    if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
        return false
    end
   
    local function clamp( val, lower, upper )
        if ( lower > upper ) then lower, upper = upper, lower end
        return math.max( lower, math.min( upper, val ) )
    end
   
    radius = type( radius ) == "number" and radius or 50
    width = type( width ) == "number" and width or 5
    angleAmount = type( angleAmount ) == "number" and angleAmount or 1
    startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
    stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
    color = color or tocolor( 255, 255, 255, 200 )
    postGUI = type( postGUI ) == "boolean" and postGUI or false
   
    if ( stopAngle < startAngle ) then
        local tempAngle = stopAngle
        stopAngle = startAngle
        startAngle = tempAngle
    end
   
    for i = startAngle, stopAngle, angleAmount do
        local startX = math.cos( math.rad( i ) ) * ( radius - width )
        local startY = math.sin( math.rad( i ) ) * ( radius - width )
        local endX = math.cos( math.rad( i ) ) * ( radius + width )
        local endY = math.sin( math.rad( i ) ) * ( radius + width )
   
        dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
    end
   
    return true
end