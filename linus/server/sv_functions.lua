GetIdentifier = function(source, charid)
    if charid then
        for k,v in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(v, 'license:') then
                local identifier = charid..':'..string.gsub(v, 'license:', '')
                return identifier
            end
        end
    else
        for k,v in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(v, 'license:') then
                local identifier = string.gsub(v, 'license:', '')
                return identifier
            end
        end
    end
end
exports ('GetIdentifier', source, charid)

GetCharSkin = function(identifier)
    local appearance =  GetResourceKvpString(('%s:CharacterData:outfit'):format(identifier))
    local charappearance = json.decode(appearance)
	return charappearance
end

SaveCharSkinToDB = function(identifier, appearance)
	SetResourceKvp(('%s:CharacterData:outfit'):format(identifier), json.encode(appearance))  
end

SaveCharacterDataToDB = function(DbId, identifier, CharacterData)
    local data = json.encode(CharacterData)
    local job = "Unemployed"
	return SetResourceKvp(('%s:CharacterData:chardetails'):format(identifier), data) and  SetResourceKvp(('%s:CharacterData:job'):format(DbId), job) 
end

GetCharacters = function(charid)
    local identifier = GetIdentifier(source, charid)
    local chardata = GetResourceKvpString(('%s:CharacterData:chardetails'):format(identifier))
    local data = json.decode(chardata)
    return data
end

GetPlayerList = function()
    local players = GetPlayers()
    local playerList = {}
    for i = 1, #players do
      local playerId = tonumber(players[i])
      local name = GetPlayerName(playerId)
      playerList[playerId] = name
    end
    return playerList
end

SetStartingCash = function(identifier, account, amount)
    if account == 'wallet' then
   return SetResourceKvpInt(('%s:CharacterData:wallet'):format(identifier), amount)
    elseif account =='bank' then
   return SetResourceKvpInt(('%s:CharacterData:bank'):format(identifier), amount)
    else
        print('Unknown Error! Function: SetStartingCash()')
    end
end

GetBalance = function(identifier, account)
    if account == 'wallet' then
        return GetResourceKvpInt(('%s:CharacterData:wallet'):format(identifier))
    elseif account =='bank' then
       return GetResourceKvpInt(('%s:CharacterData:bank'):format(identifier))
    else
        print('Unknown Error! Function: GetBalance()')
        return nil
    end
end

AddAccountMoney = function(playerId, identifier, account, amount)
    local wallet = GetBalance(identifier, 'wallet')
    local bank = GetBalance(identifier, 'bank')
    if account == 'wallet' then 
            local sum = wallet + amount
            local newbalance = SetResourceKvpInt(('%s:CharacterData:wallet'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudWalletBalance', playerId)
    elseif account == 'bank' then
            local sum = bank + amount
            local newbalance = SetResourceKvpInt(('%s:CharacterData:bank'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudBankBalance', playerId)
    else
        print('Unknown Error: Function AddAccountMoney()')
    end
end

RemoveAccountMoney = function(playerId, identifier, account, amount)
    local wallet = GetBalance(identifier, 'wallet')
    local bank = GetBalance(identifier, 'bank')
    if account == 'wallet' then 
            local sum = wallet - amount
            local newbalance = SetResourceKvpInt(('%s:CharacterData:wallet'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudWalletBalance', playerId)
    elseif account == 'bank' then
            local sum = bank - amount
            local newbalance = SetResourceKvpInt(('%s:CharacterData:bank'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudBankBalance', playerId)
    else
        print('Unknown Error: Function RemoveAccountMoney()')
    end
end

incrementId = function()
    local nextId = GetResourceKvpInt('nextId')
    nextId = nextId + 1
    SetResourceKvpInt('nextId', nextId)
    return nextId
end

SetIdentifierToDbId = function(playerId, identifier)
    return SetResourceKvp(('%s:identifier'):format(playerId), identifier) and SetResourceKvpInt(('%s:id'):format(identifier), playerId)
end

GetIdentifierFromDbId = function(playerId)
    return GetResourceKvpString(('%s:identifier'):format(playerId))
end

GetDbIdFromIdentifier = function(identifier)
    return GetResourceKvpInt(('%s:id'):format(identifier))
end

GetServerIdFromIdentifier = function(identifier)
    return GetResourceKvpInt(('%s:serverid'):format(identifier))
end

SetServerIdToIdentifier = function(identifier, svid)
    return SetResourceKvpInt(('%s:serverid'):format(identifier), svid)
end

SetCharacterJob = function(playerId, job)
    return SetResourceKvp(('%s:CharacterData:job'):format(playerId), job)
end

GetCharacterJob = function(playerId)
   return GetResourceKvpString(('%s:CharacterData:job'):format(playerId))
end

RegisterCommand('giveaccountmoney', function(source, args)
    if args[1] and args[2] and args[3] then
        local account = args[1]
        local pid = tonumber(args[2])
        local amount = tonumber(args[3])
        local getIdentifier = GetIdentifierFromDbId(pid)
        local playerId = GetServerIdFromIdentifier(getIdentifier)
        AddAccountMoney(playerId, getIdentifier, account, amount) 
    else
        print('Invalid Usage - Format: /giveaccountmoney [bank/wallet] [DbId] [Amount]')
    end
end, true)

RegisterCommand('removeaccountmoney', function(source, args)
    if args[1] and args[2] and args[3] then
        local account = args[1]
        local pid = tonumber(args[2])
        local amount = tonumber(args[3])
        local getIdentifier = GetIdentifierFromDbId(pid)
        local playerId = GetServerIdFromIdentifier(getIdentifier)
        RemoveAccountMoney(playerId, getIdentifier, account, amount) 
    else
        print('Invalid Usage - Format: /removeaccountmoney [bank/wallet] [DbId] [Amount]')
    end
end, true)

RegisterCommand('setjob', function(source, args)
    if args[1] and args[2]then
        local pid = tonumber(args[1])
        local job = args[2]
        local getIdentifier = GetIdentifierFromDbId(pid)
        local playerId = GetServerIdFromIdentifier(getIdentifier)
        SetCharacterJob(playerId, job)
    else
        print('Invalid Usage - Format: /setjob [Dbid] [jobname]')
    end
end, true)