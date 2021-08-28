charid = 'char'
firstspawn = false

RegisterNetEvent('Multichar:InitiateServerSession')
AddEventHandler('Multichar:InitiateServerSession', function()
    local identifier = GetIdentifier(source)
        if not identifier then
            deferrals.done('Unknown Error. We could not find your identifier. Try restarting your FiveM game client')
        else if identifier then
            TriggerClientEvent('Multichar:InitiateClientSession', source)
        end 
    end
end)

RegisterNetEvent('Multichar:SetupCharacterData')
AddEventHandler('Multichar:SetupCharacterData', function(CharacterData)
     charid = CharacterData[6]
    local identifier = GetIdentifier(source, charid)
    local existingchars = GetIdentifier(source)
    firstspawn = true
    SaveCharacterDataToDB(source, identifier, charid, CharacterData)
end)

RegisterNetEvent('Player:GetCharactersOutfit')
AddEventHandler('Player:GetCharactersOutfit', function()
    print('Player:GetCharactersOutfit')
    local identifier = GetIdentifier(source, charid)
    local charappearance  = GetCharSkin(source, charid)
        if firstspawn then 
            TriggerClientEvent('Player:CreateNewCharacterOutfit', source)   
            firstspawn = false
        else
            TriggerClientEvent('Player:LoadCharacterOutfit', source, charappearance)
        end
end)

RegisterNetEvent('Player:SaveCharacterOutfit')
AddEventHandler('Player:SaveCharacterOutfit', function(appearance)
    local identifier = GetIdentifier(source, charid)
        SetResourceKvp(('users:%s:CharacterData:outfit'):format(identifier), json.encode(appearance))     
end)
