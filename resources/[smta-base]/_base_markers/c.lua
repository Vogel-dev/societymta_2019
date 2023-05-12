--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

marker = dxCreateTexture("marker.png")
kupno = dxCreateTexture("kupno_marker.png")
oddawanie = dxCreateTexture("oddawanie_marker.png")
zdawanie = dxCreateTexture("zdawanie_marker.png")
drzwi = dxCreateTexture("drzwi_marker.png")
fastfood = dxCreateTexture("fastfood_marker.png")
samochod = dxCreateTexture("pojazd_icon.png")
skrzynka = dxCreateTexture("box_icon.png")
stacja = dxCreateTexture("stacjapaliw_marker.png")
gielda = dxCreateTexture("gielda_marker.png")
wedkarz = dxCreateTexture("wedkarz_marker.png")
malowanie = dxCreateTexture("malowanie_marker.png")
tuning = dxCreateTexture("tuning_marker.png")
mechanik = dxCreateTexture("mechanik_marker.png")
bankomat = dxCreateTexture("bankomat_marker.png")
kilof = dxCreateTexture("kilof_icon.png")
delivery = dxCreateTexture("delivery_point.png")
casino = dxCreateTexture("casino_marker.png")
narko = dxCreateTexture("narko_marker.png")
guns = dxCreateTexture("guns_marker.png")


function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function dxDrawImageElementMarker(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, marker, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementWedkarz(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, wedkarz, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementGuns(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, guns, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementCasino(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, casino, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementNarko(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, narko, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementMechanik(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, mechanik, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementMalowanie(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, malowanie, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementTuning(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, tuning, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementDoors(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, drzwi, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementZdawanie(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, zdawanie, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementStacja(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, stacja, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementBankomat(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, bankomat, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementOddawanie(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, oddawanie, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementGielda(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, gielda, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElementFastfood(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, fastfood, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElement(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, samochod, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElement2(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, skrzynka, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElement3(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, kilof, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElement4(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, delivery, 1.5, tocolor(255, 255, 255)) 
end

function dxDrawImageElement5(element)
	local x, y, z = getElementPosition(element)
	local distance = 1.3
	z = z+distance-math.sin(getTickCount()/500)*0.07
	dxDrawMaterialLine3D(x, y, z+0.8, x, y, z-0.7, kupno, 1.5, tocolor(255, 255, 255)) 
end



addEventHandler( "onClientRender", getRootElement(), function()
	for i,v in ipairs(getElementsByType("marker")) do
		if getMarkerType(v) == "cylinder" and getElementDimension(v) == getElementDimension(localPlayer) and getElementInterior(v) == getElementInterior(localPlayer)  then
		if getElementAlpha(v) ~= 0 then
			setElementAlpha(v, 0)
		end
		local count = getTickCount(  )
		local animation = getMarkerSize(v) / 8
		local size = getMarkerSize(v) * 1.5 - math.sin(count * 1/500) * animation
		local x2,y2,z2 = getElementPosition(v)
		local r,g,b,a = getMarkerColor(v)
		local x, y = getElementPosition( localPlayer )
		local direction = math.rad( findRotation(x2, y2, x, y) )
		local offsetX, offsetY = math.cos(direction) * size / 2,  math.sin(direction) * size / 2
		if getElementData(v, "bankomat") then
			dxDrawImageElementBankomat(v)
		elseif getElementData(v, "sprzedaz") then
			dxDrawImageElement5(v)
		elseif getElementData(v, "drzwi") then
			dxDrawImageElementDoors(v)
		elseif getElementData(v, "zdawanie") then
			dxDrawImageElementZdawanie(v)
		elseif getElementData(v, "przechowalnia") then
			dxDrawImageElementOddawanie(v)
		elseif getElementData(v, "kasyno") then
			dxDrawImageElementCasino(v)
		elseif getElementData(v, "narkotyki") then
			dxDrawImageElementNarko(v)
		elseif getElementData(v, "wedkarz") then
			dxDrawImageElementWedkarz(v)
		elseif getElementData(v, "stacja") then
			dxDrawImageElementStacja(v)
		elseif getElementData(v, "mechanik") then
			dxDrawImageElementMechanik(v)
		elseif getElementData(v, "fastfoody") then
			dxDrawImageElementFastfood(v)
		elseif getElementData(v, "malowanie") then
			dxDrawImageElementMalowanie(v)
		elseif getElementData(v, "tuning") then
			dxDrawImageElementTuning(v)
		elseif getElementData(v, "gielda") then
			dxDrawImageElementGielda(v)
		elseif getElementData(v, "przechowalnia2") then
			dxDrawImageElement(v)
		elseif getElementData(v, "skrzynki") then	
			dxDrawImageElement2(v)
		elseif getElementData(v, "kopanie") then	
			dxDrawImageElement3(v)
		elseif getElementData(v, "delivery") then	
			dxDrawImageElement4(v)
		elseif getElementData(v, "guns") then
			dxDrawImageElementGuns(v)
		else
			dxDrawImageElementMarker(v)
		end
		end
	end
end)

