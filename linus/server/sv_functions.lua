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

function SaveCharacterDataToDB(identifier, playeridentifier, CharacterData)
    print('Saving character data via KVS')
		SetResourceKvp(('users:%s:CharacterData:firstname'):format(identifier), CharacterData[1])
		SetResourceKvp(('users:%s:CharacterData:lastname'):format(identifier), CharacterData[2])
		SetResourceKvp(('users:%s:CharacterData:gender'):format(identifier), CharacterData[3])
		SetResourceKvp(('users:%s:CharacterData:nation'):format(identifier), CharacterData[4])
		SetResourceKvp(('users:%s:CharacterData:dob'):format(identifier), CharacterData[5])
        SetResourceKvp(('users:%s:CharacterData:job'):format(identifier), 'Unemployed')
    print('char saved')

end

function GetCharacter1()

    local identifier = GetIdentifier(source, 'char1')
    print('Retrieving character data via KVS')
    local Character1Data = { -- Perhaps table is the issue?
        FirstName = GetResourceKvpString(('users:%s:CharacterData:firstname'):format(identifier)),
        LastName = GetResourceKvpString(('users:%s:CharacterData:lastname'):format(identifier)),
        Gender = GetResourceKvpString(('users:%s:CharacterData:gender'):format(identifier)),
        Nation = GetResourceKvpString(('users:%s:CharacterData:nation'):format(identifier)),
        Dob = GetResourceKvpString(('users:%s:CharacterData:dob'):format(identifier)),
}

return Character1Data

end


function GetCharacter2()

    local identifier = GetIdentifier(source, 'char2')
    print('Retrieving character data via KVS')
    local Character2Data = { -- Perhaps table is the issue?
        FirstName = GetResourceKvpString(('users:%s:CharacterData:firstname'):format(identifier)),
        LastName = GetResourceKvpString(('users:%s:CharacterData:lastname'):format(identifier)),
        Gender = GetResourceKvpString(('users:%s:CharacterData:gender'):format(identifier)),
        Nation = GetResourceKvpString(('users:%s:CharacterData:nation'):format(identifier)),
        Dob = GetResourceKvpString(('users:%s:CharacterData:dob'):format(identifier)),
}

return Character2Data

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
