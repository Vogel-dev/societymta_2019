--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

DxImage = dxDrawImage 
DxText = shadowText

daten = {
	maximalIndex = 3,
	bildschirm = Vector2( guiGetScreenSize(  ) ),
	texture = { charaktere = {}, hintergrunde = {} },
	font = {}
}

daten.hintergrundeStr = {
	[1] = {"DISCORD", "Bądź na bieżąco, poznaj nowych graczy, integruj się ze społecznością serwera.\nNajlepsze miejsce do rozmów, zastąp pisanie na chatcie.\n"},
	[2] = {"FORUM", "Dołącz do społecznośći na forum, znajdziesz tam wszystkie regulaminy\nporadniki, miejsce na apelowanie od kar, dołącz do frakcji\nlub jeżeli czujesz się na siłach - do ekipy serwera.\nJesteśmy otwarci na propozycje graczy, rozważymy każdą propozycje od Ciebie."},
	[3] = {"SERWER", "Society MTA to serwer, który wyróżnia się na tle innych serwerów swoją jakością i rozgrywką.\nSerwer jest prowadzony z myślą o graczach,twoje zdanie jest dla nas najważniejsze.\nKażdy znajdzie tu miejsce dla siebie.\nGwarantujemy niezapomniane przeżycia."},
}

function Artikelladen()
	if not daten.charaktere then
		daten.charaktere = { startZeit = getTickCount(  ), index = math.random(1.0, daten.maximalIndex), zuStand = "anzeigen" }
		daten.charaktere.endZeit = daten.charaktere.startZeit + (10*1000)
	end
	for i=1,3 do
		daten.texture.charaktere[i] = DxTexture("files/texture/charaktere/"..i..".png")
		daten.texture.hintergrunde[i] = DxTexture("files/texture/hintergrunde/"..i..".png")
	end
	daten.font.bold = DxFont("files/font/bold.ttf", 42.0/1080*daten.bildschirm.y, false, "antialiased")
	daten.font.gtav = DxFont("files/font/gtav.ttf", 35.0/1080*daten.bildschirm.y, false, "antialiased")
	daten.font.normal = DxFont("files/font/normal.ttf", 25.0/1080*daten.bildschirm.y, false, "antialiased")
	daten.font.normal2 = DxFont("files/font/light.ttf", 15.0/1080*daten.bildschirm.y, false, "antialiased")
	daten.texture.hintergrund = DxTexture("files/texture/hintergrund.png")
	daten.texture.wird_geladen = DxTexture("files/texture/wird_geladen.png")
	daten.texture.logo = DxTexture("files/texture/logo.png")
	daten.starten = getTickCount(  )
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), Artikelladen)

function startenDrin()
	if not isElement(daten.musik) then
		daten.musik = Sound("files/sound/musik.mp3", true)
		addEventHandler( "onClientRender", getRootElement(), istTransferboxaktivRende)
	end
end
addEventHandler("onClientResourceStart", root, startenDrin)

function istTransferboxaktivRende()
	if GuiElement.isTransferBoxActive(  ) then
		ansichtRende()
		showChat(false)
	else
		if isElement(daten.musik) then
			daten.musik:destroy()
			showChat(true)
		end
		removeEventHandler( "onClientRender", getRootElement(), istTransferboxaktivRende)
	end
end

function ansichtRende()
	DxImage(0, 0, daten.bildschirm.x, daten.bildschirm.y, daten.texture.hintergrund)
	local GroBe = Vector2( daten.texture.logo:getSize() )
	GroBe.x, GroBe.y = (GroBe.x*0.5)/1080*daten.bildschirm.y, (GroBe.y*0.5)/1080*daten.bildschirm.y
	DxImage(daten.bildschirm.x/2 - GroBe.x/2, 20/1080*daten.bildschirm.y, GroBe.x, GroBe.y, daten.texture.logo)
	ZeichneHintergrund()
	ZeichneCharakter()
end

function ZeichneHintergrund()
	local texture = daten.texture.hintergrunde[daten.charaktere.index]
	DxImage(0, daten.bildschirm.y/2 - 522/1080*daten.bildschirm.y/2, 1920/1080*daten.bildschirm.y, 522/1080*daten.bildschirm.y, texture)
	
	local text = daten.hintergrundeStr[daten.charaktere.index][1]
	local x, y, w, h = 0, daten.bildschirm.y/2 - 522/1080*daten.bildschirm.y/2, 1820/1080*daten.bildschirm.y, 522/1080*daten.bildschirm.y
	local w, y = (w-0/1080*daten.bildschirm.y), (y+45/1080*daten.bildschirm.y)
	DxText(text, x, y, w/1080*daten.bildschirm.y, h/1080*daten.bildschirm.y, tocolor(200, 200, 200, 255), 1.0, daten.font.bold, "right", "top", false, false, false)

	local text = daten.hintergrundeStr[daten.charaktere.index][2]
	local x, y, w, h = 0, daten.bildschirm.y/2 - 522/1080*daten.bildschirm.y/2, 1820/1080*daten.bildschirm.y, 522/1080*daten.bildschirm.y
	local w, y = (w-0/1080*daten.bildschirm.y), (y+100/1080*daten.bildschirm.y)
	DxText(text, x, y, w/1080*daten.bildschirm.y, h/1080*daten.bildschirm.y, tocolor(150, 150, 150, 255), 1.0, daten.font.normal, "right", "top", false, false, false)
end

function ZeichneCharakter()
	local jetzt = getTickCount()
	local verstricheneZeit = jetzt - daten.charaktere.startZeit
	local texture = daten.texture.charaktere[daten.charaktere.index]

	local s = (verstricheneZeit/5000)*75
	if verstricheneZeit <= 1000 then
		a = 255-(verstricheneZeit/1000)*255
		a = math.max(a, 0)
	elseif verstricheneZeit >= 4000 then
		a = ( (verstricheneZeit-4000)/1000)*255
		a = math.min(a, 255)
	else
		a = 0
	end
	if verstricheneZeit > 5300 then
		daten.charaktere.startZeit = jetzt
		daten.charaktere.index = daten.charaktere.index < daten.maximalIndex and daten.charaktere.index+1.0 or 1.0
	end
	local GroBe = Vector2( texture:getSize() )
	GroBe.x, GroBe.y = ( (GroBe.x*0.8)+s/1080*daten.bildschirm.y)/1080*daten.bildschirm.y, ( (GroBe.y*0.8)+s/1080*daten.bildschirm.y )/1080*daten.bildschirm.y
	DxImage(0, math.floor( daten.bildschirm.y-GroBe.y ), GroBe.x, GroBe.y, texture)
	dxDrawRectangle( 0, 0, daten.bildschirm.x, daten.bildschirm.y, tocolor(30, 30, 30, a) )

	local wird_geladentexture = daten.texture.wird_geladen
	local GroBe = Vector2( wird_geladentexture:getSize() )
	
	text = "Wczytywanie..."
	DxText(text, 0, 0, daten.bildschirm.x-(120/1080*daten.bildschirm.y), (daten.bildschirm.y-GroBe.y/2)-5.0/1080*daten.bildschirm.y, tocolor(200, 200, 200, 255), 1.0, daten.font.gtav, "right", "bottom", false, false, false)
	DxImage( (daten.bildschirm.x-GroBe.x)-(340/1080*daten.bildschirm.y), (daten.bildschirm.y-GroBe.y)-40.0/1080*daten.bildschirm.y, GroBe.x, GroBe.y, wird_geladentexture, getTickCount(  )/5 )
end