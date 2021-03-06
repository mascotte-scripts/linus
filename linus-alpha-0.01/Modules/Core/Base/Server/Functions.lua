IDENTIFIER_CACHE = {}

GetCharSkin = function(identifier)
    local appearance =  GetResourceKvpString(('%s:CharacterData:outfit'):format(identifier))
    local charappearance = json.decode(appearance)
	return charappearance
end

SaveCharSkinToDB = function(identifier, appearance)
	SetResourceKvp(('%s:CharacterData:outfit'):format(identifier), json.encode(appearance))
end
exports('SaveCharSkinToDB', SaveCharSkinToDB)

SaveCharacterDataToDB = function(DbId, identifier, CharacterData)
    local data = json.encode(CharacterData)
    local job = GetConvar("DefaultJob", "Unemployed")
	return SetResourceKvp(('%s:CharacterData:chardetails'):format(identifier), data) and  SetResourceKvp(('%s:CharacterData:job'):format(DbId), job)
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

GetBalance = function(identifier, account)
    if account == 'wallet' then
        return GetResourceKvpInt(('%s:CharacterData:wallet'):format(identifier)) or 0
    elseif account =='bank' then
       return GetResourceKvpInt(('%s:CharacterData:bank'):format(identifier)) or 0
    else
        print('Unknown Error! Function: GetBalance()')
        return nil
    end
end
exports('GetBalance', GetBalance)

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
exports('AddAccountMoney', AddAccountMoney)

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
exports('RemoveAccountMoney', RemoveAccountMoney)

incrementId = function()
    local nextId = GetResourceKvpInt('nextId')
    nextId = nextId + 1
    SetResourceKvpInt('nextId', nextId)
    return nextId
end

function getAllPlayerIdentifiers(netId, temporary)
    local netId = tonumber(netId)
  if not IDENTIFIER_CACHE[netId] then
    local identifiers = {}

    for i = 1, GetNumPlayerIdentifiers(netId) - 1 do
      local raw = GetPlayerIdentifier(netId, i)
      local idx, value = raw:match("^([^:]+):(.+)$")

      if idx ~= 'ip' then
        identifiers[idx] = value
      end
    end

    if temporary then
      return identifiers
    end

    IDENTIFIER_CACHE[netId] = identifiers
  end

  return IDENTIFIER_CACHE[netId]
end
exports('getAllPlayerIdentifiers', 'getAllPlayerIdentifiers')

function getPlayerFromIdentifier(identifier)
	local players = GetPlayers()
	for i = 1, #players do
		local playerId = tonumber(players[i])
		for _, id in pairs(IDENTIFIER_CACHE[playerId]) do
			if id == identifier then
				return playerId
			end
		end
	end
	return -1
end
exports('getPlayerFromIdentifier', 'getPlayerByIdentifier')


SetIdentifierToDbId = function(playerId, identifier)
    return SetResourceKvp(('%s:identifier'):format(playerId), identifier) and SetResourceKvpInt(('%s:id'):format(identifier), playerId)
end

GetIdentifierFromDbId = function(playerId)
    return GetResourceKvpString(('%s:identifier'):format(playerId))
end
exports('GetIdentifierFromDbId', GetIdentifierFromDbId)

GetDbIdFromIdentifier = function(identifier)
    return GetResourceKvpInt(('%s:id'):format(identifier))
end
exports('GetDbIdFromIdentifier', GetDbIdFromIdentifier)

GetServerIdFromIdentifier = function(identifier)
    return GetResourceKvpInt(('%s:serverid'):format(identifier))
end
exports('GetServerIdFromIdentifier', GetServerIdFromIdentifier)

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