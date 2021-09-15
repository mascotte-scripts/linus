local isOpen = false
isSpawn = false
firstspawn = false

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('Player:GetCharactersOutfit')
end)

RegisterNetEvent('Multichar:InitiateClientSession') -- function that characters should be passed to
AddEventHandler('Multichar:InitiateClientSession', function(source)
    ShutdownLoadingScreenNui()
    TriggerServerEvent('Player:GetCharacterData')
end)

RegisterNetEvent('Player:CreateNewCharacterOutfit')
AddEventHandler('Player:CreateNewCharacterOutfit', function(source)
    if firstspawn then
          Citizen.Wait(300)
          CreateNewPlayerAppearance()
        firstspawn = false
    else
        CreateNewPlayerAppearance() 
    end
end)

RegisterNetEvent('Player:LoadCharacterOutfit')
AddEventHandler('Player:LoadCharacterOutfit', function(source, charappearance)
  local appearance = charappearance
  exports["fivem-appearance"]:setPlayerAppearance(source, appearance)
  print('Loaded Outfit')
end)

RegisterNetEvent('Player:cl_SetCharacterData')
AddEventHandler('Player:cl_SetCharacterData', function(source, Character1Data, Character2Data)
  print('Set Char Data')
  print(Character1Data)
  Citizen.Wait(3000) -- NUI wont load right without this
  if Character1Data then
  SetSelectionScreenDisplay(true, Character1Data[1], Character1Data[2], Character2Data.FirstName, Character2Data.LastName)
  else
  SetSelectionScreenDisplay(true)
  end
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
    isSpawn = false
    Citizen.Wait(100)
end)

RegisterNetEvent('xPlayer:SetClientSource')
AddEventHandler('xPlayer:SetClientSource', function(source, xPlayerData)
    xPlayer = {
        firstname = xPlayerData.FirstName,
        lastname = xPlayerData.LastName,
        gender = xPlayerData.Gender,
        nation = xPlayerData.Nation,
        dob = xPlayerData.Dob,
    }
end)

RegisterNUICallback("SetCharacterData", function(CharacterData)
    isSpawn = true
    firstspawn = true
    SetSelectionScreenDisplay(false)
    TriggerServerEvent('Multichar:SetupCharacterData', CharacterData)
    TriggerEvent('Player:SpawnPlayer', isSpawn)
end)

RegisterNUICallback("LoadCharacterData", function(activecharid)
    local characterid = activecharid
    TriggerServerEvent('Player:SetCharacterID', characterid)
    isSpawn = true
    SetSelectionScreenDisplay(false)
    TriggerEvent('Player:SpawnPlayer', isSpawn)
end)
