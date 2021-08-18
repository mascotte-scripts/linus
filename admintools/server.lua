RegisterNetEvent('Admin:RequestPlayerPunishment')
AddEventHandler('Admin:RequestPlayerPunishment', function(type, playerId, reason)
    local playerId = tonumber(playerId)
     if IsPlayerAceAllowed(source, 'ace.perm') then
    if (type == 'kick') then
        DropPlayer(playerId, reason)
    else
        exports.Valkyrie:banPlayer(playerId, reason)
    end
      end
end)


