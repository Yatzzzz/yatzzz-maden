ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("yatzzz:tasver")
AddEventHandler("yatzzz:tasver", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('stones').count < 40 then
            xPlayer.addInventoryItem('stones', math.random(1,5))
            TriggerClientEvent('esx:showNotification', source, 'Taş kırdın.')
        end
    end
end)

RegisterNetEvent("yatzzz:taslarıyika")
AddEventHandler("yatzzz:taslarıyika", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('stones').count > 9 then
            TriggerClientEvent("yatzzz:yika", source)
            Citizen.Wait(15900)
            xPlayer.addInventoryItem('washedstones', 10)
            xPlayer.removeInventoryItem("stones", 10)
        elseif xPlayer.getInventoryItem('stones').count < 10 then
            TriggerClientEvent('esx:showNotification', source, 'Üzerinde yeterli taş yok.')
        end
    end
end)

RegisterNetEvent("yatzzz:taserit")
AddEventHandler("yatzzz:taserit", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('washedstones').count > 9 then
            TriggerClientEvent("yatzzz:erit", source)
            Citizen.Wait(15900)
            if randomChance < 5 then
                xPlayer.addInventoryItem("diamond", 1)
                xPlayer.removeInventoryItem("washedstones", 10)
                TriggerClientEvent('esx:showNotification', _source, '10 taş yıkayıp 1 elmas buldun.')
            elseif randomChance > 9 and randomChance < 25 then
                xPlayer.addInventoryItem("gold", math.random(1,5))
                xPlayer.removeInventoryItem("washedstones", 10)
                TriggerClientEvent('esx:showNotification', _source, '10 taş yıkayıp bir miktar altın buldun.')
            elseif randomChance > 24 and randomChance < 50 then
                xPlayer.addInventoryItem("iron", math.random(5,10))
                xPlayer.removeInventoryItem("washedstones", 10)
                TriggerClientEvent('esx:showNotification', _source, '10 taş yıkayıp bir miktar demir buldun.')
            elseif randomChance > 49 then
                xPlayer.addInventoryItem("copper", math.random(10,20))
                xPlayer.removeInventoryItem("washedstones", 10)
                TriggerClientEvent('esx:showNotification', _source, '10 taş yıkayıp bir miktar bakır buldun.')
            end
        elseif xPlayer.getInventoryItem('stones').count < 10 then
            TriggerClientEvent('esx:showNotification', source, 'Yeterli miktarda taşınız yok.')
            TriggerClientEvent('esx:showNotification', source, 'Minimum 10 taşınızın olması gerekmektedir.')
        end
    end
end)

ESX.RegisterServerCallback('ytz-checkitem', function(source, cb, item, output)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end
end)