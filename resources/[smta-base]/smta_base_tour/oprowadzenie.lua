--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

local marker1 = createMarker(-1806.68, 540.25, 35.16-0.8,"cylinder",1,68, 215, 168, 50)

local text = createElement("text")
setElementData(text, "text", "Oprowadzanie po serwerze")
setElementPosition(text, -1806.68, 540.25, 35.16)

local ped = createPed(184, -1806.69, 541.75, 35.16, 180)
setElementData(ped, "name", "Étienne Bonnet")

addEventHandler("onMarkerHit", marker1, function(el,md)
setElementFrozen(el, true)
	setElementInterior(el,0)
	setElementDimension(el,0)
	setElementPosition(el,-1796.85, 539.00, 35.16)
	setCameraMatrix(el, -2017.3686523438, -87.21019744873, 44.608001708984, -2017.7835693359, -87.910308837891, 44.026908874512)
	exports["smta_base_notifications"]:noti("Szkoła jazdy.", el)
		setTimer ( function()
		setCameraMatrix(el, -1888.4527587891, -568.33801269531, 33.470699310303, -1889.1527099609, -567.72973632813, 33.09644317627)
		exports["smta_base_notifications"]:noti("Kraina złomu, możesz tutaj kupić pierwszy pojazd.", el)
	end, 10000, 1 )

	end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -2121.8725585938, -13.015600204468, 42.722400665283, -2121.4353027344, -13.800426483154, 42.283218383789)
		exports["smta_base_notifications"]:noti("Przechowalnia pojazdów.", el)
	end, 20000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -2166.1081542969, -37.321899414063, 42.289501190186, -2166.8168945313, -37.913429260254, 41.905124664307)
		exports["smta_base_notifications"]:noti("Pamiętaj o odżywianiu się.", el)
	end, 30000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -2261.9697265625, -164.64950561523, 42.216899871826, -2262.7939453125, -164.16717529297, 41.919887542725)
		exports["smta_base_notifications"]:noti("'Turborura', możesz tutaj ztuningować swój pojazd.", el)
	end, 40000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -2416.3759765625, -201.99119567871, 42.361999511719, -2417.0625, -201.32525634766, 42.070213317871)
		exports["smta_base_notifications"]:noti("'Monopolowy u Stolara', możesz tam podjąć pracę lub kupić pożądanych trunki.", el)
	end, 50000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -2733.7673339844, 388.80261230469, 23.015300750732, -2734.4924316406, 388.32119750977, 22.522901535034)
		exports["smta_base_notifications"]:noti("Urząd miasta.", el)
	end, 60000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -2678.7182617188, 603.13708496094, 26.718200683594, -2677.9509277344, 603.72552490234, 26.463233947754)
		exports["smta_base_notifications"]:noti("Szpital.", el)
	end, 70000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -1738.2447509766, 926.76318359375, 38.329601287842, -1738.8372802734, 927.47918701172, 37.960422515869)
		exports["smta_base_notifications"]:noti("Zajezdnia tramwajowa, możesz tam podjąć pracę.", el)
	end, 80000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -1789.6147460938, 928.57421875, 33.657901763916, -1790.0187988281, 927.68579101563, 33.44012832641)
		exports["smta_base_notifications"]:noti("Kasyno.", el)
	end, 90000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -1464.5405273438, 730.13250732422, 18.468299865723, -1465.1212158203, 729.37042236328, 18.181747436523)
		exports["smta_base_notifications"]:noti("Praca jako nurek.", el)
	end, 100000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -1589.1846923828, 739.75787353516, 24.620000839233, -1589.6563720703, 738.96429443359, 24.235624313354)
		exports["smta_base_notifications"]:noti("Komisariat policji.", el)
	end, 110000, 1 )

end)	
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setCameraMatrix(el, -1300.3420410156, 411.86260986328, 18.653499603271, -1301.2047119141, 412.32409667969, 18.446413040161)
		exports["smta_base_notifications"]:noti("Punkt zbierania marichuany.", el)
	end, 120000, 1 )
	
	end)
addEventHandler("onMarkerHit", marker1, function(el,md)
		setTimer ( function()
		setElementFrozen(el, false)
		setCameraTarget(el, el)
	end, 130000, 1 )
	
	end)