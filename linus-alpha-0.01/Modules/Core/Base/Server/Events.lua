Load("Server/Functions.lua")

charid = 'char'
firstspawn = false

RegisterNetEvent('Multichar:InitiateServerSession', function()
    local netId = tonumber(source)
    local identifier = IDENTIFIER_CACHE[netId].license2
        if not identifier then
            DropPlayer(source, 'Error! We could not find your identifier. Try restarting your FiveM game client')
        else if identifier then
            local svid = tonumber(source)
            SetServerIdToIdentifier(identifier, svid)
            local sourceroutebucket = GetPlayerRoutingBucket(source)
            SetRoutingBucketEntityLockdownMode(sourceroutebucket, GetConvar("sv_entityLockdown ", "relaxed"))
            TriggerClientEvent('Multichar:InitiateClientSession', source)
        end
    end
end)

RegisterNetEvent('Multichar:SetupCharacterData', function(CharacterData, isSpawn)
    if isSpawn then
    charid = CharacterData.charid
    local netId = tonumber(source)
    local identifier = IDENTIFIER_CACHE[netId].license2..':'..charid
    IDENTIFIER_CACHE[netId].license2 = identifier
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
    local netId = tonumber(source)
    local identifier = IDENTIFIER_CACHE[netId].license2
    local charappearance  = GetCharSkin(identifier)
    if firstspawn then
        TriggerClientEvent('Player:CreateNewCharacterOutfit', source)
        firstspawn = false
    else
        TriggerClientEvent('Player:LoadCharacterOutfit', source, charappearance)
    end
end)

RegisterNetEvent('Player:SaveCharacterOutfit', function(appearance)
    local netId = tonumber(source)
    local identifier = IDENTIFIER_CACHE[netId].license2
        SaveCharSkinToDB(identifier, appearance)
end)


-- Linus:MultiCharacter:RequestCharacterData
RegisterNetEvent('Player:GetCharacterData', function()
  local netId = tonumber(source)
  local license = IDENTIFIER_CACHE[netId].license2
  local characterData = {}

  for i = 1, GetConvarInt("Multicharacter:MaxCharacterCount", 4) do
    local license = license..':'..i
    -- "license:char:charNum"
    local data = GetResourceKvpString(('%s:CharacterData:chardetails'):format(license)) or nil

    if data then
      characterData[i] = json.decode(data)
    else
      break
    end
  end

  local fad = 'fad'

  -- Linus:MultiCharacter:PutCharacterData
  TriggerLatentClientEvent('Player:cl_SetCharacterData', source, 500, fad, characterData)
end)

local GetCharacter = function(identifier)
    local chardata = GetResourceKvpString(('%s:CharacterData:chardetails'):format(identifier))
    local data = json.decode(chardata)
    return data
end

RegisterNetEvent('Player:SetCharacterID', function(characterid)
   charid = characterid
   local netId = tonumber(source)
   local license = IDENTIFIER_CACHE[netId].license2..':'..charid
    IDENTIFIER_CACHE[netId].license2 = license
    local xPlayerData = GetCharacter(license)
 TriggerLatentClientEvent('xPlayer:SetClientSource', source, 500, test, xPlayerData)
end)

RegisterServerCallback('linus-callbacks:GetLastCoordinates', function(source)
    local netId = tonumber(source)
    local identifier = IDENTIFIER_CACHE[netId].license2
    local data = GetResourceKvpString(('%s:CharacterData:lastlocation'):format(identifier))
    local result = json.decode(data)
    return result or nil
end)

AddEventHandler('playerDropped', function()
    local netId = tonumber(source)
    local identifier = IDENTIFIER_CACHE[netId].license2
    local ped = GetPlayerPed(source)
    local oldplayerCoords = GetEntityCoords(ped)
    local playerCoords = json.encode(oldplayerCoords)
    SetResourceKvp(('%s:CharacterData:lastlocation'):format(identifier), playerCoords)
    SetResourceKvpInt(('%s:serverid'):format(GetCharacter), nil) -- Intentional
end)

RegisterServerCallback('linus-callback:GetAccountBalance', function(source, account)
    local netId = tonumber(source)
    local identifier = IDENTIFIER_CACHE[netId].license2
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
    local netId = tonumber(source)
local identifier = IDENTIFIER_CACHE[netId].license2
local svid = tonumber(source)
SetServerIdToIdentifier(identifier, svid)
end)

AddEventHandler('playerJoining', function()
  -- Cache player identifiers right away for internel use
  getAllPlayerIdentifiers(source, false)
end)