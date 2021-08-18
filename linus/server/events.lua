RegisterNetEvent('onPlayerJoined')
AddEventHandler('onPlayerJoined', function()
    local identifier = GetIdentifier(source)
    local existingid = GetResourceKvpString(('users:%s:'):format(identifier), identifier)
        if not identifier then
            deferrals.done('Unknown Error. We could not find your identifier. Try restarting your FiveM game client')
        else if identifier then
           TriggerEvent('player:loadplayer', source, identifier, existingid)
        end 
    end
end)

RegisterNetEvent('player:loadplayer')
AddEventHandler('player:loadplayer', function(source, identifier, existingid)
        if existingid then 
                print(('Joined: %s'):format(identifier))
        else if not existingid then
                CreateNewPlayer(source, identifier)
                else
                print('Unknown Error')
        end
    end
end)

RegisterNetEvent('updatecharacterclothes')
AddEventHandler('updatecharacterclothes', function(appearance)
    local identifier = GetIdentifier(source)
        SetResourceKvp(('users:%s:outfit_current'):format(identifier), json.encode(appearance))
        print('outfit saved to db')
end)

RegisterNetEvent('getcharacterclothes')
AddEventHandler('getcharacterclothes', function()
    local source = source
    local charappearance  = GetCharSkin(source)
    TriggerClientEvent('player:loadcharacterclothes', source, charappearance)
end)

RegisterNetEvent('Admin:RequestPlayerList', function()
    local playerList = GetPlayerList()   
    TriggerLatentClientEvent('Admin:RecievePlayerList', source, 500, playerList)    
end)
