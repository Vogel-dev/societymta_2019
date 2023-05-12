--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function cmd_mandat(player, command, target, money, ...)
	if getElementData(player, "frakcja:sluzba") ~= "SAPD" then return false; end

	if getElementData(player, "mandat:wystawil") then
		exports['smta_base_notifications']:noti("Wystawiłeś już komuś mandat, poczekaj na jego decyzję!", player, "error");
		return false;
	end

	if not target or not money then
		exports['smta_base_notifications']:noti("Użyj: /" .. command .. " [ID Gracza] [Kwota] [Opis]", player);
		return false;
	end

	local target2 = getElementByID("p"..target);	
	if not target2 then
		exports['smta_base_notifications']:noti("Nie znaleziono takiego gracza", player, "error");
		return false;
	end

	local x1,y1,z1 = getElementPosition(player);
	local x2,y2,z2 = getElementPosition(target2);
	local dist = getDistanceBetweenPoints3D(x1,y1,z1, x2,y2,z2);
	if dist > 20 then
		exports['smta_base_notifications']:noti("Gracz jest za daleko", player, "error");
		return false;
	end

	local hajs = tonumber(money);
	if not hajs then
		exports['smta_base_notifications']:noti("Wpisana kwota jest błędna", player, "error");
		return false;
	end

	if hajs < 1 then
		exports['smta_base_notifications']:noti("Kwota mandatu musi być większa od 0", player, "error");
		return false;
	end

	local opis = table.concat({ ... }, " ");
	if not ... then
		opis = "Brak opisu";
	end

	if player == target2 then
    	exports["smta_base_notifications"]:noti("Nie możesz wystawić sobie mandatu.", player, "error")
		return
	end
	if getElementData(player, "dbid") == getElementData(target2, "dbid") then
    	exports["smta_base_notifications"]:noti("Nie możesz wystawić sobie mandatu.", player, "error")
		return
	end

	exports['smta_base_notifications']:noti("Wystawiasz graczowi " .. getPlayerName(target2) .. " mandat na kwotę " .. hajs .. " $", player);

	outputChatBox("==============================================", target2, 185, 43, 39);
	outputChatBox("#B92B27[#]#eeeeee Funkcjonariusz #B92B27" .. getPlayerName(player) .. "#eeeeee wystawia ci mandat!", target2, 230, 230, 230, true);
	outputChatBox("#B92B27[#]#eeeeee Kwota: " .. hajs .. " $", target2, 230, 230, 230, true);
	outputChatBox("#B92B27[#]#eeeeee " .. opis, target2, 230, 230, 230, true);
	outputChatBox("#B92B27[#]#eeeeee Przyjmowanie: /przyjmij  #B92B27|#eeeeee Odrzucanie: /odrzuc", target2, 185, 43, 39, true)
	outputChatBox("==============================================", target2, 185, 43, 39);

	setElementData(target2, "mandat", true, false);
	setElementData(target2, "mandat:kwota", hajs, false);
	setElementData(target2, "mandat:kto", player, false);
	setElementData(player, "mandat:wystawil", true, false);
	setElementData(target2, "mandat:opis", opis, false);

	local timer = setTimer(function ()
		setElementData(target2, "mandat", false, false);
		setElementData(target2, "mandat:kwota", false, false);
		setElementData(target2, "mandat:kto", false, false);
		setElementData(target2, "mandat:timer", false, false);
		setElementData(target2, "mandat:opis", false, false);
		setElementData(player, "mandat:wystawil", false, false);

		exports['smta_base_notifications']:noti("Mandat dla gracza " .. getPlayerName(target2) .. " wygasł", player);
	end, 30000, 1);

	setElementData(target2, "mandat:timer", timer, false);
end
addCommandHandler("mandat", cmd_mandat);

function cmd_przyjmij(player, command)
	if not getElementData(player, "mandat") then return false; end

	local kto = getElementData(player, "mandat:kto");
	local opis = getElementData(player, "mandat:opis");
	local kwota = getElementData(player, "mandat:kwota");
	local timer = getElementData(player, "mandat:timer"); 

	if getElementData(player, "pieniadze") < kwota then
		exports['smta_base_notifications']:noti("Nie stać cię na zapłatę tego mandatu", player, "error");
		exports['smta_base_notifications']:noti("Gracza nie stać na zapłacenie mandatu", kto, "error");
	else
		setElementData(player, "pieniadze", getElementData(player, "pieniadze") - kwota);
		exports['smta_base_notifications']:noti("Zapłaciłeś mandat", player);
		--exports['smta_base_notifications']:noti("Gracz " .. getPlayerName(player) .. " zapłacił mandat", kto);
		setElementData(kto, "pieniadze", getElementData(kto, "pieniadze") + kwota/4);


		local log = "dla: " .. getPlayerName(player) .. " | kwota: " .. kwota .. " | opis: " .. opis;
		exports['smta_base_db']:wykonaj("INSERT INTO smtadb_logs SET nick=?, tresc=?, serial=?, typ=?, data=?", getPlayerName(kto), log, getPlayerSerial(kto), "MANDAT", data().." "..czas());
	end

	if isTimer(timer) then killTimer(timer); end

	setElementData(player, "mandat", false, false);
	setElementData(player, "mandat:kwota", false, false);
	setElementData(player, "mandat:kto", false, false);
	setElementData(player, "mandat:opis", false, false);
	setElementData(player, "mandat:timer", false, false);
	setElementData(kto, "mandat:wystawil", false, false);
end
addCommandHandler("przyjmij", cmd_przyjmij);

function cmd_odrzuc(player, command)
	if not getElementData(player, "mandat") then return false; end

	local kto = getElementData(player, "mandat:kto");

	exports['smta_base_notifications']:noti("Odrzucasz wystawiony mandat", player);
	exports['smta_base_notifications']:noti("Gracz " .. getPlayerName(player) .. " odrzucił wystawiony mandat", kto);

	if isTimer(timer) then killTimer(timer); end

	setElementData(player, "mandat", false, false);
	setElementData(player, "mandat:kwota", false, false);
	setElementData(player, "mandat:kto", false, false);
	setElementData(player, "mandat:opis", false, false);
	setElementData(player, "mandat:timer", false, false);
	setElementData(kto, "mandat:wystawil", false, false);
end
addCommandHandler("odrzuc", cmd_odrzuc);




function data()
	local t = getRealTime()
	local r = t.year
	local m = t.month
	local t = t.monthday
	r = r+1900
	m = m+1 
	if t < 10 then
		t = "0"..t
	end
	return r.."-"..m.."-"..t
end

function czas()
	local t = getRealTime()
	local h = t.hour
	local m = t.minute
	return h..":"..m
end