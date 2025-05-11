ESX = exports['es_extended']:getSharedObject()

local sleep = 750
local custom = nil
local last_custom = nil
local size1 = 0
local mathed = false
local grasses = nil
local trashes = nil
local planted = false
local grass_list = {}
local trash_list = {}
local onjob = false
local tasks = 0
local noj2 = 0
local started = false
local ped2 = nil
local garbage = false
local garbagebag = nil
local notified = true
local way = nil
local job_blip = nil
local spawned = false
local car = nil

Citizen.CreateThread(function()
    while true do
        if Config.JobMenu then
            if custom ~= nil then
                sleep = 10
                if not mathed then
                    for _ in pairs(custom.Todos) do size1 = size1 + 1 end
                    mathed = true
                end
                if not planted then
                    plant(custom.Todos)
                    planted = true
                end
                if tasks == 0 and not notified then
                    Citizen.Wait(750)
                    if Config.NotifyType == 'esx' then
                        ESX.ShowNotification(Config.Locales['job_done'])
                    elseif Config.NotifyType == 'esx-advanced' then
                        notification(Config.Locales['job_done'], PlayerPedId())
                    end
                    notified = true
                end
                tasks = (#grass_list + #trash_list)
                if IsControlJustReleased(0, 166) then
                    local money2 = custom.Payment
                    local tabok = {
                        {
                        unselectable=true,
                        icon="fas fa-info-circle",
                        title=Config.Dialogs['mission'],
                        },
                        {
                        icon="fas fa-info-circle",
                        title=Config.Dialogs['client_name']..custom.Name,
                        },
                        {
                        icon="fas fa-info-circle",
                        title=Config.Dialogs['tasks']..tasks.."/"..size1,
                        },
                        {
                        icon="fas fa-info-circle",
                        title=Config.Dialogs['paycheck']..custom.Payment..Config.Dialogs['currency'],
                        },
                        {
                        icon="fas fa-info-circle",
                        title=Config.Dialogs['leave_job'],
                        }
                    }
                    if tasks == 0 then
                        table.insert(tabok, {icon="fas fa-info-circle",title=Config.Dialogs['end_job'],})
                    end
                    ESX.OpenContext("right" , tabok,
                        function(menu,element)
                            if element.title ==Config.Dialogs['leave_job'] then
                                endjob()
                                if Config.NumberOfJobs ~= nil then
                                    TriggerServerEvent("bnc_gardening:PlusJob")
                                end
                                ESX.CloseContext()
                            end
                            if element.title == Config.Dialogs['end_job'] then
                                endjob()
                                TriggerServerEvent("bnc_gardening:Pay", money2)
                                ESX.CloseContext()
                            end
                        end, function(menu)
                    end)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep4 = 1000
        if Config.Talk then
            if custom ~= nil then
                local pos = custom.Position
                local plr = PlayerPedId()
                local dist = #(pos - GetEntityCoords(plr))
                if dist <= 10.0 then
                    if custom.Ped == nil then
                        sleep4 = 5
                        DrawMarker(2, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 128, 0, 130, false, true, 2, nil, nil, false)
                    end
                    if dist <= 2.0 then
                        if Config.TextUI == '3d' then
                            sleep4 = 5
                            if Config.OverHead then
                                DrawText3D(pos.x, pos.y, pos.z + 0.98, Config.Locales['speak_client']..custom.Name)
                            else
                                DrawText3D(pos.x, pos.y, pos.z, Config.Locales['speak_client']..custom.Name)
                            end
                        elseif Config.TextUI == 'esx' then
                            ESX.ShowHelpNotification(Config.Locales['speak_client']..custom.Name)
                        end
                        if IsControlJustReleased(0, 51) then
                            local money2 = custom.Payment
                            if not started then
                                local cuccok = {
                                    {
                                    unselectable=true,
                                    icon="fas fa-info-circle",
                                    title=custom.Name,
                                    description=Config.Dialogs['start'],
                                    },
                                    {
                                    icon="fas fa-info-circle",
                                    title=Config.Dialogs['yes'],
                                    },
                                    {
                                    icon="fas fa-info-circle",
                                    title=Config.Dialogs['no_job'],
                                    },
                                }
                                ESX.OpenContext("right" , cuccok,
                                    function(menu,element)
                                        if element.title == Config.Dialogs['yes'] then
                                            started = true
                                            ESX.CloseContext()
                                        end
                                        if element.title == Config.Dialogs['no_job'] then
                                            endjob()
                                            if Config.NumberOfJobs ~= nil then
                                                TriggerServerEvent("bnc_gardening:PlusJob")
                                            end
                                            ESX.CloseContext()
                                        end
                                    end, function(menu)
                                end)
                            else
                                local cuccok2 = {
                                    {
                                    unselectable=true,
                                    icon="fas fa-info-circle",
                                    title=custom.Name,
                                    description=Config.Dialogs['leave_end'],
                                    },
                                    {
                                    icon="fas fa-info-circle",
                                    title=Config.Dialogs['no'],
                                    },
                                    {
                                    icon="fas fa-info-circle",
                                    title=Config.Dialogs['yes_job'],
                                    },
                                }
                                if tasks == 0 then
                                    table.remove(cuccok2, 3)
                                    table.insert(cuccok2, {icon="fas fa-info-circle", title=Config.Dialogs['yes'],})
                                end
                                ESX.OpenContext("right" , cuccok2,
                                    function(menu,element)
                                        if element.title == Config.Dialogs['no'] then
                                            ESX.CloseContext()
                                        end
                                        if element.title == Config.Dialogs['yes_job'] then
                                            endjob()
                                            started = false
                                            if Config.NumberOfJobs ~= nil then
                                                TriggerServerEvent("bnc_gardening:PlusJob")
                                            end
                                            ESX.CloseContext()
                                        end
                                        if element.title == Config.Dialogs['yes'] then
                                            endjob()
                                            started = false
                                            TriggerServerEvent("bnc_gardening:Pay", money2)
                                            ESX.CloseContext()
                                        end
                                    end, function(menu)
                                end)
                            end
                        end
                    end
                end
            end
        else
            --onjob = true
            started = true
        end
        Citizen.Wait(sleep4)
    end
end)

-- JOBS
Citizen.CreateThread(function()
 while true do
    local sleep2 = 1500
    if started then
        sleep2 = 500
        for z, u in pairs(grass_list) do
            local closest_grass = grass_list[z]
            local grass_pos = GetEntityCoords(closest_grass)
            local player = PlayerPedId()
            local dis = #(grass_pos - GetEntityCoords(player))
                if dis < 15.0 then
                    sleep2 = 5
                    DrawMarker(0, grass_pos.x, grass_pos.y, grass_pos.z + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 128, 0, 130, false, true, 2, nil, nil, false)
                    if dis < 1.5 then
                        sleep2 = 7
                        DrawMarker(0, grass_pos.x, grass_pos.y, grass_pos.z + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 128, 0, 130, false, false, 2, nil, nil, false)
                        if Config.TextUI == '3d' then
                            if Config.OverObject then
                                DrawText3D(grass_pos.x, grass_pos.y, grass_pos.z + 0.98, Config.Locales['plant_pick'])
                            else
                                DrawText3D(grass_pos.x, grass_pos.y, grass_pos.z, Config.Locales['plant_pick'])
                            end
                        elseif Config.TextUI == 'esx' then
                            ESX.ShowHelpNotification(Config.Locales['plant_pick'])
                        end
                        if IsControlJustReleased(0, 51) then
                            gard(player)
                            table.remove(grass_list, z)
                            DeleteObject(closest_grass)
                        end
                    end
                end
        end
        for k, v in pairs(trash_list) do
            local closest_grass = trash_list[k]
            local grass_pos = GetEntityCoords(closest_grass)
            local player = PlayerPedId()
            local dis = #(grass_pos - GetEntityCoords(player))
                if dis < 15.0 then
                    sleep2 = 5
                    DrawMarker(0, grass_pos.x, grass_pos.y, grass_pos.z + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 128, 0, 130, false, true, 2, nil, nil, false)
                    if dis < 1.5 then
                        sleep2 = 7
                        DrawMarker(0, grass_pos.x, grass_pos.y, grass_pos.z + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 128, 0, 130, false, false, 2, nil, nil, false)
                        if Config.TextUI == '3d' then
                            if Config.OverObject then
                                DrawText3D(grass_pos.x, grass_pos.y, grass_pos.z + 0.98, Config.Locales['trash_up'])
                            else
                                DrawText3D(grass_pos.x, grass_pos.y, grass_pos.z, Config.Locales['trash_up'])
                            end
                        elseif Config.TextUI == 'esx' then
                            ESX.ShowHelpNotification(Config.Locales['trash_up'])
                        end
                        if IsControlJustReleased(0, 51) then
                            if not garbage then
                                RequestAnimDict("anim@heists@narcotics@trash") 
                                    while not HasAnimDictLoaded("anim@heists@narcotics@trash") do 
                                    Citizen.Wait(0)
                                    end
                                garbagebag = CreateObject(GetHashKey("prop_rub_binbag_sd_01"), 0, 0, 0, true, true, true) -- creates object
                                AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.0, -0.01, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
                                TaskPlayAnim(player, 'anim@heists@narcotics@trash', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                                garbage = true
                                -- remove things
                                table.remove(trash_list, k)
                                DeleteObject(closest_grass)
                            end
                        end
                    end
                end
        end
    end
    Citizen.Wait(sleep2)
 end
end)

Citizen.CreateThread(function()
 while true do
    local player = PlayerPedId()
    local s = 750
    if garbage then
        s = 500
        local vehicle = GetClosestVehicle(GetEntityCoords(player), 10.0, 0, 70)
        local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        --if vehname == Config.CarModel then
            if DoesEntityExist(vehicle) then
                    local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
                    if trunk ~= -1 then
                        local coords = GetWorldPositionOfEntityBone(vehicle, trunk)
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true) <= 1.5 then
                            s = 5
                            if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                                if Config.TextUI == '3d' then
                                    DrawText3D(coords.x, coords.y, coords.z, Config.Locales['trash_in'])
                                elseif Config.TextUI == 'esx' then
                                    ESX.ShowHelpNotification(Config.Locales['trash_in'])
                                end
                                if IsControlJustReleased(0, 74)then
                                    SetCarBootOpen(vehicle)
                                    trashin(player)
                                    DeleteObject(garbagebag)
                                    Citizen.Wait(250)
                                    garbage = false
                                    SetVehicleDoorShut(vehicle, 5)
                                end
                            end
                        end
                    end
            end
        --[[else
            if Config.DisplayWrong then
                if DoesEntityExist(vehicle) then
                    local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
                    if trunk ~= -1 then
                        local coords = GetWorldPositionOfEntityBone(vehicle, trunk)
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true) <= 1.5 then
                            s = 5
                            if Config.TextUI == '3d' then
                                DrawText3D(coords.x, coords.y, coords.z, Config.Locales['trash_wrong'])
                            elseif Config.TextUI == 'esx' then
                                ESX.ShowHelpNotification(Config.Locales['trash_wrong'])
                            end
                        end
                    end
                end
            end
        end]]--
    end
    Citizen.Wait(s)
 end
end)

Citizen.CreateThread(function()
 while true do
    local sleep3 = 750
    local disp = Config.Dispatcher
    local player = PlayerPedId()
    local disto = #(disp.Position - GetEntityCoords(player))
    if disto < 10.0 then
        sleep3 = 5
        if Config.Dispatcher.Ped == nil then
            DrawMarker(disp.Marker, disp.Position.x, disp.Position.y, disp.Position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 128, 0, 130, false, false, 2, nil, nil, false)
        end
        if disto < 2.0 then
            sleep3 = 5
            if Config.TextUI == '3d' then
                if Config.OverHead then
                    DrawText3D(disp.Position.x, disp.Position.y, disp.Position.z + 0.98, Config.Locales['speak']..Config.Dispatcher.Name)
                else
                    DrawText3D(disp.Position.x, disp.Position.y, disp.Position.z, Config.Locales['speak']..Config.Dispatcher.Name)
                end
            elseif Config.TextUI == 'esx' then
                ESX.ShowHelpNotification(Config.Locales['speak']..Config.Dispatcher.Name)
            end
            if IsControlJustReleased(0, 51) then
                if not spawned then
                    if not onjob then
                        if Config.NumberOfJobs ~= nil then
                            TriggerServerEvent("bnc_gardening:GetNOJ")
                        end
                        Citizen.Wait(100)
                        local tabok2 = {}
                        if Config.DisplayJobs then
                            tabok2 = {
                                {
                                unselectable=true,
                                icon="fas fa-book",
                                title=Config.Dialogs['job'],
                                description=Config.Dialogs['take_job']..noj2,
                                },
                                {
                                icon="fas fa-check",
                                title=Config.Dialogs['yes'],
                                },
                                {
                                icon="fas fa-xmark",
                                title=Config.Dialogs['no'],
                                },
                            }
                        else
                            tabok2 = {
                                {
                                unselectable=true,
                                icon="fas fa-book",
                                title=Config.Dialogs['job'],
                                description=Config.Dialogs['take_job'],
                                },
                                {
                                icon="fas fa-check",
                                title=Config.Dialogs['yes'],
                                },
                                {
                                icon="fas fa-xmark",
                                title=Config.Dialogs['no'],
                                },
                            }
                        end
                        ESX.OpenContext("right" , tabok2,
                            function(menu,element)
                                if element.title == Config.Dialogs['yes'] then
                                    getajob()
                                    onjob = true
                                    if Config.NumberOfJobs ~= nil then
                                        TriggerServerEvent("bnc_gardening:MinusJob")
                                    end
                                    if Config.UseCar then
                                        SpawnCar()
                                    end
                                    ESX.CloseContext()
                                    Citizen.Wait(1000)
                                    notified = false
                                    --print(noj2)
                                end
                                if element.title == Config.Dialogs['no'] then
                                    ESX.CloseContext()
                                end
                            ESX.CloseContext()
                            end, function(menu)
                        end)
                    else
                        if Config.NotifyType == 'esx' then
                            ESX.ShowNotification(Config.Locales['job_already'])
                        elseif Config.NotifyType == 'esx-advanced' then
                            notification(Config.Locales['job_already'], PlayerPedId())
                        end
                    end
                else
                    if Config.NotifyType == 'esx' then
                        ESX.ShowNotification(Config.Locales['carcant'])
                    elseif Config.NotifyType == 'esx-advanced' then
                        notification(Config.Locales['carcant'], PlayerPedId())
                    end
                end
            end
        end
    end
    Citizen.Wait(sleep3)
 end
end)

Citizen.CreateThread(function() --PED DEBUG & SPAWN (DISPATCHER)
    if Config.Dispatcher.Ped ~= nil then
        RequestModel(GetHashKey(Config.Dispatcher.Ped))
        while not HasModelLoaded(GetHashKey(Config.Dispatcher.Ped)) do
            Citizen.Wait(1)
        end
        
        local ped = CreatePed(4, GetHashKey(Config.Dispatcher.Ped), Config.Dispatcher.Position.x, Config.Dispatcher.Position.y, Config.Dispatcher.Position.z - 0.98, Config.Dispatcher.Heading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityHeading(ped, Config.Dispatcher.Heading)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

Citizen.CreateThread(function() --PED DEBUG & SPAWN
 while true do
    if custom ~= nil then
        if custom.Ped ~= nil then
            if ped2 == nil then
                RequestModel(GetHashKey(custom.Ped))
                while not HasModelLoaded(GetHashKey(custom.Ped)) do
                    Citizen.Wait(1)
                end
                
                ped2 = CreatePed(4, GetHashKey(custom.Ped), custom.Position.x, custom.Position.y, custom.Position.z - 0.98, custom.Heading, false, true)
                FreezeEntityPosition(ped2, true)
                SetEntityHeading(ped2, custom.Heading)
                SetEntityInvincible(ped2, true)
                SetBlockingOfNonTemporaryEvents(ped2, true)
            else
                --[[if not onjob then
                    if not started then
                        DeletePed(ped2)
                    end
                end]]--
            end
        end
    end
    Citizen.Wait(2000)
 end
end)

Citizen.CreateThread(function() -- DELETER BUT I DONT WORK XD
 while true do
    local sleep5 = 1000
    if spawned then
        sleep5 = 500
        local del = Config.Cardeleter
        local plr = PlayerPedId()
        local dis = #(del - GetEntityCoords(plr))
        if dis <= Config.DrawDistance then
            sleep5 = 5
            DrawMarker(1, del.x, del.y, del.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.75, 2.75, 0.75, 200, 0, 0, 150, false, false, 2, nil, nil, false)
            if dis <= 2.5 then
                if IsControlJustReleased(0, 51) then
                    DeleteVehicle(car)
                    car = nil
                    spawned = false
                    if onjob then
                        endjob()
                    end
                end
            end
        end
    end
    Citizen.Wait(sleep5)
 end
end)

Citizen.CreateThread(function()
    if Config.DispatcherBlip then
        blip = AddBlipForCoord(Config.Dispatcher.Position.x, Config.Dispatcher.Position.y, Config.Dispatcher.Position.z)
        SetBlipSprite(blip, Config.DispatcherBlipId)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, Config.DispatcherBlipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.DispatcherBlipName)
        EndTextCommandSetBlipName(blip)
    end
end)

--------------------------------------------------------------------------
-------------------------- FUNCTIONS & EVENTS ----------------------------
--------------------------------------------------------------------------

function getajob()
    for k, v in pairs(Config.Customers) do
        if c == nil then
            local c = Config.Customers[math.random(1, #Config.Customers)]
            custom = c
        end
    end
    if Config.SetWaypoint then
        way = SetNewWaypoint(custom.Position.x, custom.Position.y)
    end
    job_blip = AddBlipForCoord(custom.Position.x, custom.Position.y, custom.Position.z)
      SetBlipSprite(job_blip, Config.ClientBlipId)
      SetBlipDisplay(job_blip, 4)
      SetBlipScale(job_blip, 0.9)
      SetBlipColour(job_blip, Config.ClientBlipColor)
      SetBlipAsShortRange(job_blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(Config.ClientBlipName)
      EndTextCommandSetBlipName(job_blip)
    --onjob = true
end

function plant(list)
    for k, v in pairs(list) do
        if v.typ == 'grass' then --proc_drygrasses01b
            grasses = CreateObject(GetHashKey('prop_fib_plant_02'), v.pos.x, v.pos.y, v.pos.z - 0.98, true, false, false)
            PlaceObjectOnGroundProperly_2(grasses)
            table.insert(grass_list, grasses)
        end
        if v.typ == 'trash' then --proc_drygrasses01b
            trashes = CreateObject(GetHashKey('prop_rub_binbag_01'), v.pos.x, v.pos.y, v.pos.z - 0.98, true, false, false)
            PlaceObjectOnGroundProperly_2(trashes)
            table.insert(trash_list, trashes)
        end
    end
end

function endjob(custom2)
    for k, v in pairs(grass_list) do
        DeleteObject(v)
    end
    for i, x in pairs(trash_list) do
        DeleteObject(x)
    end
    DeletePed(ped2)
    planted = false
    ped2 = nil
    onjob = false
    mathed = false
    last_custom = custom2
    custom = nil
    size1 = 0
    tasks = 0
    grass_list = {}
    trash_list = {}
    started = false
    garbage = false
    Citizen.Wait(100)
    notified = false
    if way ~= nil then
        DeleteWaypoint(way)
    end
    if job_blip ~= nil then
        RemoveBlip(job_blip)
    end
    job_blip = nil
    way = nil
end

function SpawnCar()
    for k, v in pairs(Config.CarSpawns) do
        local reserved = ESX.Game.IsSpawnPointClear(v.coords, Config.ZoneToCheck)
        local try = 0
        local tries = (#Config.CarSpawns)
        if Config.CheckIfBlocked then
            if reserved then
                if not spawned then
                    ESX.Game.SpawnVehicle(Config.CarModel, v.coords, v.heading, function(veh)
                        if Config.SetPlayerToCar then
                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                        end
                        car = veh
                    end)
                    SetEntityAsMissionEntity(car, false, false)
                    spawned = true
                end
            end
        else
            if not spawned then
                ESX.Game.SpawnVehicle(Config.CarModel, v.coords, v.heading, function(veh)
                    if Config.SetPlayerToCar then
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    end
                    car = veh
                end)
                SetEntityAsMissionEntity(car, false, false)
                spawned = true
            end
        end
    end
end

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	local factor = #text / 460
	local px,py,pz = table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.4, 0.4)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 225)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
    local w = string.len(text)
	DrawRect(_x,_y + 0.0115, w/299, 0.028, 20, 20, 20, 150)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        for k, v in pairs(grass_list) do
            DeleteObject(v)
        end
        for i, x in pairs(trash_list) do
            DeleteObject(x)
        end
	end
end)

function gard(player)
    ClearPedTasksImmediately(player)
	ClearPedTasks(player)
    -- For debug
	TaskStartScenarioInPlace(player, 'PROP_HUMAN_BUM_BIN', 0, true)
	exports.rprogress:Start(Config.Locales['weeding'], 10000)
	ClearPedTasksImmediately(player)
	ClearPedTasks(player)
    if Config.NotifyType == 'esx' then
	    ESX.ShowNotification(Config.Locales['weeding_done'])
    elseif Config.NotifyType == 'esx-advanced' then
        notification(Config.Locales['weeding_done'])
    end
end

function trashin(player)
	TaskStartScenarioInPlace(player, 'PROP_HUMAN_BUM_BIN', 0, true)
	exports.rprogress:Start(Config.Locales['trash'], 1750)
	ClearPedTasksImmediately(player)
	ClearPedTasks(player)
    if Config.NotifyType == 'esx' then
	    ESX.ShowNotification(Config.Locales['trash_done'])
    elseif Config.NotifyType == 'esx-advanced' then
        notification(Config.Locales['trash_done'])
    end
end

function notification(msg, ped)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(ped)
    ESX.ShowAdvancedNotification(Config.AdvancedTitle, Config.Dispatcher.Name, msg, 'CHAR_ORTEGA', 1)
    UnregisterPedheadshot(mugshot)
end

RegisterNetEvent("bnc_gardening:ReceiveData")
AddEventHandler("bnc_gardening:ReceiveData", function(data)
    --print(data)
	noj2 = data
end)