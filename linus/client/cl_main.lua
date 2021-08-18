Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			exports.spawnmanager:setAutoSpawn(true)
			DoScreenFadeOut(0)
			TriggerServerEvent('onPlayerJoined')
			break
		end
	end
end)
