
ESX                             = nil

local PlayerData                = {}
local uyku = 3500

local kazmaAkrif = false
local yikamaAktif = false
local eritmeAktif = false
local zaman = 0
local lokasyon = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(100)
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('yatzzz:zaman')
AddEventHandler('yatzzz:zaman', function()
    local zaman = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while zaman > -1 do
			Citizen.Wait(150)

			if zaman > -1 then
				zaman = zaman + 1
            end
            if zaman == 100 then
                break
            end
		end
    end) 

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(4)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.YikamaX, Config.YikamaY, Config.YikamaZ, true) < 5 then
                Draw3DText( Config.YikamaX, Config.YikamaY, Config.YikamaZ+0.5 -1.400, ('Taslar yıkanıyor ' .. zaman .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.EritmeX, Config.EritmeY, Config.EritmeZ, true) < 5 then
                Draw3DText( Config.EritmeX, Config.EritmeY, Config.EritmeZ+0.5 -1.400, ('Taslar isleniyor ve ayıklanıyor ' .. zaman .. '%'), 4, 0.1, 0.1)
            end
            if zaman == 100 then
                zaman = 0
                break
            end
        end
    end)
end)

RegisterNetEvent('yatzzz:kaz')
AddEventHandler('yatzzz:kaz', function()
    ESX.TriggerServerCallback("ytz-checkitem", function(output)
        if output then
            TriggerEvent('mythic_progbar:client:progress', {
                name = 'kaz',
                duration = 6000,
                label = 'Taş Kazıyorsun...',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "melee@large_wpn@streamed_core",
                    anim = "ground_attack_on_spot",
                },
            }, function(status)
                if not status then
                    TriggerServerEvent('yatzzz:tasver')
                end
            end)
        elseif not output then 
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Taş kırdın"})
        end
    end)
end)

Citizen.CreateThread(function()
    local send = false
    while true do
        Citizen.Wait(12)
		perform = false
		isInMarker = false
        for i=1, #lokasyon, 1 do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, lokasyon[i].x, lokasyon[i].y, lokasyon[i].z)

            if dist < 4.0 then
                perform = true
                DrawMarker(20, lokasyon[i].x, lokasyon[i].y, lokasyon[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.301, 1.3001, 1.3001, 205, 250, 200, 255, 0, 0, 0, 1, 0, 0, 0)
                isInMarker = true
                send = true
                exports["yatzzz-ui"]:DrawNotify("kaz", "Kazmaya başlamak İçin [E] Bas", nil)
                
                if IsControlJustPressed(0, 38) then
                    TriggerEvent('yatzzz:kaz')
                    kazmaAkrif = true
                end
                if perform then
                    uyku = 10
                elseif not perform then
                    uyku = 10000
                end
            else
                if send then
                    send = false
                    exports["yatzzz-ui"]:Clear("kaz")
                end
            end
        end
    end
end)

RegisterNetEvent('yatzzz:yika')
AddEventHandler('yatzzz:yika', function()
    ESX.TriggerServerCallback("ytz-checkitem", function(output)
        if output then
            TriggerEvent('mythic_progbar:client:progress', {
                name = 'yika',
                duration = 6000,
                label = 'Taşlar Yıkanıyor...',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@prop_human_bum_bin@idle_a",
                    anim = "idle_a",
                },
            }, function(status)
                if not status then
                    TriggerServerEvent('yatzzz:taslarıyika')
                    TriggerEvent("yatzzz:zaman")
                end
            end)
        elseif not output then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Üzerinde yeterli taş yok"})
        end
    end, "stones")
end)

Citizen.CreateThread(function()
    local send = false
    while true do
        Citizen.Wait(12)
		perform = false
		isInMarker = false

        local plyCoords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.YikamaX, Config.YikamaY, Config.YikamaZ)

        if dist < 4.0 then
            perform = true
            DrawMarker(20, 1916.2, 582.44, 176.37, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.301, 1.3001, 1.3001, 205, 250, 200, 255, 0, 0, 0, 1, 0, 0, 0)
			isInMarker = true
            send = true
            exports["yatzzz-ui"]:DrawNotify("yika", "Taşları Yıkamak İçin [E] Bas", nil)
            
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent("yatzzz:taslarıyika")
                local yikamaAktif = false
            end
            if perform then
                uyku = 10
            elseif not perform then
                uyku = 10000
            end
        else
            if send then
                send = false
                exports["yatzzz-ui"]:Clear("yika")
            end
        end
    end
end)

RegisterNetEvent('yatzzz:erit')
AddEventHandler('yatzzz:erit', function()
    ESX.TriggerServerCallback("ytz-checkitem", function(output)
        if output then
            TriggerEvent('mythic_progbar:client:progress', {
                name = 'erit',
                duration = 6000,
                label = 'Taşlar Eritiliyor...',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@prop_human_bum_bin@idle_a",
                    anim = "idle_a",
                },
            }, function(status)
                if not status then
                    TriggerServerEvent('yatzzz:taserit')
                end
            end)
        elseif not output then 
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Yıkanmış Taşın Yok"})
        end
    end, "washedstones")
end)

Citizen.CreateThread(function()
    local send = false
    while true do
        Citizen.Wait(12)
		perform = false
		isInMarker = false

        local plyCoords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.EritmeX, Config.EritmeY, Config.EritmeZ)

        if dist < 4.0 then
            perform = true
            DrawMarker(20, 1109.03, -2007.61, 30.94, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.301, 1.3001, 1.3001, 205, 250, 200, 255, 0, 0, 0, 1, 0, 0, 0)
			isInMarker = true
            send = true
            exports["yatzzz-ui"]:DrawNotify("erit", "Taşları Eritmek İçin [E] Bas", nil)
            
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent("yatzzz:taserit")
                local eritmeAktif = false
            end
            if perform then
                uyku = 10
            elseif not perform then
                uyku = 10000
            end
        else
            if send then
                send = false
                exports["yatzzz-ui"]:Clear("erit")
            end
        end
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end