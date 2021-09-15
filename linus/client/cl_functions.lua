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
		local playerid = GetPlayerServerId(source)
		local stringbalance = NetworkGetStringWalletBalance(playerid)
		local intbalance = stringbalance:sub(2)
		local sum = amount
		local moneyType = wallet
		StatSetInt(GetHashKey("MP0_WALLET_BALANCE"), math.floor(sum), true)
	elseif type == 'bank' then
		local playerid = GetPlayerFromServerId()
		local stringbalance = NetworkGetStringBankBalance(playerid)
		local intbalance = stringbalance:sub(2)
		local sum = amount
		local moneyType = bank
		StatSetInt(GetHashKey("BANK_BALANCE"), math.floor(sum), true)
	else
		print('An unknown error occured while attempting to finding this account')
	end
end
