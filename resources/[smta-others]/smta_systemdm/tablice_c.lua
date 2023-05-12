--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

bronieFire = {
 -- Bronie z których można strzelac / robić zdjęcia .. ITD
[23] = true, -- Paralizator
[24] = true, -- Deagle
[38] = true, -- Minigun
[41] = true, -- Spray
[42] = true, -- Gaśnica
[46] = true, -- Aparat
[35] = true, -- Dildo
[9] = true, -- Dildo
[43] = true, -- Camera
[25] = true, -- ShotGun
[8] = true, -- siekiera
[16] = true, -- granat
[34] = true, -- Dildo
[30] = true, -- ak
[3] = true, -- ak
[5] = true, -- ak
[31] = true, -- ak
[36] = true, -- ak
[4] = true, -- noz
[28] = true, -- uzi
[39] = true, -- bomba
[40] = true, -- detonator
[1] = true, -- kastet
[37] = true, -- ogien
[18] = true, -- molotiov
[26] = true, -- obrzyn
[27] = true, -- bojowa


}
bronieAim = {
-- Bronie z
[22] = true, -- Suszarka
--[28] = true, -- SuszarkaPol
}

bronieSkin = {
[284]={[31]=true,[29]=true,[25]=true,[3]=true},
[285]={[31]=true,[29]=true,[25]=true,[3]=true},
[286]={[31]=true,[29]=true,[25]=true,[3]=true},
[247]={[0]=true},
[201]={[42]=true},
[277]={[42]=true},
[278]={[42]=true},
[279]={[42]=true},
}


local isDm = true
local strefaDM = createColCuboid(90,-2901,-100,2900,2500,240) -- CAŁE LS
local strefaDM = createColCuboid(2230.2880859375,-1721.671875,13.56-25, 394,89,70) -- GROVE STREET LS


addEventHandler("onClientRender",root,function()
	if bronieAim[getPedWeapon(localPlayer)] and not isPedInVehicle(localPlayer) then
		toggleControl("aim_weapon",true)
		toggleControl("fire",false)
		toggleControl("action",false)
	elseif isCursorShowing() then
		toggleControl("action",false)
		toggleControl("fire",false)
		toggleControl("aim_weapon",false)
	elseif bronieSkin[getElementModel(localPlayer)] and bronieSkin[getElementModel(localPlayer)][getPedWeapon(localPlayer)] == true then
		--toggleControl("vehicle_fire",true)
		toggleControl("fire",true)
		toggleControl("aim_weapon",true)
		--toggleControl("vehicle_secondary_fire",true)
		toggleControl("action",true)
	elseif isElementInWater(localPlayer) then -- żeby gracz mógł nurkować
		toggleControl("fire",true)
		toggleControl("aim_weapon",true)
		toggleControl("action",true)
	elseif bronieFire[getPedWeapon(localPlayer)] then
		toggleControl("fire",true)
		toggleControl("aim_weapon",true)
		toggleControl("action",true)
	elseif getElementData(localPlayer, "dmstatus") == "on" then
		--toggleControl("vehicle_fire",true)
		toggleControl("fire",true)
		toggleControl("aim_weapon",true)
		--toggleControl("vehicle_secondary_fire",true)
		toggleControl("action",true)
	elseif isDm and getElementData(localPlayer,"strefaDM")  then
		--toggleControl("vehicle_fire",true)
		toggleControl("fire",true)
		toggleControl("aim_weapon",true)
		--toggleControl("vehicle_secondary_fire",true)
		toggleControl("action",true)
	elseif getElementData(localPlayer,"dmstatus") == "on" or getElementData(localPlayer,"driveBy") then
		--toggleControl("vehicle_fire",true)
		toggleControl("fire",true)
		toggleControl("aim_weapon",true)
		--toggleControl("vehicle_secondary_fire",true)
		toggleControl("action",true)
	elseif isPedInVehicle(localPlayer) then
		local veh=getPedOccupiedVehicle(localPlayer)
		if veh and getElementModel(veh)==4999 and tonumber(getElementData(veh,"zapelnienie:wody")) > 100 then
			--toggleControl("vehicle_fire",true)
			toggleControl("fire",true)
			toggleControl("aim_weapon",true)
			--toggleControl("vehicle_secondary_fire",true)
			toggleControl("action",true)
		else
			if getElementData(localPlayer,"dmstatus") == "on" or getElementData(localPlayer,"driveBy") then
				--toggleControl("vehicle_fire",true)
				toggleControl("fire",true)
				toggleControl("aim_weapon",true)
				--toggleControl("vehicle_secondary_fire",true)
				toggleControl("action",true)
			else
				--toggleControl("vehicle_fire",false)
				toggleControl("fire",false)
				toggleControl("aim_weapon",false)
				--toggleControl("vehicle_secondary_fire",false)
				toggleControl("action",true)
			end
		end
			toggleControl("aim_weapon",true)
			toggleControl("fire",false)
			toggleControl("action",false)
		else
			--toggleControl("vehicle_fire",false)
			toggleControl("fire",false)
			toggleControl("aim_weapon",false)
			--toggleControl("vehicle_secondary_fire",false)
			toggleControl("action",false)
	end
end)


setElementData(localPlayer,"strefaDM",false)
addEventHandler("onClientColShapeHit",resourceRoot,function()
	if isDm and not getElementData(localPlayer,"strefaDM") and getElementDimension(localPlayer) == 0 and getElementInterior(localPlayer) == 0 and source == strefaDM and isElementWithinColShape(localPlayer,strefaDM) and getElementData(localPlayer,"sid") then
		setElementData(localPlayer,"strefaDM",isDm)
		outputChatBox("DM ON")
		outputChatBox("DM ON")
	end
end)



addEventHandler("onClientColShapeLeave",resourceRoot,function()
	if isDm and getElementData(localPlayer,"strefaDM") and source == strefaDM and not isElementWithinColShape(localPlayer,strefaDM) and getElementData(localPlayer,"sid") then
		setElementData(localPlayer,"strefaDM",false)
		outputChatBox("DM OFF")
		outputChatBox("DM OFF")
	end
end)