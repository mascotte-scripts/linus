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
    firstspawn = true
        SetResourceKvp(('users:%s:'):format(identifier), identifier)
		SetResourceKvp(('users:%s:CharacterData:firstname'):format(identifier), CharacterData[1])
		SetResourceKvp(('users:%s:CharacterData:lastname'):format(identifier), CharacterData[2])
		SetResourceKvp(('users:%s:CharacterData:gender'):format(identifier), CharacterData[3])
		SetResourceKvp(('users:%s:CharacterData:nation'):format(identifier), CharacterData[4])
		SetResourceKvp(('users:%s:CharacterData:dob'):format(identifier), CharacterData[5])
end)

RegisterNetEvent('Player:GetCharactersOutfit')
AddEventHandler('Player:GetCharactersOutfit', function()
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
