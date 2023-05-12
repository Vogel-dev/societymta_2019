--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local sx,sy = guiGetScreenSize()
local screenW,screenH = guiGetScreenSize()

local font = dxCreateFont("cz.ttf", 16)
local font2 = dxCreateFont("cz.ttf", 13)

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    local cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

local text = ""
local showed = false

local info = [[
Witaj na serwerze SocietyMTA
Jeżeli jesteś tutaj poraz pierwszy, to przeczytaj "Przewodnik", aby dowiedzieć się jak zacząć rozgrywkę.
Nasze forum znajduje się pod adresem: societymta.pl
Oficjalny kanał głosowy Discord https://discord.gg/DMQU3bn
]]

local przewodnik = [[
	W tym dziale spróbujemy Ci pomóc w rozpoczęciu rozgrywki na naszym serwerze Society MTA!
	Na samym początku znajdujemy się na spawnie gdzie panuje zielona strefa. Oznacza to, że nie może nam się tam 
	stać żadna krzywda wyrządzona przez innych graczy. Jeżeli zastanawiacie się jak zacząć i co w pierwszej kolejności 
	zrobić polecalibyśmy udanie się do szkoły jazdy w celu uzyskania prawa jazdy. Gdy egzamin zostanie pomyślnie ukończony, 
	udaj się do restauracji lub food-truck'a, który znajdziesz stojący przy ulicach w wielu miejscach. 
	Kupcie sobie tam pare przekąsek by nie zginąć z głodu. Jeżeli opatrzymy się już w jedzenie, 
	możemy udać się do naszej pierwszej pracy. Po zarobieniu swoich pierwszych większych pieniędzy 
	nadejdzie czas na kupno własnego auta. Na naszym serwerze posiadamy możliwość otworzenia własnego biznesu. 
	Kolejną możliwością jest dołączenie do grupy przestępczej lub ubieganie się o założenie własnej na naszym discordzie. 
	Po pięciu spędzonych godzinach na naszym serwerze możemy samotnie zacząć swoją przygodę z handlem narkotyków, 
	a dokładniej z marihuaną. Rzucając się jednak na tak głęboką wodę musimy się liczyć z konsekwencjami. 
	Oczywiście istnieje też możliwość dołączenia do policji, pogotowia ratunkowego lub straży pożarnej.
	To jak chcecie żeby wyglądało wasze życie na serwerze zależy tylko od was!
]]

local diamond = [[
- Dostęp do skinów diamond
- Większy drop SP, większe zarobki o 50%
- Tańsze paliwo, tańsze naprawy
- Premia gotówki co godzine
- Chat diamond /d
- Diamentowy kolor nicku
- Wygrana w kasynie większa o 50%
- Mniejszy spadek głodu

Konto diamond możesz zakupić po otworzeniu panelu 'F4'

Tańszy zakup punktów premium za posrednictwem własciciela serwera z wykorzystaniem płatnosci
PaySafeCard/PayPal/Przelew
]]

function gui()
	dxDrawImage(screenW * 0.2174, screenH * 0.0000, screenW * 0.5659, screenH * 0.1042, ":smta_base_help/gfx/up.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * 0.2174, screenH * 0.1250, screenW * 0.5659, screenH * 0.3997, ":smta_base_help/gfx/window.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if mysz(screenW * 0.3045, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		dxDrawImage(screenW * 0.3045, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 else
		dxDrawImage(screenW * 0.3045, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 end
	 if mysz(screenW * 0.4122, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		dxDrawImage(screenW * 0.4122, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 else
		dxDrawImage(screenW * 0.4122, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 end
	 if mysz(screenW * 0.5176, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		dxDrawImage(screenW * 0.5176, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 else
		dxDrawImage(screenW * 0.5176, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 end
	 if mysz(screenW * 0.6201, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		dxDrawImage(screenW * 0.6201, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 else
		dxDrawImage(screenW * 0.6201, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508, ":smta_base_businesses/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	 end
	 dxDrawText("Informacje", screenW * 0.3053, screenH * 0.0260, screenW * 0.3792, screenH * 0.0781, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
	 dxDrawText("Przewodnik", screenW * 0.4122, screenH * 0.0260, screenW * 0.4861, screenH * 0.0781, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
	 dxDrawText("Aktualizacje", screenW * 0.5176, screenH * 0.0273, screenW * 0.5915, screenH * 0.0794, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
	 dxDrawText("Diamond", screenW * 0.6201, screenH * 0.0273, screenW * 0.6940, screenH * 0.0794, tocolor(150, 150, 150, 255), 1.00, font, "center", "center", false, false, false, false, false)
   shadowText(text, screenW * 0.2306, screenH * 0.1380, screenW * 0.7679, screenH * 0.5039, tocolor(200, 200, 200, 255), 1.00, font2, "center", "top", false, false, false, false, false)
end

bindKey("F1", "down", function()
	if showed == true then
		showed = false
		text = ""
		removeEventHandler("onClientRender", root, gui)
		showCursor(false)
		setElementData(localPlayer, "hud", false)
		showChat(true)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", true)
		setElementData(localPlayer, "player:blackwhite", false)
	else
		tick = getTickCount()
		showed = true
		showCursor(true)
		setElementData(localPlayer, "hud", true)
		showChat(false)
		triggerEvent("radar:onClientHudComponent", localPlayer, "radar", false)
		setElementData(localPlayer, "player:blackwhite", true)
		text = info
		addEventHandler("onClientRender", root, gui)
	end
end)

addEventHandler("onClientClick", root, function(b, s)
	if b ~= "state" and s ~= "down" then return end
	if showed ~= true then return end
	if mysz(screenW * 0.3045, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		text = info
	elseif mysz(screenW * 0.4122, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		text = przewodnik
	elseif mysz(screenW * 0.5176, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		local el = getElementsByType("updates")[1]
		if el then
			local aktualizacje = getElementData(el, "text")
			text = "Aktualizacje:\n"..aktualizacje
		end
	elseif mysz(screenW * 0.6201, screenH * 0.0273, screenW * 0.0747, screenH * 0.0508) then
		text = diamond
	end
end)