--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function playerAFK(x,y,z,x2,y2,z2)
	if y-0.5 < y2 and y+0.5 > y2 and x-0.5 < x2 and x+0.5 > x2 and z-0.5 < z2 and z+0.5 > z2 then 
		return true 
	else
		return false 
	end
end

setElementData(localPlayer,"Anti-AFK",0)
setTimer(function()
	if getElementData(localPlayer,"duty") > 2 then return end
	local x,y,z = getElementPosition(localPlayer)
	local x,y,z = math.floor(x),math.floor(y),math.floor(z)
	if getElementData(localPlayer,"AFK:pos") then
		local x2,y2,z2 = getElementData(localPlayer,"AFK:pos")[1],getElementData(localPlayer,"AFK:pos")[2],getElementData(localPlayer,"AFK:pos")[3]
		if playerAFK(x,y,z,x2,y2,z2) then
			local numer = getElementData(localPlayer,"Anti-AFK") or 0
			setElementData(localPlayer,"Anti-AFK",numer+1)
			if numer ~= 0 then
				if numer == 24 then
					outputChatBox("[AFK]",255,0,0)
					outputChatBox("Prawdopodobnie jesteś AFK! Rusz się, albo zostaniesz wyrzucony z serwera! (Ostrzeżenie 1 / 5)",255,0,0)
					outputChatBox("[AFK]",255,0,0)
				elseif numer == 48 then
					outputChatBox("[AFK]",255,0,0)
					outputChatBox("Prawdopodobnie jesteś AFK! Rusz się, albo zostaniesz wyrzucony z serwera! (Ostrzeżenie 2 / 5)",255,0,0)
					outputChatBox("[AFK]",255,0,0)
				elseif numer == 72 then
					outputChatBox("[AFK]",255,0,0)
					outputChatBox("Prawdopodobnie jesteś AFK! Rusz się, albo zostaniesz wyrzucony z serwera! (Ostrzeżenie 3 / 5)",255,0,0)
					outputChatBox("[AFK]",255,0,0)
				elseif numer == 96 then
					outputChatBox("[AFK]",255,0,0)
					outputChatBox("Prawdopodobnie jesteś AFK! Rusz się, albo zostaniesz wyrzucony z serwera! (Ostrzeżenie 4 / 5)",255,0,0)
					outputChatBox("[AFK]",255,0,0)
				elseif numer == 120 then
					outputChatBox("[AFK]",255,0,0)
					outputChatBox("Prawdopodobnie jesteś AFK! Rusz się, albo zostaniesz wyrzucony z serwera! (Ostrzeżenie 5 / 5)",255,0,0)
					outputChatBox("[AFK]",255,0,0)
					outputChatBox("Zostajesz wywalony z powodu AFK!")
					triggerServerEvent("kickPlayer",localPlayer,localPlayer)
				end
			end
		else
			setElementData(localPlayer,"Anti-AFK",0)
		end
	end
	setElementData(localPlayer,"AFK:pos",{x,y,z})
end,5000,0)
