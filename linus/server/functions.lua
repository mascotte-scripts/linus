-- For testing sake, default char value is equal to char1
-- Needs full implementation

char = 'char1'

-- Function that gets the identifier
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

-- @parma identifier | string | player identifier with prefix('license:xxxxx')
-- @return int | playerId or -1 if no player is found
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

-- Saves person to DB
-- This will be set by an NUI at some point
function CreateNewPlayer(source, identifier, playerdata)
	local source = source
    SetResourceKvp(('users:%s:'):format(identifier), identifier)
	SetResourceKvp(('users:%s:%s'):format(identifier, playerdata), identifier, playerdata)
    print('CreateNewPlayer function')
end


function GetCharSkin(source)
	local source = source
    local identifier = GetIdentifier(source)
    local appearance =  GetResourceKvpString(('users:%s:outfit_current'):format(identifier))
    local charappearance = json.decode(appearance)

	return charappearance
end

-- Gets cash as a string, need to substring it

function getMoneyForId(source, identifier, moneyType)
	local source = source
    return GetResourceKvpInt(('money:%s:%s'):format(identifier, moneyType))
end
