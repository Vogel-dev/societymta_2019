--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()

local editboxs = {}
local liters = 0

local gui_showed = false

function editbox_create(edit, name, x1, x2, x3, x4, xx1, xx2, xx3, xx4, main_name, masked)
	if masked then
		masked = true
	else
		masked = false
	end
	table.insert(editboxs, {edit, name, x1, x2, x3, x4, xx1, xx2, xx3, xx4, true, false, main_name, masked})
	liters = liters+1
	if gui_showed ~= true then
		gui_showed = true
	end
end

function editbox_destroy(name)
    for i=#editboxs, 1, -1 do
        if editboxs[i][13] == name then
            table.remove(editboxs, i)
            if gui_showed == true then
            	if liters == 1 then
            		gui_showed = false
            	else
            		liters = liters-1
            	end
            end
        end
    end
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

local czcionka = dxCreateFont("cz.ttf", 16)

addEventHandler("onClientRender", root, function()
	for i,v in ipairs(editboxs) do
		local text = ""
		if v[1] == "" and v[12] ~= true then
			text = v[2]
		elseif v[12] == true then
			text = v[1]
			if v[14] == true then
				text = string.gsub(text, ".", "•")
			end
			text = text.."|"
		else
			text = v[1]
			if v[14] == true then
				text = string.gsub(text, ".", "•")
			end
		end
		--dxDrawRectangle(v[7]-2, v[8], v[9]+4, v[10], tocolor(50,50,50,175), true)
		--dxDrawRectangle(v[7]-(2)+screenW*0.0010, v[8]+screenW*0.0010, v[9]+(4)-screenW*0.0020, v[10]-screenW*0.0020, tocolor(15,15,15,222), true)
		dxDrawText(text, v[3]+1, v[4]+1, v[5]+1, v[6]+1, tocolor(0, 0, 0, 255), 1, czcionka, "left", "center", true, false, true, false, false)
   	 	dxDrawText(text, v[3], v[4], v[5], v[6], tocolor(255, 255, 255, 255), 1, czcionka, "left", "center", true, false, true, false, false)

	end
end)

function editbox_text(name)
	for i,v in ipairs(editboxs) do
		if v[13] == name then
			return v[1]
		end
	end
end

bindKey("backspace", "down", function()
	for i,v in ipairs(editboxs) do
		if v[12] == true then
			v[1] = string.sub(v[1], 1, string.len(v[1])-1)
		end
	end
end)

local zakazane_litery = {
{"t"},
{"y"},
{"o"},
{"p"},
{"f"},
{"c"},
{"v"},
}

local zakazane_przyciski = {
["enter"] = true,	
["lshift"] = true,
["f5"] = true,
["f2"] = true,
["f3"] = true,
["f1"] = true,
["f11"] = true,
}

addEventHandler("onClientCharacter", root, function(key)
	if not key then return end
	for i,v in ipairs(editboxs) do
		if v[12] == true then
			v[1] = v[1]..""..key
		end
	end
end)

addEventHandler("onClientKey", root, function(b, key)
	for i,v in ipairs(editboxs) do
		if zakazane_przyciski[b] then
			cancelEvent()
		end
		for i,v in ipairs(zakazane_litery) do
			if v[1] == b then
				cancelEvent()
			end
		end
	end
end)

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
	for i,v in ipairs(editboxs) do
		if v[12] == true then
			v[12] = false
		else
			if mysz(v[7], v[8], v[9], v[10]) and v[11] == true then
				v[12] = true
			end
		end
	end
end)