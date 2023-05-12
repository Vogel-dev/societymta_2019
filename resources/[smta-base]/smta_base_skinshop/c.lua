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
local przebiera = false
local aktualnySkin = 1
local rodzaj = 1

local normalne = {0, 2, 7, 15, 16, 17, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 37, 43, 44,  46, 47, 48, 49, 50, 51, 57, 59, 60, 61, 62, 66, 67, 68, 70, 72, 73, 78, 79, 80, 81, 94, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 161, 162, 163, 164, 165, 166, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 206, 212, 213, 217, 220, 221, 223, 228, 230, 234, 235, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 10, 11, 12, 13, 31, 40, 54, 55, 56, 64, 69, 76, 77, 85, 89, 90, 91, 93, 129, 130, 131, 141, 150, 151, 157, 169, 172, 190, 191, 192, 193, 194, 195, 196, 197, 199, 211, 214, 216, 218, 219, 225, 226, 231, 232, 233, 237, 243, 245, 251, 256, 263}
local premium= {311, 309, 308, 301, 300, 291, 290, 289, 288, 287, 286}

local przebieralnie = {
	-- marker, ped, rotp, int, dim, typ(1-4), cameramatrix
	{2396.74, -1733.21, 1070.43, 2392.07, -1733.83, 1070.43, 313, 1, 0, 3, 2394.8588867188, -1731.2891845703, 1071.677734375, 2394.162109375, -1731.9461669922, 1071.3896484375},
	{2396.34, -1728.08, 1070.43, 2392.40, -1726.82, 1070.43, 225, 1, 0, 4, 2395.0895996094, -1729.7703857422, 1071.3094482422, 2394.4038085938, -1729.0529785156, 1071.1871337891},
}

 
 local text = createElement("text")
setElementData(text, "text", "Ubrania zwykłe")
setElementPosition(text, 2396.74, -1733.21, 1070.43)
local text2 = createElement("text")
setElementData(text2, "text", "Ubrania diamond")
setElementPosition(text2, 2396.34, -1728.08, 1070.43)
 
for i, v in ipairs(przebieralnie) do
	marker = createMarker(v[1], v[2], v[3]-.95, "cylinder", 1, 97, 64, 81, 100)
	setElementData(marker, "pedx", v[4])
	setElementData(marker, "pedy", v[5])
	setElementData(marker, "pedz", v[6])
	setElementData(marker, "pedxyz", v[4]..","..v[5]..","..v[6])
	setElementData(marker, "pedr", v[7])
	setElementData(marker, "int", v[8])
	setElementData(marker, "dim", v[9])
	setElementData(marker, "typ", v[10])
	setElementData(marker, "camxyz", v[11]..","..v[12]..","..v[13]..","..v[14]..","..v[15]..","..v[16]) -- dodać
	setElementInterior(marker, v[8])
	setElementDimension(marker, v[9])
	addEventHandler("onClientMarkerHit", marker, function(gracz)
		if gracz ~= localPlayer then return end
		local kordy = split(getElementData(source, "pedxyz"), ",")
		local cam = split(getElementData(source, "camxyz"), ",")
		ped = createPed(0, kordy[1], kordy[2], kordy[3], getElementData(source, "pedr"))
		setElementDimension(ped, getElementData(source, "dim"))
		setElementInterior(ped, getElementData(source, "int"))
		setCameraMatrix(cam[1], cam[2], cam[3], cam[4], cam[5], cam[6])
		addEventHandler("onClientRender", root, gui)
		przebiera = true
		rodzaj = getElementData(source, "typ")
		setElementFrozen(localPlayer, true)
		setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
	end)
end

function gui()
    dxDrawImage(screenW * 0.3684, screenH * 0.0000, screenW * 0.2640, screenH * 0.1471, ":smta_base_skinshop/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

bindKey("enter", "down", function()
	if przebiera == false then return end
	exports["smta_base_notifications"]:noti("Zmieniono skin.")
	triggerServerEvent("zapiszSkin:przebieralnia", resourceRoot, localPlayer, getElementModel(ped))
	destroyElement(ped)
	aktualnySkin = 1
	przebiera = false
	setElementFrozen(localPlayer, false)
	setCameraTarget(localPlayer)
	removeEventHandler("onClientRender", root, gui)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
end)

bindKey("backspace", "down", function()
	if przebiera == false then return end
	exports["smta_base_notifications"]:noti("Opuszczono przebieralnie.")
	destroyElement(ped)
	aktualnySkin = 1
	przebiera = false
	setElementFrozen(localPlayer, false)
	setCameraTarget(localPlayer)
	removeEventHandler("onClientRender", root, gui)
	setElementData(localPlayer, "hud", false)
	showChat(true)
	triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
end)

bindKey("arrow_l", "both", function(k, s)
	if s ~= "down" then return end
	if przebiera == false then return end
	if aktualnySkin == 1 then return end
	aktualnySkin = aktualnySkin-1
	if rodzaj == 1 then
		setElementModel(ped, wisniackie[aktualnySkin])
	elseif rodzaj == 2 then
		setElementModel(ped, prestiz[aktualnySkin])
	elseif rodzaj == 3 then
		setElementModel(ped, normalne[aktualnySkin])
	elseif rodzaj == 4 then
		if getElementData(localPlayer, "premium", true) then
		setElementModel(ped, premium[aktualnySkin])
		else
		exports["smta_base_notifications"]:noti("Nie posiadasz konta diamond.")
		end
	end
end)

bindKey("arrow_r", "both", function(k, s)
	if s ~= "down" then return end
	if przebiera == false then return end
	if rodzaj == 1 and aktualnySkin < #wiesniackie then
		aktualnySkin = aktualnySkin+1
		setElementModel(ped, wisniackie[aktualnySkin])
	elseif rodzaj == 2 and aktualnySkin < #prestiz then
		aktualnySkin = aktualnySkin+1
		setElementModel(ped, prestiz[aktualnySkin])
	elseif rodzaj == 3 and aktualnySkin < #normalne then
		aktualnySkin = aktualnySkin+1
		setElementModel(ped, normalne[aktualnySkin])
	elseif rodzaj == 4 and aktualnySkin < #premium then
		if getElementData(localPlayer, "premium", true) then
		aktualnySkin = aktualnySkin+1
		setElementModel(ped, premium[aktualnySkin])
		else
		exports["smta_base_notifications"]:noti("Nie posiadasz konta diamond.")
		end
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