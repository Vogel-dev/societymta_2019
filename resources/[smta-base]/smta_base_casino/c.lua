--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()

local maszyna = false
local komulowanie = false
local stawka = 100
local sx, sy = guiGetScreenSize()
local font = dxCreateFont("cz.ttf", 16)
local font2 = dxCreateFont("cz.ttf", 22)

local blip=createBlip(-1809.64, 902.93, 24.89, 43)
setBlipVisibleDistance(blip, 300)

local tekst = ""

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end

local maszyny = {
	{1969.65, 1030.48, 992.47},
	{1969.54, 1028.71, 992.47},
	{1966.40, 1027.99, 992.47},
	{1966.60, 1029.77, 992.47},
	{1966.60, 1031.53, 992.47},
	{1966.60, 1021.61, 992.47},
	{1966.60, 1020.07, 992.47},
	{1969.55, 1020.83, 992.47},
	{1969.54, 1023.35, 992.47},
	{1969.55, 1014.92, 992.47},
	{1969.54, 1013.13, 992.47},
	{1966.60, 1012.27, 992.47},
	{1966.60, 1014.14, 992.47},
	{1966.60, 1015.87, 992.47},
	{1966.60, 1007.25, 992.47},
	{1966.60, 1004.69, 992.47},
	{1969.54, 1004.67, 992.47},
	{1969.54, 1006.22, 992.47},
	{1969.54, 1008.19, 992.47},
}

function hitmaszyna(gracz)
	if gracz ~= localPlayer then return end
	addEventHandler("onClientRender", root, maszynagui)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	maszyna = true
end

for i,v in ipairs(maszyny) do
	local marker = createMarker(v[1], v[2], v[3]-.95, "cylinder", 1, 0, 73, 83, 50)
	setElementData(marker, "kasyno", true)
	setElementInterior(marker, 10)
	setElementDimension(marker, 0)
	addEventHandler("onClientMarkerHit", marker, hitmaszyna)
end

local losy = { }

local width = scale_x(619)
local height = scale_y(182)

local maxRender = dxCreateRenderTarget(width, height, true)


function maszynagui()
	dxDrawImage(screenW * 0.2694, screenH * 0.2865, screenW * 0.4619, screenH * 0.4284, ":smta_base_casino/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.7430, screenH * 0.2826, screenW * 0.2269, screenH * 0.4284, ":smta_base_casino/gfx/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.6559, screenH * 0.6432, screenW * 0.0622, screenH * 0.0443) then
		dxDrawImage(screenW * 0.6559, screenH * 0.6432, screenW * 0.0622, screenH * 0.0443, ":smta_veh_exchange/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(screenW * 0.6559, screenH * 0.6432, screenW * 0.0622, screenH * 0.0443, ":smta_veh_exchange/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	shadowText("PODWÓJ", screenW * 0.6567, screenH * 0.6432, screenW * 0.7182, screenH * 0.6875, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
	shadowText("STAWKA: "..stawka.." $", screenW * 0.6567, screenH * 0.5859, screenW * 0.7182, screenH * 0.6302, tocolor(150, 150, 150, 255), 1.00, font2, "right", "center", false, false, false, false, false)
	if mysz(screenW * 0.2877, screenH * 0.6146, screenW * 0.0915, screenH * 0.0534) then
		dxDrawImage(screenW * 0.2877, screenH * 0.6146, screenW * 0.0915, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(screenW * 0.2877, screenH * 0.6146, screenW * 0.0915, screenH * 0.0534, ":smta_veh_boosters_montage/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	shadowText("ROZPOCZNIJ", screenW * 0.2870, screenH * 0.6146, screenW * 0.3792, screenH * 0.6680, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.7094, screenH * 0.3008, screenW * 0.0110, screenH * 0.0247) then
		dxDrawImage(screenW * 0.7094, screenH * 0.3008, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(screenW * 0.7094, screenH * 0.3008, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
    shadowText(tekst, scale_x(413), scale_y(507), scale_x(1032), scale_y(544), tocolor(0, 225, 0, 255), 1.00, font, "center", "center", false, false, false, false, false)
    if komulowanie == true then
    dxSetRenderTarget(maxRender, true)
    for i, v in ipairs(losy) do
    	local dodatekX = (scale_x(82.5))*(i-1)
    	local move = interpolateBetween(scale_x(1100)-dodatekX, 0, 0, scale_x(-500)-dodatekX, 0, 0, (getTickCount() - czas)/time, "OutBack")
    	if v[1] == "lose" then
    		grafika = "lose"
    	elseif v[1] == 2 then
    		grafika = "x2"
    	elseif v[1] == 3 then
    		grafika = "x3"
    	elseif v[1] == 4 then
    		grafika = "x4"
    	elseif v[1] == 10 then
    		grafika = "x10"
    	end
    	dxDrawRectangle(scale_x(1000+adds)-dodatekX+move, scale_y(10), scale_x(162), scale_y(192), tocolor(0, 0, 0, 100), false)
    	dxDrawImage(scale_x(1000+adds)-dodatekX+move, scale_y(10), scale_x(162), scale_y(162), "gfx/"..grafika..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    dxSetRenderTarget(false)
	dxDrawImage(scale_x(413), scale_y(326), width, height, maxRender)
	--dxDrawLine(scale_x(722), scale_y(326), scale_x(722), scale_y(508), tocolor(0, 255, 0, 255), 2, false)
	end
end

addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" then
  		if mysz(scale_x(440), scale_y(549), scale_x(182), scale_y(57)) and maszyna == true then
  			if leci == true then exports["smta_base_notifications"]:noti("Aktualnie trwa losowanie, czekaj.", "error") return end
  			if getElementData(localPlayer, "pieniadze") < stawka then exports["smta_base_notifications"]:noti("Nie stać cię aby postawić taką sumę pieniędzy.", "error") return end
  			setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-stawka)
  			losy = { }
  			adds = math.random(1, 120)
  			time = math.random(3600, 4600)
  			komulowanie = true
  			leci = true
  			czas = getTickCount( )
  			for i = 1, math.random(10,20) do
  				local los = math.random(1, 250)
  				if los >= 1 and los <= 84 then
  					jaki = "lose"
  				elseif los >= 85 and los <= 90 then
  					jaki = 2
  				elseif los >= 91 and los <= 93 then
  					jaki = 3
  				elseif los >= 94 and los <= 98 then
  					jaki = 4
  				elseif los >= 99 and los <= 100 then
  					jaki = 10
  				end
  				table.insert(losy, {jaki})
  			end
  			setTimer(function()
  				for i, v in ipairs(losy) do
  					if i == 3 then
  						leci = false
						  if v[1] ~= "lose" then
							if not getElementData(localPlayer, "premium") then
							  setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+stawka*(v[1]))
							else 
							  setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+stawka*(v[1])*1.5)
				if not getElementData(localPlayer, "premium") then			  
				tekst = "Gratulacje, wygrywasz "..stawka*(v[1])
				else
				tekst = "(DIAMOND) Gratulacje, wygrywasz "..stawka*(v[1])*1.5	
                setTimer(function()
                  tekst = ""
                end, 3000, 1)
  						end
  					end
				  end
				end
			end
  			end, time, 1)
  		elseif mysz(scale_x(882), scale_y(587), scale_x(140), scale_y(43)) and maszyna == true then
        if leci == true then exports["smta_base_notifications"]:noti("Nie możesz zmienić stawki gdy trwa losowanie", "error") return end
  			if stawka == 25600 then
  				stawka = 100
  			else
  				stawka = stawka*2
  			end
  		elseif mysz(screenW * 0.7094, screenH * 0.3008, screenW * 0.0110, screenH * 0.0247) and maszyna == true then
  			if leci == true then exports["smta_base_notifications"]:noti("Nie możesz wyłączyć panelu podczas losowania!", "error") return end
  			removeEventHandler("onClientRender", root, maszynagui)
			showCursor(false)
			setElementData(localPlayer, "hud", false)
			showChat(true)
			executeCommandHandler("radar")
			setElementData(localPlayer, "player:blackwhite", false)
			maszyna = false
			komulowanie = false
			losy = { }
		end
  	end
end)

--opcje

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