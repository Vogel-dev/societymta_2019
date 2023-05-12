--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local px, py = sx/1440, sy/900
local okno1 = false
local ulepszenia = false

local pracodawca = createPed(127, -1756.11, 961.56, 24.88, 180)
setElementData(pracodawca, "name", "Pracodawca")
setElementDimension(pracodawca, 0)
setElementFrozen(pracodawca, true)
local rozpoczecie = createMarker(-1755.92, 960.82, 24.88-0.95, "cylinder", 1, 59, 122, 87, 100)
setElementData(rozpoczecie, "sprzedaz", true)
setElementDimension(rozpoczecie, 0)


addEventHandler("onClientMarkerHit", rozpoczecie, function(gracz)
	if gracz ~= localPlayer then return end
    if getPedOccupiedVehicle(localPlayer) then return end
	if getElementDimension(source) ~= getElementDimension(localPlayer) then return end
	if getElementDimension(source) ~= getElementDimension(localPlayer) then return end
    --if getElementData(localPlayer, "punkty") < 300 then exports["smta_base_notifications"]:noti("Nie posiadasz 300 punktów reputacji!", "error") return end
    --if getElementData(localPlayer, "prawko_c") ~= 1 then exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy kat.c!", "error") return end
    if getElementData(localPlayer, "pracuje") then
        if getElementData(localPlayer, "pracuje") ~= "autobusy" then exports["smta_base_notifications"]:noti("Posiadasz inną aktywną prace!", "error") return end
    end
	addEventHandler("onClientRender", root, guistart)
	okno1 = true
	showCursor(true)
	triggerServerEvent("pokazTopke:autobusy:source", localPlayer)
end)

local font = dxCreateFont("cz.ttf", 10)
local font2 = dxCreateFont("cz.ttf", 12)

local pracownicy = { }

local listaulepszen = {
	{"Druga trasa", "", 200, "dolar.png"},
    {"Zarobek +25%", "", 300, "dolar.png"},
}


function guistart()
    if ulepszenia == false then
	   local punkty = getElementData(localPlayer, "apunkty") or 0
	   local zlecenia = getElementData(localPlayer, "azlecenia") or 0
	    dxDrawImage(screenW * 0.2592, screenH * 0.2839, screenW * 0.4824, screenH * 0.4323, ":smta_jobs_tram/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Kursy: "..zlecenia.."\nPunkty: "..punkty.."", screenW * 0.2701, screenH * 0.5924, screenW * 0.3843, screenH * 0.6445, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
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
           dxDrawText(v.liczba, screenW * 0.6611, screenH * 0.4766+ dodatekY2, screenW * 0.7160, screenH * 0.5091, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        end
    else
		local punkty = getElementData(localPlayer, "apunkty") or 0
		dxDrawImage(screenW * 0.2855, screenH * 0.2773, screenW * 0.4297, screenH * 0.3008, ":smta_jobs_tram/gfx/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if mysz(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247) then
			dxDrawImage(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 else
			dxDrawImage(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 end
        dxDrawText("Posiadasz "..punkty.." punktów pracy jako kierowca tramwaju.", screenW * 0.2862, screenH * 0.4818, screenW * 0.7152, screenH * 0.5703, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
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
    	if getElementData(localPlayer, "pracuje") == "autobusy" then
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
    elseif mysz(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247) and okno1 == true and ulepszenia == true then
        ulepszenia = false
    end
    for i, v in ipairs(listaulepszen) do
        local dodatekY = (scale_y(72))*(i-1)
        if mysz(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443) and okno1 == true and ulepszenia == true then
            local punkty = getElementData(localPlayer, "apunkty") or 0
            if punkty < tonumber(v[3]) then exports["smta_base_notifications"]:noti("Posiadasz za mało punktów by zakupić to ulepszenie", "error") return end
            if v[1] == "Druga trasa" then 
                if getElementData(localPlayer, "autobusy:ulepszenie1") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już to ulepszenie", "error") return end
                setElementData(localPlayer, "autobusy:ulepszenie1", 1)
            elseif v[1] == "Zarobek +25%" then
                if getElementData(localPlayer, "autobusy:ulepszenie2") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już to ulepszenie", "error") return end
                setElementData(localPlayer, "autobusy:ulepszenie2", 1)
            end
            exports["smta_base_notifications"]:noti("Zakupujesz ulepszenie: "..v[1])
            setElementData(localPlayer, "apunkty", punkty-tonumber(v[3]))
        end
    end
  end
end)

addEvent("pokazTopke:autobusy:client", true)
addEventHandler("pokazTopke:autobusy:client", root, function(tabelka)
  pracownicy = tabelka
end)

-- praca

local bileciki = true
local trzymam1 = false
local trzymam2 = false
local bilet = false
local klienci = 0
local sprzedane = 0

local markers = {
    [1] = {
        [1] = {
			{-1820.33, 921.13, 26.08},
			{-1869.27, 921.09, 35.50},
			{-1930.81, 921.00, 38.61},
			{-2000.05, 911.85, 45.75},
			{-1973.88, 848.88, 45.65},
			{-1888.13, 848.88, 35.50},
			{-1798.50, 848.88, 25.13},
			{-1705.04, 848.88, 25.22},
			{-1610.89, 848.89, 8.00},
			{-1536.28, 820.89, 7.50},
			{-1556.07, 729.11, 7.50},
			{-1655.90, 728.75, 17.19},
			{-1711.56, 677.83, 25.12},
			{-1754.13, 603.25, 26.25},
			{-1857.03, 603.25, 35.50},
			{-1961.89, 603.25, 35.50},
			{-2003.45, 533.78, 35.50},
			{-2003.63, 431.14, 35.50},
			{-2003.63, 325.91, 35.50},
			{-2006.50, 220.89, 28.24},
			{-2006.50, 112.01, 28.00},
			{-2039.13, 30.27, 35.48},
			{-2149.50, 30.45, 35.62},
			{-2168.17, -63.66, 35.62},
			{-2255.50, -50.14, 35.62},
			{-2253.62, 55.25, 35.62},
			{-2251.50, 161.67, 35.62},
			{-2251.47, 270.53, 35.62},
			{-2267.61, 376.57, 34.30},
			{-2343.36, 457.80, 32.99},
			{-2317.02, 508.50, 32.83},
			{-2264.88, 568.05, 35.50},
			{-2264.98, 673.43, 49.75},
			{-2264.91, 777.68, 49.84},
			{-2264.88, 879.47, 66.89},
			{-2264.88, 982.07, 72.48},
			{-2264.88, 1086.27, 80.34},
			{-2265.08, 1189.03, 55.88},
			{-2249.22, 1271.21, 41.47},
			{-2156.59, 1274.24, 26.77},
			{-2062.54, 1280.78, 8.55},
			{-1981.62, 1307.88, 7.50},
			{-1891.17, 1337.77, 7.50},
			{-1801.52, 1379.84, 7.50},
			{-1714.94, 1328.16, 7.50},
			{-1638.28, 1251.25, 7.50},
			{-1584.69, 1159.90, 7.50},
			{-1584.13, 1046.06, 7.50},
			{-1532.67, 954.80, 7.50},
			{-1599.01, 921.18, 8.00},
			{-1698.75, 921.13, 25.12},
        },
    },
	[2] = {
        [1] = {
{-1942.53, 172.68, 27.12},
{-1943.58, 151.20, 27.12},
{-1944.35, 115.78, 27.12},
{-1944.38, 66.90, 27.12},
{-1944.38, 5.06, 27.12},
{-1944.46, -68.86, 27.12},
{-1944.53, -155.13, 27.12},
{-1953.35, -252.47, 27.12},
{-1966.18, -360.32, 27.12},
{-1977.53, -479.29, 27.12},
{-1979.83, -609.01, 27.21},
{-1978.55, -748.64, 27.12},
{-1978.57, -884.52, 27.12},
{-1974.73, -1014.62, 24.61},
{-1942.38, -1139.03, 16.85},
{-1880.58, -1251.54, 15.37},
{-1803.55, -1358.41, 15.37},
{-1705.20, -1449.13, 15.37},
{-1582.85, -1493.37, 17.42},
{-1450.70, -1507.46, 22.67},
{-1319.19, -1510.42, 25.26},
{-1187.45, -1517.67, 39.87},
{-1057.85, -1505.11, 70.37},
{-932.84, -1493.61, 93.62},
{-850.47, -1415.50, 94.50},
{-829.77, -1300.53, 81.40},
{-800.65, -1185.61, 67.76},
{-706.59, -1122.27, 57.40},
{-602.76, -1154.95, 43.74},
{-518.25, -1222.51, 43.50},
{-417.41, -1254.40, 43.54},
{-323.65, -1183.96, 37.40},
{-248.02, -1080.87, 20.94},
{-139.84, -1024.16, 12.90},
{-20.93, -1018.00, 21.99},
{94.51, -1018.61, 23.43},
{204.80, -1029.45, 22.93},
{310.27, -1053.93, 20.17},
{419.57, -1094.43, 15.42},
{532.44, -1152.25, 9.57},
{641.76, -1224.22, 4.08},
{741.05, -1301.84, 0.66},
{833.95, -1384.05, -0.11},
{925.00, -1473.43, -0.40},
{1011.84, -1566.38, -1.50},
{1097.90, -1663.87, -2.59},
{1184.54, -1764.43, -2.82},
{1272.94, -1865.75, -1.29},
{1379.12, -1942.68, 10.51},
{1511.80, -1953.74, 15.00},
{1649.37, -1953.66, 15.00},
{1788.34, -1953.82, 15.00},
{1922.31, -1953.75, 15.25},
{2056.09, -1953.75, 15.25},
{2182.07, -1939.37, 15.25},
{2198.63, -1819.02, 15.09},
{2201.21, -1690.03, 15.48},
{2242.26, -1564.64, 20.38},
{2281.53, -1441.71, 25.12},
{2284.88, -1307.97, 25.62},
{2284.88, -1172.76, 27.72},
{2284.88, -1041.98, 28.50},
{2284.78, -903.90, 28.16},
{2259.71, -771.92, 37.22},
{2166.60, -681.55, 51.56},
{2062.40, -598.28, 69.49},
{1994.08, -493.34, 73.12},
{2042.58, -381.06, 68.05},
{2163.38, -357.27, 54.74},
{2281.61, -331.39, 38.60},
{2393.88, -273.44, 20.65},
{2516.65, -280.63, 18.20},
{2634.35, -294.92, 15.10},
{2749.57, -268.20, 20.21},
{2809.44, -160.35, 31.99},
{2827.80, -33.67, 32.89},
{2821.97, 95.42, 27.16},
{2787.73, 222.40, 12.03},
{2765.23, 346.08, 9.19},
{2765.27, 471.42, 9.70},
{2765.08, 603.20, 10.90},
{2764.77, 734.43, 12.27},
{2764.75, 873.69, 12.37},
{2764.75, 1011.25, 12.37},
{2830.08, 1135.09, 12.25},
{2864.75, 1259.02, 12.25},
{2864.75, 1391.76, 12.25},
{2858.01, 1523.97, 12.25},
{2788.88, 1634.20, 12.25},
{2780.88, 1763.95, 12.25},
{2781.00, 1896.86, 8.27},
{2778.98, 2024.07, 5.23},
{2711.10, 2133.71, -0.07},
{2604.66, 2209.81, 1.24},
{2552.95, 2324.22, 5.19},
{2552.38, 2453.87, 12.20},
{2543.80, 2580.08, 12.25},
{2473.23, 2681.55, 12.25},
{2342.43, 2690.13, 12.25},
{2209.69, 2690.13, 12.25},
{2081.59, 2694.13, 12.46},
{1947.67, 2694.13, 12.25},
{1817.62, 2687.79, 12.25},
{1697.74, 2648.44, 12.25},
{1569.36, 2632.25, 12.25},
{1431.57, 2632.25, 12.25},
{1293.73, 2632.25, 12.25},
{1159.09, 2655.08, 13.74},
{1047.17, 2739.59, 16.45},
{918.05, 2750.65, 20.97},
{826.92, 2659.08, 22.25},
{768.38, 2540.79, 22.22},
{728.54, 2416.80, 21.34},
{730.39, 2281.28, 19.99},
{739.21, 2144.68, 15.53},
{740.75, 2010.36, 8.04},
{741.83, 1872.80, 7.32},
{742.72, 1735.33, 7.45},
{743.36, 1597.70, 9.67},
{738.82, 1460.88, 12.30},
{686.33, 1340.11, 13.25},
{570.75, 1266.89, 13.43},
{443.70, 1210.59, 18.26},
{305.78, 1212.55, 24.11},
{180.08, 1253.42, 24.25},
{56.48, 1289.83, 20.40},
{-75.20, 1290.56, 20.05},
{-202.63, 1275.54, 26.41},
{-325.86, 1248.85, 31.47},
{-446.66, 1220.67, 31.54},
{-563.42, 1195.55, 28.72},
{-681.81, 1167.38, 30.70},
{-787.56, 1102.92, 35.25},
{-891.98, 1027.15, 36.00},
{-996.07, 951.36, 36.00},
{-1100.98, 875.11, 36.00},
{-1209.66, 796.18, 36.00},
{-1322.04, 714.56, 36.00},
{-1430.83, 635.52, 36.00},
{-1536.80, 558.48, 35.93},
{-1641.23, 482.75, 23.56},
{-1743.44, 408.46, 6.26},
{-1843.22, 338.86, 6.39},
{-1927.32, 260.57, 22.82},
{-1943.66, 149.23, 27.12},
		},
	},		
}

x, y = 39*px, 30*py
x2, y2 = 39*px, 174*py

--guiCreateWindow(0.70, 0.19, 0.29, 0.60, "", true)

function gbilety()
    local mx, my = getCursorPosition()
    if mysz(x, y, 370*px, 127*py) and getKeyState("mouse1") == true then
        x, y = (mx*sx-(370*px/2)),(my*sy-(127*py/2))
        trzymam1 = true
        trzymam2 = false
    end
    if mysz(x2, y2, 370*px, 127*py) and getKeyState("mouse1") == true then
        x2, y2 = (mx*sx-(370*px/2)),(my*sy-(127*py/2))
        trzymam1 = false
        trzymam2 = true
    end
    if mysz(587*px, 373*py, 370*px, 127*py) and trzymam1 == true or trzymam2 == true then
        git = true
    else
        git = false
    end
    if mysz(587*px, 373*py, 370*px, 127*py) and git == true and getKeyState("mouse1") ~= true then
        sprzedal()
        trzymam1 = false
        trzymam2 = false
        git = false
    end
    --dxDrawImage(0, 0, sx, sy, ":np-gui/grafiki/tlo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    --dxDrawImage(x, y, 370*px, 127*py, ":smta_jobs_tram/gfx/ulgowy.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    --dxDrawImage(x2, y2, 370*px, 127*py, ":smta_jobs_tram/gfx/normalny.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    --dxDrawLine(586*px, 372*py, 586*px, 500*py, tocolor(25, 175, 131, 255), 2, false)
    --dxDrawLine(957*px, 372*py, 586*px, 372*py, tocolor(25, 175, 131, 255), 2, false)
    --dxDrawLine(586*px, 500*py, 957*px, 500*py, tocolor(25, 175, 131, 255), 2, false)
    --dxDrawLine(957*px, 500*py, 957*px, 372*py, tocolor(25, 175, 131, 255), 2, false)
    --dxDrawRectangle(587*px, 373*py, 370*px, 127*py, tocolor(0, 0, 0, 120), false)
    --dxDrawText(bilet[1], 585*px, 373*py, 957*px, 500*py, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    if not myElement or not myObject then return end
    local projPosX, projPosY = guiGetPosition(guiWindow,true)
    local projSizeX, projSizeY = guiGetSize(guiWindow, true)
    exports.object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
end

function rozpocznijprace()
    setElementData(localPlayer, "pracuje", "autobusy")
    exports["smta_base_notifications"]:noti("Rozpoczynasz pracę, uważaj na drodze.")
    triggerServerEvent("dajAutobus:autobusy", localPlayer)
    punkty = 0
    if getElementData(localPlayer, "autobusy:ulepszenie1") == 1 then
    	region = 2 
    else
    	region = 1
    end
    los = math.random(1, #markers[region])
    showMarkers()
end

function zakonczprace(cos)
    setElementData(localPlayer, "pracuje", false)
	triggerServerEvent("usunAutobus:autobusy", localPlayer)
	setElementPosition(localPlayer, -1751.57, 959.07, 24.88)
    if isElement(marker) then
		destroyElement(marker)
		setElementPosition(localPlayer, -1751.57, 959.07, 24.88)
		exports["smta_base_notifications"]:noti("Zakończyłes pracę.")
    end
    if isElement(blip) then
		destroyElement(blip)
		setElementPosition(localPlayer, -1751.57, 959.07, 24.88)
    end
    if cos then
		setElementPosition(localPlayer, -1751.57, 959.07, 24.88)
		--exports["smta_base_notifications"]:noti("Zakończyłes pracę.")
    end
end
addEvent("zakonczPrace:autobusy", true)
addEventHandler("zakonczPrace:autobusy", root, zakonczprace)

function showMarkers()
    if isElement(marker) then
        destroyElement(marker)
    end
    if isElement(blip) then
        destroyElement(blip)
    end
    if punkty == #markers[region][los] then return end
    punkty = punkty + 1
    local przystanek = markers[region][los][punkty][4] or 0
    if przystanek == 1 then
        r, g, b = 185, 43, 39
    else
        r, g, b = 21, 101, 192
    end
    marker = createMarker(markers[region][los][punkty][1], markers[region][los][punkty][2], markers[region][los][punkty][3], "checkpoint", 4, r, g, b)
    blip = createBlipAttachedTo(marker, 41)
    setElementData(marker, "przystanek", (markers[region][los][punkty][4] or 0 ))
    if markers[region][los][punkty+1] then
        ile = markers[region][los][punkty+1]
        setMarkerTarget(marker, ile[1], ile[2], ile[3])
    end
    addEventHandler("onClientMarkerHit", marker, markersHit)
end

local bilety = {
    {"Ulgowy"},
    {"Normalny"},
}

function markersHit(gracz)
    if gracz ~= localPlayer then return end
    if punkty == #markers[region][los] then
        zakonczprace()
        triggerServerEvent("daj:azlecenia", localPlayer, localPlayer)
    end
	if getElementData(source, "przystanek") == 1 then
        addEventHandler("onClientRender", root, gbilety)
        showCursor(true)
        bileciki = true
		setElementData(localPlayer, "hud", true)
        local x1, y1, z1 = getCameraMatrix()
        myElement = createPed(math.random(10, 41), x1, y1, z1, 0)
        myObject = exports.object_preview:createObjectPreview(myElement, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
        guiWindow = guiCreateWindow(987*px, 186*py, 418*px, 506*py, "", false, false)
        guiSetAlpha(guiWindow, 0)
        local projPosX, projPosY = guiGetPosition(guiWindow,true)
        local projSizeX, projSizeY = guiGetSize(guiWindow, true)
        exports.object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
        exports.object_preview:setRotation(myObject, -10, 0, 160)
        bilet = bilety[math.random(#bilety)]
        klienci = math.random(1,4)
        --outputChatBox(klienci)
        sprzedane = 0
    else
        showMarkers()
        if getElementData(localPlayer, "autobusy:ulepszenie1") == 1 then
       		zarobek2 = math.random(9, 11)
       	else
       		zarobek2 = math.random(5, 7)
       	end
        if getElementData(localPlayer, "premium") then
            zarobek2 = zarobek2 + zarobek2*0.50
		end
		if getElementData(localPlayer, "autobusy:ulepszenie2") == 1 then
            zarobek2 = zarobek2 + zarobek2*0.25
        end
		setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+zarobek2)
		exports["smta_base_notifications"]:noti("Otrzymujesz "..zarobek2.." $ za wykonywanie pracy.")
		local punkty = getElementData(localPlayer, "apunkty") or 0
    	setElementData(localPlayer, "apunkty", punkty+math.random(0,1))
        local nagroda = math.random(1, 20)
        if tonumber(nagroda) == 5 then
            local los2 = math.random(1,3)
            if getElementData(localPlayer, "premium") then
                los2 = math.random(2, 6)
            end
            setElementData(localPlayer, "punkty", getElementData(localPlayer, "punkty")+los2)
            exports["smta_base_notifications"]:noti("Za dobrą prace otrzymujesz "..los2.." SP")
        end
    end
end

function sprzedal()
    if (bilet[1] == "Ulgowy" and trzymam2 == true) or (bilet[1] == "Normalny" and trzymam1 == true) then
        exports["smta_base_notifications"]:noti("Dałeś klientowi zły bilet", "error")
    else
        exports["smta_base_notifications"]:noti("Sprzedajesz bilet klientowi")
        if getElementData(localPlayer, "autobusy:ulepszenie1") == 1 then
        	zarobek = math.random(10, 18)
        else
        	zarobek = math.random(8, 16)
        end
        if getElementData(localPlayer, "premium") then
            zarobek = zarobek + zarobek*1.50
        end
        if getElementData(localPlayer, "autobusy:ulepszenie2") == 1 then
            zarobek = zarobek + zarobek*1.25
        end
		setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+zarobek)
		exports["smta_base_notifications"]:noti("Otrzymujesz "..zarobek.." $ za wykonywanie pracy.")
		local punkty = getElementData(localPlayer, "apunkty") or 0
    	setElementData(localPlayer, "apunkty", punkty+math.random(0,1))
    end
    sprzedane = sprzedane + 1
    bilet = bilety[math.random(#bilety)]
    if sprzedane >= klienci then 
        showMarkers() 
        removeEventHandler("onClientRender", root, gbilety)
        showCursor(false)
        bileciki = false
        x, y = 39*px, 30*py
        x2, y2 = 39*px, 174*py
        setElementFrozen(getPedOccupiedVehicle(localPlayer), false)
        if isElement(myElement) then
            destroyElement(myElement)
        end
        setElementData(localPlayer, "hud", false)
    return end
    local punkty = getElementData(localPlayer, "apunkty") or 0
    setElementData(localPlayer, "apunkty", punkty+math.random(0,1))
    x, y = 39*px, 30*py
    x2, y2 = 39*px, 174*py
    if isElement(myElement) then
        destroyElement(myElement)
    end
    local x1, y1, z1 = getCameraMatrix()
    myElement = createPed(math.random(10, 41), x1, y1, z1, 0)
    myObject = exports.object_preview:createObjectPreview(myElement, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
    guiWindow = guiCreateWindow(987*px, 186*py, 418*px, 506*py, "", false, false)
    guiSetAlpha(guiWindow, 0)
    local projPosX, projPosY = guiGetPosition(guiWindow,true)
    local projSizeX, projSizeY = guiGetSize(guiWindow, true)
    exports.object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
    exports.object_preview:setRotation(myObject, -10, 0, 160)
end

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

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end