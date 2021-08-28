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

function GetCharacterID(source, identifier)
    return GetResourceKvpString(('users:%s:CharID'):format(identifier))
end

function GetCharSkin(source, charid)
    local identifier = GetIdentifier(source, charid)
    local appearance =  GetResourceKvpString(('users:%s:CharacterData:outfit'):format(identifier))
    local charappearance = json.decode(appearance)
	return charappearance
end

function GetCharacterData(source, identifier)
    local CharacterData = {
    ["firstname"] =	GetResourceKvpString(('users:%s:CharacterData:firstname'):format(identifier)),
	["lastname"] =	GetResourceKvpString(('users:%s:CharacterData:lastname'):format(identifier)),
	["gender"] = 	GetResourceKvpString(('users:%s:CharacterData:gender'):format(identifier)),
	["nation"] = 	GetResourceKvpString(('users:%s:CharacterData:nation'):format(identifier)),
	["dob"] = 	    GetResourceKvpString(('users:%s:CharacterData:dob'):format(identifier))
    }
    return CharacterData
end

function SaveCharacterDataToDB(source, identifier, charid, CharacterData)
    print('Saving character data via KVS')
		SetResourceKvp(('users:%s:CharacterData:firstname'):format(identifier), CharacterData[1])
		SetResourceKvp(('users:%s:CharacterData:lastname'):format(identifier), CharacterData[2])
		SetResourceKvp(('users:%s:CharacterData:gender'):format(identifier), CharacterData[3])
		SetResourceKvp(('users:%s:CharacterData:nation'):format(identifier), CharacterData[4])
		SetResourceKvp(('users:%s:CharacterData:dob'):format(identifier), CharacterData[5])
    print('char saved')
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
