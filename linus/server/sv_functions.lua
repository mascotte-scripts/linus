  function GetIdentifier(source, charid)
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

function GetCharacterID(identifier)
    return GetResourceKvpString(('users:%s:CharID'):format(identifier))
end

function GetCharSkin(identifier)
    local appearance =  GetResourceKvpString(('users:%s:CharacterData:outfit'):format(identifier))
    local charappearance = json.decode(appearance)
	return charappearance
end

function SaveCharSkinToDB(identifier, appearance)
	SetResourceKvp(('users:%s:CharacterData:outfit'):format(identifier), json.encode(appearance))  
end

function SaveCharacterDataToDB(identifier, CharacterData)
    local data = json.encode(CharacterData)
		SetResourceKvp(('users:%s:CharacterData:chardetails'):format(identifier), data)
    print('character saved')
end

function GetCharacter1()
    local identifier = GetIdentifier(source, 'char1')
    print('Retrieving character data via KVS')
    local chardata = GetResourceKvpString(('users:%s:CharacterData:chardetails'):format(identifier))
    local data = json.decode(chardata)
    return data
end


function GetCharacter2()
    local identifier = GetIdentifier(source, 'char2')
    print('Retrieving character data via KVS')
    local chardata = GetResourceKvpString(('users:%s:CharacterData:chardetails'):format(identifier))
    local data = json.decode(chardata)
    return data
end

function GetPlayerList()
    local players = GetPlayers()
    local playerList = {}
    for i = 1, #players do
      local playerId = tonumber(players[i])
      local name = GetPlayerName(playerId)
      playerList[playerId] = name
    end
    return playerList
end

function getPlayerFromIdentifier(identifier)
	local players = GetPlayers()
	for i = 1, #players do
		local playerId = tonumber(players[i])
		for _, id in pairs(GetPlayerIdentifiers(playerId)) do
			if id == identifier then
				return playerId
			end
		end
	end
	return -1
end
exports('getPlayerFromIdentifier', 'getPlayerByIdentifier')

function SetStartingCash(identifier, account, amount)
    if account == 'wallet' then
    SetResourceKvpInt(('users:%s:CharacterData:wallet'):format(identifier), amount)
    elseif account =='bank' then
    SetResourceKvpInt(('users:%s:CharacterData:bank'):format(identifier), amount)
    else
        print('Unknown Error! Function: SetStartingCash()')
    end
end

function GetBalance(identifier, account)
    if account == 'wallet' then
        local balance =  GetResourceKvpInt(('users:%s:CharacterData:wallet'):format(identifier))
        return balance
    elseif account =='bank' then
       local balance = GetResourceKvpInt(('users:%s:CharacterData:bank'):format(identifier))
       return balance
    else
        print('Unknown Error! Function: GetBalance()')
        return nil
    end
end

function AddAccountMoney(source, identifier, account, amount)
    local wallet = GetBalance(identifier, 'wallet')
    local bank = GetBalance(identifier, 'bank')
    if account == 'wallet' then 
            local sum = wallet + amount
            local newbalance = SetResourceKvpInt(('users:%s:CharacterData:wallet'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudWalletBalance', source)
    elseif account == 'bank' then
            local sum = bank + amount
            local newbalance = SetResourceKvpInt(('users:%s:CharacterData:bank'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudBankBalance', source)
    else
        print('Unknown Error: Function AddAccountMoney()')
    end
end

function GiveAccountMoney(identifier, account, amount)
    local wallet = GetBalance(identifier, 'wallet')
    local bank = GetBalance(identifier, 'bank')
    if account == 'wallet' then 
            local sum = wallet + amount
            local newbalance = SetResourceKvpInt(('users:%s:CharacterData:wallet'):format(identifier), sum)
    elseif account == 'bank' then
            local sum = bank + amount
            local newbalance = SetResourceKvpInt(('users:%s:CharacterData:bank'):format(identifier), sum)
    else
        print('Unknown Error: Function GiveAccountMoney()')
    end
end

function RemoveAccountMoney(source, identifier, account, amount)
    local wallet = GetBalance(identifier, 'wallet')
    local bank = GetBalance(identifier, 'bank')
    if account == 'wallet' then 
            local sum = wallet - amount
            local newbalance = SetResourceKvpInt(('users:%s:CharacterData:wallet'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudWalletBalance', source)
    elseif account == 'bank' then
            local sum = bank - amount
            local newbalance = SetResourceKvpInt(('users:%s:CharacterData:bank'):format(identifier), sum)
        TriggerClientEvent('Player:UpdateHudWalletBalance', source)
    else
        print('Unknown Error: Function RemoveAccountMoney()')
    end
end

-- a sequence field using KVS
function incrementId()
    local nextId = GetResourceKvpInt('nextId')
    nextId = nextId + 1
    SetResourceKvpInt('nextId', nextId)

    return nextId
end

-- Function that retrives the identifiered tied to a characters DB ID

function SetIdentifierToDbId(playerId, identifier)
    return SetResourceKvp(('%s:identifier'):format(playerId), identifier) and SetResourceKvpInt(('%s:id'):format(identifier), playerId)
end

function GetIdentifierFromDbId(playerId)
    local result = GetResourceKvpString(('%s:identifier'):format(playerId))
    return result
end

function GetDbIdFromIdentifier(identifier)
    local result = GetResourceKvpInt(('%s:id'):format(identifier))
    return result
end

-- Test Command, will be removed at some point 

RegisterCommand('Data', function(source, args)
    if not args[1] then
        print('Usage:')
        print('\tplayerData getId <dbId>: gets identifiers for ID')
        print('\tplayerData getIdentifier <identifier>: gets ID for identifier')

        return
    end

    if args[1] == 'getId' then
        local id = args[2]
        local resultfunction = GetIdentifierFromDbId(id)
        print(resultfunction)
    
    elseif args[1] == 'getIdentifier' then
        print('result:', GetDbIdFromIdentifier(args[2]))

    elseif args[1] == 'giveaccountcash' then
        local account = args[2]
        local pid = tonumber(args[3])
        local amount = tonumber(args[4])
        print(account)
        print(pid)
        print(amount)
        local getIdentifier = GetIdentifierFromDbId(pid)
        print(getIdentifier)

        GiveAccountMoney(source, getIdentifier, account, amount) 

    end
end, true)