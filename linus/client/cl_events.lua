-- To Trigger Use: TriggerServerEvent('Admin:RequestPlayerList')
RegisterNetEvent('Admin:RecievePlayerList')
AddEventHandler('Admin:RecievePlayerList', function(playerList)
  local players = playerList
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
  local appearance = charappearance
  exports["fivem-appearance"]:setPlayerAppearance(source, appearance)
  print('Loaded Outfit')
end)
