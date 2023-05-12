--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--
local screenW, screenH = guiGetScreenSize()
local rozx, rozy = screenW/1920, screenH/1080

local sx, sy = guiGetScreenSize()
local font3 = dxCreateFont("cz.ttf", 8) or "default-bold"
local font4 = dxCreateFont("cz.ttf", 10) or "default-bold"
local font = dxCreateFont("cz.ttf", 14) or "default-bold"
local font2 = dxCreateFont("cz.ttf", 17) or "default-bold"
local px,py = screenW/1440, screenH/900
local panel = false
local oreporty = false
local ologi = false
local omuty = false
local obany = false
local oprawka = false

local oczat = false
local oprzelewy = false
local opmy = false

local reporty = {}
local przelewy = {}
local czat = {}
local pmy = {}
local bany = {}
local prawka = {}
local muty = {}

local k = 1
local n = 10
local m = 10

local k2 = 1
local n2 = 10
local m2 = 10

local k3 = 1
local n3 = 10
local m3 = 10

local k4 = 1
local n4 = 10
local m4 = 10

local k5 = 1
local n5 = 10
local m5 = 10

local k6 = 1
local n6 = 10
local m6 = 10

local tlo = dxCreateTexture("tlo.png", "argb", true, "clamp")

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

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end

function paneladm()
    local ilosc = 0
    for i, v in ipairs(getElementsByType("player")) do
      if getElementData(v, "duty") then
        ilosc = ilosc+1
      end
    end
	dxDrawImage(0*rozx, 0*rozy, 1920*rozx, 1080*rozy, tlo, 0, 0, 0, tocolor(255, 255, 255), false)
	if mysz(screenW * 0.0824, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) or oreporty == true then
        	dxDrawImage(screenW * 0.0824, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.0824, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.2529, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) or ologi == true then
        	dxDrawImage(screenW * 0.2529, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.2529, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.4228, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) or omuty == true then
        	dxDrawImage(screenW * 0.4228, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.4228, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.5934, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) or obany == true then
        	dxDrawImage(screenW * 0.5934, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.5934, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
		if mysz(screenW * 0.7640, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) or oprawka == true then
        	dxDrawImage(screenW * 0.7640, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
        	dxDrawImage(screenW * 0.7640, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508, ":smta_base_admin/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
    shadowText("Zgłoszenia", screenW * 0.0824, screenH * 0.1107, screenW * 0.2346, screenH * 0.1628, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText("Logi serwera", screenW * 0.2529, screenH * 0.1107, screenW * 0.4051, screenH * 0.1628, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText("Baza zmutowanych", screenW * 0.4228, screenH * 0.1107, screenW * 0.5750, screenH * 0.1628, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText("Baza zbanowanych", screenW * 0.5934, screenH * 0.1107, screenW * 0.7456, screenH * 0.1628, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText("Baza zabranych licencji", screenW * 0.7640, screenH * 0.1107, screenW * 0.9162, screenH * 0.1628, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    --shadowText("Statystyki:\nLiczba reportów: "..#reporty.."\nBany: "..#bany.."\nPrawka: "..#prawka.."\nMuty: "..#muty.."\nAdministracja on-line: "..ilosc, 359*px, 595*py, 574*px, 687*py, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    if oreporty == false and ologi == false and omuty == false and obany == false and oprawka == false then
    	shadowText("Witaj "..getPlayerName(localPlayer).."\nWybierz opcję", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
   	end
   	if omuty == true then
	      if #muty == 0 then
        shadowText("Żaden gracz nie został zmutowany.", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        triggerServerEvent("poka:muty", localPlayer)
      else
        local x = 0
		dxDrawRectangle(screenW * 0.3551, screenH * 0.2214, screenW * 0.2897, screenH * 0.4896, tocolor(0, 0, 0, 120), false)
		dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		--dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Mutujący:", screenW * 0.3618, screenH * 0.2240, screenW * 0.4544, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        shadowText("Zmutowany:",  screenW * 0.4493, screenH * 0.2240, screenW * 0.5419, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        shadowText("Powód:", screenW * 0.5419, screenH * 0.2240, screenW * 0.6346, screenH * 0.257, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        triggerServerEvent("poka:muty", localPlayer)
        for i, v in ipairs(ReverseTable(muty)) do
          if i >= k5 and i <= n5 then
            x = x+1
            local addY = (40*py)*(x-1)
            local addY2 = (80*py)*(x-1)
            local mx,my = getCursorPosition ()
            local cursorX,cursorY = mx*screenW, my*screenH
            local text = "Do: "..v["data"]
            local width = dxGetTextWidth(text, 1, font, false)
            if cursorX+width > screenW-10 then
              cursorX = cursorX-width
            end
            dxDrawRectangle(screenW * 0.3551, screenH * 0.2643+addY, screenW * 0.2890, screenH * 0.0469, tocolor(0, 0, 0, 120), false)
            shadowText(v["admin"], screenW * 0.3640, screenH * 0.2708+addY2, screenW * 0.4559, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            shadowText(v["nick"], screenW * 0.4500, screenH * 0.2708+addY2, screenW * 0.5419, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            shadowText(v["powod"], screenW * 0.5419, screenH * 0.2708+addY2, screenW * 0.6338, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font4, "left", "center", false, true, false, false, false)
            dxDrawImage(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260, "kosz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) then
              dxDrawRectangle(cursorX+10, cursorY+10, width, 18, tocolor(0 , 0, 0, 120), true, true)
              dxDrawText(text, cursorX+10, cursorY+10, 0, 0, tocolor(255, 255, 255, 255), 1, font,  "left", "top", false, false, true)
            end
          end
        end
      end
    end
    if oreporty == true then
    	if #reporty == 0 then
    		shadowText("Brak zgłoszeń na aktualną chwilę.", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
     	  triggerServerEvent("poka:reporty", localPlayer)
      else
    		local x = 0
			dxDrawRectangle(screenW * 0.3551, screenH * 0.2214, screenW * 0.2897, screenH * 0.4896, tocolor(0, 0, 0, 120), false)
			dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    		shadowText("Reportujący:", screenW * 0.3618, screenH * 0.2240, screenW * 0.4544, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        	shadowText("Zreportowany:",  screenW * 0.4493, screenH * 0.2240, screenW * 0.5419, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        	shadowText("Powód:", screenW * 0.5419, screenH * 0.2240, screenW * 0.6346, screenH * 0.257, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
          --triggerServerEvent("poka:reporty", localPlayer)
    		for i, v in ipairs(ReverseTable(reporty)) do
    			if i >= k and i <= n then
    				x = x+1
    				local addY = (40*py)*(x-1)
    				local addY2 = (80*py)*(x-1)
    				local mx,my = getCursorPosition ()
					local cursorX,cursorY = mx*screenW, my*screenH
					local text = "Data: "..v["kiedy"]
					local width = dxGetTextWidth(text, 1, font, false)
					if cursorX+width > screenW-10 then
						cursorX = cursorX-width
					end
            if getPlayerFromName(v["kto"]) then
              id1 = getElementData(getPlayerFromName(v["kto"]), "id") or 0
            else
              id1 = "N/A"
            end
            if getPlayerFromName(v["kogo"]) then
              id2 = getElementData(getPlayerFromName(v["kogo"]), "id") or 0
            else
              id2 = "N/A"
            end
					dxDrawRectangle(screenW * 0.3551, screenH * 0.2643+addY, screenW * 0.2890, screenH * 0.0469, tocolor(0, 0, 0, 120), false)
        			shadowText(v["kto"].." ["..id1.."]", screenW * 0.3640, screenH * 0.2708+addY2, screenW * 0.4559, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v["kogo"].." ["..id2.."]", screenW * 0.4500, screenH * 0.2708+addY2, screenW * 0.5419, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v["powod"], screenW * 0.5419, screenH * 0.2708+addY2, screenW * 0.6338, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font4, "left", "center", false, true, false, false, false)
   					dxDrawImage(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260, "kosz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
   					if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) then
   						dxDrawRectangle(cursorX+10, cursorY+10, width, 18, tocolor(0 , 0, 0, 120), true, true)
						  dxDrawText(text, cursorX+10, cursorY+10, 0, 0, tocolor(255, 255, 255, 255), 1, font,  "left", "top", false, false, true)
   					end
   				end
   			end
   		end
   	end
   	if ologi == true then
   		if mysz(screenW * 0.3551, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234) then
   			dxDrawRectangle(screenW * 0.3551, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234, tocolor(21, 101, 192, 120), false)
   		else
   			dxDrawRectangle(screenW * 0.3551, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234, tocolor(0, 0, 0, 120), false)
   		end
   		if mysz(screenW * 0.4096, screenH * 0.1979, screenW * 0.0537, screenH * 0.0234) then
        	dxDrawRectangle(screenW * 0.4096, screenH * 0.1979, screenW * 0.0537, screenH * 0.0234, tocolor(21, 101, 192, 120), false)
        else
        	dxDrawRectangle(screenW * 0.4096, screenH * 0.1979, screenW * 0.0537, screenH * 0.0234, tocolor(0, 0, 0, 120), false)
        end
   		if mysz(screenW * 0.4632, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234) then
        	dxDrawRectangle(screenW * 0.4632, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234, tocolor(21, 101, 192, 120), false)
        else
        	dxDrawRectangle(screenW * 0.4632, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234, tocolor(0, 0, 0, 120), false)
        end
        shadowText("CHAT", screenW * 0.3544, screenH * 0.1979, screenW * 0.4096, screenH * 0.2214, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("TRANSFER", screenW * 0.4103, screenH * 0.1979, screenW * 0.4632, screenH * 0.221, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        shadowText("PM",  screenW * 0.4625, screenH * 0.1979, screenW * 0.5176, screenH * 0.2214, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
   		if oprzelewy == true then
    		if #przelewy == 0 then
    			shadowText("Brak danych na temat przelewów.", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    		else
			dxDrawRectangle(screenW * 0.3551, screenH * 0.2214, screenW * 0.2897, screenH * 0.4896, tocolor(0, 0, 0, 120), false)
			dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
          local x = 0
    			for i, v in ipairs(ReverseTable(przelewy)) do
    				if i >= k2 and i <= n2 then
              x = x+1
              local addY = (40*py)*(x-1)
              local addY2 = (80*py)*(x-1)

    				  dxDrawRectangle(screenW * 0.3551, screenH * 0.2643+addY, screenW * 0.2890, screenH * 0.0469, tocolor(0, 0, 0, 120), false)
					shadowText("Od:", screenW * 0.3618, screenH * 0.2240, screenW * 0.4544, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
					shadowText("Dla:",  screenW * 0.4493, screenH * 0.2240, screenW * 0.5419, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
					shadowText("Ile:", screenW * 0.5419, screenH * 0.2240, screenW * 0.6346, screenH * 0.257, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[1], screenW * 0.3640, screenH * 0.2708+addY2, screenW * 0.4559, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[2], screenW * 0.4500, screenH * 0.2708+addY2, screenW * 0.5419, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[3].." USD", screenW * 0.5419, screenH * 0.2708+addY2, screenW * 0.6338, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
   				  end
          end
   			end
   		end
   		if oczat == true then
    		if #czat == 0 then
    			shadowText("Brak danych na temat chatu.", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    		else
			dxDrawRectangle(screenW * 0.3551, screenH * 0.2214, screenW * 0.2897, screenH * 0.4896, tocolor(0, 0, 0, 120), false)
			dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
          local x = 0
    			for i, v in ipairs(ReverseTable(czat)) do
    				if i >= k3 and i <= n3 then
              x = x+1
              local addY = (40*py)*(x-1)
              local addY2 = (80*py)*(x-1)
    				  dxDrawRectangle(screenW * 0.3551, screenH * 0.2643+addY, screenW * 0.2890, screenH * 0.0469, tocolor(0, 0, 0, 120), false)
					shadowText("Typ:", screenW * 0.3618, screenH * 0.2240, screenW * 0.4544, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
					shadowText("Napisał:",  screenW * 0.4493, screenH * 0.2240, screenW * 0.5419, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
					shadowText("Treść:", screenW * 0.5419, screenH * 0.2240, screenW * 0.6346, screenH * 0.257, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[1], screenW * 0.3640, screenH * 0.2708+addY2, screenW * 0.4559, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[2], screenW * 0.4500, screenH * 0.2708+addY2, screenW * 0.5419, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[3], screenW * 0.5419, screenH * 0.2708+addY2, screenW * 0.6338, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, true, false, false, false)
            end
   				end
   			end
   		end
   		if opmy == true then
    		if #pmy == 0 then
    			shadowText("Brak danych na temat wiadomości prywatnych.", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    		else
			dxDrawRectangle(screenW * 0.3551, screenH * 0.2214, screenW * 0.2897, screenH * 0.4896, tocolor(0, 0, 0, 120), false)
			dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
          local x = 0
    			for i, v in ipairs(ReverseTable(pmy)) do
            if i >= k4 and i <= n4 then
              x = x+1
    				  local addY = (40*py)*(x-1)
    				  local addY2 = (80*py)*(x-1)
    				  dxDrawRectangle(screenW * 0.3551, screenH * 0.2643+addY, screenW * 0.2890, screenH * 0.0469, tocolor(0, 0, 0, 120), false)
					shadowText("Od kogo:", screenW * 0.3618, screenH * 0.2240, screenW * 0.4544, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
					shadowText("Do kogo:",  screenW * 0.4493, screenH * 0.2240, screenW * 0.5419, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
					shadowText("Treść:", screenW * 0.5419, screenH * 0.2240, screenW * 0.6346, screenH * 0.257, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[1], screenW * 0.3640, screenH * 0.2708+addY2, screenW * 0.4559, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[2], screenW * 0.4500, screenH * 0.2708+addY2, screenW * 0.5419, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        			shadowText(v[3], screenW * 0.5419, screenH * 0.2708+addY2, screenW * 0.6338, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font3, "left", "center", false, true, false, false, false)
            end
   				end
   			end
   		end
   	end
    if obany == true then
      if #bany == 0 then
        shadowText("Żaden gracz nie zostal zbanowany.", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        triggerServerEvent("poka:bany", localPlayer)
      else
	  dxDrawRectangle(screenW * 0.3551, screenH * 0.2214, screenW * 0.2897, screenH * 0.4896, tocolor(0, 0, 0, 120), false)
	  dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        local x = 0
        shadowText("Banujący:", screenW * 0.3618, screenH * 0.2240, screenW * 0.4544, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        shadowText("Zbanowany:",  screenW * 0.4493, screenH * 0.2240, screenW * 0.5419, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        shadowText("Powód:", screenW * 0.5419, screenH * 0.2240, screenW * 0.6346, screenH * 0.257, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        triggerServerEvent("poka:bany", localPlayer)
        for i, v in ipairs(ReverseTable(bany)) do
          if i >= k5 and i <= n5 then
            x = x+1
            local addY = (40*py)*(x-1)
            local addY2 = (80*py)*(x-1)
            local mx,my = getCursorPosition ()
            local cursorX,cursorY = mx*screenW, my*screenH
            local text = "Do: "..v["data"]
            local width = dxGetTextWidth(text, 1, font, false)
            if cursorX+width > screenW-10 then
              cursorX = cursorX-width
            end
            dxDrawRectangle(screenW * 0.3551, screenH * 0.2643+addY, screenW * 0.2890, screenH * 0.0469, tocolor(0, 0, 0, 120), false)
            shadowText(v["admin"], screenW * 0.3640, screenH * 0.2708+addY2, screenW * 0.4559, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            shadowText(v["nick"], screenW * 0.4500, screenH * 0.2708+addY2, screenW * 0.5419, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            shadowText(v["powod"], screenW * 0.5419, screenH * 0.2708+addY2, screenW * 0.6338, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font4, "left", "center", false, true, false, false, false)
            dxDrawImage(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260, "kosz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) then
              dxDrawRectangle(cursorX+10, cursorY+10, width, 18, tocolor(0 , 0, 0, 120), true, true)
              dxDrawText(text, cursorX+10, cursorY+10, 0, 0, tocolor(255, 255, 255, 255), 1, font,  "left", "top", false, false, true)
            end
          end
        end
      end
    end
    if oprawka == true then
      if #prawka == 0 then
        shadowText("Nikt nie posiada zabranego prawa jazdy.", screenW * 0.4125, screenH * 0.4258, screenW * 0.5868, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        triggerServerEvent("poka:prawka", localPlayer)
      else
        local x = 0
			  dxDrawRectangle(screenW * 0.3551, screenH * 0.2214, screenW * 0.2897, screenH * 0.4896, tocolor(0, 0, 0, 120), false)
	  dxDrawImage(screenW * 0.3551, screenH * 0.2604, screenW * 0.2897, screenH * 0.0052, ":smta_base_admin/line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        shadowText("Zabrał:", screenW * 0.3618, screenH * 0.2240, screenW * 0.4544, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        shadowText("Zabrano:",  screenW * 0.4493, screenH * 0.2240, screenW * 0.5419, screenH * 0.2578, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        shadowText("Powód:", screenW * 0.5419, screenH * 0.2240, screenW * 0.6346, screenH * 0.257, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        triggerServerEvent("poka:prawka", localPlayer)
        for i, v in ipairs(ReverseTable(prawka)) do
          if i >= k6 and i <= n6 then
            x = x+1
            local addY = (40*py)*(x-1)
            local addY2 = (80*py)*(x-1)
            local mx,my = getCursorPosition ()
            local cursorX,cursorY = mx*screenW, my*screenH
            local text = "Do: "..v["data"]
            local width = dxGetTextWidth(text, 1, font, false)
            if cursorX+width > screenW-10 then
              cursorX = cursorX-width
            end
            dxDrawRectangle(screenW * 0.3551, screenH * 0.2643+addY, screenW * 0.2890, screenH * 0.0469, tocolor(0, 0, 0, 120), false)
            shadowText(v["admin"], screenW * 0.3640, screenH * 0.2708+addY2, screenW * 0.4559, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            shadowText(v["nick"], screenW * 0.4500, screenH * 0.2708+addY2, screenW * 0.5419, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            shadowText(v["powod"], screenW * 0.5419, screenH * 0.2708+addY2, screenW * 0.6338, screenH * 0.3060, tocolor(255, 255, 255, 255), 1.00, font4, "left", "center", false, true, false, false, false)
            dxDrawImage(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260, "kosz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) then
              dxDrawRectangle(cursorX+10, cursorY+10, width, 18, tocolor(0 , 0, 0, 120), true, true)
              dxDrawText(text, cursorX+10, cursorY+10, 0, 0, tocolor(255, 255, 255, 255), 1, font,  "left", "top", false, false, true)
            end
          end
        end
      end
    end
end


bindKey("f2","down", function()
	if not getElementData(localPlayer, "duty") then return end
	if panel == true then
		panel = false
		oreporty = false
		ologi = false
		omuty = false
    obany = false
    oprawka = false
		removeEventHandler("onClientRender", root, paneladm)
		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
	else
		triggerServerEvent("poka:reporty", localPlayer)
		triggerServerEvent("poka:bany", localPlayer)
		triggerServerEvent("poka:prawka", localPlayer)
		oreporty = true
		panel = true
		addEventHandler("onClientRender", root, paneladm)
		showCursor(true)
		setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
		setElementData(localPlayer, "player:blackwhite", true)
	end
end)


addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if oreporty == true then
  	 local x2 = 0
  	 for i,v in ipairs(ReverseTable(reporty)) do
  		  if i >= k and i <= n then
  			 x2 = x2+1
  			 local addY = (40*py)*(x2-1)
  			 if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) and panel == true then
  				  exports["smta_base_notifications"]:noti("Usunąłeś raport na gracza "..v["kogo"])
  				  triggerServerEvent("usunReporta", localPlayer, v["id"], v["kto"])
  				  table.remove(reporty, i)
            triggerServerEvent("poka:reporty", localPlayer)
  			 end
  		  end
  	 end
    end
    if obany == true then
     local x2 = 0
     for i,v in ipairs(ReverseTable(bany)) do
        if i >= k5 and i <= n5 then
         x2 = x2+1
         local addY = (40*py)*(x2-1)
         if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) and panel == true and obany == true then
            if v["admin"] ~= getPlayerName(localPlayer) then exports["smta_base_notifications"]:noti("Nie możesz usunąc bana którego nie nadałeś", "error") return end
            exports["smta_base_notifications"]:noti("Usunąłeś bana gracza "..v["nick"])
            triggerServerEvent("usun:bana", localPlayer, v["id"])
            table.remove(bany, i)
         end
        end
     end
    end
	if omuty == true then
     local x2 = 0
     for i,v in ipairs(ReverseTable(muty)) do
        if i >= k5 and i <= n5 then
         x2 = x2+1
         local addY = (40*py)*(x2-1)
         if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) and panel == true and omuty == true then
            if v["admin"] ~= getPlayerName(localPlayer) then exports["smta_base_notifications"]:noti("Nie możesz usunąc muta którego nie nadałeś", "error") return end
            exports["smta_base_notifications"]:noti("Usunąłeś muta gracza "..v["nick"])
            triggerServerEvent("usun:muta", localPlayer, v["id"])
            table.remove(muty, i)
         end
        end
     end
    end
    if oprawka == true then
     local x2 = 0
     for i,v in ipairs(ReverseTable(prawka)) do
        if i >= k6 and i <= n6 then
         x2 = x2+1
         local addY = (40*py)*(x2-1)
         if mysz(screenW * 0.6272, screenH * 0.2773+addY, screenW * 0.0147, screenH * 0.0260) and panel == true and oprawka == true then
            if v["admin"] ~= getPlayerName(localPlayer) then exports["smta_base_notifications"]:noti("Nie możesz usunąc prawka którego nie nadałeś", "error") return end
            exports["smta_base_notifications"]:noti("Usunąłeś prawko gracz "..v["nick"])
            triggerServerEvent("usun:prawko", localPlayer, v["id"])
            table.remove(prawka, i)
         end
        end
     end
    end
    if mysz(screenW * 0.0824, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) and panel == true and oreporty == false then
    	triggerServerEvent("poka:reporty", localPlayer)
    	oreporty = true
    	ologi = false
    	omuty = false
      obany = false
      oprawka = false
    elseif mysz(screenW * 0.5934, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) and panel == true and obany == false then
      triggerServerEvent("poka:bany", localPlayer)
      oreporty = false
      ologi = false
      omuty = false
      obany = true
      oprawka = false
    elseif mysz(screenW * 0.7640, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) and panel == true and oprawka == false then
      triggerServerEvent("poka:prawka", localPlayer)
      oreporty = false
      ologi = false
      omuty = false
      obany = false
      oprawka = true
    elseif mysz(screenW * 0.2529, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) and panel == true and ologi == false then
    	ologi = true
    	oczat = true
    	opmy = false
    	oprzelewy = false
    	omuty = false
    	oreporty = false
      obany = false
      oprawka = false
    elseif mysz(screenW * 0.4228, screenH * 0.1107, screenW * 0.1522, screenH * 0.0508) and panel == true and omuty == false then
		triggerServerEvent("poka:muty", localPlayer)
    	omuty = true
    	oreporty = false
    	ologi = false
      obany = false
      oprawka = false
    elseif mysz(screenW * 0.3551, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234) and ologi == true and oczat == false then
    	oczat = true
    	opmy = false
    	oprzelewy = false
      obany = false
      oprawka = false
    elseif mysz(screenW * 0.4096, screenH * 0.1979, screenW * 0.0537, screenH * 0.0234) and ologi == true and oprzelewy == false then
    	oczat = false
    	opmy = false
    	oprzelewy = true
      obany = false
      oprawka = false
    elseif mysz(screenW * 0.4632, screenH * 0.1979, screenW * 0.0544, screenH * 0.0234) and ologi == true and opmy == false then
    	oczat = false
    	opmy = true
    	oprzelewy = false
      obany = false
      oprawka = false
    end
  end
end)

bindKey("mouse_wheel_down", "both", function()
	if oreporty == true then
		scrollUp()
	end
	if oprzelewy == true then
		scrollUp2()
	end
	if oczat == true then
		scrollUp3()
	end
	if opmy == true then
		scrollUp4()
	end
  if obany == true then
    scrollUp5()
  end
  if oprawka == true then
    scrollUp6()
  end
end)

bindKey("mouse_wheel_up", "both", function()
	if oreporty == true then
		scrollDown()
	end
	if oprzelewy == true then
		scrollDown2()
	end
	if oczat == true then
		scrollDown3()
	end
	if opmy == true then
		scrollDown4()
	end
  if obany == true then
    scrollDown5()
  end
  if oprawka == true then
    scrollDown6()
  end
end)


function scrollDown()
	if n == m then return end
	k = k-1
	n = n-1
end

function scrollUp()
	if n >= #reporty then return end
	k = k+1
	n = n+1
end

function scrollDown2()
	if n2 == m2 then return end
	k2 = k2-1
	n2 = n2-1
end

function scrollUp2()
	if n2 >= #przelewy then return end
	k = k+1
	n = n+1
end

function scrollDown3()
	if n3 == m3 then return end
	k3 = k3-1
	n3 = n3-1
end

function scrollUp3()
	if n3 >= #czat then return end
	k3 = k3+1
	n3 = n3+1
end

function scrollDown4()
	if n4 == m4 then return end
	k4 = k4-1
	n4 = n4-1
end

function scrollUp4()
	if n4 >= #pmy then return end
	k4 = k4+1
	n4 = n4+1
end

function scrollDown5()
  if n5 == m5 then return end
  k5 = k5-1
  n5 = n5-1
end

function scrollUp5()
  if n5 >= #bany then return end
  k5 = k5+1
  n5 = n5+1
end

function scrollDown6()
  if n6 == m6 then return end
  k6 = k6-1
  n6 = n6-1
end

function scrollUp6()
  if n6 >= #prawka then return end
  k6 = k6+1
  n6 = n6+1
end


addEvent("pokaz:reporty", true)
addEventHandler("pokaz:reporty", root, function(tab)
	reporty = tab
end)

addEvent("pokaz:bany", true)
addEventHandler("pokaz:bany", root, function(tab)
  bany = tab
end)

addEvent("pokaz:muty", true)
addEventHandler("pokaz:muty", root, function(tab)
  muty = tab
end)

addEvent("pokaz:prawka", true)
addEventHandler("pokaz:prawka", root, function(tab)
  prawka = tab
end)


addEvent("dLogi:przelewy", true)
addEventHandler("dLogi:przelewy", root, function(kto, komu, ile)
   	table.insert(przelewy, {"["..getElementData(kto, "id").."] "..getPlayerName(kto), " ["..getElementData(komu, "id").."] "..getPlayerName(komu), ile})
end)

addEvent("dLogi:pmy", true)
addEventHandler("dLogi:pmy", root, function(kto, komu, co)
   	table.insert(pmy, {"["..getElementData(kto, "id").."] "..getPlayerName(kto), " ["..getElementData(komu, "id").."] "..getPlayerName(komu), co})
end)
--[[
addEvent("dLogi:czat", true)
addEventHandler("dLogi:czat", root, function(jakiczat, kto, tekst)
   	table.insert(czat, {jakiczat, " ["..getElementData(kto, "id").."] "..getPlayerName(kto), tekst})
end)
--]]
function ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end

local ltext = {}

addEventHandler("onClientRender", root, function()
  if getElementData(localPlayer, "duty") and not getElementData(localPlayer, "ucho") then
    local l_text = ""
    for i,v in ipairs(ltext) do
      l_text = l_text.."\n"..v
    end
    --roundedRectangle(screenW * 0.0000, screenH * 0.3454, screenW * 0.2714, screenH * 0.0278, tocolor(0,0,0,100), false)
    --shadowText("Lista logów\n"..l_text, screenW * 0.0300, screenH * 0.3500, screenW * 0.0300, screenH * 0.6875, tocolor(255, 255, 255), 1.00, font, "left", "top", false, true, false, false, false)


    --dxDrawRectangle(7, screenH/3+8, 7+dxGetTextWidth("Lista logów"), 20, tocolor(0, 0, 0, 150))
    --shadowText("Logi", 7, screenH/3+8, 7+dxGetTextWidth("Lista logów")+7, 20+screenH/3+8, tocolor(255, 255, 255, 255), 1, font4, "left", "center", false, true)
    shadowText(l_text, 10, screenH/3+14, 500, 50, tocolor(255, 255, 255, 255), 1, font4, "left", "top", false, true, false, false, false)
  end
end)

addEvent("dLogi", true)
addEventHandler("dLogi", root, function(tekst)
    if #ltext > 11 then
    table.remove(ltext, 1)
    end
    table.insert(ltext, tekst)
end)


-- banicje etc

local czcionka = dxCreateFont( "cz.ttf", 14) or "default-bold"

addEvent("oknoZbanowany", true)
addEventHandler("oknoZbanowany", root, function(g, i, s, d, a, n, p)
    function oknozbanowanego()
       local RF = interpolateBetween(0, 0, 0, screenW * 0.4549, 0, 0, (getTickCount() - tick)/14000, "Linear")
       dxDrawRectangle(screenW * 0.2701, screenH * 0.1522, screenW * 0.4562, screenH * 0.5078, tocolor(0, 0, 0, 180), false)
       dxDrawRectangle(screenW * 0.2715, screenH * 0.7000, screenW * 0.4549, screenH * 0.0911, tocolor(0, 0, 0, 180), false)
       dxDrawRectangle(screenW * 0.2715, screenH * 0.7000, RF, screenH * 0.0911, tocolor(185, 43, 39, 255), false)
       dxDrawText("Wychodzenie z serwera...", screenW * 0.2708, screenH * 0.7011, screenW * 0.7271, screenH * 0.7900, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
       dxDrawText("Jestes zbanowany!", screenW * 0.2632, screenH * 0.1422, screenW * 0.7333, screenH * 0.2322, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
       dxDrawText("Informacje\nBan został nałożony na serial: "..s.."\nBan został nałożony na IP: "..i.."\nBan został nałożony na nick: "..n.."\nBan jest aktywny do: "..d.."\nNick admina banującego: "..a.."\nPowód: "..p.."\n\nOd kary możesz zaapelować na forum: societymta.pl", screenW * 0.2639, screenH * 0.2322, screenW * 0.7333, screenH * 0.6711, tocolor(255, 255, 255, 255), 1.00, czcionka, "center", "center", false, false, false, false, false)
    end
    addEventHandler("onClientRender", root, oknozbanowanego)
    tick = getTickCount()
end)

local text = false

function gui()
	if getElementData(localPlayer, "hud") then return end
 	dxDrawRectangle(screenW * 0.0000, screenH * 0.9688, screenW * 1.0000, screenH * 0.0313, tocolor(0, 0, 0, 151), false)
	dxDrawText(text, screenW * 0.0000+1, screenH * 0.9661+1, screenW * 1.0000+1, screenH * 1.000+1, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, true)
	dxDrawText(text, screenW * 0.0000, screenH * 0.9661, screenW * 1.0000, screenH * 1.000, tocolor(255, 0, 0, 255), 1.00, font, "center", "center", false, true)
end

addEvent("notiAdmin", true)
addEventHandler("notiAdmin", root, function(t)
	addEventHandler("onClientRender", root, gui)
	text = t
	setTimer(function()
		removeEventHandler("onClientRender", root, gui)
		text = false
	end, 15000, 1)
end)

local text4 = false

function gui4()
	if getElementData(localPlayer, "hud") then return end
 	dxDrawRectangle(screenW * 0.0000, screenH * 0.9688, screenW * 1.0000, screenH * 0.0313, tocolor(0, 0, 0, 151), false)
	dxDrawText(text, screenW * 0.0000+1, screenH * 0.9661+1, screenW * 1.0000+1, screenH * 1.000+1, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, true)
	dxDrawText(text, screenW * 0.0000, screenH * 0.9661, screenW * 1.0000, screenH * 1.000, tocolor(0, 255, 0, 255), 1.00, font, "center", "center", false, true)
end

addEvent("notiAdmin4", true)
addEventHandler("notiAdmin4", root, function(t)
	addEventHandler("onClientRender", root, gui4)
	text = t
	setTimer(function()
		removeEventHandler("onClientRender", root, gui4)
		text = false
	end, 15000, 1)
end)



local wtext = false

function gui2()
		local r,g,b = interpolateBetween(0,0,0,255,0,0,(getTickCount()-tick)/2500,"SineCurve")
		dxDrawRectangle(0,0,screenW,screenH, tocolor(r,g,b, 180))
        dxDrawText("Otrzymałeś ostrzeżenie od "..wtext.kto, (screenW * 0.2965) + 1, (screenH * 0.2057) + 1, (screenW * 0.7035) + 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Otrzymałeś ostrzeżenie od "..wtext.kto, screenW * 0.2965, screenH * 0.2057, screenW * 0.7035, screenH * 0.2721, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Powód: "..wtext.powod.."\n\n\n\nNie stosowanie się do ostrzeżenia może skutkować kickiem lub banem.\n\n\nKliknij backspace aby wyłączyć okno warna", (screenW * 0.3199) + 1, (screenH * 0.3333) + 1, (screenW * 0.6852) + 1, (screenH * 0.7174) + 1, tocolor(0,0,0), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Powód: "..wtext.powod.."\n\n\n\nNie stosowanie się do ostrzeżenia może skutkować kickiem lub banem.\n\n\nKliknij backspace aby wyłączyć okno warna", screenW * 0.3199, screenH * 0.3333, screenW * 0.6852, screenH * 0.7174, tocolor(255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
end

addEvent("warnPlayer", true)
addEventHandler("warnPlayer", root, function(t)
	addEventHandler("onClientRender", root, gui2)
	wtext = t
	tick = getTickCount()
	setElementData(localPlayer, "hud", true)
	setElementData(localPlayer, "warn", true)
  setElementData(localPlayer, "warny", getElementData(localPlayer, "warny")+1)
	dzwiek = playSound("warning.mp3", true)
	bindKey("backspace","down", function()
		if wtext ~= false then
			setElementData(localPlayer, "hud", false)
			removeEventHandler("onClientRender", root, gui2)
			wtext = false
			stopSound(dzwiek)
			dzwiek = false
			setElementData(localPlayer, "warn", false)
      if getElementData(localPlayer, "warny") > 4 then
        triggerServerEvent("posiadacz5warnow", localPlayer)
      end
		end
	end)
end)

addEvent("swarnPlayer", true)
addEventHandler("swarnPlayer", root, function(t)
	addEventHandler("onClientRender", root, gui2)
	wtext = t
	tick = getTickCount()
	setElementData(localPlayer, "hud", true)
	setElementData(localPlayer, "warn", true)
  --setElementData(localPlayer, "warny", getElementData(localPlayer, "warny")+1)
	dzwiek = playSound("warning.mp3", true)
	bindKey("backspace","down", function()
		if wtext ~= false then
			setElementData(localPlayer, "hud", false)
			removeEventHandler("onClientRender", root, gui2)
			wtext = false
			stopSound(dzwiek)
			dzwiek = false
			setElementData(localPlayer, "warn", false)
      if getElementData(localPlayer, "warny") > 4 then
        triggerServerEvent("posiadacz5warnow", localPlayer)
      end
		end
	end)
end)


local itext = false

function gui3()
	local move = interpolateBetween(0, 0, 0, scale_x(3500), 0, 0, (getTickCount()-tick2)/28000, "Linear")
	if (getTickCount()-tick2) > 28000 then
		tick2 = getTickCount( )
	end
	dxDrawRectangle(0, scale_y(876), screenW, scale_y(24), tocolor(185, 43, 39, 150), false)
	shadowText(itext, scale_x(1339)-move, scale_y(880), scale_x(1654), scale_y(900), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
end

addEvent("infoAdm", true)
addEventHandler("infoAdm", root, function(t)
	addEventHandler("onClientRender", root, gui3)
	itext = t
	tick2 = getTickCount( )
	setTimer(function()
		removeEventHandler("onClientRender", root, gui3)
		itext = false
	end, 56000, 1)
end)

addCommandHandler("camera", function()
	local x, y, z, lx, ly, lz = getCameraMatrix()
	outputChatBox(x..", "..y..", "..z..", "..lx..", "..ly..", "..lz)
end)

addCommandHandler("gp",function()
    local x,y,z = getElementPosition(localPlayer)
    local p = string.format("%.2f, %.2f, %.2f", x,y,z)
    local rx,ry,rz = getElementRotation(localPlayer)
    outputChatBox("".. p)
    outputChatBox(""..rz)
    setClipboard(p)
    local pojazd = getPedOccupiedVehicle(localPlayer)
    if pojazd then
        local x,y,z = getElementPosition(pojazd)
        local rx,ry,rz = getElementRotation(pojazd)
        p = string.format("%.2f, %.2f, %.2f, %.1f, %.1f, %.1f", x, y, z, rx, ry, rz)
        outputChatBox("".. p)
        setClipboard(p)
    end
end)

addCommandHandler("gp2",function()
    local x,y,z = getElementPosition(localPlayer)
    local p = string.format("%.2f, %.2f, %.2f", x,y,z)
    local rx,ry,rz = getElementRotation(localPlayer)
    outputChatBox("{".. p.."},")
    --outputChatBox("Rotacja gracza: "..rz)
    setClipboard(p)
    local pojazd = getPedOccupiedVehicle(localPlayer)
    if pojazd then
        local x,y,z = getElementPosition(pojazd)
        local rx,ry,rz = getElementRotation(pojazd)
        p = string.format("%.2f, %.2f, %.2f, %.1f, %.1f, %.1f", x, y, z, rx, ry, rz)
        outputChatBox("Pozycja pojazdu: ".. p)
        setClipboard(p)
    end
end)


addCommandHandler("devmode", function (cmd)
   if getElementData(localPlayer, "duty") > 2 then 
   setDevelopmentMode(true)
end
end)



function putPlayerInPosition(timeslice)
    local cx,cy,cz,ctx,cty,ctz = getCameraMatrix()
    ctx,cty = ctx-cx,cty-cy
    timeslice = timeslice*0.1
    local tx, ty, tz = getWorldFromScreenPosition(sx / 2, sy / 2, 10)
    if isChatBoxInputActive() or isConsoleActive() or isMainMenuActive () or isTransferBoxActive () then return end
    if getKeyState("lctrl") then timeslice = timeslice*4 end
    if getKeyState("lalt") then timeslice = timeslice*0.25 end
    local mult = timeslice/math.sqrt(ctx*ctx+cty*cty)
    ctx,cty = ctx*mult,cty*mult
    if getKeyState("2") then abx,aby = abx+ctx,aby+cty end
    if getKeyState("w") then abx,aby = abx+ctx,aby+cty end
    if getKeyState("s") then abx,aby = abx-ctx,aby-cty end
    if getKeyState("a") then  abx,aby = abx-cty,aby+ctx end
    if getKeyState("d") then abx,aby = abx+cty,aby-ctx end
    if getKeyState("space") then  abz = abz+timeslice end
    if getKeyState("lshift") then   abz = abz-timeslice end
    local xxd,yxd = 100,200
    shadowText("Pozycja gracza:\nX: "..abx.."\nY: "..aby.."\nZ: "..abz, screenW * 0.7430, screenH * 0.6029, screenW * 0.9788, screenH * 0.7435, tocolor(255, 255, 255, 255), 1.00, font, "left", "top", false, false, false, false, false)
    if isPedInVehicle ( getLocalPlayer( ) ) then
    local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
    local angle = getPedCameraRotation(getLocalPlayer ( ))
    setElementPosition(vehicle,abx,aby,abz)
    setElementRotation(vehicle,0,0,-angle)
    else
    local angle = getPedCameraRotation(getLocalPlayer ( ))
    setElementRotation(getLocalPlayer ( ),0,0,angle)
    setElementPosition(getLocalPlayer ( ),abx,aby,abz)
    end
end

function toggleAirBrakec()
      --if getPlayerSerial(localPlayer, "F5686A30BDBAB03643105204222F28F3") then toggleAirBrake() end
    if getElementData(localPlayer, "duty") > 2 then toggleAirBrake() end
end

function toggleAirBrake()
    air_brake = not air_brake or nil
    if air_brake then

        if isPedInVehicle ( getLocalPlayer( ) ) then
        local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
        abx,aby,abz = getElementPosition(vehicle)
        Speed,AlingSpeedX,AlingSpeedY = 0,1,1
        OldX,OldY,OldZ = 0
        setElementCollisionsEnabled ( vehicle, false )
        setElementFrozen(vehicle,true)
        setElementAlpha(getLocalPlayer(),0)
        addEventHandler("onClientPreRender",root,putPlayerInPosition)
    else
        abx,aby,abz = getElementPosition(localPlayer)
        Speed,AlingSpeedX,AlingSpeedY = 0,1,1
        OldX,OldY,OldZ = 0
        setElementCollisionsEnabled ( localPlayer, false )
        addEventHandler("onClientPreRender",root,putPlayerInPosition)
    end


    else
    if isPedInVehicle ( getLocalPlayer( ) ) then
        local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
        abx,aby,abz = nil
        setElementFrozen(vehicle,false)
        setElementCollisionsEnabled ( vehicle, true )
        setElementAlpha(getLocalPlayer(),255)
        removeEventHandler("onClientPreRender",root,putPlayerInPosition)
        else
        abx,aby,abz = nil
        setElementCollisionsEnabled ( localPlayer, true )
        removeEventHandler("onClientPreRender",root,putPlayerInPosition)
        end
    end
end
bindKey("mouse4","down",toggleAirBrakec)

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
