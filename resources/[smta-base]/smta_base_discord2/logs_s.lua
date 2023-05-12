 function core:logi_wejsc(message, user)
 	avatar = (user == "logi-wejscwyjsc")
	
 	local logi_wejsc_option = {
 		formFields = {
 			username = (user == "logi-wejscwyjsc") and "Logi",
 			content = message,
 		},
 		method = "POST"
 	}
 	fetchRemote("https://discordapp.com/api/webhooks/516071150112079894/yhljdI_k5sz4aVAQRzEMkLiFfssHgo7Uh60EiiIwUyGmBeSUs1_FoQRL3Bdpb5KReI7q", logi_wejsc_option, function() end)
 end

 function core:logi_wyjsc(message, user)
 	avatar = (user == "logi_wyjsc")
	
 	local logi_wyjsc_option = {
 		formFields = {
 			username = (user == "logi-wejscwyjsc") and "Logi",
 			content = message,
 		},
 		method = "POST"
 	}
 	fetchRemote("https://discordapp.com/api/webhooks/516071150112079894/yhljdI_k5sz4aVAQRzEMkLiFfssHgo7Uh60EiiIwUyGmBeSUs1_FoQRL3Bdpb5KReI7q", logi_wyjsc_option, function() end)
 end

 function core:connectWeb(message, user)
 	avatar = (user == "konfident") and "https://discordapp.com/api/webhooks/516071150112079894/yhljdI_k5sz4aVAQRzEMkLiFfssHgo7Uh60EiiIwUyGmBeSUs1_FoQRL3Bdpb5KReI7q"
	
 	local sendOptions = {
 		formFields = {
 			username = (user == "logi-wejscwyjsc") and "Logi",
 			content = message,
 		    avatar_url = avatar
 		},
 		method = "POST"
 	}
 	fetchRemote("https://discordapp.com/api/webhooks/516059889106157578/RU8Ouk0IcsAYePAiDeRVZAS_MNIL-Rwj-tX40EX5xVi3jlqLl6Q85LJZz_QvOaRxK0W0", sendOptions, function() end)
 end

local webhooks = {
{"logi-resetowanie-skryptow", "logi-resetowanie-skryptow", "https://discordapp.com/api/webhooks/516059889106157578/RU8Ouk0IcsAYePAiDeRVZAS_MNIL-Rwj-tX40EX5xVi3jlqLl6Q85LJZz_QvOaRxK0W0"},
{"logi-wejscwyjsc", "logi-wejscwyjsc", "https://discordapp.com/api/webhooks/516071150112079894/yhljdI_k5sz4aVAQRzEMkLiFfssHgo7Uh60EiiIwUyGmBeSUs1_FoQRL3Bdpb5KReI7q"},
{"logi-akcjirp", "logi-akcjirp", "https://discordapp.com/api/webhooks/516074254190772224/44NUrZhL_k-nDLDwPs4cCji_dusWdq_lL5PDF0E0QvZn0OLr2yeGmRruujd-K5oOI07d"},
{"logi-local", "logi-local", "https://discordapp.com/api/webhooks/516076804809818124/fmt_y8Y8qDBCoReNJSAWcYCKJgNfx3SP64o_hAcYMjlO40XxfvMbazWpQCVdwhsCwTRD"},
{"logi-transfer", "logi-transfer", "https://discordapp.com/api/webhooks/516077656526159873/k8dEdKaYJbszSc0Nu4_S26dhAQgWYiBTmGg86rnsmxjvIr2975U2CLsnUManGtBz_g3U"},
{"logi-pm", "logi-pm", "https://discordapp.com/api/webhooks/516078333847404546/gNXNbtIdDsz4PoDI7HIGZ3uRivmjOu1kIaZmG7fcxjK8tp4dsEPkRCrco6PaPqlns4G6"},
{"logi-komend-adm", "logi-komend-adm", "https://discordapp.com/api/webhooks/516228202415521802/MNLFH8-8F1zb7ldNenXaVaZV02DTls7NAGLc5AhuCBS5gQ7dfpZIZgsIKggbhflir0n1"},
{"logi-raporty", "logi-raporty", "https://discordapp.com/api/webhooks/516256178276139009/7hkw9znLTukqii1g1qxZxa7zNDQ5kc7oltaowjJXU8bsu96I1NbVf4KkfxVd2heKAeAq"},
{"logi-chat-administracji", "logi-chat-administracji", "https://discordapp.com/api/webhooks/516663375753773068/xUCxpAQex31j48e1sUb5QlbKm-mJ36IT95BU9smiHGtxjhHgT0IEcDKkPb7Qfr9H7R3h"},
{"logi-pojazdy", "logi-pojazdy", "https://discordapp.com/api/webhooks/518465341593092102/UV6HzEe3h5UhAbQQRZnglWgokTCCpqAkGWHpDOB_ZrQ6K3Seac4jR8QU5va37FOIgyX-"},
{"logi-suszarka", "logi-suszarka", "https://discordapp.com/api/webhooks/521418802777292835/hmS8PajHLiMsJoQqUVNKHRJKlVgJKB-0Jkv-GzCPsqUvCe8ibJk-LD-t4_VnsEIZ89d3"},
{"logi-prace", "logi-prace", "https://discordapp.com/api/webhooks/525430389519417354/t9sjQClwK2mqjIj6sLa_q3JmdRywnRG0IuNVJTwf4e_B2UNXMUbJnwDIMYCFfIWv6JR-"},
}

function connectWeb(message, user)
	for k, v in pairs(webhooks) do
		if user == v[1] then
			local czas1 = getTimestamp()
			local czas2 = getRealTime(czas1)
			local czas3 = getRealTime()
	
			local sendOptions = {
				formFields = {
					username = (user == v[1]) and v[2],
					content = "["..(czas2.monthday).."-"..(czas2.month+1).."-"..(czas2.year+1900).." | "..czas3.hour..":"..(czas3.minute+2).."] "..message,
				},
				method = "POST"
			}
			fetchRemote(v[3], sendOptions, function() end)
		end
	end
end

function getTimestamp(year, month, day, hour, minute, second)
     initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second

     calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second

    timestamp = timestamp - 3600 GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end

    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end
