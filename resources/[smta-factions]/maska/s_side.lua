
function zalozMaske( thePlayer )
         local sOldNick = getPlayerName( thePlayer )
    if not getElementData(thePlayer, "tempdata:originalnick" ) then
         setElementData ( thePlayer, "tempdata.originalnick", sOldNick )
	local numer = math.random(10000, 20000)
     --setPlayerName(thePlayer, "Nieznany""..numer..""")
     setPlayerName(thePlayer, "Nieznany"..numer.."")
    end
end
addCommandHandler("m", zalozMaske)

function removePlayerCustomTag ( thePlayer )
    local sOldNick = getElementData( thePlayer, "tempdata.originalnick" )
    if  sOldNick  then
        setElementData ( thePlayer, "tempdata.originalnick", false )
        setPlayerName( thePlayer, sOldNick )
    end
end
addCommandHandler ( "zm", removePlayerCustomTag )