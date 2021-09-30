local isOpen = false
isSpawn = false
firstspawn = false

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('Player:GetCharactersOutfit')
    TriggerServerEvent('Linus:SetIdentifierToServerId')
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

RegisterNetEvent('Player:cl_SetCharacterData', function(source, CharacterData)
  Citizen.Wait(3000) -- NUI wont load right without this
  if CharacterData[1] then
    local firstname = CharacterData[1][1]
    local lastname = CharacterData[1][2]
  UpdateNUICharacterDisplay(firstname, lastname, 'char1')
  end
  if CharacterData[2] then
    local firstname = CharacterData[2][1]
    local lastname = CharacterData[2][2]
  UpdateNUICharacterDisplay(firstname, lastname, 'char2')
  end
  if CharacterData[3] then
    local firstname = CharacterData[3][1]
    local lastname = CharacterData[3][2]
  UpdateNUICharacterDisplay(firstname, lastname, 'char3')
  end
  if CharacterData[4] then
    local firstname = CharacterData[4][1]
    local lastname = CharacterData[4][2]
  UpdateNUICharacterDisplay(firstname, lastname, 'char4')
  end
  SetSelectionScreenDisplay(true)
end)

RegisterNetEvent('Player:SpawnPlayer')
AddEventHandler('Player:SpawnPlayer', function(isSpawn)
    if isSpawn then
    if firstspawn then
         exports.spawnmanager:spawnPlayer({
			x = -1037.6547,
			y = -2737.7192,
			z = 20.1693 + 0.25,
			heading = 333.4462,
			model = `mp_m_freemode_01`,
			skipFade = false
		})
        else
            local result = TriggerServerCallback('linus-callbacks:GetLastCoordinates', 200)
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
    TriggerServerEvent('Multichar:SetupCharacterData', CharacterData, isSpawn)
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
    local bankbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'bank')
    local walletbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'wallet')
        SetHUDAccountBalance(source, 'bank', bankbalance)
        SetHUDAccountBalance(source, 'wallet', walletbalance)
end)

RegisterNetEvent('Player:UpdateHudWalletBalance', function(source)
    local walletbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'wallet')
    SetHUDAccountBalance(source, 'wallet', walletbalance)
end)

RegisterNetEvent('Player:UpdateHudBankBalance', function(source)
    local bankbalance = TriggerServerCallback('linus-callback:GetAccountBalance', 200, 'bank')
    SetHUDAccountBalance(source, 'bank', bankbalance)
end)
