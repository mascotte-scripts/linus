veryfirstspawn = false


-- Initiate client session

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			exports.spawnmanager:setAutoSpawn(false) -- Spawns anyway, probably due to me using fivem-hipster map until I create spawn functions
			DoScreenFadeOut(0)
			TriggerServerEvent('onPlayerJoined')
			break
		end
	end
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
  else if not veryfirstspawn then
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


-- unfinished
RegisterNetEvent('player:updatedbalance')
AddEventHandler('player:updatedbalance', function(playerbank, playercash)
print('Im rich mf')
local source = source
local playerbank = playerbank
  StatSetInt("BANK_BALANCE", playerbank, true)
  StatSetInt("MP0_WALLET_BALANCE", player, true)
end)
