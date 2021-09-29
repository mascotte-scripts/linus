charid = 'char'
firstspawn = false

RegisterNetEvent('Multichar:InitiateServerSession', function()
    local identifier = GetIdentifier(source)
        if not identifier then
            deferrals.done('Unknown Error. We could not find your identifier. Try restarting your FiveM game client')
        else if identifier then
            local svid = tonumber(source)
            SetServerIdToIdentifier(identifier, svid)
            local sourceroutebucket = GetPlayerRoutingBucket(source)
            SetRoutingBucketEntityLockdownMode(sourceroutebucket, 'strict')
            TriggerClientEvent('Multichar:InitiateClientSession', source)
        end 
    end
end)

RegisterNetEvent('Multichar:SetupCharacterData', function(CharacterData)
     charid = CharacterData[6]
    local identifier = GetIdentifier(source, charid)
    local DbId = incrementId()
    SetIdentifierToDbId(DbId, identifier)
    firstspawn = true
    SaveCharacterDataToDB(DbId, identifier, CharacterData)
    SetStartingCash(identifier, 'wallet', 5000)
    SetStartingCash(identifier, 'bank', 15000)
    print(DbId)
end)

RegisterNetEvent('Player:GetCharactersOutfit', function()
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

RegisterNetEvent('Player:SaveCharacterOutfit', function(appearance)
    local identifier = GetIdentifier(source, charid)
        SaveCharSkinToDB(identifier, appearance)
end)

RegisterNetEvent('Player:GetCharacterData', function()
   local char1 = GetCharacter1()
   local char2 = GetCharacter2()
   local CharacterData = {char1, char2}
    local fyad = 'fyad' -- Ironic but required, guess is an issue wit JS/LUA 
    TriggerLatentClientEvent('Player:cl_SetCharacterData', source, 500, fyad, CharacterData)
end)

RegisterNetEvent('Player:SetCharacterID', function(characterid)
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
    local data = GetResourceKvpString(('%s:CharacterData:lastlocation'):format(identifier))
    local result = json.decode(data)
    return result
end)

AddEventHandler('playerDropped', function()
    local identifier = GetIdentifier(source, charid)
    local ped = GetPlayerPed(source)
    local oldplayerCoords = GetEntityCoords(ped)
    local playerCoords = json.encode(oldplayerCoords)
    local pid = GetIdentifier(source)
    SetResourceKvp(('%s:CharacterData:lastlocation'):format(identifier), playerCoords)
    SetResourceKvpInt(('%s:serverid'):format(pid), 6969) -- Intentional
end)
  
RegisterServerCallback('linus-callback:GetAccountBalance', function(source, type)
    local identifier = GetIdentifier(source, charid)
    if type == 'bank' then
        local bankbalance = GetResourceKvpInt(('%s:CharacterData:bank'):format(identifier))
        return bankbalance
    elseif type == 'wallet' then
        local walletbalance = GetResourceKvpInt(('%s:CharacterData:wallet'):format(identifier))
         return walletbalance
    else
        return 'Unknown Error in callback GetAccountBalance'
    end
end)

RegisterNetEvent('Linus:SetIdentifierToServerId', function()
local identifier = GetIdentifier(source, charid)
local svid = tonumber(source)
SetServerIdToIdentifier(identifier, svid)
end)