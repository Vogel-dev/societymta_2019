--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function isEventHandlerAdded(sEventName,pElementAttachedTo,func)
	if type(sEventName)=='string' and isElement(pElementAttachedTo) and type(func)=='function' then local aAttachedFunctions = getEventHandlers(sEventName,pElementAttachedTo)
	if type(aAttachedFunctions)=='table' and #aAttachedFunctions > 0 then for i,v in ipairs(aAttachedFunctions) do if v==func then return true end end end
	end return false
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end


local nametagFont = dxCreateFont( "cz.ttf", 17) or "default-bold"
local nCz = dxCreateFont( "cz.ttf", 12) or "default-bold"
local um = dxCreateFont( "cz.ttf", 25) or "default-bold"
local licznikfont = dxCreateFont("cz.ttf", 25) or "default-bold"
local cyfrowa_f = dxCreateFont("hud.ttf", 23) or "default-bold"

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local px,py = screenW/1440, screenH/900

setTimer(function()
	local online = tonumber(getElementData(localPlayer, "online")) or 0
	if not online then return end
	setElementData(localPlayer, "online", online+1)
	if getElementData(localPlayer, "premium") then
		setElementData(localPlayer, "najedzenie", getElementData(localPlayer, "najedzenie")-1.25)
	else
		setElementData(localPlayer, "najedzenie", getElementData(localPlayer, "najedzenie")-2.25)
	end
	if getElementData( localPlayer, "najedzenie" ) <= 0 then
        if not getElementData(localPlayer, "pracuje") then
		  toggleControl( "sprint", false );
        end
		setElementHealth( localPlayer, getElementHealth( localPlayer ) - 1 );
	else
        if not getElementData(localPlayer, "pracuje") then
		  toggleControl( "sprint", true );
        end
	end
end, 60000, 0)

addEventHandler( "onClientElementDataChange", root, function( data, oldVal )
	if not getElementData(localPlayer, "zalogowany") then return end
	if data == "najedzenie" then
		if getElementData( localPlayer, "najedzenie" ) <= 0 then
            if not getElementData(localPlayer, "pracuje") then
			     toggleControl( "sprint", false )
            end
			setElementHealth( localPlayer, getElementHealth( localPlayer ) - 5)
		elseif getElementData( localPlayer, "najedzenie" ) > 1 then
            if not getElementData(localPlayer, "pracuje") then
			     toggleControl( "sprint", true )
            end
		end
	end
end)

--[[
setTimer(function()
	if getElementData(localPlayer, "premium") and getElementData(localPlayer, "premium_czas") > 59 then
		local hajs = getElementData(localPlayer, "pieniadze")
		local mp = getElementData(localPlayer, "punkty")
		setElementData(localPlayer, "pieniadze", hajs+1000)
		setElementData(localPlayer, "punkty", mp+5)
		setElementData(localPlayer, "premium_czas", 0)
		exports["np-notyfikacje"]:noti("Premium: Za pełną godzine gry otrzymujesz 1000 PLN oraz 5 RP.")
	end
	local data = getElementData(localPlayer, "premium_czas") or 0
	if data then
		setElementData(localPlayer, "premium_czas", data+1)
	end
end, 60000, 0)
]]

setTimer(function()
    if getElementData(localPlayer, "afk") then return end
    if getElementData(localPlayer, "premium") then
        local po = getElementData(localPlayer, "premium_czas") or 0
        if po and po == 60 then
            exports["smta_base_notifications"]:noti("Jako konto diamond otrzymujesz 1500 $ za pełną godzine gry.")
            setElementData(localPlayer, "premium_czas", 0)
            setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+1500)
        end
        if not po then
            setElementData(localPlayer, "premium_czas", 1)
        else
            setElementData(localPlayer, "premium_czas", (getElementData(localPlayer, "premium_czas") or 0)+1)
        end
    end
end, 60000, 0)

local oglo = ""

addEvent("addOgloszenie", true)
addEventHandler("addOgloszenie", root, function(player, texti)
	if isEventHandlerAdded("onClientRender", root, ogl) then return end
	oglo = getPlayerName(player).." ["..getElementData(player, "id").."]: "..texti
	addEventHandler("onClientRender", root, ogl)
	setTimer(function()
		removeEventHandler("onClientRender", root, ogl)
		oglo = false
	end, 10000, 1)
end)

function ogl()
	if not getElementData(localPlayer, "zalogowany") then return end
	if getElementData(localPlayer, "hud") then return end
	if getPedOccupiedVehicle(localPlayer) then return end
    dxDrawImage(1130*px, 751*py, 295*px, 128*py, ":smta_base_gui/grafiki/tlo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Ogloszenie", 1130*px, 751*py, 1425*px, 797*py, tocolor(255, 255, 255, 255), 1.00, nCz, "center", "center", false, false, false, false, false)
    dxDrawText(oglo, 1130*px, 797*py, 1425*px, 879*py, tocolor(255, 255, 255, 255), 1.00, nCz, "center", "center", false, true, false, false, false)
end

-- nametagi, licznik, hud, vopis, opisy pedów


addEventHandler("onClientRender", getRootElement(), function()
	if not getElementData(localPlayer, "zalogowany") then return end
	if getElementData(localPlayer, "hud") then return end
		local pojazd = getPedOccupiedVehicle(localPlayer)
		if pojazd and getElementModel(pojazd) ~= 481 then 
		if getVehicleEngineState(pojazd) and getElementData(pojazd, "paliwo") and getElementData(pojazd, "paliwo") < 1 then
			setVehicleEngineState(pojazd, false)
		end
		local sx, sy, sz = getElementVelocity(pojazd)
		local predkosc = (sx^2 + sy^2 + sz^2)^(0.5)
		local kmh = predkosc * 180
		kmh = string.format("%1d", kmh)
		if getElementData(localPlayer, "hud") then return end
		local paliwo = getElementData(pojazd, "paliwo") or 100
		local przebieg = getElementData(pojazd,"przebieg") or 1
		przebieg = string.format("%1d", przebieg)
		local bak = getElementData(pojazd, "bak") or 100
		if bak == 50 then
			paliwo = paliwo * 5
		elseif bak == 100 then
			paliwo = paliwo * 1.85
		end
		local rodzajpaliwa = getElementData(pojazd, "rodzajpaliwa") or "PB95"
		local pojemnosc = getElementData(pojazd, "pojemnosc") or "1.6"
        --[[
		dxDrawImage(1130*px, 594*py, 300*px, 300*py, ":smta_base_gui/grafiki/licznik.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1130*px, 594*py, 300*px, 300*py, ":smta_base_gui/grafiki/strzalka.png", (kmh)-131, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(kmh, 1232*px, 689*py, 1336*px, 796*py, tocolor(255, 255, 255, 255), 1.00, licznikfont, "center", "center", false, false, false, false, false)

        dxDrawImage(1019*px, 770*py, 120*px, 120*py, ":smta_base_gui/grafiki/fuellicznik.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1019*px, 770*py, 120*px, 120*py, ":smta_base_gui/grafiki/fuelstrzalka.png", paliwo-125, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawText(przebieg.."km", 1226*px, 775*py, 1337*px, 815*py, tocolor(255, 255, 255, 255), 1.00, nCz, "center", "center", false, false, false, false, false)
        ]]
	end
	if not isPlayerMapVisible() then
	if getElementData(localPlayer, "hud") then return end
		local kasa = getElementData(localPlayer, "pieniadze")
    	kasa = string.format("%1d", kasa)
    	local zycie = getElementHealth(localPlayer)
    	local najedzenie = getElementData(localPlayer, "najedzenie") or 0
    	--dxDrawText(kasa.." $",  screenW * 0.8273, screenH * 0.0131, screenW * 0.9928, screenH * 0.0769, tocolor(0, 0, 0, 255), 1.00, cyfrowa_f, "right", "top", false, false, false, false, false)
    	--dxDrawText(kasa.." $",  screenW * 0.8272, screenH * 0.0130, screenW * 0.9927, screenH * 0.0768, tocolor(185, 43, 39, 255), 1.00, cyfrowa_f, "right", "top", false, false, false, false, false)
    end

  for _, p in ipairs(getElementsByType("player")) do
  	local rx, ry, rz = getCameraMatrix()
      local x, y, z = getPedBonePosition(p, 5)
      local sx, sy = getScreenFromWorldPosition(x, y, z + 0.5)
      local dystans = getDistanceBetweenPoints3D(rx, ry, rz, x, y, z)
      local alpha = getElementAlpha(p)
      local dimensions = getElementDimension(root) == getElementDimension(p)
      local interiors = getElementInterior(root) == getElementInterior(p)
      if getElementData(root, "duty") then
        ilosc = 60
    else
        ilosc = 17
    end
      if dystans < ilosc and sy and sx and interiors and dimensions and alpha > 0 and p ~= root then
      local nick = getPlayerName(p)
      local id = getElementData(p, "id")
      if not getElementData(p, "zalogowany") then return end
      	local hex = getElementData(p, "hex") or "#ffffff"
      	if getElementData(p, "premium") then
      		hex = "#b9f2ff"
      	end
		if getElementData(p, "duty") == 4 then
      		hex = "#FF0000"
		elseif getElementData(p, "duty") == 3 then
			hex = "#9932CC"
		elseif getElementData(p, "duty") == 2 then
			hex = "#228B22"
		elseif getElementData(p, "duty") == 1 then
			hex = "#4169E1"
      	end
		local hexfrakcja = getElementData(p, "hexfrakcja") or "#ffffff" --todo
		if getElementData(p, "nazwa-frakcji") == 4 then
      		hexfrakcja = "#ffffff"
		elseif getElementData(p, "nazwa-frakcji") == 3 then
			hexfrakcja = "#ffffff"
		elseif getElementData(p, "nazwa-frakcji") == 2 then
			hexfrakcja = "#ffffff"
		elseif getElementData(p, "nazwa-frakcji") == 1 then
			hexfrakcja = "#ffffff"
      	end
		dxDrawText("["..id.."] "..nick:gsub("#%x%x%x%x%x%x","").."", sx + 1, sy + 30, sx + 1, sy + 1, tocolor(0, 0, 0, 190), 1, nametagFont, "center", "center", false, false, false, true, false)
		dxDrawText("#969696["..hex..id.."#969696] "..hexfrakcja..nick.."", sx, sy + 29, sx, sy, tocolor(150, 150, 150, 190), 1, nametagFont, "center", "center", false, false, false, true, false)
        local duty = getElementData(p, "duty")
        local premium = getElementData(p, "premium")
        local frakcja = getElementData(p, "frakcja")
        local zycie = getElementHealth(p)
        local isAFK=getElementData(p, 'afk') or false
		local isChatTyping=getElementData(p, 'chat_typing') or false
		local isPremium=getElementData(p, 'premium') or false
		local isAdm=getElementData(p, 'duty') or false
        local liczbaikonek = {}
        zycie = string.format("%1d", zycie)
        if isAFK==true then
			table.insert(liczbaikonek, {grafika='afk.png', waznosc=10})
		end	
		if isChatTyping==true then
			table.insert(liczbaikonek, {grafika='czat.png', waznosc=10})
		end
		if isPremium then
			table.insert(liczbaikonek, {grafika='premium.png', waznosc=50})
		end
		if isAdm then
			table.insert(liczbaikonek, {grafika='admins.png', waznosc=60})
		end
		if #liczbaikonek == 1 then
			dxDrawImage(sx-20, sy-45, 35, 35, 'ikonki/' ..liczbaikonek[1].grafika, 0, 0, 0, tocolor(255, 255, 255, 255))
		elseif #liczbaikonek == 2 then
			table.sort(liczbaikonek, function(a,b) return a.waznosc>b.waznosc end)
			dxDrawImage(sx-40, sy-45, 35, 35, 'ikonki/' ..liczbaikonek[1].grafika, 0, 0, 0, tocolor(255, 255, 255, 255))
			dxDrawImage(sx, sy-45, 35, 35, 'ikonki/' ..liczbaikonek[2].grafika, 0, 0, 0, tocolor(255, 255, 255, 255))
		elseif #liczbaikonek > 2 then
			table.sort(liczbaikonek, function(a,b) return a.waznosc>b.waznosc end)
			dxDrawImage(sx-120/2, sy-45, 35, 35, 'ikonki/' ..liczbaikonek[1].grafika, 0, 0, 0, tocolor(255, 255, 255, 255))
			dxDrawImage(sx-40/2, sy-45, 35, 35, 'ikonki/' ..liczbaikonek[2].grafika, 0, 0, 0, tocolor(255, 255, 255, 255))
			dxDrawImage(sx+40/2, sy-45, 35, 35, 'ikonki/' ..liczbaikonek[3].grafika, 0, 0, 0, tocolor(255, 255, 255, 255))
		end
      end
  	end
	for _,v in ipairs(getElementsByType("vehicle")) do
	  local x1x, y1x, z1x = getElementPosition(v)
	  local x2x, y2x, z2x = getElementPosition(localPlayer)
	  local dist = getDistanceBetweenPoints3D(x1x,y1x,z1x, x2x,y2x,z2x)
	  if dist < 7 then
	      local sx,sy = getScreenFromWorldPosition(x1x, y1x, z1x)
	      if sx and sy then
	        local text = getElementData(v, "nametag") or ""
	        dxDrawText(text, sx+1, sy+1, sx+1, sy+1, tocolor(0, 0, 0, 255), 1, nametagFont, "center", "center")
	        dxDrawText(text, sx, sy, sx, sy, tocolor(150, 150, 150, 255), 1, nametagFont, "center", "center")
	   		end
		end
	end

	for i,v in ipairs(getElementsByType("text")) do
		local x1, y1, z1 = getElementPosition(v)
		local x2, y2, z2 = getElementPosition(localPlayer)
		local dist = getDistanceBetweenPoints3D(x1,y1,z1, x2,y2,z2)
		if dist < 15 then
			if isLineOfSightClear(x1,y1,z1+1.2, x2,y2,z2, true, false, true, true, false, false, true, localPlayer) then
				local sx,sy = getScreenFromWorldPosition(x1, y1, z1)
				if sx and sy then
					local text = getElementData(v, "text") or ""
					dxDrawText(text, sx+1, sy+1, sx+1, sy+1, tocolor(0, 0, 0, 255), 1, nametagFont, "center", "center")
					dxDrawText(text, sx, sy, sx, sy, tocolor(150, 150, 150, 255), 1, nametagFont, "center", "center")
				end
			end
		end
	end

	for i,v in ipairs(getElementsByType("ped")) do
		local x1, y1, z1 = getPedBonePosition(v, 8)
		local x2, y2, z2 = getElementPosition(localPlayer)
		local dist = getDistanceBetweenPoints3D(x1,y1,z1+0.3, x2,y2,z2)
		if dist < 15 then
			if isLineOfSightClear(x1,y1,z1+0.3, x2,y2,z2, true, false, false, true, false, false, true, getPedOccupiedVehicle(localPlayer) or localPlayer) then
				local sx,sy = getScreenFromWorldPosition(x1, y1, z1+0.4)
				if sx and sy then
					local text = getElementData(v, "name") or ""
					dxDrawText(""..text, sx+1, sy+1, sx+1, sy+1, tocolor(0, 0, 0, 255), 1, nametagFont, "center", "center", false, false, false, false)
					dxDrawText(text, sx, sy, sx, sy, tocolor(150, 150, 150, 255), 1, nametagFont, "center", "center", false, false, false, true)
				end
			end
		end
	end
	if getElementData(localPlayer, "premium") then
		if getElementData(localPlayer, "premium_czas") then return end
		setElementData(localPlayer, "premium_czas", 0)
	end
end)

local rx,ry,rz = getCameraMatrix()

	for i,v in ipairs(getElementsByType("text")) do
		local x2, y2, z2 = getElementPosition(localPlayer)
		local x1, y1, z1 = getElementPosition(v)
		local distance = getDistanceBetweenPoints3D(x1,y1,z1, x2,y2,z2)
		local sx,sy = getScreenFromWorldPosition(x1, y1, z1)
		if x1 ~= 0 and y1 ~= 0 and z1 ~= 0 and sx and sy and distance < 10 and getElementDimension(v) == getElementDimension(localPlayer) and getElementInterior(v) == getElementInterior(localPlayer) and isLineOfSightClear(rx, ry, rz, x1, y1, z1, false, false, false) then
			local text = getElementData(v, "text") or ""
			shadowText(text, sx, sy, sx, sy, tocolor(255, 255, 255, 255), 1, nametagFont, "center", "center")
		end
	end

bindKey("F5", "down", function()
	if getElementData(localPlayer, "hud") == true then
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
	else
		setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
	end
end)

local x1,y1,z1

addEventHandler("onClientPreRender", getRootElement(), function ()
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
		local przebieg = getElementData(pojazd, "przebieg")
		local paliwo = getElementData(pojazd, "paliwo")
		if przebieg then
			setElementData(pojazd, "przebieg", przebieg+0.040)
		end
		if paliwo then
			setElementData(pojazd, "paliwo", paliwo-0.005)
		end
		x1,y1,z1 = getElementPosition(pojazd)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _,v in ipairs(getElementsByType("player")) do
		setPlayerNametagShowing(v, false)
	end
end)

addEventHandler("onClientPlayerSpawn", root,  function()
	setPlayerNametagShowing(source, false)
end)

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

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second

    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end

    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function przecinkiAdd(amount) 
	local formatted = amount 
	while true do   
	  formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
	  if (k==0) then 
		break 
	  end 
	end 
	return formatted 
end

local cFunc={}
local cSetting={}

AFKClass={}
AFKClass.__index=AFKClass

function AFKClass:new(...)
	local obj=setmetatable({}, {__index=self})
	if obj.constructor then
		obj:constructor(...)
	end
	return obj
end

function AFKClass:render()
	local now=getTickCount()
	if now-self.lastTickAFKLU>=45000 then
		if getElementData(localPlayer, 'afk')==false then
			local hp=getElementHealth(localPlayer)
			if hp>0 then
				setElementData(localPlayer, 'afk', true)
			end
		end
	end
	
	if isChatBoxInputActive() then
		if getElementData(localPlayer, 'chat_typing')==false then
			setElementData(localPlayer, 'chat_typing', true)
		end
	else
		if getElementData(localPlayer, 'chat_typing')==true then
			setElementData(localPlayer, 'chat_typing', false)
		end
	end
end

function AFKClass:constructor(...)
	self.lastTickAFKLU=getTickCount()
	self.lastTickChatLU=getTickCount()
	
	self.renderFunc=function() self:render() end
	addEventHandler('onClientRender', root, self.renderFunc)
	addEventHandler('onClientRestore', localPlayer, function()
		self.lastTickAFKLU=getTickCount()
		setElementData(localPlayer, 'afk', false)
		
		if isChatBoxInputActive() then
			if getElementData(localPlayer, 'chat_typing')==false then
				setElementData(localPlayer, 'chat_typing', true)
			end
		else
			if getElementData(localPlayer, 'chat_typing')==true then
				setElementData(localPlayer, 'chat_typing', false)
			end
		end
	end)
	addEventHandler('onClientMinimize', root, function()
		setElementData(localPlayer, 'afk', true)
		
		if isChatBoxInputActive() then
			if getElementData(localPlayer, 'chat_typing')==false then
				setElementData(localPlayer, 'chat_typing', true)
			end
		else
			if getElementData(localPlayer, 'chat_typing')==true then
				setElementData(localPlayer, 'chat_typing', false)
			end
		end
	end)
	addEventHandler('onClientCursorMove', root, function()
		self.lastTickAFKLU=getTickCount()
		if getElementData(localPlayer, 'afk')==true then
			setElementData(localPlayer, 'afk', false)
		end
	end)
	addEventHandler('onClientKey', root, function()
		self.lastTickAFKLU=getTickCount()
		if getElementData(localPlayer, 'afk')==true then
			setElementData(localPlayer, 'afk', false)
		end
		
		if isChatBoxInputActive() then
			if getElementData(localPlayer, 'chat_typing')==false then
				setElementData(localPlayer, 'chat_typing', true)
			end
		else
			if getElementData(localPlayer, 'chat_typing')==true then
				setElementData(localPlayer, 'chat_typing', false)
			end
		end
	end)
end

afkClient=AFKClass:new()


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

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second

    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end

    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function przecinkiAdd(amount) 
	local formatted = amount 
	while true do   
	  formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
	  if (k==0) then 
		break 
	  end 
	end 
	return formatted 
end