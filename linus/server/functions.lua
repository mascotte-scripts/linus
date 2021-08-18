char = 'char1'

GetIdentifier = function(source)
	local UsingMultiChar = GetConvar("UsingMultiChar", "true")
	if UsingMultiChar then
		for k,v in ipairs(GetPlayerIdentifiers(source)) do
			if string.match(v, 'license:') then
				local identifier = char..':'..string.gsub(v, 'license:', '')				
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

function CreateNewPlayer(source, identifier)
	local source = source
    SetResourceKvp(('users:%s:'):format(identifier), identifier)

end

function GetCharSkin(source)
	local source = source
    local identifier = GetIdentifier(source)
    local appearance =  GetResourceKvpString(('users:%s:outfit_current'):format(identifier))
    local charappearance = json.decode(appearance)
	return charappearance
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
