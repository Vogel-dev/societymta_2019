--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEventHandler("onResourceStart", resourceRoot, function ()
	local grob_vini = createColSphere(1969.16, -1689.84, 990.03, 1);
	addEventHandler("onColShapeHit", grob_vini, enter);
	addEventHandler("onColShapeLeave", grob_vini, exit);
end);

function enter(hit, dim)
	addCommandHandler("podnies", cmd_zbadaj);
	outputChatBox("* Na podłodze leży znajoma puszka.", hit, 100, 100, 100);
end

function exit(hit, dim)
	removeCommandHandler("podnies", cmd_zbadaj);
end

function cmd_zbadaj(plr, cmd)
	local odkryl = getElementData(plr, "odkryl_grob") or 0;

	if odkryl == 0 then
		setElementData(plr, "odkryl_grob", 1);
		exports['smta_base_db']:wykonaj("UPDATE smtadb_accounts SET odkryl_grob=1 WHERE dbid=?", getElementData(plr, "dbid"));

		triggerEvent("odegrajRp:eq", plr, plr, "#4343ff*"..getPlayerName(plr).." podnosi justcole i wypija.");

		--outputChatBox("== Rest In Piece", plr, 150, 150, 150);
		outputChatBox("== Ostatnia puszka JustColi", plr, 150, 150, 150);
		outputChatBox("== Ostatnio widziana 2 lata temu", plr, 150, 150, 150);

		local punkty = getElementData(plr, "punkty");
		setElementData(plr, "punkty", punkty + 250);

		exports['smta_base_notifications']:noti("Za znalezienie ostatniej puszki JustColi otrzymujesz 250 SP", plr);
	end
end