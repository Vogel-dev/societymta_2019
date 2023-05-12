--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local nacisniecia = 0

bindKey("mouse1", "down", function()
  nacisniecia = nacisniecia + 1
  if nacisniecia == 8 then
    triggerServerEvent("kick:spamer", localPlayer)
    --outputChatBox("kick")
  end
end)

setTimer(function() nacisniecia = 0 end, 1000, 0)

local screenW, screenH = guiGetScreenSize()
local px,py = screenW/1440, screenH/900

--- bw

function mth(minutes)
  local h = math.floor(minutes/60)
  local m = minutes - (h*60)
  return {h,m}
end

local czas = 0

local font = dxCreateFont("cz.ttf", 22)

function umieranie()
		dxDrawText("Jesteś nieprzytomny!\nZa "..mth(czas)[1].." minut "..mth(czas)[2].." sekund odzyskasz przytomność.", screenW * 0.7101+1, screenH * 0.0026+1, screenW * 0.9927, screenH * 0.0859, tocolor(0, 0, 0, 255), 1.00, font, "right", "center", false, false, false, true, false)
    dxDrawText("Jesteś nieprzytomny!\nZa #960000"..mth(czas)[1].."#969696 minut #960000"..mth(czas)[2].." #969696sekund odzyskasz przytomność.", screenW * 0.7101, screenH * 0.0026, screenW * 0.9927, screenH * 0.0859, tocolor(150, 150, 150, 255), 1.00, font, "right", "center", false, false, false, true, false)
end

addEvent("oknoNieprzytomnosci", true)
addEventHandler("oknoNieprzytomnosci", root, function()
  setElementData(localPlayer, "hud", true)
  setElementData(localPlayer, "bw", true)
  triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
  setElementData(localPlayer, "player:blackwhite", true)
  addEventHandler("onClientRender", root, umieranie)
  showChat(false)
  czas = 600
  setTimer(function()
    czas = czas-1
    if czas <= 0 then
      removeEventHandler("onClientRender", root, umieranie)
      setElementData(localPlayer, "hud", false)
      setElementData(localPlayer, "player:blackwhite", false)
      setElementData(localPlayer, "bw", false)
      triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
      triggerServerEvent("zrespZmarlego", localPlayer)
	if getElementData(localPlayer, "najedzenie") < 20 then
   	 setElementData(localPlayer, "najedzenie", 25)
  	end
      showChat(true)
    end
  end, 1000, 600)
end)

addEvent("usunBw", true)
addEventHandler("usunBw", root, function()
  removeEventHandler("onClientRender", root, umieranie)
  setElementData(localPlayer, "hud", false)
  setElementData(localPlayer, "player:blackwhite", false)
  setElementData(localPlayer, "bw", false)
  triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
  triggerServerEvent("zrespZmarlego", localPlayer)
  showChat(true)
  if getElementData(localPlayer, "najedzenie") < 20 then
    setElementData(localPlayer, "najedzenie", 25)
  end
end)