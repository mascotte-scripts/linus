function SetSelectionScreenDisplay(bool, firstname1, lastname1, firstname2, lastname2)
	local isOpen = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = "ui",
		status = bool,
		Char1InfoFName = firstname1,
		Char1InfoLName = lastname1,
		Char2InfoFName = firstname2,
		Char2InfoLName = lastname2,
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
