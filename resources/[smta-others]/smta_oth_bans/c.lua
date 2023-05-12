--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local okno = guiCreateWindow(0.35, 0.29, 0.30, 0.43, "Lista banów serwerowych", true)
local lista = guiCreateGridList(0.02, 0.06, 0.97, 0.81, true, okno)
local button2 = guiCreateButton(0.02, 0.88, 0.23, 0.10, "Zdejmij bana", true, okno)
local button = guiCreateButton(0.26, 0.88, 0.23, 0.10, "Zamknij panel", true, okno)
local wyszukaj = guiCreateEdit(0.50, 0.88, 0.23, 0.10, "", true, okno)    
guiGridListAddColumn(lista, "ID", 0.09)
guiGridListAddColumn(lista, "NICK", 0.15)
guiGridListAddColumn(lista, "POWÓD", 0.36)
guiGridListAddColumn(lista, "SERIAL", 0.45)
guiGridListAddColumn(lista, "DATA DO", 0.3)
guiGridListAddColumn(lista, "NAŁOZYŁ", 0.3)
guiSetVisible(okno, false)

local result = false

addEvent("lBanow", true)
addEventHandler("lBanow", root, function(s)
	result = s
  	default_bans()
 end)

function default_bans()
  guiSetVisible(okno, true)
  showCursor(true, false)
  guiGridListClear(lista)
  if not result then return end
  for i, p in pairs(result) do
    local spr = guiGridListAddRow(lista)
    guiGridListSetItemText(lista, spr, 1, p["id"], false, false)
    guiGridListSetItemText(lista, spr, 2, p["nick"], false, false)
    guiGridListSetItemText(lista, spr, 3, p["powod"], false, false)
    guiGridListSetItemText(lista, spr, 4, p["serial"], false, false)
    guiGridListSetItemText(lista, spr, 5, p["data"], false, false)
    guiGridListSetItemText(lista, spr, 6, p["admin"], false, false)
  end
end

addEventHandler("onClientGUIClick", button, function()
	showCursor(false)
	guiSetVisible(okno, false)
end)

addEventHandler("onClientGUIClick", button2, function()
	local spr = guiGridListGetSelectedItem(lista)
	local id = guiGridListGetItemText(lista, spr, 1)
	if #id < 1 then return end
	triggerServerEvent("zdejmijBana", localPlayer, id)
end)

addEventHandler("onClientGUIChanged", wyszukaj, function() 
    if guiGetText(wyszukaj) == "" then
    	default_bans()
        return
    end 
    guiGridListClear(lista)
    for i, v in ipairs(result) do 
    	v["id"] = tostring(v["id"])
      v["nick"] = tostring(v["nick"])
      v["powod"] = tostring(v["powod"])
      v["serial"] = tostring(v["serial"])
      v["data"] = tostring(v["data"])
      v["admin"] = tostring(v["admin"])
    	local spr = guiGridListAddRow(lista)
        if string.find(string.gsub(v["id"]:lower(),"#%x%x%x%x%x%x", ""), guiGetText(wyszukaj):lower(), 1, true) or string.find(string.gsub(v["nick"]:lower(),"#%x%x%x%x%x%x", ""), guiGetText(wyszukaj):lower(), 1, true) or string.find(string.gsub(v["powod"]:lower(),"#%x%x%x%x%x%x", ""), guiGetText(wyszukaj):lower(), 1, true) or string.find(string.gsub(v["serial"]:lower(),"#%x%x%x%x%x%x", ""), guiGetText(wyszukaj):lower(), 1, true) or string.find(string.gsub(v["data"]:lower(),"#%x%x%x%x%x%x", ""), guiGetText(wyszukaj):lower(), 1, true) or string.find(string.gsub(v["admin"]:lower(),"#%x%x%x%x%x%x", ""), guiGetText(wyszukaj):lower(), 1, true) or string.find(string.gsub(v["aktywnyod"]:lower(),"#%x%x%x%x%x%x", ""), guiGetText(wyszukaj):lower(), 1, true)  then
          guiGridListSetItemText(lista, spr, 1, v["id"], false, false)
          guiGridListSetItemText(lista, spr, 2, v["nick"], false, false)
          guiGridListSetItemText(lista, spr, 3, v["powod"], false, false)
          guiGridListSetItemText(lista, spr, 4, v["serial"], false, false)
          guiGridListSetItemText(lista, spr, 5, v["data"], false, false)
          guiGridListSetItemText(lista, spr, 6, v["admin"], false, false)
        end
    end
end)