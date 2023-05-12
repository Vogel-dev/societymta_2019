--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local font = dxCreateFont("cz.ttf", 15)
local font2 = dxCreateFont("cz.ttf", 17)
local font3 = dxCreateFont("cz.ttf", 25)
local font4 = dxCreateFont("cz.ttf", 13)
local okno1 = false
local okno2 = false
local okno3 = false
local punkty = 1

SW, SH = guiGetScreenSize()

local baseX = 1440
local zoom = 1 
local minZoom = 2
if SW < baseX then
    zoom = math.min(minZoom, baseX/SW)
end 

local blip = createBlip(-2026.70, -95.54, 35.16, 24)
setBlipVisibleDistance(blip, 300)

local markerA = createMarker(2443.24, -1648.21, 1016.14-0.95, "cylinder", 1, 23, 114, 69, 100)
local markerB = createMarker(2462.07, -1656.09, 1016.14-0.95, "cylinder", 1, 23, 114, 69, 100)
local markerC = createMarker(2443.22, -1664.05, 1016.14-0.95, "cylinder", 1, 23, 114, 69, 100)
setElementInterior(markerA, 1)
setElementInterior(markerB, 1)
setElementInterior(markerC, 1)

local punktyA = {
{-2047.17, -81.36, 35.27},
{-2023.89, -72.87, 35.28},
{-1951.48, -67.00, 26.19},
{-1894.29, -103.06, 18.60},
{-1813.60, -117.46, 5.60},
{-1801.14, -159.16, 8.40},
{-1801.16, -226.54, 18.34},
{-1802.03, -305.92, 25.24},
{-1815.26, -400.84, 16.36},
{-1825.76, -516.38, 15.07},
{-1818.89, -633.05, 16.66},
{-1811.30, -744.21, 31.59},
{-1816.20, -853.25, 38.21},
{-1812.24, -963.01, 48.67},
{-1785.87, -1072.90, 54.23},
{-1739.32, -1180.18, 54.78},
{-1684.87, -1283.57, 50.78},
{-1622.82, -1382.49, 45.20},
{-1558.28, -1444.37, 40.44},
{-1522.71, -1405.36, 43.14},
{-1532.24, -1331.66, 51.77},
{-1563.05, -1254.19, 61.48},
{-1619.45, -1185.13, 70.01},
{-1694.91, -1125.03, 73.26},
{-1732.10, -1022.25, 74.96},
{-1753.44, -907.19, 76.19},
{-1702.00, -816.34, 82.18},
{-1637.68, -823.88, 93.25},
{-1629.46, -893.03, 98.36},
{-1641.99, -982.17, 101.24},
{-1630.80, -1086.01, 102.94},
{-1568.31, -1182.59, 102.59},
{-1485.89, -1265.88, 101.03},
{-1442.96, -1368.87, 100.85},
{-1403.66, -1417.03, 105.83},
{-1331.86, -1394.87, 113.48},
{-1250.96, -1360.10, 120.55},
{-1156.31, -1340.14, 126.63},
{-1053.70, -1359.68, 130.11},
{-952.78, -1406.35, 129.22},
{-902.50, -1357.35, 122.41},
{-891.44, -1249.31, 112.05},
{-884.38, -1144.40, 101.66},
{-934.54, -1068.70, 97.29},
{-1013.42, -987.71, 91.71},
{-1095.01, -903.98, 77.31},
{-1176.70, -820.12, 65.81},
{-1238.82, -776.21, 64.88},
{-1297.90, -805.48, 71.56},
{-1374.94, -813.43, 80.69},
{-1464.93, -816.79, 71.58},
{-1582.12, -801.19, 50.08},
{-1691.12, -755.27, 40.05},
{-1757.92, -675.77, 23.17},
{-1764.97, -587.36, 16.44},
{-1833.63, -575.90, 16.94},
{-1913.54, -577.68, 24.55},
{-2010.94, -577.13, 25.75},
{-2104.06, -538.40, 33.66},
{-2176.91, -466.97, 47.80},
{-2242.19, -390.97, 50.97},
{-2253.28, -279.56, 45.16},
{-2252.15, -161.11, 35.27},
{-2247.92, -78.02, 35.28},
{-2188.66, -72.60, 35.28},
{-2106.12, -72.50, 35.28},
{-2047.55, -73.90, 35.17},
}

local punktyB = {
{-2047.23, -82.70, 35.29},
{-2029.59, -71.81, 35.28},
{-1996.15, -72.43, 35.16},
{-1940.57, -66.31, 25.86},
{-1892.69, -105.86, 17.72},
{-1819.89, -119.97, 5.60},
{-1796.36, -91.45, 7.88},
{-1797.42, -27.74, 15.16},
{-1801.24, 57.45, 15.07},
{-1808.14, 163.06, 15.07},
{-1792.68, 257.52, 14.15},
{-1718.07, 330.06, 7.14},
{-1635.18, 412.31, 7.14},
{-1561.31, 501.77, 7.14},
{-1555.86, 618.18, 7.15},
{-1543.46, 733.61, 7.14},
{-1529.50, 849.70, 7.14},
{-1526.78, 919.54, 7.14},
{-1589.85, 935.78, 7.62},
{-1662.39, 933.11, 25.05},
{-1733.70, 932.52, 24.84},
{-1829.53, 931.58, 28.45},
{-1914.83, 931.42, 35.25},
{-1985.74, 931.42, 45.40},
{-2000.98, 980.77, 47.37},
{-1999.95, 1048.98, 55.66},
{-2051.23, 1081.08, 55.68},
{-2140.20, 1079.61, 55.68},
{-2248.33, 1079.63, 55.68},
{-2362.73, 1097.22, 55.68},
{-2476.96, 1118.63, 55.68},
{-2591.25, 1137.29, 55.53},
{-2665.77, 1222.37, 55.53},
{-2671.33, 1339.03, 55.54},
{-2671.89, 1455.98, 55.53},
{-2670.97, 1572.69, 63.04},
{-2671.21, 1689.53, 67.40},
{-2671.56, 1806.46, 67.95},
{-2671.50, 1923.46, 64.65},
{-2671.31, 2040.23, 57.48},
{-2671.13, 2157.07, 55.54},
{-2703.17, 2267.62, 56.31},
{-2730.99, 2334.63, 70.92},
{-2703.32, 2367.32, 70.74},
{-2676.40, 2448.91, 45.78},
{-2621.53, 2500.75, 27.52},
{-2539.23, 2454.43, 18.34},
{-2494.79, 2402.03, 16.18},
{-2466.20, 2317.53, 4.95},
{-2475.44, 2263.25, 4.94},
{-2527.20, 2276.82, 4.95},
{-2561.67, 2329.07, 4.94},
{-2543.70, 2390.21, 14.79},
{-2511.94, 2431.04, 16.78},
{-2554.34, 2475.91, 19.35},
{-2628.62, 2507.54, 28.40},
{-2678.19, 2464.02, 42.81},
{-2696.54, 2403.62, 59.34},
{-2731.58, 2362.05, 71.99},
{-2766.50, 2335.44, 72.77},
{-2731.31, 2258.11, 58.75},
{-2692.07, 2151.19, 55.54},
{-2692.76, 2034.49, 57.94},
{-2692.31, 1917.47, 64.90},
{-2692.28, 1800.47, 68.03},
{-2692.14, 1683.50, 67.27},
{-2692.02, 1566.60, 62.69},
{-2691.43, 1449.88, 55.60},
{-2692.89, 1333.00, 55.54},
{-2684.51, 1217.27, 55.51},
{-2613.98, 1126.94, 55.53},
{-2503.86, 1090.43, 55.68},
{-2388.81, 1076.14, 55.68},
{-2275.68, 1051.56, 55.68},
{-2158.70, 1052.48, 55.68},
{-2052.82, 1051.79, 55.68},
{-2007.09, 1038.62, 55.68},
{-2008.03, 968.74, 45.29},
{-2007.21, 863.07, 45.40},
{-2007.32, 749.23, 45.39},
{-2007.02, 645.84, 39.89},
{-2007.06, 541.66, 35.13},
{-2007.48, 441.98, 35.12},
{-2007.50, 344.60, 35.12},
{-2007.97, 245.20, 29.66},
{-2009.33, 129.57, 27.65},
{-2008.97, 15.98, 32.80},
{-2008.49, -58.47, 35.28},
{-2047.55, -73.90, 35.17},
}

local punktyC = {
		{-2046.79, -83.05, 35.26},
		{-2032.25, -74.04, 35.28},
		{-2007.52, -104.24, 35.83},
		{-2007.76, -183.19, 35.82},
		{-2006.81, -273.66, 35.42},
		{-2040.93, -290.05, 35.50},
		{-2120.22, -289.83, 35.52},
		{-2201.01, -288.29, 35.42},
		{-2204.16, -232.78, 35.50},
		{-2242.46, -187.10, 35.28},
		{-2261.24, -241.85, 38.14},
		{-2259.59, -312.84, 49.85},
		{-2248.89, -395.90, 50.97},
		{-2199.58, -481.55, 48.54},
		{-2211.71, -584.80, 51.16},
		{-2260.15, -648.50, 69.55},
		{-2241.49, -720.84, 65.23},
		{-2242.57, -744.91, 68.38},
		{-2280.16, -761.52, 82.98},
		{-2327.18, -786.65, 92.49},
		{-2352.10, -768.49, 96.28},
		{-2343.42, -715.39, 109.16},
		{-2356.58, -659.62, 120.80},
		{-2409.45, -621.85, 132.53},
		{-2446.70, -551.44, 124.33},
		{-2467.05, -491.46, 103.90},
		{-2528.91, -485.04, 84.84},
		{-2606.72, -498.37, 72.98},
		{-2618.34, -480.31, 69.27},
		{-2549.73, -468.10, 69.20},
		{-2471.64, -435.14, 81.11},
		{-2414.62, -420.02, 85.33},
		{-2354.44, -458.31, 80.41},
		{-2321.01, -434.35, 79.67},
		{-2371.41, -383.10, 76.87},
		{-2445.75, -365.95, 70.18},
		{-2555.14, -365.99, 52.39},
		{-2650.03, -390.09, 33.84},
		{-2679.51, -449.28, 29.51},
		{-2680.63, -516.80, 17.65},
		{-2756.50, -505.06, 7.34},
		{-2772.45, -472.54, 7.22},
		{-2721.30, -421.40, 7.42},
		{-2641.99, -370.56, 12.78},
		{-2551.24, -347.81, 25.48},
		{-2456.14, -342.49, 33.63},
		{-2353.81, -344.99, 39.29},
		{-2240.84, -350.40, 38.32},
		{-2124.18, -346.33, 35.10},
		{-2053.90, -350.42, 35.41},
		{-2020.55, -313.45, 35.34},
		{-2002.91, -248.38, 35.75},
		{-2003.38, -155.46, 35.82},
		{-2008.41, -73.81, 35.27},
		{-2047.55, -73.90, 35.17},
}

addEventHandler("onClientMarkerHit", markerB, function(gracz)
	if gracz ~= localPlayer then return end
	if getElementDimension(source) ~= getElementDimension(gracz) then return end
	if getElementInterior(source) ~= getElementInterior(gracz) then return end
	addEventHandler("onClientRender", root, guib)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	okno2 = true
end)

function guib()
	dxDrawImage(screenW * 0.3743, screenH * 0.2266, screenW * 0.2515, screenH * 0.5469, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Prawo jazdy kat. B", scale_x(536), scale_y(252), scale_x(903), scale_y(310), tocolor(255, 255, 255, 255), 1.00, font3, "center", "center", false, false, false, false, false)
    shadowText("Dana kategoria umożliwa\nci jazdę pojazdami osobowymi\n\nCena: 200 $", scale_x(536), scale_y(314), scale_x(903), scale_y(508), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) then
			dxDrawImage(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) then
			dxDrawImage(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    shadowText("Rozpocznij", screenW * 0.3868, screenH * 0.6875, screenW * 0.4956, screenH * 0.7474, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText("Anuluj", screenW * 0.5059, screenH * 0.6875, screenW * 0.6147, screenH * 0.7474, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) and okno2 == true then
    	removeEventHandler("onClientRender", root, guib)
    	okno2 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    	rozpocznijPrawkoB()
    elseif mysz(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) and okno2 == true then
    	removeEventHandler("onClientRender", root, guib)
    	okno2 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    end
  end
end)

function rozpocznijPrawkoB()
	if getElementData(localPlayer, "prawko_b") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już prawo jazdy kategorii B", "error") return end
	if getElementData(localPlayer, "pieniadze") < 200 then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error") return end
	punkty = 1
	stworzPunktyB()
	setElementData(localPlayer, "zdaje:prawko", "b")
	triggerServerEvent("stworzPojazd:b", localPlayer)
	setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-200)
end

function stworzPunktyB()
	local x,y,z = punktyB[punkty][1], punktyB[punkty][2], punktyB[punkty][3]
	marker = createMarker(x,y,z, "checkpoint", 3, 185, 43, 39, 100)
	if punkty == #punktyB then
		setMarkerIcon(marker, "finish")
	else
		local x,y,z = punktyB[punkty+1][1], punktyB[punkty+1][2], punktyB[punkty+1][3]
		setMarkerTarget(marker, x,y,z)
	end
	blip = createBlip(x, y, z, 41)
	addEventHandler("onClientMarkerHit", marker, onHitB)
end

function onHitB(el)
  if el ~= localPlayer then return end
	if punkty == #punktyB then
			setElementData(localPlayer, "zdaje", 10)
			zniszPunkty()
		return
	end
	zniszPunkty()
	punkty = punkty + 1
	stworzPunktyB()
end

--a

addEventHandler("onClientMarkerHit", markerA, function(gracz)
	if gracz ~= localPlayer then return end
	if getElementDimension(source) ~= getElementDimension(gracz) then return end
	if getElementInterior(source) ~= getElementInterior(gracz) then return end
	addEventHandler("onClientRender", root, guia)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	okno1 = true
end)

function guia()
	dxDrawImage(screenW * 0.3743, screenH * 0.2266, screenW * 0.2515, screenH * 0.5469, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Prawo jazdy kat. A", scale_x(536), scale_y(252), scale_x(903), scale_y(310), tocolor(255, 255, 255, 255), 1.00, font3, "center", "center", false, false, false, false, false)
    shadowText("Dana kategoria umożliwa\nci jazdę motocyklami\n\nCena: 500 $", scale_x(536), scale_y(314), scale_x(903), scale_y(508), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) then
			dxDrawImage(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) then
			dxDrawImage(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    shadowText("Rozpocznij", screenW * 0.3868, screenH * 0.6875, screenW * 0.4956, screenH * 0.7474, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText("Anuluj", screenW * 0.5059, screenH * 0.6875, screenW * 0.6147, screenH * 0.7474, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) and okno1 == true then
    	removeEventHandler("onClientRender", root, guia)
    	okno1 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    	rozpocznijPrawkoA()
    elseif mysz(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) and okno1 == true then
    	removeEventHandler("onClientRender", root, guia)
    	okno1 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    end
  end
end)

function rozpocznijPrawkoA()
	if getElementData(localPlayer, "prawko_a") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już prawo jazdy kategorii A", "error") return end
	if getElementData(localPlayer, "pieniadze") < 500 then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error") return end
	punkty = 1
	stworzPunktyA()
	setElementData(localPlayer, "zdaje:prawko", "a")
	triggerServerEvent("stworzPojazd:a", localPlayer)
	setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-500)
end

function stworzPunktyA()
	local x,y,z = punktyA[punkty][1], punktyA[punkty][2], punktyA[punkty][3]
	marker = createMarker(x,y,z, "checkpoint", 3, 185, 43, 39, 100)
	if punkty == #punktyA then
		setMarkerIcon(marker, "finish")
	else
		local x,y,z = punktyA[punkty+1][1], punktyA[punkty+1][2], punktyA[punkty+1][3]
		setMarkerTarget(marker, x,y,z)
	end
	blip = createBlip(x, y, z, 41)
	addEventHandler("onClientMarkerHit", marker, onHitA)
end

function onHitA(el)
  if el ~= localPlayer then return end
	if punkty == #punktyA then
			setElementData(localPlayer, "zdaje", 10)
			zniszPunkty()
		return
	end
	zniszPunkty()
	punkty = punkty + 1
	stworzPunktyA()
end

-- c

addEventHandler("onClientMarkerHit", markerC, function(gracz)
	if gracz ~= localPlayer then return end
	if getElementDimension(source) ~= getElementDimension(gracz) then return end
	if getElementInterior(source) ~= getElementInterior(gracz) then return end
	addEventHandler("onClientRender", root, guic)
	showCursor(true)
	setElementData(localPlayer, "hud", true)
	showChat(false)
	executeCommandHandler("radar")
	setElementData(localPlayer, "player:blackwhite", true)
	okno3 = true
end)

function guic()
	dxDrawImage(screenW * 0.3743, screenH * 0.2266, screenW * 0.2515, screenH * 0.5469, ":smta_veh_licences/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText("Prawo jazdy kat. C", scale_x(536), scale_y(252), scale_x(903), scale_y(310), tocolor(255, 255, 255, 255), 1.00, font3, "center", "center", false, false, false, false, false)
    shadowText("Dana kategoria umożliwa\nci jazdę pojazdami dostawczymi\n\nCena: 2000 $", scale_x(536), scale_y(314), scale_x(903), scale_y(508), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
	if mysz(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) then
			dxDrawImage(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) then
			dxDrawImage(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    shadowText("Rozpocznij", screenW * 0.3868, screenH * 0.6875, screenW * 0.4956, screenH * 0.7474, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText("Anuluj", screenW * 0.5059, screenH * 0.6875, screenW * 0.6147, screenH * 0.7474, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.3860, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) and okno3 == true then
    	removeEventHandler("onClientRender", root, guic)
    	okno3 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")
		setElementData(localPlayer, "player:blackwhite", false)
    	rozpocznijPrawkoC()
    elseif mysz(screenW * 0.5059, screenH * 0.6862, screenW * 0.1096, screenH * 0.0612) and okno3 == true then
    	removeEventHandler("onClientRender", root, guic)
    	okno3 = false
    	showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		executeCommandHandler("radar")	
		setElementData(localPlayer, "player:blackwhite", false)
    end
  end
end)

function rozpocznijPrawkoC()
	if getElementData(localPlayer, "prawko_c") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już prawo jazdy kategorii C", "error") return end
	if getElementData(localPlayer, "pieniadze") < 2000 then exports["smta_base_notifications"]:noti("Nie posiadasz wystarczającej sumy pieniędzy", "error") return end
	punkty = 1
	stworzPunktyC()
	setElementData(localPlayer, "zdaje:prawko", "c")
	triggerServerEvent("stworzPojazd:c", localPlayer)
	setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")-2000)
end

function stworzPunktyC()
	local x,y,z = punktyC[punkty][1], punktyC[punkty][2], punktyC[punkty][3]
	marker = createMarker(x,y,z, "checkpoint", 3, 185, 43, 39, 100)
	if punkty == #punktyC then
		setMarkerIcon(marker, "finish")
	else
		local x,y,z = punktyC[punkty+1][1], punktyC[punkty+1][2], punktyC[punkty+1][3]
		setMarkerTarget(marker, x,y,z)
	end
	blip = createBlip(x, y, z, 41)
	addEventHandler("onClientMarkerHit", marker, onHitC)
end

function onHitC(el)
  if el ~= localPlayer then return end
	if punkty == #punktyC then
			setElementData(localPlayer, "zdaje", 10)
			zniszPunkty()
		return
	end
	zniszPunkty()
	punkty = punkty + 1
	stworzPunktyC()
end


function zniszPunkty()
	if isElement(marker) then destroyElement(marker) end
	if isElement(blip) then destroyElement(blip) end
end
addEvent("destroyPunkt", true)
addEventHandler("destroyPunkt", getRootElement(), zniszPunkty)

local x1,y1,z1

addEventHandler("onClientPreRender", getRootElement(), function ()
	if not getElementData(localPlayer, "zdaje") then return end
	local pojazd = getPedOccupiedVehicle(localPlayer)
	if not pojazd then return end
 	local s = getPedOccupiedVehicleSeat(localPlayer)
	if s ~= 0 then return end
	if not x1 or not y1 or not z1 then
		x1,y1,z1 = getElementPosition(pojazd)
	end
	local x2,y2,z2 = getElementPosition(pojazd)
	local dystans = getDistanceBetweenPoints3D(x1,y1,z1, x2,y2,z2)
	if dystans > 10 then
		local dozdania = getElementData(localPlayer, "zdaje")
		if dozdania then
			setElementData(localPlayer, "zdaje", dozdania-0.050)
		end
		if dozdania <= 0 then
			setElementData(localPlayer, "zdaje", false)
			if getElementData(localPlayer, "zdaje:prawko") == "a" then   
    			triggerServerEvent("usunPojazd:a", localPlayer)
    			triggerServerEvent("dajPrawko", localPlayer, "a")
    		elseif getElementData(localPlayer, "zdaje:prawko") == "b" then 
    			triggerServerEvent("usunPojazd:b", localPlayer)
    			triggerServerEvent("dajPrawko", localPlayer, "b")
    		elseif getElementData(localPlayer, "zdaje:prawko") == "c" then 
    			triggerServerEvent("usunPojazd:c", localPlayer)
    			triggerServerEvent("dajPrawko", localPlayer, "c")
    		end
    		exports["smta_base_notifications"]:noti("Gratulacje! Pomyślnie zdajesz egzamin.")
    	end
		x1,y1,z1 = getElementPosition(pojazd)
	end
end)

addEventHandler("onClientRender", root, function()
    if getElementData(localPlayer, "zdaje") then
        if not isPedInVehicle(localPlayer) then return end
	dxDrawImage(screenW * 0.0147, screenH * 0.6654, screenW * 0.2206, screenH * 0.0638, ":smta_veh_boosters/gfx/bg1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Do końca egamiznu pozostało: "..string.format("%1.2f", getElementData(localPlayer, "zdaje")).." km\nUważaj na drodze!", screenW * 0.0162, screenH * 0.6667, screenW * 0.2353, screenH * 0.7292, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
    end
end)


-- dodatki

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
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

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

tablica = {}


function nalicz()
	local veh=getPedOccupiedVehicle(localPlayer)
	if not veh then return end
	local x,y,z=getElementPosition(veh)
	table.insert(tablica, {x,y,z})
	outputChatBox("Zapisałem!")
end

addCommandHandler("zakoncz", function()
	for i,v in ipairs(tablica) do
		lol=string.format("{%.02f, %.02f, %.02f},", v[1], v[2], v[3])
		outputChatBox("		"..lol)
		killTimer(punkty_timer)
	end
end)

addCommandHandler("licz", function()
	outputChatBox("* Rozpocząłeś(aś) naliczanie, aby zakończyć wpisz /zakoncz")
	punkty_timer=setTimer(nalicz, 3000, 0)
end)