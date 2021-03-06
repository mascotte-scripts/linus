RegisterNetEvent('Admin:RequestPlayerPunishment')
AddEventHandler('Admin:RequestPlayerPunishment', function(type, dbId, reason)
    if IsPlayerAceAllowed(source, 'ace.perm') then
        local getIdentifier = GetIdentifierFromDbId(dbId)
        local playerId = GetServerIdFromIdentifier(getIdentifier)
        if (type == 'kick') then
            DropPlayer(playerId,"You have been kicked from the server \n Reason:".." "..reason)
        elseif type == 'ban' then
            exports.linus:banPlayer(playerId, reason)
        end
    end
end)

RegisterNetEvent('Admin:RequestPlayerList', function()
    local playerList = GetPlayerList()   
    TriggerLatentClientEvent('Admin:RecievePlayerList', source, 500, playerList)    
end)

RegisterNetEvent('AdminUI:CreateVehicle')
AddEventHandler('AdminUI:CreateVehicle', function(car)
    if IsPlayerAceAllowed(source, 'ace.perm') then
        local car = GetHashKey(car)
        local ped = GetPlayerPed(source)
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local coords = vector3(x + 2,y + 2,z + 1)
        local CreateAutomobile = GetHashKey('CREATE_AUTOMOBILE')
        local veh = Citizen.InvokeNative(CreateAutomobile, car, coords, 0.0)
    else
        print('Insufficient Permissions')
    end
end)

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