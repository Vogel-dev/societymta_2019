--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local px, py = screenW/1440, screenH/900

local k = 1
local n = 10
local m = 10

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

local score = false

local tab = false

function sort(parametr1, parametr2)
	if isElement(parametr1) and isElement(parametr2) then
		return (getElementData(parametr1, "id") or 0) < (getElementData(parametr2, "id") or 0)
	end
end

local f = dxCreateFont("cz.ttf", 16)
local f2 = dxCreateFont("cz.ttf", 14)

local edit = guiCreateEdit(0.45, 0.75, 0.11, 0.04, "", true)
guiSetVisible(edit, false) 

function gui()
	local gracze = {}
	local gracz = getElementsByType("player")
	for i,v in ipairs(gracz) do
		if v ~= localPlayer then
			table.insert(gracze, v)
		end
	end
	if not getElementData(localPlayer, "zalogowany") then return end
	if getElementData(localPlayer, "hud") then return end
	if tab ~= true then return end
	showCursor(getKeyState("mouse2"))
	dxDrawImage(screenW * 0.3000, screenH * 0.1341, screenW * 0.4000, screenH * 0.7318, ":smta_base_tab/gfx/scoreboard.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.3000, screenH * 0.0651, screenW * 0.1544, screenH * 0.0612, "gfx/wyszukiwanie.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	shadowText(""..#gracz.."/100", screenW * 0.6294, screenH * 0.0833, screenW * 0.7000, screenH * 0.1211, tocolor(150, 150 ,150, 255), 1.00, f, "right", "center", false, false, false, false, false)

	local sapd = 0
	local sapd2 = 0
	local safd = 0
	local safd2 = 0
	local samc = 0
	local samc2 = 0
	local satc = 0
	local satc2 = 0
	local sara = 0
	local sara2 = 0
	for i, v in ipairs(getElementsByType("player")) do
		if getElementData(v, "frakcja") == "SAPD" then
			sapd = sapd+1
			if getElementData(v, "frakcja:sluzba") then
				sapd2 = sapd2+1
			end
		end
		if getElementData(v, "frakcja") == "SAFD" then
			safd = safd+1
			if getElementData(v, "frakcja:sluzba") then
				safd2 = safd2+1
			end
		end
		if getElementData(v, "frakcja") == "SAMC" then
			samc = samc+1
			if getElementData(v, "frakcja:sluzba") then
				samc2 = samc2+1
			end
		end
		if getElementData(v, "frakcja") == "SATC" then
			satc = satc+1
			if getElementData(v, "frakcja:sluzba") then
				satc2 = satc2+1
			end
		end
		if getElementData(v, "frakcja") == "SARA" then
			sara = sara+1
			if getElementData(v, "frakcja:sluzba") then
				sara2 = sara2+1
			end
		end
	end
    shadowText("SAPD: "..sapd2.."/"..sapd.."", screenW * 0.3023, screenH * 0.8698, screenW * 0.3675, screenH * 0.8997, tocolor(150, 150, 150, 255), 1.00, f2, "center", "center", false, false, false, false, false)
    shadowText("SAFD: "..safd2.."/"..safd.."", screenW * 0.3675, screenH * 0.8698, screenW * 0.4327, screenH * 0.8997, tocolor(150, 150, 150, 255), 1.00, f2, "center", "center", false, false, false, false, false)
    shadowText("SAMC: "..samc2.."/"..samc.."", screenW * 0.4327, screenH * 0.8698, screenW * 0.4978, screenH * 0.8997, tocolor(150, 150, 150, 255), 1.00, f2, "center", "center", false, false, false, false, false)
    --shadowText("SATC: "..satc2.."/"..satc.."", 757*px, 671*py, 859*px, 708*py, tocolor(150, 150, 150, 255), 1.00, f2, "center", "center", false, false, false, false, false)
    --shadowText("SARA: "..sara2.."/"..sara.."", 859*px, 671*py, 961*px, 708*py, tocolor(150, 150, 150, 255), 1.00, f2, "center", "center", false, false, false, false, false)
	local x = 0
	table.sort(gracze, sort)
	local _allPlayers = gracze
	gracze = {}
	table.insert(gracze, localPlayer)
	for i = 1, #_allPlayers do
		gracze[i + 1] = _allPlayers[i]
	end
	_allPlayers = nil
	for i,v in ipairs(gracze) do
		if i >= k and i <= n then 
			if exports["smta_oth_editbox"]:editbox_text("wyszukiwanie"):len() > 0 and string.find(string.gsub(getPlayerName(v):lower(),"#%x%x%x%x%x%x", ""), exports["smta_oth_editbox"]:editbox_text("wyszukiwanie"):lower(), 1, true) then
				x = x+1
				local id = getElementData(v, "id") or 0
				local rp = getElementData(v, "punkty") or ""
				local org = getElementData(v, "oname") or ""
				local frakcja = getElementData(v, "frakcja") or ""
				if getElementData(v, "frakcja:sluzba") then
					frakcjai = frakcja.." [✔]"
				else
					frakcjai = frakcja.." [✘]"
				end
				if frakcja == "" then
					frakcjai = ""
				end
				local offsetY = (110*py)*(x-1)
				local offsetY2 = (55*py)*(x-1)
				local r,g,b = getPlayerNametagColor(v)
				local hex = getElementData(v, "hex") or ""
				local nick = hex..string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", "")
				if getElementData(v, "afk") then
					nick = "#969696[AFK] "..hex..string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", "")
				end
				if getElementData(v, "bw") then
					nick = "#969696[BW] "..hex..string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", "")
				end
				if isCursorShowing() and mysz(screenW * 0.3074, screenH * 0.2240+offsetY2, screenW * 0.3853, screenH * 0.0560) then
					dxDrawImage(screenW * 0.3074, screenH * 0.2240+offsetY2, screenW * 0.3853, screenH * 0.0560, "gfx/localPlayer.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				else
					dxDrawImage(screenW * 0.3074, screenH * 0.2240+offsetY2, screenW * 0.3853, screenH * 0.0560, "gfx/belka.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				end
		        shadowText(id, screenW * 0.3176, screenH * 0.2370+offsetY, screenW * 0.3390, screenH * 0.2669, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)
		        if getElementData(v, "premium") and hex == "" then
        			dxDrawText(nick, screenW * 0.3463, screenH * 0.2305+offsetY, screenW * 0.4795, screenH * 0.2760, tocolor(185, 242, 255, 255), 1.00, f, "left", "center", false, false, false, true, false)
        		else
        			dxDrawText(nick, screenW * 0.3463, screenH * 0.2305+offsetY, screenW * 0.4795, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, true, false)
        		end
        		shadowText(rp, screenW * 0.4824, screenH * 0.2305+offsetY, screenW * 0.5271, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)
        		shadowText(frakcjai, screenW * 0.5344, screenH * 0.2305+offsetY, screenW * 0.6076, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)
        		shadowText(org, screenW * 0.6149, screenH * 0.2305+offsetY, screenW * 0.6816, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)			
        	elseif exports["smta_oth_editbox"]:editbox_text("wyszukiwanie"):len() < 1 or string.find(string.gsub(getPlayerName(v):lower(),"#%x%x%x%x%x%x", ""), exports["smta_oth_editbox"]:editbox_text("wyszukiwanie"):lower(), 1, true) == 0 then
				x = x+1
				local id = getElementData(v, "id") or 0
				local rp = getElementData(v, "punkty") or ""
				local org = getElementData(v, "oname");
				local org2 = "";
				local frakcja = getElementData(v, "frakcja") or ""
				if getElementData(v, "frakcja:sluzba") and frakcja ~= "" then
					frakcjai = frakcja.." [✔]"
				else
					frakcjai = frakcja.." [✖]"
				end
				if frakcja == "" then
					frakcjai = ""
				end

				--if org then
				--	org2 = org.name;
				--end
				local offsetY = (110*py)*(x-1)
				local offsetY2 = (55*py)*(x-1)
				local r,g,b = getPlayerNametagColor(v)
				local hex = getElementData(v, "hex") or ""
				local nick = hex..string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", "")
				if getElementData(v, "afk") then
					nick = "#969696[AFK] "..hex..string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", "")
				end
				if getElementData(v, "bw") then
					nick = "#969696[BW] "..hex..string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", "")
				end
				if isCursorShowing() and mysz(screenW * 0.3074, screenH * 0.2240+offsetY2, screenW * 0.3853, screenH * 0.0560) then
					dxDrawImage(screenW * 0.3074, screenH * 0.2240+offsetY2, screenW * 0.3853, screenH * 0.0560, "gfx/localPlayer.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				else
					dxDrawImage(screenW * 0.3074, screenH * 0.2240+offsetY2, screenW * 0.3853, screenH * 0.0560, "gfx/belka.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				end
		        shadowText(id, screenW * 0.3176, screenH * 0.2370+offsetY, screenW * 0.3390, screenH * 0.2669, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)
        		if getElementData(v, "premium") and hex == "" then
        			dxDrawText(nick, screenW * 0.3463, screenH * 0.2305+offsetY, screenW * 0.4795, screenH * 0.2760, tocolor(185, 242, 255, 255), 1.00, f, "left", "center", false, false, false, true, false)
        		else
        			dxDrawText(nick, screenW * 0.3463, screenH * 0.2305+offsetY, screenW * 0.4795, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, true, false)
        		end
        		shadowText(rp, screenW * 0.4824, screenH * 0.2305+offsetY, screenW * 0.5271, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)
        		shadowText(frakcjai, screenW * 0.5344, screenH * 0.2305+offsetY, screenW * 0.6076, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)
        		shadowText(org, screenW * 0.6149, screenH * 0.2305+offsetY, screenW * 0.6816, screenH * 0.2760, tocolor(150, 150, 150, 255), 1.00, f, "left", "center", false, false, false, false, false)
			end
		end
	end
end

bindKey("tab","down", function()
	if not getElementData(localPlayer, "zalogowany") then return end
	if getElementData(localPlayer, "hud") then return end
	if tab == true then
		tab = false
		exports["smta_oth_editbox"]:editbox_destroy("wyszukiwanie")
		removeEventHandler("onClientRender", root, gui)
	else
		tab = true
		exports["smta_oth_editbox"]:editbox_create("", "", screenW * 0.3066, screenH * 0.0768, screenW * 0.4471, screenH * 0.1133,screenW * 0.3066, screenH * 0.0768, screenW * 0.1404, screenH * 0.0365 , "wyszukiwanie")
		addEventHandler("onClientRender", root, gui)
	end
end)

bindKey("mouse_wheel_down", "both", function()
	if tab ~= true then return end
	scrollUp()
end)

bindKey("mouse_wheel_up", "both", function()
	if tab ~= true then return end
	scrollDown()
end)


function scrollDown()
	if n == m then return end
	k = k-1
	n = n-1
end

function scrollUp()
	if n >= #getElementsByType("player") then return end
	k = k+1
	n = n+1
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