charid = 'char'
firstspawn = false

RegisterNetEvent('Multichar:InitiateServerSession')
AddEventHandler('Multichar:InitiateServerSession', function()
    local identifier = GetIdentifier(source)
        if not identifier then
            deferrals.done('Unknown Error. We could not find your identifier. Try restarting your FiveM game client')
        else if identifier then
            local sourceroutebucket = GetPlayerRoutingBucket(source)
       --     SetRoutingBucketEntityLockdownMode(sourceroutebucket, 'strict')
            TriggerClientEvent('Multichar:InitiateClientSession', source)
        end 
    end
end)

RegisterNetEvent('Multichar:SetupCharacterData')
AddEventHandler('Multichar:SetupCharacterData', function(CharacterData)
     charid = CharacterData[6]
    local identifier = GetIdentifier(source, charid)
    firstspawn = true
    SaveCharacterDataToDB(identifier, CharacterData)
end)

RegisterNetEvent('Player:GetCharactersOutfit')
AddEventHandler('Player:GetCharactersOutfit', function()
    print('Player:GetCharactersOutfit')
    local identifier = GetIdentifier(source, charid)
    local charappearance  = GetCharSkin(identifier)
        if firstspawn then 
            TriggerClientEvent('Player:CreateNewCharacterOutfit', source)   
            firstspawn = false
        else
            TriggerClientEvent('Player:LoadCharacterOutfit', source, charappearance)
        end
end)

RegisterNetEvent('Player:SaveCharacterOutfit')
AddEventHandler('Player:SaveCharacterOutfit', function(appearance)
    local identifier = GetIdentifier(source, charid)
        SaveCharSkinToDB(identifier, appearance)   
end)

RegisterNetEvent('Player:GetCharacterData')
AddEventHandler('Player:GetCharacterData', function()
   local Character1Data = GetCharacter1()
   local Character2Data = GetCharacter2()
    local fyad = 'fyad' -- Ironic but required, guess is an issue wit JS/LUA 
    TriggerLatentClientEvent('Player:cl_SetCharacterData', source, 500, fyad, Character1Data, Character2Data)
end)

RegisterNetEvent('Player:SetCharacterID')
AddEventHandler('Player:SetCharacterID', function(characterid)
   charid = characterid
   if charid then
    if charid == 'char1' then
            xPlayerData = GetCharacter1()
        else if charid == 'char2' then
            xPlayerData = GetCharacter2()
        end
    end
end
  
 TriggerLatentClientEvent('xPlayer:SetClientSource', source, 500, test, xPlayerData)
end)

RegisterServerCallback('linus-callbacks:GetLastCoordinates', function(source)
    local identifier = GetIdentifier(source, charid)
    local data = GetResourceKvpString(('users:%s:CharacterData:lastlocation'):format(identifier))
    local result = json.decode(data)
    print(result)
    return result -- return any
end)

AddEventHandler('playerDropped', function ()
    local identifier = GetIdentifier(source, charid)
    local ped = GetPlayerPed(source)
    local oldplayerCoords = GetEntityCoords(ped)
    local playerCoords = json.encode(oldplayerCoords)
    print(playerCoords)
    SetResourceKvp(('users:%s:CharacterData:lastlocation'):format(identifier), playerCoords)
    print('State Updated')
end)
  
RegisterServerCallback('linus-callback:GetAccountBalance', function(source, type)
    if type == 'bank' then
        local bankbalance = xPlayerData[9]
    return bankbalance
    elseif type == 'wallet' then
        local walletbalance = xPlayerData[8]
    return walletbalance
    end
end)
