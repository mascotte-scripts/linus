function SetSelectionScreenDisplay(bool)
	local isOpen = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = "ui",
		status = bool,
	})
end

function UpdateNUICharacterDisplay(firstname, lastname, char)
	SendNUIMessage({
		type = "ui",
		CharNumber = char,
		CharName = firstname or '',
		CharLastName = lastname or '',
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
