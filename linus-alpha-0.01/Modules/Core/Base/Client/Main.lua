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