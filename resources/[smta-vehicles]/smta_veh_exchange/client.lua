--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local czLight = dxCreateFont("cz.ttf", 15)
local czBold = dxCreateFont("cz2.ttf", 19)
local czBold2 = dxCreateFont("cz2.ttf", 15)
local sx, sy = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
x,y =  (sx/1366), (sy/768)
editBox = {}
editBox.__index = editBox
editBox.instances = {}
local showed = false
local kupno = false

local blip = createBlip(-1905.66, -856.83, 31.71, 35)
setBlipVisibleDistance(blip, 300)

local marker = createMarker(-1898.65, -858.65, 32.03-2, "cylinder", 3, 139, 0, 139, 100)
local text = createElement("text")
setElementData(text, "text", "Wystawienie pojazdu na gielde")
setElementPosition(text, -1898.65, -858.65, 32.03)

function gui()
  dxDrawImage(screenW * 0.2934, screenH * 0.3112, screenW * 0.4132, screenH * 0.3776, ":smta_veh_exchange/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  shadowText("WYSTAW POJAZD NA GIEŁDĘ", scale_x(454), scale_y(273), scale_x(985), scale_y(320), tocolor(150, 150, 150, 255), 1.00, czBold, "center", "center", false, false, false, false, false)
  shadowText("CENA", scale_x(469), scale_y(330), scale_x(579), scale_y(382), tocolor(150, 150, 150, 255), 1.00, czBold, "left", "center", false, false, false, false, false)
  shadowText("OPIS", scale_x(469), scale_y(403), scale_x(579), scale_y(455), tocolor(150, 150, 150, 255), 1.00, czBold, "left", "center", false, false, false, false, false)
  shadowText("Pamiętaj że dodatkowe informacje muszą być o danym pojeździe\ninaczej twoje auto zostanie usunięte z giełdy.", scale_x(454), scale_y(470), scale_x(985), scale_y(534), tocolor(150, 150, 150, 255), 1.00, czLight, "center", "center", false, false, false, false, false)
  if mysz(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443) then
        dxDrawImage(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443, ":smta_veh_exchange/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  else
        dxDrawImage(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443, ":smta_veh_exchange/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
  end
  if mysz(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247) then
        dxDrawImage(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
        dxDrawImage(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end
        if mysz(screenW * 0.4000, screenH * 0.3646, screenW * 0.2015, screenH * 0.0677) then
                dxDrawImage(screenW * 0.4000, screenH * 0.3646, screenW * 0.2015, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
                dxDrawImage(screenW * 0.4000, screenH * 0.3646, screenW * 0.2015, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		        if mysz(screenW * 0.4000, screenH * 0.4453, screenW * 0.2015, screenH * 0.0677) then
                dxDrawImage(screenW * 0.4000, screenH * 0.4453, screenW * 0.2015, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
                dxDrawImage(screenW * 0.4000, screenH * 0.4453, screenW * 0.2015, screenH * 0.0677, ":smta_veh_paintshop/gfx/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
  shadowText("Wystaw", screenW * 0.4699, screenH * 0.6250, screenW * 0.5316, screenH * 0.6680, tocolor(150, 150, 150, 255), 1.00, czLight, "center", "center", false, false, false, false, false)
  for k,self in pairs(editBox.instances) do
      if self.visible then
        local px,py,pw,ph = self:getPosition()
        local text = self.masked and string.gsub(self.text,".","•") or self.text
        local alignX = dxGetTextWidth(text,self.scale,self.font) <= pw and "left" or "right"
        --roundedRectangle(px, py, pw, ph, tocolor(unpack(self.color)), false)
        dxDrawText(text,px+x*5, py,px-x*5+pw, py+ph,tocolor(255, 255, 255, alph),self.scale,self.font, alignX, "center",true)   
        if self.input and dxGetTextWidth(text,self.scale,self.font) <= pw then
          local lx = dxGetTextWidth(text,self.scale,self.font)+px+x*8
          local lx = dxGetTextWidth(text,self.scale,self.font)+px+x*8
          dxDrawLine(lx, py+y*10, lx, py+ph-y*10, tocolor(255,255,255,math.abs(math.sin(getTickCount()/300))*200), 2)
        end
      end
    end
    ---
    if getKeyState("backspace") then
    for k,self in pairs(editBox.instances) do
      if self.visible and self.input then
        if not keyState then
          keyState = getTickCount() + 400
          self.text = string.sub(self.text,1,string.len(self.text)-1)
        elseif keyState and keyState < getTickCount() then
          keyState = getTickCount()+100
          self.text = string.sub(self.text,1,string.len(self.text)-1)
        end
        return
      end
    end
    keyState = nil
  end
end

addEventHandler("onClientMarkerHit", marker, function(hit)
  if hit ~= localPlayer then return end
  local pojazd  = getPedOccupiedVehicle(hit)
  if not pojazd then return end
  if not getElementData(pojazd, "id") then return end
  if getElementHealth(pojazd) < 900 then outputChatBox("Twój pojazd jest zbyt mocno uszkodzony!") return end
  if getElementData(pojazd, "wlasciciel") ~= getElementData(hit, "dbid") then return end

  addEventHandler("onClientRender", root, gui)
  setElementFrozen(pojazd, true)
  showCursor(true)
  setElementData(localPlayer, "hud", true)
showChat(false)
triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
setElementData(localPlayer, "player:blackwhite", true)
  setElementFrozen(pojazd, false)
  showed = true
  edit.cena.visible = true
  edit.dinfo.visible = true
end)

addEventHandler("onClientMarkerLeave", marker, function(hit)
  if hit ~= localPlayer then return end
  local pojazd = getPedOccupiedVehicle(hit)
  if not pojazd then return end
  removeEventHandler("onClientRender", getRootElement(), gui)
  showCursor(false)
  		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
  showed = false
  edit.cena.visible = false
end)

local actual_vehicle = false

addEventHandler("onClientClick", root, function(b, s)
  if b ~= "state" and s ~= "down" then return end
  if mysz(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443) and showed == true then
    local cena = edit.cena.text
    local info = edit.dinfo.text
    if cena:len() < 1 then return end
  	if not tonumber(cena) then
    	  exports["smta_base_notifications"]:noti("Twoja cena nie jest liczbą!", "error")
        return
    end
  	if cena:len() < 2 then
    	  exports["smta_base_notifications"]:noti("Cena pojazdu nie może być niższa niż 10 $!", "error")
    	 return
  	end
  	if cena:len() > 6 then
      exports["smta_base_notifications"]:noti("Cena pojazdu nie może być wyższa niż 999999 $!", "error")
      return
  	end
  	if tonumber(cena) <= 1 then
    	  exports["smta_base_notifications"]:noti("Cena pojazdu musi być większa od zera!", "error")
  	  return
  	end
  	if string.find(cena, 'E') then return end
    if string.find(cena, 'e') then return end
  	if string.find(cena, 'r') then return end
    local pojazd = getPedOccupiedVehicle(localPlayer)
  	if getElementData(pojazd, "gielda") then
    	  exports["smta_base_notifications"]:noti("Ten pojazd jest już wystawiony na giełdzie!")
      return
  	end
    setElementData(pojazd, "gielda", {
      ["cena"] = cena,
      ["informacje"] = info,
      ["id"] = getElementData(pojazd, "id"),
      ["wlasciciel"] = getPlayerName(localPlayer),
      ["uwlasciciel"] = getElementData(localPlayer, "dbid"),
    })
    cena = string.format("%1d", cena)
    exports["smta_base_notifications"]:noti("Twój pojazd "..getVehicleName(pojazd).." został wystawiony za cenę: "..cena.." $")
    triggerServerEvent("gielda", localPlayer, pojazd)
    setElementData(pojazd, "nametag", ""..getVehicleName(pojazd).."\nCena: "..cena.." $\nPodejdź do pojazdu pojazdu po więcej informacji")
    removeEventHandler("onClientRender", root, gui)
    showCursor(false)
			setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    showed = false
  elseif mysz(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247) and showed == true then
    showCursor(false)
			setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    removeEventHandler("onClientRender", root, gui)
    showed = false
    edit.cena.visible = false
  elseif mysz(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443) and actual_vehicle ~= false then
    triggerServerEvent("kuppojazd:gielda", localPlayer, actual_vehicle)
    actual_vehicle = false
    removeEventHandler("onClientRender", root, gui2)
    showCursor(false)
			setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
    kupno = false
  elseif mysz(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247) and actual_vehicle ~= false then
    actual_vehicle = false
    kupno = false
    removeEventHandler("onClientRender", root, gui2)
    showCursor(false)
			setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
  end
end)

function gui2()
        local modules = {}
	      local lpg = getElementData(actual_vehicle, "lpg")
	       if lpg == "tak" then
		      lpg = "Posiada"
	     else
		      lpg = "Nie posiada"
	     end
        if getElementData(actual_vehicle, "ms1") == 1 then
          table.insert(modules, "SB 1")
        end
        if getElementData(actual_vehicle, "ms2") == 1 then
          table.insert(modules, "SB 2")
        end
        if getElementData(actual_vehicle, "ms3") == 1 then
          table.insert(modules, "SB 3")
        end
        modules = table.concat(modules, ", ")
        if #modules < 1 then
          modules = "brak"
        end
  	    local gielda = getElementData(actual_vehicle, "gielda")
	      idp = getVehicleID(actual_vehicle)
        local r, g, b, r2, g2, b2 = getVehicleColor(actual_vehicle, true)
        local r3, g3, b3 = getVehicleHeadLightColor(actual_vehicle)
        dxDrawImage(screenW * 0.2934, screenH * 0.3112, screenW * 0.4132, screenH * 0.3776, ":smta_veh_exchange/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("INFORMACJE O POJEŹDZIE", scale_x(454), scale_y(273), scale_x(985), scale_y(320), tocolor(150, 150, 150, 255), 1.00, czBold, "center", "center", false, false, false, false, false)
        dxDrawImage(scale_x(449), scale_y(311), scale_x(50), scale_y(50), ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(r, g, b, 255), false)
        dxDrawImage(scale_x(449), scale_y(351), scale_x(50), scale_y(50), ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(r2, g2, b2, 255), false)
        dxDrawImage(scale_x(695), scale_y(311), scale_x(50), scale_y(50), ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(r3, g3, b3, 255), false)
        shadowText("KOLOR PODSTAWOWY", scale_x(498), scale_y(311), scale_x(695), scale_y(351), tocolor(150, 150, 150, 255), 1.00, czBold2, "left", "center", false, false, false, false, false)
        shadowText("KOLOR DODATKOWY", scale_x(498), scale_y(361), scale_x(695), scale_y(401), tocolor(150, 150, 150, 255), 1.00, czBold2, "left", "center", false, false, false, false, false)
        shadowText("KOLOR ŚWIATEŁ", scale_x(745), scale_y(311), scale_x(942), scale_y(351), tocolor(150, 150, 150, 255), 1.00, czBold2, "left", "center", false, false, false, false, false)
        if getElementData(actual_vehicle, "veh:neon") then
          shadowText("KOLOR NEONÓW", scale_x(745), scale_y(361), scale_x(942), scale_y(401), tocolor(150, 150, 150, 255), 1.00, czBold2, "left", "center", false, false, false, false, false)
          dxDrawImage(scale_x(695), scale_y(351), scale_x(50), scale_y(50), ":smta_veh_store/gfx/kolor.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("ID: "..getElementData(actual_vehicle, "id").."\n"..getVehicleName(actual_vehicle).."\nWłaściciel: "..gielda.wlasciciel.."\nPrzebieg: "..string.format("%1.2f", getElementData(actual_vehicle, "przebieg")).." KM\nPojemność: "..getElementData(actual_vehicle, "pojemnosc").."dm3", scale_x(433), scale_y(412), scale_x(720), scale_y(568), tocolor(150, 150, 150, 255), 1.00, czLight, "left", "center", false, true, false, false, false)
        shadowText("Rodzaj paliwa: "..getElementData(actual_vehicle, "rodzajpaliwa").."\nCena: "..gielda.cena.." $\nUlepszenia: "..modules.."\nDodatkowe informacje: "..gielda.informacje, scale_x(720), scale_y(412), scale_x(1007), scale_y(568), tocolor(150, 150, 150, 255), 1.00, czLight, "left", "center", false, true, false, false, false)
        if mysz(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443) then
                dxDrawImage(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443, ":smta_veh_exchange/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
                dxDrawImage(screenW * 0.4691, screenH * 0.6237, screenW * 0.0625, screenH * 0.0443, ":smta_veh_exchange/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247) then
                dxDrawImage(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
                dxDrawImage(screenW * 0.6882, screenH * 0.3242, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        shadowText("Zakup", screenW * 0.4699, screenH * 0.6250, screenW * 0.5316, screenH * 0.6680, tocolor(150, 150, 150, 255), 1.00, czLight, "center", "center", false, false, false, false, false)
end

addEvent("cuboid", true)
addEventHandler("cuboid", root, function(pojazd)
  actual_vehicle = pojazd
  kupno = true
  addEventHandler("onClientRender", root, gui2)
  showCursor(true)
  setElementData(localPlayer, "hud", true)
showChat(false)
triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
setElementData(localPlayer, "player:blackwhite", true)
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
  edit = {}
  edit.cena = editBox.new()
  edit.cena:setPosition(scale_x(579), scale_y(331), scale_x(281), scale_y(51))
  edit.cena.color = {26, 177, 133, 130}
  edit.cena.font = czLight
  edit.cena.onInput = function()
    edit.cena.color = {26, 177, 133, 220}
  end
  edit.cena.onOutput = function()
    edit.cena.color = {26, 177, 133, 130}
  end
  edit.dinfo = editBox.new()
  edit.dinfo:setPosition(scale_x(579), scale_y(404), scale_x(281), scale_y(51))
  edit.dinfo.color = {26, 177, 133, 130}
  edit.dinfo.font = czLight
  edit.dinfo.onInput = function()
    edit.dinfo.color = {26, 177, 133, 220}
  end
  edit.dinfo.onOutput = function()
    edit.dinfo.color = {26, 177, 133, 130}
  end
end)

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end

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

function onClientCharacter(character)
  if not isCursorShowing() then
    return
  end
  for k,self in pairs(editBox.instances) do
    if self.visible and self.input then
      if (string.len(self.text)) < self.maxLength then
        self.text = self.text..character
      end
    end
  end
end
addEventHandler("onClientCharacter", root, onClientCharacter)

function editBox.new()
  local self = setmetatable({}, editBox)
  self.text = ""
  self.maxLength = 20
  self.scale = y*0.8
  self.state = "normal"
  self.font = "sans"
  self.color = {255,255,255,220}
  self.textColor = {255,255,255,220}
  table.insert(editBox.instances, self)
  return self
end

function editBox:getPosition()
  return self.x, self.y, self.w, self.h
end

function editBox:setPosition(x,y,w,h)
  self.x, self.y, self.w, self.h = x,y,w,h
  return true
end

function onClientClick(button,state,cX,cY)
  if not isCursorShowing() then
    return
  end
  if button == "left" and state == "up" then
    for k,self in pairs(editBox.instances) do
      if self.visible then
        if self.input then
          self.input = nil
          self.onOutput()
        end
        local x,y,w,h = self:getPosition()
        if mysz(x,y,w,h) then
          self.input = true
          self.onInput()
          tick222 = getTickCount()
        end
      end
    end
  end
end
addEventHandler("onClientClick", root, onClientClick)