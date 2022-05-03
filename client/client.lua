ESX = nil

local PlayerData, sellerPeds, changing, MenuOn = {}, {}, false, false

local Goons = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:SupremeObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	VerPuntos()

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	changing = true
	ESX.PlayerData.job = job
	Citizen.Wait(5000)
end)

VerPuntos = function ()
	changing = false

	local pedcoords
    while not NetworkIsSessionStarted() do Wait(0) end
        for k, v in pairs(Config.Zones) do
			RequestAnimDict("mini@strip_club@idles@bouncer@base")
            while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
              Wait(1)
            end
            sellerPeds[k] = createPed(v.Ped.pedHash, v.Ped.seller.coords-vector3(0.0,0.0,1.0), v.Ped.seller.heading, false)  
            FreezeEntityPosition(sellerPeds[k], true) 
		    pedcoords = v.Ped.seller.coords+vector3(0.0,0.0,0.5)
			Goons = v.Goons
        end
    while true do
		Wait(0)
        local sleep = true
        local me = PlayerPedId()
		--local jobName = Config.Gangs

		if changing then
			break
		end


		for k, v in pairs(sellerPeds) do
			if DoesEntityExist(v) then
				--if exports.esx_sup_funciones:isJob(jobName) then
				if isGang() then
					local coords = GetDistanceBetweenCoords(GetEntityCoords(me), pedcoords, true) 
					if (coords < 5) then
						sleep = false
						ESX.Supreme3DText(pedcoords, _U('press_menu'), 0.75, 4, 50)
					end
					if (coords < 3) then
						if Notify(pedcoords, _U('press_menu')) then
							OpenShopMenu()
						end
					end
				else
					local coords = GetDistanceBetweenCoords(GetEntityCoords(me), pedcoords, true) 
					if (coords < 5) then
						sleep = false
						ESX.Supreme3DText(pedcoords, _U('gtfo'), 0.75, 4, 50)
					end
					if (coords < 3) then
						if Notify(pedcoords, _U('gtfo')) then
							if not goonsCooldown then
								TriggerEvent("esx_sup_funciones:Goons", pedcoords, Goons)
							end
						end
					end
				end
			end
		end
		if sleep then Wait(500) end
    end
end

OpenShopMenu = function()
	MenuOn = true
	local elements = {}

	for k, v in ipairs(Config.Zones.BlackMarket.Items) do	
		local item  = v.item
		local price = v.price
		local label = v.label

		table.insert(elements, {
			label      = label .. ' - <span style="color: red;">' .. price .. '$</span>',
			label_real = label,
			item       = item,
			price      = price,
			-- menu properties
			value      = 1,
			type       = 'slider',
			min        = 1,
			max        = 5
		})
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title    = _U('shop'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title    = _U('shop_confirm', data.current.value, data.current.label_real, data.current.price * data.current.value),
			align    = 'bottom-right',
			elements = {
				{label = _U('no'),  value = 'no'},
				{label = _U('yes'), value = 'yes'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				TriggerServerEvent('esx_sup_blackmarket:buyItem', data.current.item, data.current.value, data.current.price, zone)
			end
			menu2.close()
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		MenuOn = false
	end)
end

createPed = function(hash, coords, heading, networked)
    while not HasModelLoaded(hash) do Wait(0) RequestModel(hash) end
    local ped = CreatePed(4, hash, coords, heading, networked, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
	TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    return ped
end

isGang = function()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs(Config.Gangs) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end 

Notify = function(position, text)
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)

	if not MenuOn then
		if #(playerCoords - position) < 1.0 then
			ESX.Supreme3DText(position, text)
	    		if IsControlJustReleased(0, 38) then
		    		return true
				end
		end
	end
end