function SetSelectionScreenDisplay(bool, Character1Data, Character2Data)
	local isOpen = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = "ui",
		status = bool,
		Char1InfoFName = Character1Data.FirstName,
		Char1InfoLName = Character1Data.LastName,
		Char2InfoFName = Character2Data.FirstName,
		Char2InfoLName = Character2Data.LastName,
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

