--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function init()
    local biznesy = exports['smta_base_db']:wykonaj("select smtadb_businesses.id,smtadb_businesses.owner,smtadb_businesses.cost,smtadb_businesses.zajety,smtadb_businesses.nazwa,smtadb_businesses.saldo,smtadb_businesses.xyz,smtadb_businesses.data,smtadb_accounts.login from smtadb_businesses LEFT JOIN smtadb_accounts on smtadb_businesses.owner=smtadb_accounts.dbid")
    for i,v in ipairs(biznesy) do
		stworz(v)
    end
end

local pickup = {}

local bramy = {}

function stworz(v)
	if not v.login then v.zajety="n" end
	v.xyz=split(v.xyz,",")
	biz = createPickup ( v.xyz[1], v.xyz[2], v.xyz[3], 3, 1274, 0 )
	local biz2 = biz
	local tw=createElement("text")
	local x2342=v.cost/16000
	local x234 = math.floor(x2342)
	local jebany = math.floor(v.cost/6)
	if v.zajety == "n" then v.login = "Brak własciciela";v.data="Nie posiada własciciela" end
	local profir1 = math.floor(x234*60*6)
	local format1 = ("Biznes: "..v.nazwa.."\nKoszt: "..v.cost.." $\nWłasciciel: "..v.login.."\nWykupiony do: "..v.data.."\nPotencjalny dochód na godzinę: "..profir1.." $")
	setElementData(tw, "text", format1)
	setElementPosition(tw, v.xyz[1], v.xyz[2], v.xyz[3]+0.8)
	setElementData(biz2, "cost", v.cost)
	setElementData(biz2, "z", v.zajety)
	setElementData(biz2, "name", v.nazwa)
	setElementData(biz2, "id", v.id)
	setElementData(biz2, "payday",x234)
	setElementData(biz2, "saldo",v.saldo)
	setElementData(biz2,"data",v.data)
	setElementData(biz2, "owner", v.owner)
end

function sprzedajbiznes(plr)
	if isElementWithinColShape(plr, getElementColShape(pickup[plr])) then
		local biz2 = pickup[plr]
		if getElementData(biz2, "z") == "n" then exports["smta_base_notifications"]:noti("Ten biznes posiada właściciela!", plr, "error") return end
		if tonumber(getElementData(biz2, "owner")) ~= tonumber(getElementData(plr, "dbid")) then exports["smta_base_notifications"]:noti("Ten biznes nie należy do Ciebie!", plr, "error") return end
		local cashit = getElementData(biz2, "cost")
		local lasthit2 = cashit/4
		local lasthit = math.floor(lasthit2)
		exports["smta_base_notifications"]:noti("Otrzymujesz "..lasthit.." $ za sprzedaż swojego biznesu "..getElementData(biz2, "name").."", plr)
		setElementData(plr, "pieniadze", getElementData(plr, "pieniadze")+lasthit)
		exports['smta_base_db']:wykonaj("UPDATE smtadb_businesses SET owner=?, zajety=?, saldo=0 WHERE id=?","brak", "n", getElementData(biz2, "id"))
		restartResource(getThisResource())
	end
end
addEvent("sprzedaj:biznesy", true)
addEventHandler("sprzedaj:biznesy", root, sprzedajbiznes)

function kupbiznes(plr)
	if isElementWithinColShape(plr, getElementColShape(pickup[plr])) then
		local biz2 = pickup[plr]
		if getElementData(biz2, "z") == "t" then exports["smta_base_notifications"]:noti("Ten biznes ma już właściciela!", plr, "error") return end
		if getElementData(biz2, "z") == "n" then
			local bkoszt = getElementData(biz2, "cost")
			local hajs = getElementData(plr, "pieniadze")
			if tonumber(bkoszt) > tonumber(hajs) then exports["smta_base_notifications"]:noti("Nie posiadasz "..getElementData(biz2, "cost").." $", plr, "error") return end
			local limit = exports['smta_base_db']:wykonaj("SELECT * FROM smtadb_businesses WHERE owner=?", getElementData(plr,"dbid"))
			if #limit >= 2 then exports["smta_base_notifications"]:noti("Posiadasz 2 biznesy, osiągnąles limit.", plr, "error") return end
			exports["smta_base_notifications"]:noti("Pomyślnie zakupiłeś biznes o nazwie "..getElementData(biz2, "name").." za "..getElementData(biz2, "cost").." $ na 3 dni!", plr)
			setElementData(plr, "pieniadze", hajs-getElementData(biz2, "cost"))
			exports['smta_base_db']:wykonaj("UPDATE smtadb_businesses SET zajety=?, owner=?, saldo=?, data = NOW() + INTERVAL 3 day WHERE id=?", "t", getElementData(plr, "dbid"), "0", getElementData(biz2, "id"))
			restartResource(getThisResource())
		end
	end
end
addEvent("kup:biznesy", true)
addEventHandler("kup:biznesy", root, kupbiznes)


function wyplac(plr)
	if isElementWithinColShape(plr, getElementColShape(pickup[plr])) then
		local biz2 = pickup[plr]
		if getElementData(biz2, "z") == "n" then exports["smta_base_notifications"]:noti("Ten biznes posiada właściciela!", plr, "error") return end
		if tonumber(getElementData(biz2, "owner")) ~= tonumber(getElementData(plr, "dbid")) then exports["smta_base_notifications"]:noti("Ten biznes nie należy do Ciebie!", plr, "error") return end
		local sal = exports['smta_base_db']:wykonaj("select saldo from smtadb_businesses where id=?",getElementData(biz2,"id"))
		local saldo = sal[1].saldo
		if saldo < 1 then exports["smta_base_notifications"]:noti("Aby wypłacić pieniądze z biznesu saldo musi być większę niż 1 $", plr, "error") return end
		setElementData(plr, "pieniadze", getElementData(plr, "pieniadze")+saldo)
		exports["smta_base_notifications"]:noti("Wypłacileś "..saldo.. " $ z biznesu!", plr)
		exports['smta_base_db']:wykonaj("update smtadb_businesses set saldo=0 where id=?", getElementData(biz2,"id"))
		restartResource(getThisResource())
	end
end
addEvent("wyplac:biznesy", true)
addEventHandler("wyplac:biznesy", root, wyplac)

function wbil ( hitElement )
	if getElementType(hitElement) ~= "player" then return end
	if getPedOccupiedVehicle(hitElement) then return end
	pickup[hitElement] = source
	local biznes = source
	--if getElementData(biznes, "z") == "n" then exports["smta_base_notifications"]:noti("Ten biznes nie ma właściciela, aby go zakupić wpisz /biznes.kup", hitElement, 255, 255, 255) return end
	local uid = getElementData(hitElement, "dbid")
	local wlasciciel = getElementData(biznes, "owner")
	local nazwa = getElementData(biznes, "name")
	local id = getElementData(biznes, "id")
	local koszt = getElementData(biznes, "cost")
	local saldo = getElementData(biznes, "saldo")
	local data = getElementData(biznes,"data")
	--local sal = exports['smta_base_db']:wykonaj("select data from smtadb_businesses where data < NOW() and id=?",getElementData(biznes,"id"))
	--if sal and #sal > 0 then exports['smta_base_db']:wykonaj("UPDATE smtadb_businesses SET owner=?,zajety=? WHERE data < NOW() and id=?","brak","n",getElementData(biznes,"id")) outputChatBox("Biznes zwolniony poniewaz nie zostal oplacony w czasie !",hitElement);restartResource(getThisResource()) return end
	--if tonumber(uid) ~= tonumber(wlasciciel) then exports["smta_base_notifications"]:noti("Ten biznes jest już zajęty!", hitElement, 255, 255, 255) return end
	triggerClientEvent("gui:otworz", hitElement, hitElement, wlasciciel, nazwa, id, koszt,saldo,data)
end
addEventHandler ( "onPickupHit", resourceRoot, wbil )


function cmd(plr,cmd,cost,...)
if getElementData(plr, "duty") > 3 then
 if not tonumber(cost) or #arg == 0 then
  outputChatBox("Użycie: /biznes.stworz <koszt> <nazwa>", plr, 32, 75, 155)
  return
 end
local x,y,z=getElementPosition(plr)
local name2 = table.concat(arg, " ")
outputChatBox("Pomyślnie utworzyłeś nowy biznes o nazwie "..name2.." za "..cost.." $", plr, 32, 75, 155)
exports['smta_base_db']:wykonaj("INSERT INTO smtadb_businesses SET owner=?, xyz='?,?,?', cost=?, nazwa=?, zajety=?", "brak",x,y,z,tonumber(cost),tostring(name2),"n")
restartResource(getThisResource())
end
end
addCommandHandler("biznes.stworz", cmd)



function cmd4(plr,cmd,...)
if getElementData(plr, "duty") > 3 then
 if #arg == 0 then
  outputChatBox("Użycie: /biznes.stworz <nazwa>", plr, 32, 75, 155)
  return
 end
 local cost = math.random(8000,14000)
local x,y,z=getElementPosition(plr)
local name2 = table.concat(arg, " ")
outputChatBox("Pomyślnie utworzyłeś nowy biznes o nazwie "..name2.." za "..cost.." $", plr, 32, 75, 155)
exports['smta_base_db']:wykonaj("INSERT INTO smtadb_businesses SET owner=?, xyz='?,?,?', cost=?, nazwa=?, zajety=?",
"brak",x,y,z,tonumber(cost),tostring(name2),"n")
restartResource(getThisResource())
end
end
addCommandHandler("biznes.auto", cmd4)

function oplac(plr)
	if isElementWithinColShape(plr, getElementColShape(pickup[plr])) then
		local biz2 = pickup[plr]
		if getElementData(biz2, "z") == "n" then exports["smta_base_notifications"]:noti("Ten biznes nie posiada właściciela!", plr, "error") return end
		if tonumber(getElementData(biz2, "owner")) ~= tonumber(getElementData(plr, "dbid")) then exports["smta_base_notifications"]:noti("To nie jest twój biznes!", plr, "error") return end
		local sal = exports['smta_base_db']:wykonaj("select data from smtadb_businesses where data < NOW() and id=?",getElementData(biz2,"id"))
		if sal and #sal > 0 then exports["smta_base_notifications"]:noti("Ten biznes juz nie nalezy do ciebie spozniles sie !", plr, "error"); restartResource(getThisResource()) return end
		local bkoszt=getElementData(biz2, "cost")
		local kwota = math.floor(bkoszt)
		local saldo = getElementData(plr, "pieniadze")
		local brakuje = kwota - saldo
		if saldo < kwota then exports["smta_base_notifications"]:noti("Nie stać cię na opłacenie biznesu", plr, "error") return end
		exports['smta_base_db']:wykonaj("update smtadb_businesses set data=data + INTERVAL 3 day where id=?",getElementData(biz2,"id"))
		setElementData(plr, "pieniadze", saldo-kwota)
		exports["smta_base_notifications"]:noti("Przedluzyles biznes o 3 dni!", plr)
		restartResource(getThisResource())
	end
end
addEvent("oplac:biznesy", true)
addEventHandler("oplac:biznesy", root, oplac)

addEventHandler("onResourceStart",resourceRoot,function()
	exports['smta_base_db']:wykonaj("UPDATE smtadb_businesses SET owner=?,zajety=? WHERE data < NOW()","brak","n")
	setTimer(init,3000,1)
end)

local czas_restartu = 60*60*1000
setTimer(function()
for i,p in pairs(getElementsByType('pickup')) do
 if #getElementsWithinColShape(getElementColShape(p)) > 0 then return end
end
restartResource(getThisResource())
end,czas_restartu,0)


local minut = 1
function sypnijmu()
	local marker = getElementsByType("pickup")
	for _,m in ipairs(marker) do
		if getElementData(m, "owner") then
			local wyplata= getElementData(m, "payday")
			exports['smta_base_db']:wykonaj("UPDATE smtadb_businesses SET saldo=saldo+?? WHERE id=?", wyplata, getElementData(m,"id"))
		end
	end
end
setTimer(sypnijmu,5000*minut,0)