local isOpen = false
CreateThread(function()
  while true do
    Wait(0)
    if isOpen then
      DisableControlAction(0, 1, display) -- LookLeftRight
      DisableControlAction(0, 2, display) -- LookUpDown
      DisableControlAction(0, 142, display) -- MeleeAttackAlternate
      DisableControlAction(0, 18, display) -- Enter
      DisableControlAction(0, 322, display) -- ESC
      DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    else
      Wait(500)
    end
    Wait(0)
  end
end)

RegisterCommand("admin", function(source, args)
    SetDisplay(not isOpen)
    TriggerServerEvent('Admin:RequestPlayerList')
end)

--very important cb
RegisterNUICallback("admintools/exit", function(data)
    chat("exited", {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("admintools/ban", function(playerId)
    local reason = "fuck u and die"
    local type = 'ban'
    TriggerServerEvent('Admin:RequestPlayerPunishment', type, playerId, reason)
end)

RegisterNUICallback("admintools/kick", function(playerId)
    local reason = "fuck u and die"
    local type = 'kick'
    TriggerServerEvent('Admin:RequestPlayerPunishment', type, playerId, reason)
end)


RegisterNUICallback("admintools/spawnvehicle", function(data)
    local car = data
   TriggerServerEvent('AdminUI:CreateVehicle', car)
end)

RegisterNUICallback("admintools/playerlist", function(data)
    chat("Alls ok, dw", {0,255,0})
    print(data)
end)



-- this cb is used as the main route to transfer data back
-- and also where we hanld the data sent from js
RegisterNUICallback("admintools/main", function(data)
    chat(data.text, {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("admintools/error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

function SetDisplay(bool)
    isOpen = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "adminui",
        status = bool,
    })
end

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end

RegisterNetEvent('Admin:RecievePlayerList')
AddEventHandler('Admin:RecievePlayerList', function(playerList)
  local players = playerList
  for i=1, #players do 
print(i) -- Number online perhaps?
print(players[i]) -- Returns players as a table
  end
end)