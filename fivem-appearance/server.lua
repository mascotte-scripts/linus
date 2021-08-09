RegisterNetEvent('fivemappearance:saveclothes')
AddEventHandler('fivemappearance:saveclothes', function(source, appearance)

getPlayersIdFromIdentifier(identifier)
  
print(identifier)
SetResourceKvp(format('player_clothes_%s', identifier), json.encode(appearance))
print('saved with kvs')


end)

