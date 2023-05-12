local czas = getRealTime()

addEventHandler("onResourceStart", root, function(startedResource)
	exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] Zasób **"..startedResource.name.."** został uruchomiony/zrestartowany i jest gotowy do działania.", "logi-resetowanie-skryptow")
end)

function testInfo()
	--connectWeb("Dziękujemy za wsparcie serwera graczowi **Podhal**\nSposób wsparcia: **zakup konta premium**\nTyp płatności: **SMS**\nKwota: **11,07zł**\n \nDziękujemy zespół NewPlace.", "konfident")
	exports["smta_base_discord"]:connectWeb("logi-wejscwyjsc", "logi-wejscwyjsc")
end

addCommandHandler("discordtest", testInfo)

addEventHandler("onPlayerQuit", root, function()
 	exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] Użytkownik o nicku **"..source.name.."** opuścił/a serwer.", "logi-wejscwyjsc")
end)

addEventHandler("onPlayerConnect", root, function(playerNick, _, _, playerSerial, version)
	exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] Użytkownik o nicku **"..playerNick.."** dołącza na serwer.\n**Numer seryjny**: "..playerSerial.."", "logi-wejscwyjsc")
end)

addEventHandler("onPlayerCommand", root, function(cmd)
	--exports["smta_base_discord"]:connectWeb("**"..getPlayerName(source).."** użył komendy: "..cmd, "logi-wejscwyjsc")
end)


setTimer(function()
	exports["smta_base_discord"]:connectWeb("["..czas.hour..":"..czas.minute.."] Aktualna ilość graczy na serwerze: **"..#getElementsByType("player").."**", "logi-wejscwyjsc")
end, 360000, 0)
