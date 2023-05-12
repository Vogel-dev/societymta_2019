--
-- c_rtpool.lua
--

scx, scy = guiGetScreenSize ()
sx, sy = guiGetScreenSize ()

-----------------------------------------------------------------------------------
-- Pool of render targets
-----------------------------------------------------------------------------------
RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( sx, sy )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.sx == sx and info.sy == sy then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	--outputDebugString( "creating new RT " .. tostring(sx) .. " x " .. tostring(sx) )
	local rt = dxCreateRenderTarget( sx, sy )
	if rt then
		RTPool.list[rt] = { bInUse = true, sx = sx, sy = sy }
	end
	return rt
end

function RTPool.clear()
	for rt,info in pairs(RTPool.list) do
		destroyElement(rt)
	end
	RTPool.list = {}
end


-----------------------------------------------------------------------------------
-- DebugResults
-- Store all the rendertarget results for debugging
-----------------------------------------------------------------------------------
DebugResults = {}
DebugResults.items = {}

function DebugResults.frameStart()
	DebugResults.items = {}
end

function DebugResults.addItem( rt, label )
	table.insert( DebugResults.items, { rt=rt, label=label } )
end

function DebugResults.drawItems( sizeX, sliderX, sliderY )
	local posX = 5
	local gapX = 4
	local sizeY = sizeX * 90 / 140
	local textSizeY = 15 + 10
	local posY = 5
	local textColor = tocolor(0,255,0,255)
	local textShad = tocolor(0,0,0,255)

	local numImages = #DebugResults.items
	local totalWidth = numImages * sizeX + (numImages-1) * gapX
	local totalHeight = sizeY + textSizeY

	posX = posX - (totalWidth - (scx-10)) * sliderX / 100
	posY = posY - (totalHeight - scy) * sliderY / 100

	local textY = posY+sizeY+1
	for index,item in ipairs(DebugResults.items) do
		dxDrawImage( posX, posY, sizeX, sizeY, item.rt )
		local sizeLabel = string.format( "%d) %s %dx%d", index, item.label, dxGetMaterialSize( item.rt ) )
		dxDrawText( sizeLabel, posX+1.0, textY+1, posX+sizeX+1.0, textY+16, textShad,  1, "arial", "center", "top", true )
		dxDrawText( sizeLabel, posX,	 textY,   posX+sizeX,     textY+15, textColor, 1, "arial", "center", "top", true )
		posX = posX + sizeX + gapX
	end
end

local screenSize = Vector2(guiGetScreenSize())
local screen = dxCreateScreenSource(screenSize.x, screenSize.y)

bEffectEnabled = false

Settings = {}
Settings.var = {}

addEventHandler("onClientResourceStart", resourceRoot, function()
    if getVersion().sortable < "1.1.0" then 
		return false
	else
    myScreenSourceFull = dxCreateScreenSource( scx, scy )
	
	-- Shaders
		contrastShader = dxCreateShader( "fx/contrast.fx" )
		bloomCombineShader = dxCreateShader( "fx/bloom_combine.fx" )
		bloomExtractShader = dxCreateShader( "fx/bloom_extract.fx" )
		blurHShader = dxCreateShader( "fx/blurH.fx" )
		blurVShader = dxCreateShader( "fx/blurV.fx" )
		modulationShader = dxCreateShader( "fx/modulation.fx" )
		time=501
		-- 1 pixel render target to store the result of scene luminance calculations
		lumTarget = dxCreateRenderTarget( 1, 1 )
		nextLumSampleTime = 0
		textureVignette = dxCreateTexture ( "images/vignette1.dds" );
		shader6=false
		effectParts = {
			myScreenSourceFull,
			contrastShader,
			bloomCombineShader,
			bloomExtractShader,
			blurHShader,
			blurVShader,
			modulationShader,
			lumTarget,
			textureVignette
		}
    end
end)


local dxfont0_1 = dxCreateFont("cz.ttf", 10)

local fps = false
function getCurrentFPS() -- Setup the useful function
    return fps
end

local function updateFPS(msSinceLastFrame)
    -- FPS are the frames per second, so count the frames rendered per milisecond using frame delta time and then convert that to frames per second.
    if getTickCount()-time >= 500 then
	time=getTickCount()
	fps = math.floor((1 / msSinceLastFrame) * 1000)
	end
end
addEventHandler("onClientPreRender", root, updateFPS)

addEventHandler("onClientHUDRender", root, function()
	if localPlayer:getData("shader:fps") then
    dxDrawText(fps, sx-22, 1, 16, 16, tocolor(255, 255, 255, 255), 1.00, dxfont0_1, "left", "top", false, false, true, false, false)
	end
    if contrastShader and shader6 and not localPlayer:getData("shader:6") then
		shader6=false
    end
	if contrastShader and not shader6 and localPlayer:getData("shader:6") then
	    local v = Settings.var
		v.Brightness=0.32
		v.Contrast=2.24

		v.ExtractThreshold=0.72

		v.DownSampleSteps=2
		v.GBlurHBloom=1.68
		v.GBlurVBloom=1.52

		v.BloomIntensity=0.94
		v.BloomSaturation=1.66
		v.BaseIntensity=0.94
		v.BaseSaturation=-0.38

		v.LumSpeed=51
		v.LumChangeAlpha=27

		v.MultAmount=0.46
		v.Mult=0.70
		v.Add=0.10
		v.ModExtraFrom=0.11
		v.ModExtraTo=0.58
		v.ModExtraMult=4

		v.MulBlend=0.82
		v.BloomBlend=0.25

		v.Vignette=0.47

		-- Debugging
		v.PreviewEnable=0
		v.PreviewPosY=0
		v.PreviewPosX=100
		v.PreviewSize=70
		
		shader6=true
    end
	if shader6 then
		local v = Settings.var

		RTPool.frameStart()
		DebugResults.frameStart()

		dxUpdateScreenSource( myScreenSourceFull )

		-- Get source textures
		local current1 = myScreenSourceFull
		local current2 = myScreenSourceFull
		local sceneLuminance = lumTarget

		-- Effect path 1 (contrast)
		current1 = applyModulation( current1, sceneLuminance, v.MultAmount, v.Mult, v.Add, v.ModExtraFrom, v.ModExtraTo, v.ModExtraMult )
		current1 = applyContrast( current1, v.Brightness, v.Contrast )

		-- Effect path 2 (bloom)
		current2 = applyBloomExtract( current2, sceneLuminance, v.ExtractThreshold )
		current2 = applyDownsampleSteps( current2, v.DownSampleSteps )
		current2 = applyGBlurH( current2, v.GBlurHBloom )
		current2 = applyGBlurV( current2, v.GBlurVBloom )
		current2 = applyBloomCombine( current2, current1, v.BloomIntensity, v.BloomSaturation, v.BaseIntensity, v.BaseSaturation )

		-- Update texture used to calculate the scene luminance level
		updateLumSource( current1, v.LumSpeed, v.LumChangeAlpha )

		-- Final output
		dxSetRenderTarget()
		dxDrawImage( 0, 0, scx, scy, current1, 0, 0, 0, tocolor(255,255,255,v.MulBlend*255) )
		dxDrawImage( 0, 0, scx, scy, current2, 0, 0, 0, tocolor(255,255,255,v.BloomBlend*255) )

		-- Draw border texture
		dxDrawImage( 0, 0, scx, scy, textureVignette, 0, 0, 0, tocolor(255,255,255,v.Vignette*255) )

		-- Debug stuff
		if v.PreviewEnable > 0.5 then
			DebugResults.drawItems ( v.PreviewSize, v.PreviewPosX, v.PreviewPosY )
		end
	end
end)

----------------------------------------------------------------
-- post process items
----------------------------------------------------------------

function applyBloomCombine( src, base, sBloomIntensity, sBloomSaturation, sBaseIntensity, sBaseSaturation )
	if not src or not base then return nil end
	local mx,my = dxGetMaterialSize( base )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( bloomCombineShader, "sBloomTexture", src )
	dxSetShaderValue( bloomCombineShader, "sBaseTexture", base )
	dxSetShaderValue( bloomCombineShader, "sBloomIntensity", sBloomIntensity )
	dxSetShaderValue( bloomCombineShader, "sBloomSaturation", sBloomSaturation )
	dxSetShaderValue( bloomCombineShader, "sBaseIntensity", sBaseIntensity )
	dxSetShaderValue( bloomCombineShader, "sBaseSaturation", sBaseSaturation )
	dxDrawImage( 0, 0, mx,my, bloomCombineShader )
	DebugResults.addItem( newRT, "BloomCombine" )
	return newRT
end

function applyBloomExtract( src, sceneLuminance, sBloomThreshold )
	if not src or not sceneLuminance then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( bloomExtractShader, "sBaseTexture", src )
	dxSetShaderValue( bloomExtractShader, "sBloomThreshold", sBloomThreshold )
	dxSetShaderValue( bloomExtractShader, "sLumTexture", sceneLuminance )
	dxDrawImage( 0, 0, mx,my, bloomExtractShader )
	DebugResults.addItem( newRT, "BloomExtract" )
	return newRT
end

function applyContrast( src, Brightness, Contrast  )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxSetShaderValue( contrastShader, "sBaseTexture", src )
	dxSetShaderValue( contrastShader, "sBrightness", Brightness )
	dxSetShaderValue( contrastShader, "sContrast", Contrast )
	dxDrawImage( 0, 0, mx, my, contrastShader )
	DebugResults.addItem( newRT, "Contrast" )
	return newRT
end

function applyModulation( src, sceneLuminance, MultAmount, Mult, Add, ExtraFrom, ExtraTo, ExtraMult )
	if not src or not sceneLuminance then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxSetShaderValue( modulationShader, "sBaseTexture", src )
	dxSetShaderValue( modulationShader, "sMultAmount", MultAmount )
	dxSetShaderValue( modulationShader, "sMult", Mult )
	dxSetShaderValue( modulationShader, "sAdd", Add )
	dxSetShaderValue( modulationShader, "sLumTexture", sceneLuminance )
	dxSetShaderValue( modulationShader, "sExtraFrom", ExtraFrom )
	dxSetShaderValue( modulationShader, "sExtraTo", ExtraTo )
	dxSetShaderValue( modulationShader, "sExtraMult", ExtraMult )
	dxDrawImage( 0, 0, mx, my, modulationShader )
	DebugResults.addItem( newRT, "Modulation" )
	return newRT
end

function applyResize( src, tx, ty )
	if not src then return nil end
	local newRT = RTPool.GetUnused(tx, ty)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxDrawImage( 0,  0, tx, ty, src )
	DebugResults.addItem( newRT, "Resize" )
	return newRT
end

function applyDownsampleSteps( src, steps )
	if not src then return nil end
	for i=1,steps do
		src = applyDownsample ( src )
	end
	return src
end

function applyDownsample( src )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	mx = mx / 2
	my = my / 2
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, src )
	DebugResults.addItem( newRT, "Downsample" )
	return newRT
end

function applyGBlurH( src, bloom )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurHShader, "tex0", src )
	dxSetShaderValue( blurHShader, "tex0size", mx,my )
	dxSetShaderValue( blurHShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurHShader )
	DebugResults.addItem( newRT, "GBlurH" )
	return newRT
end

function applyGBlurV( src, bloom )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurVShader, "tex0", src )
	dxSetShaderValue( blurVShader, "tex0size", mx,my )
	dxSetShaderValue( blurVShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShader )
	DebugResults.addItem( newRT, "GBlurV" )
	return newRT
end


function updateLumSource( current, changeRate, changeAlpha )
	if not current then return nil end
	changeRate = changeRate or 50

	local mx,my = dxGetMaterialSize( current );

	local size = 1
	while ( size < mx / 2 or size < my / 2 ) do
		size = size * 2
	end

	current = applyResize( current, size, size )
	while ( size > 1 ) do
		size = size / 2
		current = applyDownsample( current, 2 )
	end

	if getTickCount() > nextLumSampleTime then
		nextLumSampleTime = getTickCount() + changeRate
		dxSetRenderTarget( lumTarget )
		dxDrawImage( 0,  0, 1, 1, current, 0,0,0, tocolor(255,255,255,changeAlpha) )
	end

	current = applyResize( lumTarget, 1, 1 )

	return lumTarget
end


----------------------------------------------------------------
-- Avoid errors messages when memory is low
----------------------------------------------------------------
_dxDrawImage = dxDrawImage
function xdxDrawImage(posX, posY, width, height, image, ... )
	if not image then return false end
	return _dxDrawImage( posX, posY, width, height, image, ... )
end
