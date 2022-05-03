ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('esx_sup_blackmarket:buyItem')
AddEventHandler('esx_sup_blackmarket:buyItem', function(itemName, amount, price, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--local sourceItem = xPlayer.getInventoryItem(itemName)
	amount = ESX.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_sup_blackmarket: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end

	-- get price
	local itemLabel = ''
	price = price * amount

	-- can the player afford this item?
	if xPlayer.getAccount('black_money').money >= price then
		-- can the player carry the said amount of x item?
		if xPlayer.canCarryItem(itemName, amount) then
			xPlayer.removeAccountMoney('black_money', price)
            xPlayer.addInventoryItem(itemName, amount)
            ESX.pNotify(_source,_U('bought', amount, itemLabel, price), 3000)
        else
            ESX.pNotify(_source,'No puedes llevar mas ' .. itemName .. '', 3000)
        end
	else
		ESX.pNotify(_source,"No tienes suficiente dinero!")
	end
end)
