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
