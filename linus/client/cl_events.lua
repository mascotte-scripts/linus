local isOpen = false
isSpawn = false
firstspawn = false

AddEventHandler('playerSpawned', function()
    if firstspawn then
        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            SetPedComponentVariation(playerPed, 0, 0, 0, 2) --Face
            SetPedComponentVariation(playerPed, 2, 11, 4, 2) --Hair 
            SetPedComponentVariation(playerPed, 4, 1, 5, 2) -- Pantalon
            SetPedComponentVariation(playerPed, 6, 1, 0, 2) -- Shoes
            SetPedComponentVariation(playerPed, 11, 7, 2, 2) -- Jacket
          end)
        CreateNewPlayerAppearance()
        firstspawn = false
    end
end)

RegisterNetEvent('Multichar:InitiateClientSession')
AddEventHandler('Multichar:InitiateClientSession', function(source)
    ShutdownLoadingScreenNui()
    Citizen.Wait(3000) -- NUI wont load right without this
    SetSelectionScreenDisplay(true)
end)

RegisterNetEvent('Player:CreateNewCharacterOutfit')
AddEventHandler('Player:CreateNewCharacterOutfit', function(source)
    CreateNewPlayerAppearance()
end)

RegisterNetEvent('Player:LoadCharacterOutfit')
AddEventHandler('Player:LoadCharacterOutfit', function(source, charappearance)
  local appearance = charappearance
  exports["fivem-appearance"]:setPlayerAppearance(source, appearance)
  print('Loaded Outfit')
end)

RegisterNetEvent('Player:SpawnPlayer')
AddEventHandler('Player:SpawnPlayer', function(isSpawn)
    if isSpawn then
      
        exports.spawnmanager:spawnPlayer({
			x = 1391.773,
			y = 3608.716,
			z = 38.942 + 0.25,
			heading = 0.0,
			model = `mp_m_freemode_01`,
			skipFade = false
		})
    end
    local isSpawn = false
end)

RegisterNUICallback("SetCharacterData", function(CharacterData)
    isSpawn = true
    firstspawn = true
    SetSelectionScreenDisplay(false)
    TriggerServerEvent('Multichar:SetupCharacterData', CharacterData)
    TriggerEvent('Player:SpawnPlayer', isSpawn)
end)
