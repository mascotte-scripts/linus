veryfirstspawn = false
local players = {}

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

RegisterNetEvent('Admin:RecievePlayerList')
AddEventHandler('Admin:RecievePlayerList', function(playerList)
  local players = playerList
end)

-- Not called by anything
RegisterNetEvent('player:createcharacter')
AddEventHandler('player:createcharacter', function(existingid)
    print('hello?')
    local existingid = existingid
    if not existingid then
    -- CreateNewPlayerAppearance(source)
    veryfirstspawn = true
            else if existingid then 
                  print('insert load character function here')
             end
        end
end)

AddEventHandler('playerSpawned', function()
  if veryfirstspawn then
  CreateNewPlayerAppearance(source)
    veryfirstspawn = false
  else
    TriggerServerEvent('getcharacterclothes', source)
  end
end
end)

RegisterNetEvent('player:loadcharacterclothes')
AddEventHandler('player:loadcharacterclothes', function(source, charappearance)
  print('and here')
  local appearance = charappearance
  exports["fivem-appearance"]:setPlayerAppearance(source, appearance)
  print('Loaded clothes')
end)
