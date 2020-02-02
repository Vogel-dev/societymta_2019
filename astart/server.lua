--[[
@Author: Vogel
@Copyright: Vogel / Society MTA // 2019-2020
@Pierwotne prawo do użytku tego skryptu ma TYLKO autor i serwery otrzymujące zgodę na jego użytkowanie przez autora
@Obowiązuje całkowity zakaz rozpowszechniania skryptów, zmiany autora, edycji skryptów bez zgody autora
@Nie masz prawa użytkować tego skryptu bez mojej zgody.
]]--

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
	if string.find(getResourceName(v), "smta_") or string.find(getResourceName(v), "smta_") then
        stopResource(v)
        outputDebugString(getResourceName(v).." stopped.")
	end
    end
outputChatBox("SMTA / Skrypty zostały wyłączone", getRootElement())
end)


addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
    if string.find(getResourceName(v), "smta_") or string.find(getResourceName(v), "smta_") then
        startResource(v)
        outputDebugString(getResourceName(v).." started.")
        end
    end
end)

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
	if string.find(getResourceName(v), "maps") or string.find(getResourceName(v), "maps_") then
        stopResource(v)
        outputDebugString(getResourceName(v).." stopped.")
	end
    end
outputChatBox("MAPS / Skrypty zostały wyłączone", getRootElement())
end)


addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
    if string.find(getResourceName(v), "maps") or string.find(getResourceName(v), "maps_") then
        startResource(v)
        outputDebugString(getResourceName(v).." started.")
        end
    end
end)

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
	if string.find(getResourceName(v), "mod") or string.find(getResourceName(v), "mod_") then
        stopResource(v)
        outputDebugString(getResourceName(v).." stopped.")
	end
    end
outputChatBox("MOD / Skrypty zostały wyłączone", getRootElement())
end)


addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
    if string.find(getResourceName(v), "mod") or string.find(getResourceName(v), "mod_") then
        startResource(v)
        outputDebugString(getResourceName(v).." started.")
        end
    end
end)