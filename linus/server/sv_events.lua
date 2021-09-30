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
    firstspawn = true
    SetIdentifierToDbId(DbId, identifier)
    SaveCharacterDataToDB(DbId, identifier, CharacterData)
    local CashStartingBalance = GetConvar("startingWalletAmount", 0)
    local BankStartingBalance = GetConvar("startingBankAmount", 0)
    local a = tonumber(CashStartingBalance)
    local b = tonumber(BankStartingBalance)
    AddAccountMoney(source, identifier, 'wallet', a)
    AddAccountMoney(source, identifier, 'bank', b)
end)

RegisterNetEvent('Player:GetCharactersOutfit', function()
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
local charslots = {
    char1 = "char1",
    char2 = "char2",
    char3 = "char3",
    char4 = "char4"
}
local chars = {}
    for k,v in pairs(charslots) do
        local a = GetCharacters(charslots[k])
        table.insert(chars, a)
    end
local char1 = chars[1]
local char2 = chars[2]
local char3 = chars[3]
local char4 = chars[4]
   local CharacterData = {char1, char2, char3, char4}
   local fyad = 'fyad' -- Ironic but required, guess is an issue wit JS/LUA 
    TriggerLatentClientEvent('Player:cl_SetCharacterData', source, 500, fyad, CharacterData)
end)

RegisterNetEvent('Player:SetCharacterID', function(characterid)
   charid = characterid
   if charid then
        if charid == 'char1' then
            xPlayerData = GetCharacters('char1')
        elseif charid == 'char2' then
            xPlayerData = GetCharacters('char2')
        elseif charid == 'char3' then
            xPlayerData =  GetCharacters('char3')
        elseif charid == 'char4' then
            xPlayerData = GetCharacters('char4')
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