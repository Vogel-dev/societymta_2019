--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--


function pokazpracownikow()
	local q = exports['smta_base_db']:wykonaj("SELECT * from smtadb_accounts order by mskrzynki desc")
	local topka = {}

	for i = 1,5 do
		table.insert(topka, {nick = q[i]["login"], liczba = q[i]["mskrzynki"]})
	end

	return topka
end

tablica = pokazpracownikow()

setTimer(function()
	tablica = pokazpracownikow()
end, 600000, 0)

addEvent("pokazTopke:magazynier:source", true)
addEventHandler("pokazTopke:magazynier:source", root, function()
	triggerClientEvent(source, "pokazTopke:magazynier:client", source, tablica)
end)

addEvent("daj:mskrzynki", true)
addEventHandler("daj:mskrzynki", root, function(player)
	local dbid = getElementData(player, "dbid")
	local ilosc = getElementData(player, "mskrzynki") or 0
	local q = exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET mskrzynki=mskrzynki+1 where dbid=?", dbid)
	setElementData(player, "mskrzynki", ilosc+1)
end)

local skrzynka = {}
local timer = {}


addEvent("dajSkrzynke:magazynier", true)
addEventHandler("dajSkrzynke:magazynier", root, function()
	local x,y,z = getElementPosition(source)
	skrzynka[source] = createObject(2969, x,y,z)
	pudelko = exports.bone_attach:attachElementToBone(skrzynka[source],source,11,-0.15,0.00,0.10,-92.00,-5.00,5.00)
	setPedAnimation(source,"CARRY","crry_prtial",0,true,true,false,true)
	setElementInterior(skrzynka[source], 10)
	toggleControl(source,"sprint", false) 
	toggleControl(source,"jump", false) 
	toggleControl(source,"fire", false) 
	if getElementData(source, "magazynier:ulepszenie1") then
		toggleControl(source,"walk", true) 
		setControlState(source,"walk", false)
	else
		toggleControl(source,"walk", false) 
		setControlState(source,"walk", true)
	end
	setObjectScale(skrzynka[source], 1)
	unbug(source)
end)

function unbug(gracz)
	timer[gracz] = setTimer(function()
		toggleControl(gracz,"sprint", false) 
		toggleControl(gracz,"jump", false) 
		toggleControl(gracz,"fire", false) 
		if getElementData(gracz, "magazynier:ulepszenie1") == 1 then
			toggleControl(gracz,"walk", true) 
			setControlState(gracz,"walk", false)
		else
			toggleControl(gracz,"walk", false) 
			setControlState(gracz,"walk", true)
		end
	end, 51, 0)
end



addEvent("usunSkrzynke:magazynier", true)
addEventHandler("usunSkrzynke:magazynier", root, function()
	exports.bone_attach:detachElementFromBone(skrzynka[source])
	if isElement(skrzynka[source]) then destroyElement(skrzynka[source]) end
	setPedAnimation(source,"ped","facanger",-1,false,true,true,false)
	toggleControl(source,"sprint", true) 
	toggleControl(source,"jump", true) 
	toggleControl(source,"fire", false) 
	toggleControl(source,"walk", true) 
	setControlState(source,"walk", false)
	if isTimer(timer[source]) then
		killTimer(timer[source])
	end
end)

addEventHandler("onPlayerQuit", root, function()
	if isTimer(timer[source]) then
		killTimer(timer[source])
	end
	if isElement(skrzynka[source]) then 
		destroyElement(skrzynka[source]) 
	end
end)