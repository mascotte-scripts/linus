RegisterNetEvent('fivemappearance:saveclothes')
AddEventHandler('fivemappearance:saveclothes', function(source, appearance)

getPlayersIdFromIdentifier(identifier)
  
print(identifier)
SetResourceKvp(format('player_clothes_%s', identifier), json.encode(appearance))
print('saved with kvs')


end)

-- gets the ID tied to an identifier in the schema, or nil
function getPlayersIdFromIdentifier(identifier)
    local str = GetResourceKvpString(('identifier:%s'):format(identifier))

    if not str then
        return nil
    end

    return msgpack.unpack(str).id
end