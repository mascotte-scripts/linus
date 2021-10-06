--LoadModuleTranslations("Data/Locales/".. GlobalConfig.Lang ..".lua")
--local Config = LoadModuleConfig("Data/Config.lua")
--Load("Client/Events.lua")

--print(Translate("Example:Test"))
--print(Config.Test)


--print(Translate("Example:Test"))
--print(Config.Test)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			exports.spawnmanager:setAutoSpawn(false)
			TriggerServerEvent('Multichar:InitiateServerSession')
			break
		end
	end
end)


