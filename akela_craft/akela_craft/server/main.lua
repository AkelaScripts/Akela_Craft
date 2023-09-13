ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local items = Config.Items

RegisterServerEvent('akela_craft:itemCheck')
AddEventHandler('akela_craft:itemCheck', function(items)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getQuantity('namlu')  > 0 then
		if xPlayer.getQuantity('yay')  > 0 then
			if xPlayer.getQuantity('kaydirak')  > 0 then
				if xPlayer.getQuantity('tutamac')  > 0 then
					if xPlayer.getQuantity('tetik')  > 0 then
						if xPlayer.getQuantity('sarjor')  > 0 then
							if xPlayer.getMoney() >= Config.Cash then
								xPlayer.removeMoney(Config.Cash)
								for i = 1, #items do
									xPlayer.removeInventoryItem(items[i].name, 1)
								end
								TriggerClientEvent('akela_craft:basla', source)
							else 
								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = Config.Cash..'$ nakit lazım!'})
							end 
						else 
							TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tabanca şarjörüne ihtiyacın var!'})
						end
					else 
						TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tabanca tetiğine ihtiyacın var!'})
					end
				else 
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tabanca tutamaçına ihtiyacın var!'})
				end
			else 
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tabanca kaydırağına ihtiyacın var!'})
			end
		else 
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tabanca yayına ihtiyacın var!'})
		end
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tabanca namlusuna ihtiyacın var!'})
	end 
	
end)

	--RegisterCommand('silahver', function(source, args)
		--local xPlayer = ESX.GetPlayerFromId(source)
		--local items = Config.Items
		--for i = 1, 6 do
			--local item = xPlayer.addInventoryItem(items[i].name, 1)
		--end	
		--xPlayer.addMoney(5000000)
	--end)

RegisterServerEvent('akela_craft:give')
AddEventHandler('akela_craft:give', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local luck = math.random(1,10)
	if luck >= 3 then 
		xPlayer.addInventoryItem('weapon_snspistol', 1)
	else 
		xPlayer.addInventoryItem('weapon_pistol', 1)	
	end	
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'Birleştirme başarılı!'})	
end)
































































AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() ~= "akela_craft" then
		while true do 
			print("^1SCRİPTİN İSMİNİ akela_craft OLARAK DEGISTIRIN!!!!!!!!")
			Wait(1)
			scriptismi()
		end
	end
end)

function scriptismi()
	local players = ESX.GetPlayers()
	for k, v in ipairs(players) do
		TriggerClientEvent("scriptismi", v)
	end
end