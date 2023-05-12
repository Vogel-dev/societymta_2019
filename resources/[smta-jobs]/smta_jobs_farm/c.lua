--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local info_1 = " "
local info_2 = " "
local dozasiania = 0
local dosciecia = 0
local bele = 0
local ulepszenia = false
local sieje = false
local mabele = false
local mozesiac = false
local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local x2, y2, z2 = " "

local blip = createBlip(-1199.08, -1071.92, 129.13, 52)
setBlipVisibleDistance(blip, 300)


local rzecz1 = { }
local rzecz2 = { }
local rzecz3 = { }
local rzecz4 = { }
local rzecz5 = { }

local pracodawca = createPed(158, -1199.08, -1071.92, 129.13, 90)
setElementData(pracodawca, "name", "Pracodawca\nWilly Bęcwał")
setElementDimension(pracodawca, 0)
setElementFrozen(pracodawca, true)
local rozpoczecie = createMarker(-1200.80, -1071.89, 128.85-.95, "cylinder", 1.5, 59, 122, 87, 100)
setElementData(rozpoczecie, "sprzedaz", true)
setElementDimension(rozpoczecie, 0)

addEventHandler("onClientMarkerHit", rozpoczecie, function(gracz)
    if gracz ~= localPlayer then return end
    if getPedOccupiedVehicle(localPlayer) then return end
    if getElementData(localPlayer, "punkty") < 150 then exports["smta_base_notifications"]:noti("Nie posiadasz 150 SP!", "error") return end
    addEventHandler("onClientRender", root, guistart)
    okno1 = true
    showCursor(true)
    triggerServerEvent("pokazTopke:farma:source", localPlayer)
end)

local font = dxCreateFont("cz.ttf", 12)
local font2 = dxCreateFont("cz.ttf", 14)

local pracownicy = { }

local listaulepszen = {
	{"Szybsze sadzenie", "", 100, "farmer.png"},
    {"Zarobek +25%", "", 300, "farmer.png"},
}


function guistart()
    if ulepszenia == false then
	   local punkty = getElementData(localPlayer, "fpunkty") or 0
	   local zlecenia = getElementData(localPlayer, "fzlecenia") or 0
	    dxDrawImage(screenW * 0.2592, screenH * 0.2839, screenW * 0.4824, screenH * 0.4323, ":smta_jobs_farm/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Kursy: "..zlecenia.."\nPunkty: "..punkty.."", screenW * 0.2701, screenH * 0.5924, screenW * 0.3843, screenH * 0.6445, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        if mysz(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443) then
    	   dxDrawImage(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443, ":smta_jobs_tram/gfx/button_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
    	   dxDrawImage(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443, ":smta_jobs_tram/gfx/button_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443) then
    	   dxDrawImage(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443, ":smta_jobs_tram/gfx/button_on2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
    	   dxDrawImage(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443, ":smta_jobs_tram/gfx/button_off2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        if mysz(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247) then
			dxDrawImage(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 else
			dxDrawImage(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 end

        for i, v in ipairs(pracownicy) do
    	   local dodatekY2 = (scale_y(87))*(i-1)

    	   dxDrawText(v.nick, screenW * 0.5300, screenH * 0.4766 + dodatekY2, screenW * 0.6537, screenH * 0.5091, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
           dxDrawText(v.liczba, screenW * 0.6611, screenH * 0.4766+ dodatekY2, screenW * 0.7160, screenH * 0.5091, tocolor(150, 150, 150, 255), 1.00, font2, "left", "center", false, false, false, false, false)
        end
    else
		local punkty = getElementData(localPlayer, "fpunkty") or 0
		dxDrawImage(screenW * 0.2855, screenH * 0.2773, screenW * 0.4297, screenH * 0.3008, ":smta_jobs_farm/gfx/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if mysz(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247) then
			dxDrawImage(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_on.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 else
			dxDrawImage(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247, ":smta_veh_stations/gfx/close_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		 end
        dxDrawText("Posiadasz "..punkty.." punktów pracy jako farmer.", screenW * 0.2862, screenH * 0.4818, screenW * 0.7152, screenH * 0.5703, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        for i, v in ipairs(listaulepszen) do
            local dodatekY = (scale_y(68))*(i-1)
            if mysz(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443) then
                dxDrawImage(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443, ":smta_jobs_tram/gfx/button_on3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443, ":smta_jobs_tram/gfx/button_off3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
    end
end

addEventHandler("onClientClick", root, function(btn, state)
  if btn == "left" and state == "down" then
    if mysz(screenW * 0.2701, screenH * 0.6523, screenW * 0.1142, screenH * 0.0443) and okno1 == true and ulepszenia == false then
    	if getElementData(localPlayer, "pracuje") == "farma" then
    		zakonczprace()
    	else
    		rozpocznijprace()
    	end
    elseif mysz(screenW * 0.3946, screenH * 0.6523, screenW * 0.0769, screenH * 0.0443) and okno1 == true and ulepszenia == false then
    	ulepszenia = true
    elseif mysz(screenW * 0.7233, screenH * 0.2969, screenW * 0.0110, screenH * 0.0247) and okno1 == true and ulepszenia == false then
    	removeEventHandler("onClientRender", root, guistart)
		okno1 = false
		showCursor(false)
    elseif mysz(screenW * 0.6969, screenH * 0.2904, screenW * 0.0110, screenH * 0.0247) and okno1 == true and ulepszenia == true then
        ulepszenia = false
    end
    for i, v in ipairs(listaulepszen) do
        local dodatekY = (scale_y(72))*(i-1)
        if mysz(screenW * 0.6464, screenH * 0.3490+dodatekY, screenW * 0.0483, screenH * 0.0443) and okno1 == true and ulepszenia == true then
            local punkty = getElementData(localPlayer, "fpunkty") or 0
            if punkty < tonumber(v[3]) then exports["smta_base_notifications"]:noti("Posiadasz za mało punktów by zakupić to ulepszenie", "error") return end
            if v[1] == "Szybsze sadzenie" then 
                if getElementData(localPlayer, "farma:ulepszenie1") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już to ulepszenie", "error") return end
                setElementData(localPlayer, "farma:ulepszenie1", 1)
            elseif v[1] == "Zarobek +25%" then
                if getElementData(localPlayer, "farma:ulepszenie2") == 1 then exports["smta_base_notifications"]:noti("Posiadasz już to ulepszenie", "error") return end
                setElementData(localPlayer, "farma:ulepszenie2", 1)
            end
            exports["smta_base_notifications"]:noti("Zakupujesz ulepszenie: "..v[1])
            setElementData(localPlayer, "fpunkty", punkty-tonumber(v[3]))
        end
    end
  end
end)

addEvent("pokazTopke:farma:client", true)
addEventHandler("pokazTopke:farma:client", root, function(tabelka)
  pracownicy = tabelka
end)

-- praca

local nasionka = { }

function rozpocznijprace()
	--local spr = exports["smta_base_db"]:wykonaj("SELECT * FROM smtadb_licences WHERE serial=?", getPlayerSerial(localPlayer))
     --if #spr > 0 then exports["smta_base_notifications"]:noti("Posiadasz zawieszone prawo jazdy kat. A,B,C do "..spr[1].data.." zabrane przez "..spr[1].admin, localPlayer) return end
    triggerServerEvent("spr:prawko", localPlayer)
	--if getElementData(localPlayer, "prawko_c") ~= 1 then exports["smta_base_notifications"]:noti("Nie posiadasz prawa jazdy kat. C", "error") return end
	if getElementData(localPlayer, "punkty") < 150 then exports["smta_base_notifications"]:noti("Nie posiadasz 150 SP!", "error") return end
	setElementData(localPlayer, "pracuje", "farma")
	exports["smta_base_notifications"]:noti("Rozpoczynasz prace na farmie (sadzenie = lewy myszki)")
	addEventHandler("onClientRender", root, infogui)
	removeEventHandler("onClientRender", root, guistart)
	triggerEvent("ghost:vehicleWITHplayer", localPlayer, true)
    okno1 = false
	showCursor(false)
	dozasiania = 20
	info_1 = "Aktualne zadanie: Zasiej pole."
	info_2 = "Pozostało Ci do zasadzenia "..dozasiania.." nasion."
	x2, y2, z2 = -1196.29, -1069.05, 129.22
	pole = createColPolygon(-1114.30, -1006.11, -1195.26, -1064.44, -1160.55, -1061.40, -1127.00, -1060.80, -1091.86, -1061.32, -1007.53, -1061.35, -1006.12, -1034.55, -1005.27, -972.39, -1006.64, -915.87, -1047.32, -915.24, -1171.46, -921.43, -1190.67, -930.54, -1194.15, -976.65, -1195.18, -1064.47)
	addEventHandler("onClientColShapeHit", pole, function(gracz)
		if gracz ~= localPlayer then return end
		mozesiac = true
	end)
	addEventHandler("onClientColShapeLeave", pole, function(gracz)
		if gracz ~= localPlayer then return end
		mozesiac = false
	end)
end

function zakonczprace(cos)
	if cos == true then
		setTimer(function()
			setElementPosition(localPlayer, -1195.48, -1073.15, 129.22)
		end, 200, 1)
	end
	nasionka = { }
	setElementData(localPlayer, "pracuje", false)
	exports["smta_base_notifications"]:noti("Zakończyłes prace")
	removeEventHandler("onClientRender", root, infogui)
	triggerEvent("ghost:vehicleWITHplayer", localPlayer)
	for i, v in ipairs(rzecz1) do
    	if isElement(v[1]) then
    		destroyElement(v[1])
    	end
    end
    for i, v in ipairs(rzecz2) do
    	if isElement(v[1]) then
    		destroyElement(v[1])
    	end
    end
    for i, v in ipairs(rzecz3) do
    	if isElement(v[1]) then
    		destroyElement(v[1])
    	end
    end
    for i, v in ipairs(rzecz4) do
    	if isElement(v[1]) then
    		destroyElement(v[1])
    	end
    end
    for i, v in ipairs(rzecz5) do
    	if isElement(v[1]) then
    		destroyElement(v[1])
    	end
    end
    if isElement(pole) then
    	destroyElement(pole)
    end
    if isElement(stodola) then
    	destroyElement(stodola)
    end
    if isElement(bstodola) then
    	destroyElement(bstodola)
    end
    rzecz1 = { }
	rzecz2 = { }
	rzecz3 = { }
	rzecz4 = { }
	rzecz5 = { }
	triggerServerEvent("usunPojazdy:farma", localPlayer)
end

bindKey("mouse1", "down", function()
	if getElementData(localPlayer, "pracuje") ~= "farma" or dozasiania <= 0 then return end
	if sieje == true then return end
	if mozesiac == false then exports["smta_base_notifications"]:noti("Nie możesz tutaj zasiać zboża", "error") return end
	moszna = true
	if #nasionka > 0 then
		for i,v in ipairs(nasionka) do
			if moszna == false then return end
			local x, y, z = getElementPosition(localPlayer)
			local distance = getDistanceBetweenPoints3D(x, y, z, v[1], v[2], v[3])
			if distance < 10 then
				exports["smta_base_notifications"]:noti("Jesteś zbyt blisko wczesniejszego miejsca siania", "error")
				moszna = false
			end
		end
	end

	if moszna ~= false then 
		--exports["smta_base_notifications"]:noti("Rozpoczynasz sianie zboża")
		sieje = true
		triggerServerEvent("animacja:siania", localPlayer, true)
		czas = 2500
		if getElementData(localPlayer, "farma:ulepszenie1") == 1 then
			czas = 1250
		end
		setTimer(function()
			local x, y, z = getElementPosition(localPlayer)
			sieje = false
			triggerServerEvent("animacja:siania", localPlayer)
			dozasiania = dozasiania-1
			info_2 = "Pozostało Ci do zasadzenia "..dozasiania.." nasion."
			--exports["smta_base_notifications"]:noti("Zboże zostało zasiane udaj się dalej")
			x2, y2, z2 = x, y, z
			table.insert(nasionka, {x, y, z})
			if dozasiania == 0 then
				uroslynasiona()
			end
		end, czas, 1)
	end
end)

function uroslynasiona()
	dosciecia = #nasionka
	--exports["smta_base_notifications"]:noti("Zetnij zboże")
	triggerEvent("ghost:vehicleWITHplayer", localPlayer)
	for i, v in ipairs(nasionka) do
		marker = createMarker(v[1], v[2], v[3], "corona", 3.5, 255, 0, 0, 0)
		obj1 = createObject(818, v[1], v[2], v[3]-1)
		setElementData(marker, "zboze", obj1)
		table.insert(rzecz1, {marker})
		table.insert(rzecz2, {obj1})
		addEventHandler("onClientMarkerHit", marker, function(gracz)
			if gracz ~= localPlayer then return end
			if not getPedOccupiedVehicle(localPlayer) then return end
			local x, y, z = getElementPosition(source)
			stworzBele(x, y, z)
			destroyElement(getElementData(source, "zboze"))
			destroyElement(source)
			dosciecia = dosciecia - 1
			info_2 = "Pozostało Ci do scięcia "..dosciecia.." żbóża."
			if dosciecia == 0 then
				triggerServerEvent("dajForklift:farma", localPlayer)
				stodola = createMarker(-1185.39, -1129.94, 129.22-1.95, "cylinder", 3.5, 127, 255, 212, 50)
				bstodola = createBlipAttachedTo(stodola, 12)
				bele = 20
				--exports["smta_base_notifications"]:noti("Zbierz belki siana i odwieź do stodoły")
				info_1 = "Aktualne zadanie: Zawieź snopy siana."
				info_2 = "Pozostało Ci co zawiezienia "..bele.." snopów."
				addEventHandler("onClientMarkerHit", stodola, function(gracz)
					if gracz ~= localPlayer then return end
					if mabele == true then
						local veh = getPedOccupiedVehicle(localPlayer)
						destroyElement(getElementData(veh, "bela"))
						mabele = false
						bele = bele-1
						info_2 = "Pozostało Ci co zawiezienia "..bele.." snopów."
						local los = math.random(0, 2)
						local pkt = getElementData(localPlayer, "fpunkty") or 0
						setElementData(localPlayer, "fpunkty", pkt+los)
						local zarobek = math.random(270, 300)
						if getElementData(localPlayer, "premium") then
							zarobek =  zarobek+(zarobek*0.50)
						end
						if getElementData(localPlayer, "farma:ulepszenie2") == 1 then
							zarobek = zarobek + zarobek*1.25
						end
						exports["smta_base_notifications"]:noti("Za odwieziony snop zarabiasz: "..zarobek.." $")
						setElementData(localPlayer, "pieniadze", getElementData(localPlayer, "pieniadze")+zarobek)
						if bele == 0 then
							zakonczprace(true)
							triggerServerEvent("daj:fzlecenia", localPlayer, localPlayer)
						end
					end
				end)
			end
		end)
	end
	nasionka = { }
	info_1 = "Aktualne zadanie: Wykoś zboże"
	info_2 = "Pozostało Ci co wykoszenia "..bele.." zboża."
	triggerServerEvent("dajBizon:farma", localPlayer)
end

function stworzBele(x,y,z)
	marker2 = createMarker(x, y, z, "corona", 2, 0,0,0,0)
	bela = createObject(1454, x, y, z-0.5)
	blip = createBlipAttachedTo(bela, 41)
	table.insert(rzecz3, {marker2})
	table.insert(rzecz4, {bela})
	table.insert(rzecz5, {blip})
	setElementData(marker2, "bela", bela)
	setElementData(marker2, "blip", blip)
	setElementCollisionsEnabled(bela, false)
	addEventHandler("onClientMarkerHit", marker2, function(gracz)
		if gracz ~= localPlayer then return end
		if mabele == true then return end
		local veh = getPedOccupiedVehicle(localPlayer)
		if not veh then return end
		local id = getElementModel(veh)
		if id == 530 then
			attachElements(getElementData(source, "bela"), veh, -0.014,1.039,-0.041)
			setElementData(veh, "bela", getElementData(source, "bela"))
			destroyElement(getElementData(source, "blip"))
			destroyElement(source)
			mabele = true
		end
	end)
end

function infogui()
	dxDrawImage(screenW * 0.0146, screenH * 0.6250, screenW * 0.1947, screenH * 0.0885, ":smta_jobs_farm/gfx/bg3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    shadowText(info_1, screenW * 0.0146, screenH * 0.6263, screenW * 0.2094, screenH * 0.6706, tocolor(150, 150, 150, 255), 1.00, font2, "center", "center", false, false, false, false, false)
    shadowText(info_2, screenW * 0.0146, screenH * 0.6706, screenW * 0.2094, screenH * 0.7148, tocolor(150, 150, 150, 255), 1.00, font, "center", "top", false, false, false, false, false)
end

--opcje

function shadowText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x+1,y+1,w+1,h+1,tocolor(0,0,0),size,font,xx,yy,x1,x2,x3,x4,x5)
	dxDrawText(text,x,y,w,h,color,size,font,xx,yy,x1,x2,x3,x4,x5)
end

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function scale_x(value)
    local result = (value / 1440) * sx

    return result
end

function scale_y(value)
    local result = (value / 900) * sy

    return result
end

addEvent("praca:moze", true)
addEventHandler("praca:moze", root, function()
    moze = true
end)