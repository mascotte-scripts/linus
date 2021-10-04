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


RegisterNetEvent('__pmc_callback:client')
AddEventHandler('__pmc_callback:client', function(eventName, ...)
	local p = promise.new()

	TriggerEvent(('c__pmc_callback:%s'):format(eventName), function(...)
		p:resolve({...})
	end, ...)

	local result = Citizen.Await(p)
	TriggerServerEvent(('__pmc_callback:server:%s'):format(eventName), table.unpack(result))
end)
