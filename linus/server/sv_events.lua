charid = 'char'
firstspawn = false

RegisterNetEvent('Multichar:InitiateServerSession', function()
    local identifier = GetIdentifier(source)
        if not identifier then
            deferrals.done('Error! We could not find your identifier. Try restarting your FiveM game client')
        else if identifier then
            print(identifier)
            local svid = tonumber(source)
            SetServerIdToIdentifier(identifier, svid)
            local sourceroutebucket = GetPlayerRoutingBucket(source)
            SetRoutingBucketEntityLockdownMode(sourceroutebucket, 'strict')
            TriggerClientEvent('Multichar:InitiateClientSession', source)
        end
    end
end)

RegisterNetEvent('Multichar:SetupCharacterData', function(CharacterData, isSpawn)
    if isSpawn then
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
    local isSpawn = false
    else
    print('Possible attempted cheating detected')
    print(tonumber(source))
    end
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

local GetCharacters = function(charid)
    local identifier = GetIdentifier(source, charid)
    local chardata = GetResourceKvpString(('%s:CharacterData:chardetails'):format(identifier))
    local data = json.decode(chardata)
    return data
end

-- Linus:MultiCharacter:RequestCharacterData
RegisterNetEvent('Player:GetCharacterData', function()
  local license = IDENTIFIER_CACHE[netId].license
  local source = source
  local characterData = {}

  for i = 1, GetConvarInt('Multicharacter:MaxCharacterCount', 4) do

    -- "license:char:charNum"
    local data = GetResourceKvpString('%s:CharacterData:chardetails'):format(license)

    if data then
      characterData[i] = json.decode(data)
    else
      break
    end
  end

  -- Linus:MultiCharacter:PutCharacterData
  TriggerLatentClientEvent('Player:cl_SetCharacterData', source, 500, characterData)
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
        else
            xPlayerData = GetCharacters('char4')
        end
    end
 TriggerLatentClientEvent('xPlayer:SetClientSource', source, 500, test, xPlayerData)
end)

RegisterServerCallback('linus-callbacks:GetLastCoordinates', function(source)
    local identifier = GetIdentifier(source, charid)
    local data = GetResourceKvpString(('%s:CharacterData:lastlocation'):format(identifier))
    local result = json.decode(data)
    return result or nil
end)

AddEventHandler('playerDropped', function()
    local identifier = GetIdentifier(source, charid)
    local ped = GetPlayerPed(source)
    local oldplayerCoords = GetEntityCoords(ped)
    local playerCoords = json.encode(oldplayerCoords)
    local pid = GetIdentifier(source)
    SetResourceKvp(('%s:CharacterData:lastlocation'):format(identifier), playerCoords)
    SetResourceKvpInt(('%s:serverid'):format(pid), nil) -- Intentional
end)

RegisterServerCallback('linus-callback:GetAccountBalance', function(source, account)
    local identifier = GetIdentifier(source, charid)
    if account == 'bank' then
       local balance = GetBalance(identifier, account)
        return balance
    elseif account == 'wallet' then
        local balance = GetBalance(identifier, account)
        return balance
    else
        return 'Unknown Error in callback GetAccountBalance'
    end
end)

RegisterNetEvent('Linus:SetIdentifierToServerId', function()
local identifier = GetIdentifier(source, charid)
local svid = tonumber(source)
SetServerIdToIdentifier(identifier, svid)
end)

AddEventHandler('playerJoining', function()
  -- Cache player identifiers right away for internel use
  getAllPlayerIdentifiers(source, false)
end)
