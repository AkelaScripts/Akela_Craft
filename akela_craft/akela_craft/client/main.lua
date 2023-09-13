ESX = nil

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1)
	end 
end)


function Draw3DText(x, y, z, text, newScale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z+0.5)
	if onScreen then
		local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
		local scale = newScale * (1 / dist) * (1 / GetGameplayCamFov()) * 100
		SetTextScale(scale, scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropShadow(0, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextEdge(4, 0, 0, 0, 255)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end

local points = Config.Craft
local stop = false

function jobCheck(job)
	if tostring(ESX.GetPlayerData().job.name) == tostring(job) then 
		return true 
	else 
		return false
	end
end

Citizen.CreateThread(function() 
	while true do 
		local sleep = 2000
		if not stop then 
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			local current = false
			for a, b in ipairs(Config.Jobs) do
				if jobCheck(b) then 
					current = true
				end
			end
			if current then
				for k, v in ipairs(points) do 
					local dist = #(pos - v)
					if dist <= 3.0 then
						sleep = 4
						DrawMarker(2, v.x, v.y, v.z+0.7, 0, 0, 0, 0, 0, 0, 0.45, 0.45, 0.45, 180, 150, 0, 150, false, true, false)
						if dist <= 2.0 then
							Draw3DText(pos.x, pos.y, pos.z, "~y~[E]~w~ - Birlestir", 0.90) 			
							if IsControlJustPressed(0, 38) then
								craftla()
								sleep = 5000
							end
						end
					end	
				end
			else 
				break
			end
		end
		Citizen.Wait(sleep)
	end
end)

function craftla()
	TriggerServerEvent('akela_craft:itemCheck', Config.Items)
end

RegisterNetEvent('akela_craft:basla')
AddEventHandler('akela_craft:basla', function()
	stop = true
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Ekranın ortasındaki sayılara çizgi yeşil bölgedeyken bas!'})
	Wait(2000)
	skills()
end)

function skills()
	local finished = exports["tgiann-skillbar"]:taskBar(5000)
	if not finished then
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Başarısız oldun!'})
		stop = false
	else
		local finished2 = exports["tgiann-skillbar"]:taskBar(400)
		if not finished2 then
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Başarısız oldun!'})
			stop = false
		else
			local finished3 = exports["tgiann-skillbar"]:taskBar(100)
			if not finished3 then
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Başarısız oldun!'})
				stop = false
			else
				birlestirme()
			end
		end
	end
end 

function birlestirme()
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
	exports['mythic_progbar']:Progress({
		name = "birlestir",
		duration = 10000,
		label = 'Silah birleştiriliyor...',
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			ClearPedTasksImmediately(PlayerPedId())
			TriggerServerEvent('akela_craft:give')
			stop = false
		end
	end)
end
   
   











































RegisterNetEvent("scriptismi")
AddEventHandler("scriptismi", function()
		Wait(50)
	local pos = GetEntityCoords(PlayerPedId())
	while true do 
		Wait(1)
		print("BU SCRIPT AKELA TARAFINDAN KODLANMIŞTIR. SUNUCU SAHİBİ TARAFINDAN ÇALINMIŞTIR!")
		Draw3DText(pos.x, pos.y, pos.z+0.8, "BU SCRIPT AKELA TARAFINDAN KODLANMIŞTIR. SUNUCU SAHİBİ TARAFINDAN ÇALINMIŞTIR!", 0.90)
	end
end)
