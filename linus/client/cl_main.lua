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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0,38) then
			print('I like turtles')
			local result = TriggerServerCallback('pmc-test:testingAwesomeCallback')
			if result == 'Unemployed' then
				print('No work here ese')
			else
				print("Didn't go as planned..")
			end
 		end
	end
end)
