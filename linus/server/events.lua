firstspawn = false

--AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
  --  local identifier = GetIdentifier(source)
   -- local existingid = GetResourceKvpString(('users:%s:'):format(identifier), identifier)
     --   if not identifier then
       --     deferrals.done('Unknown Error. We could not find your identifier. Try restarting your FiveM game client')
        --else if identifier then
          -- TriggerEvent('player:loadplayer', source, identifier, existingid)
        --end 
    --end
--end)

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
               TriggerEvent('player:getplayerfunds')
        else if not existingid then
                CreateNewPlayer(source, identifier)
                TriggerClientEvent('player:createcharacter', source, existingid)
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
    print('made it here')
    local source = source
  local charappearance  = GetCharSkin(source)
    TriggerClientEvent('player:loadcharacterclothes', source, charappearance)
end)


-- Not fully working yet

RegisterNetEvent('player:getplayerfunds')
AddEventHandler('player:getplayerfunds', function()
    print('balance loaded')
    local source = source
    local identifier = GetIdentifier(source)
    local playerbank = getMoneyForId(source, identifier, bank)
    local playercash = getMoneyForId(source, identifier, cash)
    TriggerClientEvent('player:updatedbalance', source, playerbank, playercash)
end)
