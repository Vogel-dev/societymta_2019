--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

gBlipSet=false

local cFunc={}
local cSetting={}

--
addEvent('radar:refeshBlips', true) -- triggerClientEvent(localPlayer, 'ms_refeshBlips', localPlayer) -- triggerEvent('ms_refeshBlips', localPlayer)
addEvent('radar:onClientSpawned', true)
addEvent('radar:onClientHudComponent', true)
--

HudRadar={}
HudRadar.__index=HudRadar

function HudRadar:new(...)
	local obj=setmetatable({}, {__index=self})
	if obj.constructor then
		obj:constructor(...)
	end
	return obj
end

function HudRadar:isPointInRectangle(cx, cy, rx, ry, width, height)
	local ret=0
	if cx>rx then ret=1 end
	if cx<rx+width then ret=2 end
	if cy>ry then ret=3 end
	if cy>rx+height then ret=4 end
	return ret
end

function HudRadar:getElementSpeed(element, unit)
	if unit==nil then unit=0 end
	if isElement(element) then
		local x,y,z=getElementVelocity(element)
		
		return (x^2+y^2+z^2)^0.5*1.8*100
	else
		return false
	end
end

function HudRadar:toggle(bool)
	if bool==nil then
		self.renderEnabled=not self.renderEnabled
	else
		self.renderEnabled=bool
	end
end

function HudRadar:refreshGlobalBlips(blip)
	self.globalBlips={}
	for _,v in pairs(getElementsByType('blip')) do
		if getBlipVisibleDistance(v)==1337 then
			table.insert(self.globalBlips, v)
		end
	end
	self:refreshBlips()
end

function HudRadar:refreshAllShape()
	self:refreshGlobalBlips()
	--self:refreshAreas()
	gBlipSet=true
end

function HudRadar:refreshBlips()
	if not isElement(self.blipTarget) then return end
	dxSetRenderTarget(self.blipTarget, true)
	
	if #self.globalBlips>0 then
		for _, blip in pairs(self.globalBlips) do
			local model=getBlipIcon(blip)
			local r,g,b=255, 255, 255
			local x,y,_=getElementPosition(blip)
			local mapX=(x/2)+1500
			local mapY=3000-((y/2)+1500)
			local width=26
			if model<2 then
				r,g,b=getBlipColor(blip)
				width=16
			end
			dxDrawImage(mapX-(width/2), mapY-(width/2), width, width, ('i/blips/%d.png'):format(model), 0, 0, 0, tocolor(r, g, b, 255))
		end
	else
		for _, blip in pairs(getElementsByType('blip')) do
			if getElementDimension(blip)==getElementDimension(localPlayer) then
				local model=getBlipIcon(blip)
				local r,g,b=255, 255, 255
				local x,y,_=getElementPosition(blip)
				local mapX=(x/2)+1500
				local mapY=3000-((y/2)+1500)
				local width=32
				if model<2 then
					r,g,b=getBlipColor(blip)
					width=16
				end
				dxDrawImage(mapX-(width/2), mapY-(width/2), width, width, ('i/blips/%d.png'):format(model), 0, 0, 0, tocolor(r, g, b, 255))
			end
		end
	end
	dxSetTextureEdge(self.blipTarget, 'clamp')
	dxSetRenderTarget()
end

function HudRadar:refreshAreas()
	--[[if not isElement(self.radarTarget) then return end
	dxSetRenderTarget(self.radarTarget, true)
	for _, zone in pairs(getElementsByType('radararea')) do
		if getElementDimension(blip)==getElementDimension(localPlayer) then
			local r,g,b,a=getRadarAreaColor(zone)
			local sx,sy=getRadarAreaSize(zone)
			local x,y,_=getElementPosition(zone)
			local mapX=(x/2)+1500
			local mapY=3000-((y/2)+1500)
			local width, height=getRadarAreaSize(zone)
			
			dxDrawRectangle(mapX-width/2, mapY-height/2, width, height, tocolor(r,g,b, 200))
		end
	end
	dxSetRenderTarget()]]
end

function HudRadar:moveIn()
	local curZoom=self.targetZoom
	
	if curZoom-self.zoomLevel>self.minZoom and self.canZoom then
		self.targetZoom=self.targetZoom-self.zoomLevel
		
		self.moveType=true
		self.hudZoomStartTick=getTickCount()
		self.canZoom=false
		
		self:refreshAllShape()
	end
end

function HudRadar:moveOut()
	local curZoom=self.targetZoom
	
	if curZoom+self.zoomLevel<self.maxZoom and self.canZoom then
		self.targetZoom=self.targetZoom+self.zoomLevel
		
		self.moveType=false
		self.hudZoomStartTick=getTickCount()
		self.canZoom=false
		
		self:refreshAllShape()
	end
end

function HudRadar:render()
	if not self.renderEnabled then return end
	--local cmp_name='radar'
	--if not hudManager.components[cmp_name].enabled or hudManager.components[cmp_name].enabled==false then
	--	return false
	--end
	
	local zoom=0.9
	local x,y=21, self.sy-200 -- 16, self.sy-210
	local w,h=332*zoom, 195*zoom -- 332*1.0, 195*1.0
	local alpha=255
	
	local mapX, mapY=self.sizeX, self.sizeY
	local pX, pY, pZ=getElementPosition(localPlayer)
	local nX, nY=(mapX+pX)/(mapX*2)*mapX, (mapY-pY)/(mapY*2)*mapY
	--outputChatBox('PX: ' ..pX.. ' PY: ' ..pY.. ' NX: ' ..nX.. ' NY: ' ..nY)
	
	local original_zoom=1.0
	local targetZoom=self.targetZoom
	local currentZoom=self.currentZoom
	
	if isPedInVehicle(localPlayer) then
		local speed=self:getElementSpeed(getPedOccupiedVehicle(localPlayer))
		if speed then
			speed=speed*getGameSpeed()
			targetZoom=targetZoom+(speed/2)
		end
	end
	
	if self.moveType==true then
		self.currentZoom=interpolateBetween(targetZoom+self.zoomLevel, 0, 0, targetZoom, 0, 0, (getTickCount()-self.hudZoomStartTick)/500, 'InOutQuad', 0, 0, 2)
	else
		self.currentZoom=interpolateBetween(targetZoom-self.zoomLevel, 0, 0, targetZoom, 0, 0, (getTickCount()-self.hudZoomStartTick)/500, 'InOutQuad', 0, 0, 2)
	end
	
	if ((getTickCount()-self.hudZoomStartTick)/500)>1 and self.canZoom==false then
		self.canZoom=true
	end
	
	local originalZoom=currentZoom
	if nX>mapX then
		nX=mapX
	elseif nX<0 then
		nX=0
	end
	if nY>mapY then
		nY=mapY
	elseif nY<0 then
		nY=0
	end
	
	local original_zoom_alt_x=originalZoom/256*w
	local original_zoom_alt_y=originalZoom/(256+20)*h
	
	local radar_h=self.radarTypH-20
	if getElementInterior(localPlayer)~=0 then 
		dxDrawImage(x, y, self.radarTypW*zoom, radar_h*zoom, 'i/interior_alt.jpg', 0, 0, 0, tocolor(255, 255, 255, alpha))
	else
		if self.texture then
			dxDrawImageSection(x, y, self.radarTypW*zoom, radar_h*zoom, nX-original_zoom_alt_x/2, nY-original_zoom_alt_y/2, original_zoom_alt_x, original_zoom_alt_y, self.texture, 0, 0, 0, tocolor(255, 255, 255, alpha))
		end
	end
	
	-- blips
	-- gracz lokalny
	if getElementInterior(localPlayer)==0 then 
		dxDrawImage(x+(w/2)-((16/currentZoom*512)*zoom)/2, y+(h/2)-((16/currentZoom*512)*zoom)/2, (16/currentZoom*512)*zoom, (16/currentZoom*512)*zoom, 'i/icon_me.png', (getPedRotation(localPlayer)+180)*-1, 0, 0, tocolor(255, 255, 255, alpha))
	end
	
	if #self.globalBlips>0 then
		gBlipSet=true
		dxDrawImage(x, y, w, h, 'i/background_alt.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
		for k,v in pairs(self.globalBlips) do
			if v and isElement(v) and getElementInterior(v)==getElementInterior(localPlayer) then
				local bx,by=getElementPosition(v)
				if not(self:isPointInRectangle((bx/2)+1500, 3000-((by/2)+1500), nX-original_zoom_alt_x/2, nY-original_zoom_alt_y/2, original_zoom_alt_x, original_zoom_alt_y)) then
					local px,py,_=getElementPosition(localPlayer)
					local rot=self:findRotation(px,py, bx,by)
					local distance=math.sqrt((x+(w/2)^2), (y+(h/2)^2))
					local xx,yy=getPointFromDistanceRotation(x+(w/2), y+(h/2), distance, 360-rot)
					
					if xx>x+w then
						xx=tonumber(x+w)
					end
					if xx<tonumber(x) then
						xx=tonumber(x)
					end
					
					if yy>y+h then
						xx=tonumber(y)
					end
					if yy<tonumber(y) then
						xx=tonumber(y+w)
					end
					
					dxDrawImage(xx-16, yy-16, 32, 32, ('i/blips/%d.png'):format(getBlipIcon(v)))
					local walk_distance = getDistanceBetweenPoints2D(px, py, bx, by)
					dxDrawText(math.round(walk_distance).."m", xx, yy+35, xx, yy+35, tocolor(255, 255, 255, 255), 4.8, "default-bold", "center", "bottom")
					self:refreshAllShape()
				else
					setBlipVisibleDistance(v, 1000)
					self:refreshAllShape()
				end
			else
				self:refreshAllShape()
			end
		end
	else
		if gBlipSet then
			self:refreshAllShape()
			gBlipSet=false
		end
		dxDrawImageSection(x, y, self.radarTypW*zoom, radar_h*zoom, nX-original_zoom_alt_x/2, nY-original_zoom_alt_y/2, original_zoom_alt_x, original_zoom_alt_y, self.blipTarget, 0, 0, 0, tocolor(255, 255, 255, alpha))
		-- chwilowo wycofano - dxDrawImageSection(x, y, self.radarTypW*hudManager.components[cmp_name].zoom, radar_h*hudManager.components[cmp_name].zoom, nX-original_zoom_alt_x/2, nY-original_zoom_alt_y/2, original_zoom_alt_x, original_zoom_alt_y, self.radarTarget, 0, 0, 0, tocolor(255, 255, 255, alpha))
		dxDrawImage(x, y, w, h, 'i/background_alt.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
	end
	
	local cur_weather=getWeather() -- pobieramy pierwsza pogode, druga zbedna(?)
	if getElementInterior(localPlayer)==0 and cur_weather==16 then
		--local minus_rain=(getTickCount()-self.startTick)
		--minus_rain=minus_rain/10
		dxDrawImage(x, y, w, h, 'i/rain.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
	end
	
	-- zone text
	local zoneText=getZoneName(pX, pY, pZ, false).. ', ' ..getZoneName(pX, pY, pZ, true)
	if getElementInterior(localPlayer)~=0 then zoneText='Znajdujesz się w pomieszczeniu...' end
	
	--dxDrawRectangle(x+3*zoom, y+155, w-6*zoom, 18*zoom, tocolor(0, 0, 0, alpha/1.3))
	--dxDrawText(zoneText, x, y+170*zoom, x+w, y+h, tocolor(200, 200, 200, alpha), 0.8*zoom, self.font1, 'center', 'top')
end

function HudRadar:restore(clearedRenders)
	if not self.renderEnabled then return end
	if clearedRenders then
		setTimer(function()
			self:refreshAllShape()
		end, 1500, 1)
	end
end

function HudRadar:ms_onClientHudComponent(data, show)
	if data=='radar' then
		if show==true then
			self:toggle(true)
		else
			self:toggle(false)
		end
	end
end

function HudRadar:ms_onClientSpawned(data)
	if data=='login' then
		self:toggle(true)
	elseif data=='register' then
		self:toggle(true)
	end
end

function HudRadar:constructor(zoom, sizeX, sizeX, antilag, typ, typeW, typeH)
	self.renderEnabled=false
	
	self.moveInKey='num_add'
	self.moveOutKey='num_sub'
	self.currentZoom=256
	self.targetZoom=256
	self.zoomLevel=64
	self.minZoom=128
	self.maxZoom=586
	
	--self.startTick=getTickCount()

	self.hudZoomStartTick=getTickCount()
	self.canZoom=true
	
	local x,y=guiGetScreenSize()
	self.sx, self.sy=x,y
	self.sizeX=sizeX or 3000
	self.sizeY=sizeY or 3000
	
	self.radarTyp=typ
	self.radarTypW=typeW or 332 --332
	self.radarTypH=typeH or 215 --215
	
	self.moveInFunc=function() self:moveIn() end
	self.moveOutFunc=function() self:moveOut() end
	self.renderFunc=function() self:render() end
	self.restoreFunc=function(clearedRenders) self:restore(clearedRenders) end
	
	self.font1=dxCreateFont('f/cz.ttf', 16)
	self.font2=dxCreateFont('f/cz.ttf', 20)
	
	self.texture=dxCreateTexture('i/map.jpg', 'argb', true, 'clamp', '2d')
	if not self.texture then
		outputDebugString('SMTA_BASE_RADAR: Nie stworzono textury mapy #1##ER')
		--return
	end
	
	local mapWidth,mapHeight=3000,3000
	self.blipTarget=dxCreateRenderTarget(mapWidth, mapHeight, true)
	-- chwilowo wycofane - self.radarTarget=dxCreateRenderTarget(mapWidth, mapHeight, true)
	
	bindKey(self.moveInKey, 'down', self.moveInFunc)
	bindKey(self.moveOutKey, 'down', self.moveOutFunc)
	
	self.globalBlips={}
	local _createBlip=createBlip
	function createBlip(...)
		local blip=_createBlip(...)
		self:refreshGlobalBlips(blip)
		return blip
	end
	addEventHandler('onClientRender', root, self.renderFunc)
	addEventHandler('onClientRestore', root, self.restoreFunc)
	
	self.funcSpawned=function(data) self:ms_onClientSpawned(data) end
	addEventHandler('radar:onClientSpawned', root, self.funcSpawned)
	
	self.funcHUDVisible=function(data, show) self:ms_onClientHudComponent(data, show) end
	addEventHandler('radar:onClientHudComponent', root, self.funcHUDVisible)
	
	self.funcRefresh=function() setTimer(function() self:refreshAllShape() end, 500, 1) end
	addEventHandler('radar:refeshBlips', root, self.funcRefresh)
	
	-- cmd
	self.cmdRadar=function(plr, cmd) self:toggle() end
	addCommandHandler('showradar', self.cmdRadar)
	
	self:refreshAllShape()

	setTimer(function()
		self:refreshAllShape()
	end, 51, 0)
end

function HudRadar:findRotation(x1, y1, x2, y2)
	local t=-math.deg(math.atan2(x2-x1, y2-y1))
	if t<0 then t=t+360 end
	return t
end

RadarClass=HudRadar:new()