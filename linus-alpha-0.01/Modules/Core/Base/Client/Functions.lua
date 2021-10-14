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
		TriggerServerEvent('Player:SaveCharacterOutfit', appearance)
		else
		print('Canceled')
		end
	end, config)
end

function SetHUDAccountBalance(type, sum)
    if type == 'wallet' then
		local accountwallet = `MP0_WALLET_BALANCE`
        StatSetInt(accountwallet, math.floor(sum), true)
    elseif type == 'bank' then
		local accountbank = `BANK_BALANCE`
        StatSetInt(accountbank, math.floor(sum), true)
    else
        print('An error occured: SetHUDAccountBalance(type, sum)')
    end
end
