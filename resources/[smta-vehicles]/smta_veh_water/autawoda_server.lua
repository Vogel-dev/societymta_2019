--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

function detectVehiclesInWater()
	local in_water = {};
	local count = 0;
	local wyjebano = 0;

	for i,v in ipairs(getElementsByType("vehicle")) do
		if isElementInWater(v) then
			count = count + 1;

			if wyjebDoPrzecho(v) then
				wyjebano = wyjebano + 1;
			end
		end
	end

	--outputDebugString("SMTA_VEH_WATER - Samochody przeniesione do przechowywalni " .. wyjebano .. " z " .. count .. " obecnych w wodzie");
end
setTimer(detectVehiclesInWater, 30*600, 0);

function wyjebDoPrzecho(veh)
	local wyk = exports["smta_base_db"]:wykonaj("UPDATE smtadb_vehicles SET przechowalnia=1 WHERE id=?", getElementData(veh, "id"));
    if getElementData(veh, "id") then
		if wyk then
			exports["smta_veh_base"]:zapiszPojazdy(veh);
			destroyElement(veh);
			return true;
		end
	end
end


setTimer(
function ( )
	for _, vehicle in ipairs ( getElementsByType ( "vehicle" ) ) do
	 if getElementHealth(vehicle) < 300 then
	 setVehicleDamageProof( vehicle, true)
	 setVehicleEngineState( vehicle, false)
  end
 end
end,
100, 0
)
--[[
local multiSeatModels={
  [542]={ -- escalade
    seats={ 
            {0.7,0,-0.4},
            {0.7,-0.8,-0.4},
            {-0.35,-0.8,-0.4},
            {-0.7,-1.6,-0.4},
	    {-0.7,-1.6,-0.4},
          }
    }
}

local function getFreeMultiSeat(veh)
  local available_seats={}

  for i,v in ipairs(multiSeatModels[getElementModel(veh)].seats) do
    available_seats[i]=true
  end
--  { [1]=true, [2]=true, [3]=true, [4]=true}

  for i,v in ipairs(getAttachedElements(veh)) do
    if getElementType(v)=="vehicle" then
      local seat=getElementData(v,"multiseat")
      if seat then available_seats[seat]=nil end
    end
  end

  -- return first element
  for i,v in pairs(available_seats) do return i  end
  return nil
end


addEventHandler("onVehicleEnter", root, function(plr, seat)
  if seat==0 then return end
  local vm=getElementModel(source)
  if not multiSeatModels[vm] then return end

  -- Let's find a free place
  local seat=getFreeMultiSeat(source)
  if not seat then
    -- no empty space, let the player seat in front passenger seat
    return
  end
--  outputDebugString("multiseat: " .. seat)

  removePedFromVehicle(plr)
  local veh=createVehicle(441, 0,0,-100)
  setElementCollisionsEnabled(veh, false)  
  attachElements(veh,source, unpack(multiSeatModels[vm].seats[seat])) -- 0.7,1.6,0)
  warpPedIntoVehicle(plr,veh,0)
  setTimer(warpPedIntoVehicle, 500, 1, plr, veh, 0)
  setElementAlpha(veh, 0)
  setCameraTarget(plr, source)
  setVehicleEngineState(veh,false)
  setVehicleLocked(veh, true)
  setElementData(veh,"multiseat", seat, false)
end, true, "low")


addEventHandler("onVehicleStartExit", resourceRoot, function(plr, seat)
  if seat~=0 then return end
  if getElementModel(source)~=441 then return end
  local firetruck=getElementAttachedTo(source)
  if firetruck then
      detachElements(source, firetruck)
      attachElements(source,firetruck, -0.7,1.6,0) -- przesuwamy na lewa strone aby wysiedli od strony kierowcy
--      cancelEvent()
  end
  setTimer(destroyElement, 500, 1, source)
  
end, true, "low")
--]]