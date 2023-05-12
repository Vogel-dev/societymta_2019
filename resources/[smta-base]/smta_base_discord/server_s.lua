-- 1. zmienna 2. nazwa wyświetlana 3. link do webhooka 
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
	
	local options = {
		formFields = {
			username = (user == v[1]) and v[2],
			content = message,
		},
		method = "POST"
	}
	fetchRemote(v[3], options, function() end)
	end
end

addCommandHandler("senddiscord", function()
	exports["smta_base_discord"]:connectWeb("wiadomość", "test")
end)