function CreateNewPlayerAppearance(source)
      print('hello!!!')
            local config = {
            ped = true,
            headBlend = true,
            faceFeatures = true,
            headOverlays = true,
            components = true,
            props = true,
          }
         local source = source
          local playerid = GetPlayerFromServerId(source)
            exports['fivem-appearance']:startPlayerCustomization(function (appearance)
                if (appearance) then
                print('Saved')        
                TriggerServerEvent('updatecharacterclothes', appearance)
                else
                print('Canceled')
                end
            end, config)
end