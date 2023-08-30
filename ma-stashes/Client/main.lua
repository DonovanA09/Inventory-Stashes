QBCore = exports['qb-core']:GetCoreObject()

local currentLocation = nil
local ininv = false


local function activateLoop(locationData)
    if currentLocation == locationData then
        return -- Evita reiniciar el bucle si ya está activo en esta ubicación
    end

    currentLocation = locationData

    CreateThread(function()
        while currentLocation == locationData do
            Wait(1) -- Espera 1 ms para reducir la carga
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)

            local distance = #(coords - locationData.coords)

            if distance < 2.5 then

                if not ininv then
                    exports['qb-core']:DrawText(locationData.Stash.msg, 'left')
                end
                HandleLocationInteraction(locationData)
            else
                exports['qb-core']:HideText()
            end
        end
    end)
end

local listen = false

Citizen.CreateThread(function()
    for location, locationData in pairs(Config.JobStashs) do
        local offsetZ = 5.0
        local circleCenter = vector3(locationData.coords.x, locationData.coords.y, locationData.coords.z)

        LoopZone = CircleZone:Create(circleCenter, 2.5, {
            name = location .. " Loop",
            debugPoly = false,
        })

        LoopZone:onPlayerInOut(function(isPointInside)
            local Player = QBCore.Functions.GetPlayerData()
            local playerJob = Player.job.name
            local playerGrade = Player.job.grade.level
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            

            if isPointInside and IsPlayerAuthorized(locationData, playerJob, playerGrade) then

                listen = true
                activateLoop(locationData)
            else
                listen = false
                ininv = false
                currentLocation = nil
            end
        end)
    end
    
    for location, locationData in pairs(Config.PublicStashs) do
        local circleCenter = vector3(locationData.coords.x, locationData.coords.y, locationData.coords.z)

        LoopZone = CircleZone:Create(circleCenter, 2.0, {
            name = location .. " Loop",
            debugPoly = false,
        })

        LoopZone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                listen = true
                activateLoop(locationData)
            else
                listen = false
                ininv = false
                currentLocation = nil
            end
        end)
    end
end)

function IsPlayerAuthorized(locationData, playerJob, playerGrade)
    if locationData.Stash.job == playerJob and (locationData.Stash.grade == 'all' or playerGrade >= locationData.Stash.grade) then
        return true
    else
        return false
    end
end

function HandleLocationInteraction(locationData)
    if IsControlJustReleased(0, 38) then -- E
        if locationData then
            local stashName = locationData.label
            local IsPersonal = locationData.Stash.personal

            if IsPersonal then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "stash_".. stashName .. "_" .. QBCore.Functions.GetPlayerData().citizenid)
                TriggerEvent("inventory:client:SetCurrentStash", "stash_".. stashName .. "_" .. QBCore.Functions.GetPlayerData().citizenid)
                ininv = true
                exports['qb-core']:HideText()

            else
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "stash_" .. stashName)
                TriggerEvent("inventory:client:SetCurrentStash", "stash_" .. stashName)
                ininv = true
                exports['qb-core']:HideText()
            end
        end
    end
end
