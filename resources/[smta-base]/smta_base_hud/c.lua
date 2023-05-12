--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

--odpowiada za chowanie podstawowego hudu z gta
setPlayerHudComponentVisible("ammo", false)
setPlayerHudComponentVisible("armour", false)
setPlayerHudComponentVisible("clock",  false)
setPlayerHudComponentVisible("health", false)
setPlayerHudComponentVisible("money", false)
setPlayerHudComponentVisible("vehicle_name", false)
setPlayerHudComponentVisible("weapon", false)
setPlayerHudComponentVisible("breath", false)
setPlayerHudComponentVisible("wanted", false)

local screenW, screenH = guiGetScreenSize()
local sx,sy = guiGetScreenSize()
local px,py = (sx/1920),(sy/1080) --wpisujemy swoją rozdzielczość, dzięki czemu będzie odpowienie skalowanie na innych monitorach z inną rozdzielczością
local normal = dxCreateFont("normal.ttf", 17)
local normal20 = dxCreateFont("normal.ttf", 20)

local toggle = false

tik = getTickCount()
addEventHandler("onClientRender", root,
	function()
	if not getElementData(localPlayer, "zalogowany") then return end
	if getElementData(localPlayer, "hud") then return end
	local hajs =getElementData(localPlayer,"pieniadze") or 0 --pieniądze
	local brudnyhajs =getElementData(localPlayer,"brudne:pieniadze") or 0 --bpieniądze
	local health=getElementHealth(localPlayer) --zdrowie
	local najedzenie=getElementData(localPlayer,"najedzenie") or 0 --w core musisz dodać linijki aby odczytywało oraz zapisywało głód, nie zapomnij również dodać kolumne z nazwą "najedzenie"
	local reputacja=getElementData(localPlayer,"punkty") or 0 --wpisz tutaj swoją element date żeby poprawnie odczytywało reputację, w wiekszości przypadkach nie trzeba zmieniać
	
		--dxDrawText("$", 1702*px, 180*py, 1672*px, 72*py, tocolor(0, 0, 0, 255), 1.0*px, normal20, "center", "center", false, false, false, false, false)	
		--dxDrawText("$", 1700*px, 178*py, 1670*px, 70*py, tocolor(180, 180, 180, 255), 1.0*px, normal20, "center", "center", false, false, false, false, false)
		dxDrawText(przecinek(hajs).." $", screenW * 0.2504+2, screenH * 0.9375+2, screenW * 0.3499, screenH * 0.9701, tocolor(0, 0, 0, 255), 1.0*px, normal20, "left", "center", false, false, false, false, false)
		dxDrawText(przecinek(hajs).." $", screenW * 0.2504, screenH * 0.9375, screenW * 0.3499, screenH * 0.9701, tocolor(180, 180, 180, 255), 1.0*px, normal20, "left", "center", false, false, false, false, false)
		dxDrawText(przecinek(brudnyhajs).." $", screenW * 0.3304+2, screenH * 0.9375+2, screenW * 0.3499, screenH * 0.9701, tocolor(0, 0, 0, 255), 1.0*px, normal20, "left", "center", false, false, false, false, false)
		dxDrawText(przecinek(brudnyhajs).." $", screenW * 0.3304, screenH * 0.9375, screenW * 0.3499, screenH * 0.9701, tocolor(180, 0, 0, 255), 1.0*px, normal20, "left", "center", false, false, false, false, false)
		dxDrawImage(screenW * 0.2408, screenH * 0.7292, screenW * 0.0652, screenH * 0.1094, ":smta_base_hud/gfx/heart.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.2408, screenH * 0.8307, screenW * 0.0652, screenH * 0.1094, ":smta_base_hud/gfx/food.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(string.format("%.0f", getElementHealth(localPlayer)).."%", screenW * 0.2555+3, screenH * 0.7969+3, screenW * 0.2914, screenH * 0.8255, tocolor(0, 0, 0, 255), 1.0*px, normal, "center", "center", false, false, false, false, false)
		dxDrawText(string.format("%.0f", getElementHealth(localPlayer)).."%", screenW * 0.2555, screenH * 0.7969, screenW * 0.2914, screenH * 0.8255, tocolor(180, 180, 180, 255), 1.0*px, normal, "center", "center", false, false, false, false, false)
		dxDrawText(string.format("%.0f", getElementData(localPlayer, "najedzenie")).."%", screenW * 0.2577+3, screenH * 0.8971+3, screenW * 0.2906, screenH * 0.9245, tocolor(0, 0, 0, 255), 1.0*px, normal, "center", "center", false, false, false, false, false)
		dxDrawText(string.format("%.0f", getElementData(localPlayer, "najedzenie")).."%", screenW * 0.2577, screenH * 0.8971, screenW * 0.2906, screenH * 0.9245, tocolor(180, 180, 180, 255), 1.0*px, normal, "center", "center", false, false, false, false, false)
	end)

function przecinek(xd) --fukcja odpowiadająca za przecinek w pieniądzach
	local left,num,right = string.match(xd,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end
