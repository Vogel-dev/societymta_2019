--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

if getElementData(localPlayer, "zalogowany") then return end

local screenW, screenH = guiGetScreenSize()
local rozx, rozy = screenW/1920, screenH/1080

local cz = dxCreateFont("cz.ttf", 12) or "default-bold"


local tlo = dxCreateTexture("img/tlo.png", "argb", true, "clamp")
local tlo2 = dxCreateTexture("img/tlo2.png", "argb", true, "clamp")

sx,sy = guiGetScreenSize()
x,y =  (sx/1920), (sy/1080)
messages = {}
editBox = {}
editBox.__index = editBox
editBox.instances = {}
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil

local muzyka = false
local zapamietaj = true

local domki = { }

local sx, sy = guiGetScreenSize()

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

panel = false
logowanie = false
rejestracja = false

addEventHandler("onClientClick", root, function(button, state)
  local login = g.nick.text
  local haslo = g.haslo.text
  if button == "left" and state == "down" and mysz(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521) and logowanie == true then
    if login:len() < 3 then
      zmienPowiadomienie("Podany login ma za mało znaków.")
      return
    end
    if haslo:len() < 3 then
      zmienPowiadomienie("Podane hasło ma za mało znaków.")
      return
    end
    login = string.gsub(login, "[ ]", "")
    haslo = string.gsub(haslo, "[ ]", "")
    triggerServerEvent("zaloguj", localPlayer, login, haslo)
  elseif button == "left" and state == "down" and mysz(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521) and rejestracja == true then
    if login:len() < 3 then
      zmienPowiadomienie("Podany login ma za mało znaków.")
      return
    end
    if haslo:len() < 3 then
      zmienPowiadomienie("Podany hasło ma za mało znaków.")
      return
    end
    login = string.gsub(login, "[ ]", "")
    haslo = string.gsub(haslo, "[ ]", "")
    triggerServerEvent("zarejestruj", localPlayer, login, haslo)
  end
end)

local czcionka = dxCreateFont("cz.ttf", 10)
local czcionka2 = dxCreateFont("cz.ttf", 12)
local czcionka3 = dxCreateFont("cz.ttf", 22)
local czcionka4 = dxCreateFont("cz.ttf", 18)
local czcionka5 = dxCreateFont("cz.ttf", 15)

function gui()
		setCameraMatrix(1283.2510986328, -2005.490234375, -97.91300201416, 1282.3190917969, -2005.6629638672, -97.594230651855)
				if muzyka then
        	local bit = getSoundFFTData(muzyka, 2048, 3)
        	for i,v in ipairs(bit) do
        		rytm = math.round((v*100),0)>100 and 100 or math.round((v*100),0)
				dxDrawImage(screenW * 0.2441, screenH * -0.0456, screenW * 0.2941, screenH * 0.5208, "img/podswietlenie.png", 0, 0, 0, tocolor(185, 43, 39, rytm), false)
			end
		end
		
				if muzyka then
        	local bit = getSoundFFTData(muzyka, 2048, 3)
        	for i,v in ipairs(bit) do
        		rytm = math.round((v*320),0)>100 and 100 or math.round((v*320),0)
				dxDrawImage(screenW * -0.3147, screenH * 0.0078, screenW * 0.5588, screenH * 0.9922, "img/podswietlenie.png", 0, 0, 0, tocolor(21, 101, 192, rytm), false)
			end
		end
		
				if muzyka then
        	local bit = getSoundFFTData(muzyka, 2048, 3)
        	for i,v in ipairs(bit) do
        		rytm = math.round((v*320),0)>100 and 100 or math.round((v*320),0)
				dxDrawImage(screenW * 0.7522, screenH * 0.0078, screenW * 0.5588, screenH * 0.9922, "img/podswietlenie.png", 0, 0, 0, tocolor(185, 43, 39, rytm), false)
			end
		end
		dxDrawImage(0*rozx, 0*rozy, 1920*rozx, 1080*rozy, tlo, 0, 0, 0, tocolor(255, 255, 255), false)
		if mysz(screenW * 0.7647, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768) or logowanie == true then
			dxDrawImage(screenW * 0.7647, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768, ":smta_base_auth/img/logowanie_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.7647, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768, ":smta_base_auth/img/logowanie_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.5169, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768) or rejestracja == true then
        	dxDrawImage(screenW * 0.5169, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768, ":smta_base_auth/img/rejestracja_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5169, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768, ":smta_base_auth/img/rejestracja_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
				if muzyka then
        	local bit = getSoundFFTData(muzyka, 2048, 3)
        	for i,v in ipairs(bit) do
        		rytm = math.round((v*320),0)>100 and 100 or math.round((v*320),0)
				dxDrawImage(screenW * 0.2441, screenH * -0.0456, screenW * 0.2941, screenH * 0.5208, "img/podswietlenie.png", 0, 0, 0, tocolor(185, 43, 39, rytm), false)
			end
		end
		
				if muzyka then
        	local bit = getSoundFFTData(muzyka, 2048, 3)
        	for i,v in ipairs(bit) do
        		rytm = math.round((v*320),0)>100 and 100 or math.round((v*320),0)
				dxDrawImage(screenW * -0.3147, screenH * 0.0078, screenW * 0.5588, screenH * 0.9922, "img/podswietlenie.png", 0, 0, 0, tocolor(21, 101, 192, rytm), false)
			end
		end
		
				if muzyka then
        	local bit = getSoundFFTData(muzyka, 2048, 3)
        	for i,v in ipairs(bit) do
        		rytm = math.round((v*320),0)>100 and 100 or math.round((v*320),0)
				dxDrawImage(screenW * 0.7522, screenH * 0.0078, screenW * 0.5588, screenH * 0.9922, "img/podswietlenie.png", 0, 0, 0, tocolor(185, 43, 39, rytm), false)
			end
		end
        if logowanie == true then
				if mysz(screenW * 0.3309, screenH * 0.3984, screenW * 0.3316, screenH * 0.0456) then
			dxDrawImage(screenW * 0.3309, screenH * 0.3984, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3309, screenH * 0.3984, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
				if mysz(screenW * 0.3309, screenH * 0.4961, screenW * 0.3316, screenH * 0.0456) then
			dxDrawImage(screenW * 0.3309, screenH * 0.4961, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3309, screenH * 0.4961, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
          if zapamietaj == true then
          	dxDrawImage(screenW * 0.3324, screenH * 0.5521, screenW * 0.1890, screenH * 0.0755, ":smta_base_auth/img/save_on.png", 0, 0, 0, tocolor(255, 255, 255), false)
          else
          	dxDrawImage(screenW * 0.3324, screenH * 0.5521, screenW * 0.1890, screenH * 0.0755, ":smta_base_auth/img/save_off.png", 0, 0, 0, tocolor(255, 255, 255), false)
          end
		 	if mysz(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521) then
			dxDrawImage(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521, ":smta_base_auth/img/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521, ":smta_base_auth/img/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		 dxDrawText("Wejdź do gry", screenW * 0.3316+1, screenH * 0.6432+1, screenW * 0.6625+1, screenH * 0.6940+1, tocolor(0, 0, 0), 1.00, czcionka4, "center", "center", false, false, false, false, false)
         dxDrawText("Wejdź do gry", screenW * 0.3316, screenH * 0.6432, screenW * 0.6625, screenH * 0.6940, tocolor(255, 255, 255), 1.00, czcionka4, "center", "center", false, false, false, false, false)
        end
        if rejestracja == true then
				if mysz(screenW * 0.3309, screenH * 0.3984, screenW * 0.3316, screenH * 0.0456) then
			dxDrawImage(screenW * 0.3309, screenH * 0.3984, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3309, screenH * 0.3984, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
				if mysz(screenW * 0.3309, screenH * 0.4961, screenW * 0.3316, screenH * 0.0456) then
			dxDrawImage(screenW * 0.3309, screenH * 0.4961, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3309, screenH * 0.4961, screenW * 0.3316, screenH * 0.0456, ":smta_base_auth/img/editbox_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
          	if mysz(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521) then
			dxDrawImage(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521, ":smta_base_auth/img/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.3316, screenH * 0.6419, screenW * 0.3309, screenH * 0.0521, ":smta_base_auth/img/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		  dxDrawText("Zarejestruj się", screenW * 0.3316+1, screenH * 0.6432+1, screenW * 0.6625+1, screenH * 0.6940+1, tocolor(0, 0, 0), 1.00, czcionka4, "center", "center", false, false, false, false, false)
          dxDrawText("Zarejestruj się", screenW * 0.3316, screenH * 0.6432, screenW * 0.6625, screenH * 0.6940, tocolor(255, 255, 255), 1.00, czcionka4, "center", "center", false, false, false, false, false)
		  dxDrawText("Zarejestrowanie się oznacza akceptację Regulaminu w aktualnym brzmieniu. \nRegulamin serwera Society MTA w pełnej okazałości znajduje się na forum: societymta.pl", screenW * 0.3331+1, screenH * 0.5443+1, screenW * 0.6588+1, screenH * 0.6302+1, tocolor(0, 0, 0), 1.00, czcionka2, "center", "center", false, false, false, false, false)
          dxDrawText("Zarejestrowanie się oznacza akceptację Regulaminu w aktualnym brzmieniu. \nRegulamin serwera Society MTA w pełnej okazałości znajduje się na forum: societymta.pl", screenW * 0.3331, screenH * 0.5443, screenW * 0.6588, screenH * 0.6302, tocolor(155, 155, 155), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        end
      --
      for k,self in pairs(editBox.instances) do
      if self.visible then
        local px,py,pw,ph = self:getPosition()
        local text = self.masked and string.gsub(self.text,".","•") or self.text
        local alignX = dxGetTextWidth(text,self.scale,self.font) <= pw and "left" or "right"
        --roundedRectangle(px, py, pw, ph, tocolor(unpack(self.color)), false)
        dxDrawText(text,px+x*5, py,px-x*5+pw, py+ph,tocolor(255, 255, 255),self.scale,self.font, alignX, "center",true)
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
  --
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


local font = dxCreateFont("cz.ttf", 13)

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

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.3324, screenH * 0.5521, screenW * 0.1890, screenH * 0.0755) and logowanie == true then
    	playSound("click.mp3", false)
    	if zapamietaj == true then
    		zapamietaj = false
    	elseif zapamietaj == false then
    		zapamietaj = true
    	end
    --panel
    elseif mysz(screenW * 0.7647, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768) and panel == true and logowanie ~= true then
    	logowanie = true
    	g.nick.visible = true
  		g.haslo.visible = true
		rejestracja = false
  		tick = getTickCount()
    elseif mysz(screenW * 0.5169, screenH * 0.0299, screenW * 0.2176, screenH * 0.0768) and panel == true and rejestracja ~= true then
    	logowanie = false
		rejestracja = true
		g.nick.visible = true
  		g.haslo.visible = true
  		tick = getTickCount()
    end
  end
end)

okno1 = false

local spawn = 1
local gui2s = false
local spawn1 = "Urząd miasta, San Fierro"

function usun()
  removeEventHandler("onClientRender", root, gui2)
  gui2s = false
  showChat(true)
  showCursor(false)
  stopSound(muzyka)
  showPlayerHudComponent("all", true)
end

function gui2()
	dxDrawImage(0*rozx, 0*rozy, 1920*rozx, 1080*rozy, tlo2, 0, 0, 0, tocolor(255, 255, 255), false)
	if mysz(screenW * 0.4162, screenH * 0.6719, screenW * 0.1632, screenH * 0.0560) then
			dxDrawImage(screenW * 0.4162, screenH * 0.6719, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.4162, screenH * 0.6719, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.4162, screenH * 0.7409, screenW * 0.1632, screenH * 0.0560) then
			dxDrawImage(screenW * 0.4162, screenH * 0.7409, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.4162, screenH * 0.7409, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.4162, screenH * 0.8151, screenW * 0.1632, screenH * 0.0560) then
			dxDrawImage(screenW * 0.4162, screenH * 0.8151, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.4162, screenH * 0.8151, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	if mysz(screenW * 0.4162, screenH * 0.8841, screenW * 0.1632, screenH * 0.0560) then
			dxDrawImage(screenW * 0.4162, screenH * 0.8841, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
        	dxDrawImage(screenW * 0.4162, screenH * 0.8841, screenW * 0.1632, screenH * 0.0560, ":smta_base_auth/img/button2_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
	dxDrawText("Spawn San Fierro", screenW * 0.4206+1, screenH * 0.6719+1, screenW * 0.5787+1, screenH * 0.7227+1, tocolor(0, 0, 0), 1.00, czcionka5, "center", "center", false, false, false, false, false)
    dxDrawText("Spawn San Fierro", screenW * 0.4206, screenH * 0.6719, screenW * 0.5787, screenH * 0.7227, tocolor(255, 255, 255), 1.00, czcionka5, "center", "center", false, false, false, false, false)
	dxDrawText("Przechowalnia", screenW * 0.4206+1, screenH * 0.7435+1, screenW * 0.578+1, screenH * 0.7943+1, tocolor(0, 0, 0), 1.00, czcionka5, "center", "center", false, false, false, false, false)
    dxDrawText("Przechowalnia", screenW * 0.4206, screenH * 0.7435, screenW * 0.5787, screenH * 0.7943, tocolor(255, 255, 255), 1.00, czcionka5, "center", "center", false, false, false, false, false)
	dxDrawText("Spawn Las Venturas", screenW * 0.4206+1, screenH * 0.8138+1, screenW * 0.5787+1, screenH * 0.8646+1, tocolor(0, 0, 0), 1.00, czcionka5, "center", "center", false, false, false, false, false)
    dxDrawText("Spawn Las Venturas", screenW * 0.4206, screenH * 0.8138, screenW * 0.5787, screenH * 0.8646, tocolor(255, 255, 255), 1.00, czcionka5, "center", "center", false, false, false, false, false)
	dxDrawText("Ostatnia pozycja", screenW * 0.4206+1, screenH * 0.8841+1, screenW * 0.5787+1, screenH * 0.9349+1, tocolor(0, 0, 0), 1.00, czcionka5, "center", "center", false, false, false, false, false)
	 dxDrawText("Ostatnia pozycja", screenW * 0.4206, screenH * 0.8841, screenW * 0.5787, screenH * 0.9349, tocolor(255, 255, 255), 1.00, czcionka5, "center", "center", false, false, false, false, false)
	 dxDrawText("Nick: "..getPlayerName(localPlayer).."\nPID: "..getElementData(localPlayer, "dbid").."",  screenW * 0.4074+1, screenH * 0.4258+1, screenW * 0.5919+1, screenH * 0.5885+1, tocolor(0, 0, 0), 1.00, czcionka3, "center", "center", false, false, false, false, false)
    dxDrawText("Nick: "..getPlayerName(localPlayer).."\nPID: "..getElementData(localPlayer, "dbid").."",  screenW * 0.4074, screenH * 0.4258, screenW * 0.5919, screenH * 0.5885, tocolor(255, 255, 255), 1.00, czcionka3, "center", "center", false, false, false, false, false)
    if #domki > 0 then
      dxDrawText("Dodatkowe spawny", 1186*rozx, 214*rozy, 1426*rozx, 252*rozy, tocolor(255, 255, 255, 255), 1.00, czcionka5, "center", "center", false, false, false, false, false)
      for i, v in ipairs(domki) do
        local dodatekY = (50*rozy)*(i-1)
        dxDrawImage(1205*rozx, 262*rozy+dodatekY, 200*rozx, 45*rozy, ":smta_base_auth/img/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(v[1], 1205*rozx, 262*rozy+(dodatekY*2), 1405*rozx, 307*rozy, tocolor(255, 255, 255, 255), 1.00, czcionka5, "center", "center", false, false, false, false, false)
      end
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.4206, screenH * 0.6719, screenW * 0.1581, screenH * 0.0508) and gui2s == true then
    	triggerServerEvent("spawn", localPlayer, "spawn")
    	usun()
		executeCommandHandler("showradar")
    elseif mysz(screenW * 0.4206, screenH * 0.7409, screenW * 0.1581, screenH * 0.0508) and gui2s == true then
      triggerServerEvent("spawn", localPlayer, "przecho")
      usun() 
	  executeCommandHandler("showradar")
    elseif mysz(screenW * 0.4206, screenH * 0.8125, screenW * 0.1581, screenH * 0.0508) and gui2s == true then
      triggerServerEvent("spawn", localPlayer, "lv")
      usun()
	  executeCommandHandler("showradar")
   elseif mysz(screenW * 0.4206, screenH * 0.8841, screenW * 0.1581, screenH * 0.0508) and gui2s == true then
      triggerServerEvent("spawn", localPlayer, "pozi")
      usun()
	  executeCommandHandler("showradar")
    end
    if gui2s == true and #domki > 0 then
      for i, v in ipairs(domki) do
        local dodatekY = (50*rozy)*(i-1)
        if mysz(1205*rozx, 262*rozy+dodatekY, 200*rozx, 45*rozy) and gui2s == true and #domki > 0 then
          local pos = split(v[2], ",")
          triggerServerEvent("spawn", localPlayer, "dom", pos[1], pos[2], pos[3])
          usun()
        end
      end
    end
  end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
  addEventHandler("onClientRender", root, gui)
  logowanie = true
  panel = true
  showCursor(true)
  showChat(false)
  fadeCamera(true)
  muzyka = playSound("muzyka.mp3", true)
  setSoundVolume(muzyka, 0.6)
  tick = getTickCount()
  setPlayerHudComponentVisible("all", false)
  setPlayerHudComponentVisible("radar", false)
  triggerEvent("usunPobieranie", localPlayer)
  triggerServerEvent("sprawdzBana", localPlayer)
  g = {}
  g.nick = editBox.new()
  g.nick:setPosition(screenW * 0.3309, screenH * 0.3984, screenW * 0.3316, screenH * 0.0456)
  g.nick.color = {26, 177, 133, 130}
  g.nick.font = font
  g.nick.text = loadLoginFromXML()
  g.nick.onInput = function()
  g.nick.color = {26, 177, 133, 220}
  end
  g.nick.onOutput = function()
  g.nick.color = {26, 177, 133, 130}
  end

  g.haslo = editBox.new()
  g.haslo:setPosition(screenW * 0.3309, screenH * 0.4961, screenW * 0.3316, screenH * 0.0456)
  g.haslo.color = {26, 177, 133, 130}
  g.haslo.font = font
  g.haslo.text = loadLoginFromXML2()
  g.haslo.masked = true
  g.haslo.onInput = function()
  g.haslo.color = {26, 177, 133, 220}
  end
  g.haslo.onOutput = function()
  g.haslo.color = {26, 177, 133, 130}
  end
  g.nick.visible = true
  g.haslo.visible = true
end)

addEvent("bShowedLogin", true)
addEventHandler("bShowedLogin", root, function()
  g.nick.visible = false
  g.haslo.visible = false
  removeEventHandler("onClientRender", root, gui)
  logowanie = false
  rejestracja = false
  wyb_reg = false
  wyb_log = false
  setTimer(function()
    triggerServerEvent("banWyrzuc", localPlayer)
  end, 14000, 1)
end)

local ile = 0.1
local d = false

addEventHandler("onClientRender", root, function()
    for i,v in ipairs(getElementsByType("vehicle")) do
        if getElementData(v, "samolot1") then
            triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
            local x,y,z = getElementPosition(v)
            local rx,ry,rz = getElementRotation(v)
            if x < 1950 and d ~= true then
                dolecial()
                d = true
                return
            end
            setElementPosition(v, x-ile,y,z)
            if rx > 90 then
                setElementRotation(v, rx+0.05,ry,rz)
            end
            if z > 14.5 then
                setElementPosition(v, x-ile,y,z-0.01)
            else
                setElementPosition(v, x-ile,y,z)
            end
            if d == false then
              setTime(2,0)
              --dxDrawRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 0.2380, tocolor(15,15,15,125), false)
              --dxDrawRectangle(screenW * 0.0000, screenH * 0.7620, screenW * 1.0000, screenH * 0.2380, tocolor(15,15,15,125), false)
              dxDrawRectangle(0, 783*rozy, 1500*rozx, 123*rozy, tocolor(0, 0, 0, 140), false)
              dxDrawRectangle(0, 0, 1500*rozx, 123*rozy, tocolor(0, 0, 0, 140), false)
              --dxDrawText("Witaj w Los Santos", 328*rozx, 783*rozy, 1125*rozx, 896*rozy, tocolor(255, 255, 255, 255), 1.00, czcionka3, "center", "center", false, false, false, false, false)
            end
            local x,y,z,x1,y1,z1 = getCameraMatrix(localPlayer)
            setCameraMatrix(x-ile,y,z,x1-ile,y1,z1)
        end
    end
end)

function dolecial()
    fadeCamera(false)
    setTimer(function()
      fadeCamera(true)
      setCameraTarget(localPlayer)
      setElementData(localPlayer, "hud", false)
      showChat(true)
      local x,y,z = getElementPosition(localPlayer)
      setElementPosition(localPlayer, x, y, 69.2)
        for i,v in ipairs(getElementsByType("vehicle")) do
          if getElementData(v, "samolot2") then
              setElementData(v, "samolot3", false)
              destroyElement(v)
          end
      end
      local time = getRealTime()
      setTime(time.hour,time.minute)
      triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
    end, 1500, 1)
end

addEvent("usunElementyLogowania", true)
addEventHandler("usunElementyLogowania", root, function(onest)
  if onest == "true" then
    samolocik1 = true
  end
  g.nick.visible = false
  g.haslo.visible = false
  removeEventHandler("onClientRender", root, gui)
  	addEventHandler("onClientRender", root, gui2)
  	gui2s = true
  panel = false
  logowanie = false
  rejestracja = false
  if zapamietaj == true then
  	saveLoginToXML(g.nick.text, g.haslo.text)
  end
end)

addEvent("pokaz:domki", true)
addEventHandler("pokaz:domki", root, function(tab)
  for i, v in ipairs(tab) do
    table.insert(domki, {v.name.." (ID: "..v.id..")", v.wejscie})
  end
end)

function zmienPowiadomienie(text)
  exports["smta_base_notifications"]:noti(text)
end
addEvent("zmienPowiadomienie", true)
addEventHandler("zmienPowiadomienie", root, zmienPowiadomienie)

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
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
  self.scale = y*1.4
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

function loadLoginFromXML()
	local XML = xmlLoadFile ("zapis.xml")
    if not XML then
        XML = xmlCreateFile("zapis.xml", "konto")
    end

    local usernameNode = xmlFindChild (XML, "login", 0)
    if usernameNode then
        return xmlNodeGetValue(usernameNode)
    else
		return ""
    end
    xmlUnloadFile ( XML )
end

function loadLoginFromXML2()
	local XML = xmlLoadFile ("zapis.xml")
    if not XML then
        XML = xmlCreateFile("zapis.xml", "konto")
    end

    local hasloNode = xmlFindChild (XML, "haslo", 0)
    if hasloNode then
        return xmlNodeGetValue(hasloNode)
    else
		return ""
    end
    xmlUnloadFile ( XML )
end

function saveLoginToXML(username, hasloo)
    local XML = xmlLoadFile ("zapis.xml")
    if not XML then
        XML = xmlCreateFile("zapis.xml", "konto")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (XML, "login", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(XML, "login")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
	if (hasloo ~= "") then
		local haslo = xmlFindChild (XML, "haslo", 0)
		if not haslo then
			haslo = xmlCreateChild(XML, "haslo")
		end
		xmlNodeSetValue (haslo, tostring(hasloo))
	end
    xmlSaveFile(XML)
    xmlUnloadFile (XML)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", root, saveLoginToXML)

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
  dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0,color[4]),size,font,xx,yy,x1,x2,x3,x4,x5)
  dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end
