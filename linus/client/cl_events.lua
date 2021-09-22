local isOpen = false
isSpawn = false
firstspawn = false

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('Player:GetCharactersOutfit')
    TriggerEvent('Player:InitHudAccountBalance')
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
  SetSelectionScreenDisplay(true, Character1Data[1], Character1Data[2])--, --Character2Data[1], Character2Data[2])
  else
  SetSelectionScreenDisplay(true)
  end
end)

RegisterNetEvent('Player:SpawnPlayer')
AddEventHandler('Player:SpawnPlayer', function(isSpawn)
    if isSpawn then
    if firstspawn then
         print('Is first spawn') 
         exports.spawnmanager:spawnPlayer({
			x = -1037.6547,
			y = -2737.7192,
			z = 20.1693 + 0.25,
			heading = 333.4462,
			model = `mp_m_freemode_01`,
			skipFade = false
		})
        else
            print('Is not first spawn')
            local result = TriggerServerCallback('linus-callbacks:GetLastCoordinates', 200)
          --  local x,y,z = table.unpack(result)
            exports.spawnmanager:spawnPlayer({
                x = result.x,
                y = result.y,
                z = result.z + 0.25,
                heading = 0.0,
                model = `mp_m_freemode_01`,
                skipFade = false
            })
        end
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

RegisterNetEvent('Player:InitHudAccountBalance', function()
    if firstspawn then 
        SetHUDAccountBalance(source, 'bank', 5000)
        SetHUDAccountBalance(source, 'wallet', 500)
    else
        local bankbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'bank')
        local walletbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'wallet')
            SetHUDAccountBalance(source, 'bank', bankbalance)
            SetHUDAccountBalance(source, 'wallet', walletbalance)
    end
end)

RegisterNetEvent('Player:UpdateHudWalletBalance', function(source)
    local walletbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'wallet')
    SetHUDAccountBalance(source, 'wallet', walletbalance)
end)

RegisterNetEvent('Player:UpdateHudBankBalance', function(source)
    local bankbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'bank')
    SetHUDAccountBalance(source, 'bank', bankbalance)
end)
