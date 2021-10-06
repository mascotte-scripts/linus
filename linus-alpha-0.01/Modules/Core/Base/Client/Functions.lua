function SetSelectionScreenDisplay(bool)
	local isOpen = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = "ui",
		status = bool,
	})
end

function UpdateNUICharacterDisplay(firstname, lastname, char)
	if char == 1 then
		SendNUIMessage({
			type = "ui",
			Char1Name = firstname or '',
			Char1LastName = lastname or '',
		})
	elseif char == 2 then 
		SendNUIMessage({
			type = "ui",
			Char2Name = firstname or '',
			Char2LastName = lastname or '',
		})
	elseif char == 3 then 
		SendNUIMessage({
			type = "ui",
			Char3Name = firstname or '',
			Char3LastName = lastname or '',
		})
	elseif char == 4 then 
		SendNUIMessage({
			type = "ui",
			Char4Name = firstname or '',
			Char4LastName = lastname or '',
		})
	end
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
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
		print('Saved')        
		TriggerServerEvent('Player:SaveCharacterOutfit', appearance)
		else
		print('Canceled')
		end
	end, config)
end

function SetHUDAccountBalance(source, type, amount)
    if type == 'wallet' then
		local accountwallet = `MP0_WALLET_BALANCE`
        local sum = amount
        StatSetInt(accountwallet, math.floor(sum), true)
    elseif type == 'bank' then
		local accountbank = `BANK_BALANCE`
        local sum = amount
        StatSetInt(accountbank, math.floor(sum), true)
    else
        print('An unknown error occured while attempting to find this account')
    end
end
