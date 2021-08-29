function SetSelectionScreenDisplay(bool)
	local isOpen = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = "ui",
		status = bool,
	})
end

function CreateNewPlayerAppearance()
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
		TriggerServerEvent('Player:SaveCharacterOutfit', appearance)
		else
		print('Canceled')
		end
	end, config)
end
