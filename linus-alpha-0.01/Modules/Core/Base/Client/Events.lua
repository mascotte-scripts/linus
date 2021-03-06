Load("Client/Functions.lua")

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
AddEventHandler('Player:LoadCharacterOutfit', function(source, appearance)
  exports["fivem-appearance"]:setPlayerAppearance(source, appearance)
end)

RegisterNetEvent('Player:cl_SetCharacterData', function(source, CharacterData)
  Citizen.Wait(3000) -- NUI wont load right without this
  for i=1, #CharacterData do 
    local firstname = CharacterData[i].firstname
    local lastname = CharacterData[i].lastname
  UpdateNUICharacterDisplay(firstname, lastname, i)
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
           TriggerServerCallback {
               eventName = 'linus-callbacks:GetLastCoordinates',
               args = {'some', 'args', 'here'},
               callback = function(result)
                print(result)
                exports.spawnmanager:spawnPlayer({
                    x = result.x,
                    y = result.y,
                    z = result.z + 0.25,
                    heading = 0.0,
                    model = `mp_m_freemode_01`,
                    skipFade = false
                })
               end
            }
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

RegisterNUICallback("Base/SetCharacterData", function(CharacterData)
    isSpawn = true
    firstspawn = true
    SetSelectionScreenDisplay(false)
    TriggerServerEvent('Multichar:SetupCharacterData', CharacterData, isSpawn)
    TriggerEvent('Player:SpawnPlayer', isSpawn)
end)

RegisterNUICallback("Base/LoadCharacterData", function(activecharid)
    TriggerServerEvent('Player:SetCharacterID', activecharid)
    isSpawn = true
    SetSelectionScreenDisplay(false)
    TriggerEvent('Player:SpawnPlayer', isSpawn)
end)

RegisterNetEvent('Player:InitHudAccountBalance', function()
   TriggerServerCallback {
    eventName = 'linus-callbacks:GetBankBalance',
    args = {'bank'},
    callback = function(result, args)
     SetHUDAccountBalance('bank', result)
    end
 }

 TriggerServerCallback {
    eventName = 'linus-callbacks:GetWalletBalance',
    args = {'wallet'},
    callback = function(result, args)
     SetHUDAccountBalance('wallet', result)
    end
 }
end)

RegisterNetEvent('Player:UpdateHudWalletBalance', function(source)
    TriggerServerCallback {
        eventName = 'linus-callbacks:GetWalletBalance',
        args = {'wallet'},
        callback = function(result, args)
         SetHUDAccountBalance('wallet', result)
        end
     }
end)

RegisterNetEvent('Player:UpdateHudBankBalance', function(source)
    TriggerServerCallback {
        eventName = 'linus-callbacks:GetBankBalance',
        args = {'bank'},
        callback = function(result, args)
         SetHUDAccountBalance('bank', result)
        end
     }
end)