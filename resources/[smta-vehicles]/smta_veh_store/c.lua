--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local zoom = 1.0
local baseX = 1440
local minZoom = 2

local blip = createBlip(-2113.69, -20.23, 35.01, 20)
setBlipVisibleDistance(blip, 300)

local screenW, screenH = guiGetScreenSize()
local px,py = screenW/1440, screenH/900

if screenW < baseX then
	zoom = math.min(minZoom, baseX/screenW)
end
local sx, sy = guiGetScreenSize()
local pojazdy = {}

local przechowalnia = false
local informacje = false

local scx, scy = guiGetScreenSize ()
local myObject,myElement, guiWindow = nil, nil, nil
local myRotation = {0,0,0}

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


local f = dxCreateFont("cz.ttf", 15)

local width = scale_x(659)
local height = scale_y(222)
local scrollPos = 0
local scrollOffset = scale_y(39)

local maxRender = dxCreateRenderTarget(width, height, true)

function gui()
    dxDrawImage(screenW * 0.0000, screenH * -0.0130, screenW * 0.3618, screenH * 0.2539, ":smta_veh_store/gfx/pasek_up.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(screenW * 0.0493, screenH * -0.0117, screenW * 0.2699, screenH * 0.2174, ":smta_veh_store/gfx/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(screenW * 0.0000, screenH * 0.1328, screenW * 0.3596, screenH * 0.3555, "gfx/podpaskiem.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.3338, screenH * 0.0208, screenW * 0.0110, screenH * 0.0247) then
        	dxDrawImage(screenW * 0.3338, screenH * 0.0208, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.3338, screenH * 0.0208, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    dxSetRenderTarget(maxRender, true)
    for i,v in ipairs(pojazdy) do
    	local offsetY = (scale_y(39))*(i-1)
    	local offsetY2 = (scale_y(78))*(i-1)
    	local scroll = scrollPos * scrollOffset
    	local scroll2 = (scrollPos * scrollOffset) * 2

    	local model = getVehicleNameFromModel(v.model)
      if mysz(scale_x(21), (scale_y(195) + offsetY) - scroll, scale_x(457), scale_y(39)) then
        dxDrawImage(screenW * 0.0125,( screenH * 0.0221+offsetY) -scroll, screenW * 0.3360, screenH * 0.0508, "gfx/pasek_zazna.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
      else
        dxDrawImage(screenW * 0.0125,( screenH * 0.0221+offsetY) -scroll, screenW * 0.3360, screenH * 0.0508, "gfx/pasek_nieza.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
      end
      dxDrawText("("..v.id..") - "..model, screenW * 0.0125, (screenH * 0.0221+offsetY2)-scroll2, screenW * 0.3485, screenH * 0.0729, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
    end
    dxSetRenderTarget(false)
	  dxDrawImage(0, scale_y(190), width, height, maxRender)
end

function guiinfo()
  if vehicle_neon == 1 then
    r = 255
    g = 255
    b = 255
  elseif vehicle_neon == 2 then
    r = 255
    g = 0
    b = 0
  elseif vehicle_neon == 3 then
    r = 0
    g = 255
    b = 0
  elseif vehicle_neon == 4 then
    r = 0
    g = 0
    b = 255
  elseif vehicle_neon == 5 then
    r = 255
    g = 255
    b = 0
  elseif vehicle_neon == 6 then
    r = 0
    g = 255
    b = 255
  elseif vehicle_neon == 7 then
    r = 255
    g = 0
    b = 255
  end
  local modules = {}
  if vehicle_ms1 == 1 then
    table.insert(modules, "SB1")
  end
  if vehicle_ms2 == 1 then
    table.insert(modules, "SB2")
  end
  if vehicle_ms3 == 1 then
    table.insert(modules, "SB3")
  end
  modules = table.concat(modules, ", ")
  if #modules < 1 then
    modules = "brak"
  end
  dxDrawImage(screenW * 0.3441, screenH * -0.0247, screenW * 0.5169, screenH * 0.5130, ":smta_veh_store/gfx/podpaskiem.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
  dxDrawImage(screenW * 0.5904, screenH * 0.0273, screenW * 0.0596, screenH * 0.1055, ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(vehicle_kolor[1], vehicle_kolor[2], vehicle_kolor[3], 255), false)
  dxDrawImage(screenW * 0.5904, screenH * 0.1328, screenW * 0.0596, screenH * 0.1055, ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(vehicle_kolor[4], vehicle_kolor[5], vehicle_kolor[6], 255), false)
  dxDrawImage(screenW * 0.5904, screenH * 0.2383, screenW * 0.0596, screenH * 0.1055, ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(vehicle_swiatla[1], vehicle_swiatla[2], vehicle_swiatla[3], 255), false)
  if vehicle_neon ~= 0 then
    dxDrawImage(screenW * 0.5904, screenH * 0.3438, screenW * 0.0596, screenH * 0.1055, ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(r, g, b, 255), false)
  end
  dxDrawText("Kolor podstawowy", screenW * 0.6537, screenH * 0.0469, screenW * 0.7853, screenH * 0.1120, tocolor(255, 255, 255, 255), 1.00, f, "left", "center", false, false, false, false, false)
  dxDrawText("Kolor drugi", screenW * 0.6537, screenH * 0.1523, screenW * 0.7853, screenH * 0.2174, tocolor(255, 255, 255, 255), 1.00, f, "left", "center", false, false, false, false, false)
  dxDrawText("Kolor świateł", screenW * 0.6537, screenH * 0.2565, screenW * 0.7853, screenH * 0.3216, tocolor(255, 255, 255, 255), 1.00, f, "left", "center", false, false, false, false, false)
  if vehicle_neon ~= 0 then
    dxDrawText("Kolor neonów", screenW * 0.6537, screenH * 0.3620, screenW * 0.7853, screenH * 0.4271, tocolor(255, 255, 255, 255), 1.00, f, "left", "center", false, false, false, false, false)
  end
  dxDrawText("Przebieg: "..vehicle_przebieg.."km\nPaliwo: "..vehicle_paliwo.."L/"..vehicle_bak.."L\nPojemność silnika: "..vehicle_pojemnosc.."dm3\nStan pojazdu: "..(vehicle_stan/10).."%\nUlepszenia: "..modules, screenW * 0.3662, screenH * 0.2526, screenW * 0.5831, screenH * 0.4362, tocolor(255, 255, 255, 255), 1.00, f, "left", "top", false, false, false, false, false)
  --dxDrawText(" ", scale_x(889), scale_y(291), scale_x(1231), scale_y(456), tocolor(255, 255, 255, 255), 1.00, f, "left", "top", false, false, false, false, false)
  if mysz(screenW * 0.2088, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651) then
  	dxDrawImage(screenW * 0.2088, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  else
  	dxDrawImage(screenW * 0.2088, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  end
  if mysz(screenW * 0.0346, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651) then
  	dxDrawImage(screenW * 0.0346, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651, ":smta_veh_licences/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  else
  	dxDrawImage(screenW * 0.0346, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651, ":smta_veh_licences/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  end
  dxDrawText("Akceptuj", screenW * 0.0368, screenH * 0.1367, screenW * 0.1493, screenH * 0.1927, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)
  dxDrawText("Wycofaj", screenW * 0.2140, screenH * 0.1367, screenW * 0.3265, screenH * 0.1927, tocolor(255, 255, 255, 255), 1.00, f, "center", "center", false, false, false, false, false)

  --if not myElement or not myObject then return end
  --local projPosX, projPosY = guiGetPosition(guiWindow,true)
  --local projSizeX, projSizeY = guiGetSize(guiWindow, true)
  setVehicleColor(myElement, vehicle_kolor[1], vehicle_kolor[2], vehicle_kolor[3])
  --exports.object_preview:setProjection(myObject,projPosX, projPosY, projSizeX, projSizeY, true, true)
end

addEvent("pojazdy", true)
addEventHandler("pojazdy", root, function(cos)
  if cos == true then
    removeEventHandler("onClientRender", root, gui)
    showCursor(false)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
	setElementData(localPlayer, "player:blackwhite", false)
    przechowalnia = false
    showChat(true)
     if isElement(myElement) then
      exports.object_preview:destroyObjectPreview(myObject)
      destroyElement(myElement)
      guiSetVisible(guiWindow, false)
      removeEventHandler("onClientRender", root, guiinfo)
      informacje = false
    end
  else
  	showCursor(true, false)
    addEventHandler("onClientRender", root, gui)
    triggerServerEvent("pokazPojazdy:przechowalnia", localPlayer)
    przechowalnia = true
    showChat(false)
	setElementData(localPlayer, "hud", true)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
	setElementData(localPlayer, "player:blackwhite", true)
  end
end)

addEventHandler("onClientClick", root, function(b, s)
  if b ~= "state" and s ~= "down" then return end
  for i,v in ipairs(pojazdy) do

  	local offsetY = (scale_y(39))*(i-1)
    local scroll = scrollPos * scrollOffset

  	if mysz(scale_x(21), (scale_y(195) + offsetY) - scroll, scale_x(457), scale_y(39)) and mysz(scale_x(19), scale_y(190), scale_x(459), scale_y(222)) and przechowalnia == true and informacje == false then
    	--triggerServerEvent("wyjmij", resourceRoot, localPlayer, v.id)
    	--showCursor(false)
    	--removeEventHandler("onClientRender", root, gui)
    	addEventHandler("onClientRender", root, guiinfo)
    	informacje = true
    	vehicle_model = v.model
    	vehicle_id = v.id
    	vehicle_kolor = split(v.kolor, ",")
    	vehicle_swiatla = split(v.swiatla, ",")
    	vehicle_paliwo = v.paliwo 
    	vehicle_bak = v.bak
    	vehicle_przebieg = v.przebieg
    	vehicle_pojemnosc = v.pojemnosc
    	vehicle_stan = v.stan
      vehicle_neon = v.neon
      vehicle_ms1 = v.ms1
      vehicle_ms2 = v.ms2
      vehicle_ms3 = v.ms3
    local x1, y1, z1 = getCameraMatrix()
		myElement = createVehicle (v.model, x1, y1, z1)
		setVehicleColor(myElement, 0, 255, 255)
    local tuning = split(v.tuning, ",")
    for i=1,#tuning do
      addVehicleUpgrade(myElement, tuning[i])
    end
		myObject = exports.object_preview:createObjectPreview(myElement,0, 0, 0, 0.5, 0.5, 1, 1, true, true, true)
		guiWindow = guiCreateWindow(scale_x(530), scale_y(10), scale_x(336), scale_y(264), "Test area", false, false)
		guiSetAlpha(guiWindow, 0)
		local projPosX, projPosY = guiGetPosition(guiWindow,true)
		local projSizeX, projSizeY = guiGetSize(guiWindow, true)	
		exports.object_preview:setProjection(myObject,projPosX, projPosY, projSizeX, projSizeY,true,true)
		exports.object_preview:setRotation(myObject, -5, 0, 150)

  		end
  end
  if mysz(screenW * 0.0346, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651) and przechowalnia == true and informacje == true then
    showCursor(false)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
	setElementData(localPlayer, "player:blackwhite", false)
    removeEventHandler("onClientRender", root, gui)
    removeEventHandler("onClientRender", root, guiinfo)
    przechowalnia = false
    triggerServerEvent("wyjmij", resourceRoot, localPlayer, vehicle_id)
    exports.object_preview:destroyObjectPreview(myObject)
    destroyElement(myElement)
    guiSetVisible(guiWindow, false)
    informacje = false
    showChat(true)
  elseif mysz(screenW * 0.2088, screenH * 0.1328, screenW * 0.1176, screenH * 0.0651) and przechowalnia == true and informacje == true then
  	removeEventHandler("onClientRender", root, guiinfo)
  	exports.object_preview:destroyObjectPreview(myObject)
  	destroyElement(myElement)
  	guiSetVisible(guiWindow, false)
  	informacje = false
  elseif mysz(screenW * 0.3338, screenH * 0.0208, screenW * 0.0110, screenH * 0.0247) and przechowalnia == true then
  	removeEventHandler("onClientRender", root, gui)
  	przechowalnia = false
  	showCursor(false)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
	setElementData(localPlayer, "player:blackwhite", false)
    if isElement(myElement) then
      exports.object_preview:destroyObjectPreview(myObject)
      destroyElement(myElement)
      guiSetVisible(guiWindow, false)
      removeEventHandler("onClientRender", root, guiinfo)
      informacje = false
    end
  end
end)

addEvent("pokazPojazdy:przechowalni", true)
addEventHandler("pokazPojazdy:przechowalni", root, function(tabelka)
  pojazdy = tabelka
end)

bindKey("mouse_wheel_up", "down", function()
	if przechowalnia == true and mysz(54*px, 164*py, 323*px, 397*py) then
    	if scrollPos > 0 then
        scrollPos = scrollPos-1
   		end
   	end
end)

bindKey("mouse_wheel_down", "down", function()
	if przechowalnia == true and mysz(54*px, 164*py, 323*px, 397*py) then
       scrollPos = scrollPos+1
    end
end)
--[[
addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), function()
	local x1, y1, z1 = getCameraMatrix()
	myElement = createVehicle (411, x1, y1, z1)
	setVehicleColor(myElement, 0, 255, 255)

	myObject = exports.object_preview:createObjectPreview(myElement,0, 0, 0, 0.5, 0.5, 1, 1, true, true, true)
	guiWindow = guiCreateWindow(410*px, 58*py, 282*px, 282*py, "Test area", false, false)
	guiSetAlpha(guiWindow, 0)
	local projPosX, projPosY = guiGetPosition(guiWindow,true)
	local projSizeX, projSizeY = guiGetSize(guiWindow, true)	
	exports.object_preview:setProjection(myObject,projPosX, projPosY, projSizeX, projSizeY,true,true)
	exports.object_preview:setRotation(myObject, -15, 0, 210)
end)
]]
--[[
addEventHandler("onClientPreRender", root, function()
	if not myElement or not myObject then return end
	local projPosX, projPosY = guiGetPosition(guiWindow,true)
	local projSizeX, projSizeY = guiGetSize(guiWindow, true)
	setVehicleColor(myElement, 0, 255, 255)
	exports.object_preview:setProjection(myObject,projPosX, projPosY, projSizeX, projSizeY, true, true)
end, true, "high" )

]]
addEventHandler("onClientResourceStop", getResourceRootElement( getThisResource()), function()
	exports.object_preview:destroyObjectPreview(myObject)
end
)