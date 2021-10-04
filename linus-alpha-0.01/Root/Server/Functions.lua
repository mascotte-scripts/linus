Database = {}
UsableItems = {}


function Register.Command(Command, Group, CB, Suggestion, Description)
    RegisterCommand(Command, function(source, args, rawCommand)
        local PlayerSource = Player(source)
        local Identifier = PlayerSource.Identifier()
        if (Group == PlayerSource.GetGroup() or Group == "None") then
            CB(source, args, rawCommand)
        end
    end, false)
    TriggerClientEvent("chat:addSuggestion", -1, "/".. Command, Suggestion, Description)
end

Register.Item = function(Name, CB)
    UsableItems[Name] = CB
end