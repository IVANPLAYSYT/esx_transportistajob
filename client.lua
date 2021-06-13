local job = false
local job2 = false
--
-- citizens
--
ESX                                = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()

    RequestModel(GetHashKey("a_m_m_acult_01"))
    while not HasModelLoaded(GetHashKey("a_m_m_acult_01")) do
      Wait(155)
    end

      local ped =  CreatePed(4, GetHashKey("a_m_m_acult_01"), 1197.0, -3253.72, 6.09, 94.5, false, true)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
end)

Citizen.CreateThread(function()
	while true do
        local _sleep = 1000
        local _char = PlayerPedId()
        local _charpos = GetEntityCoords(_char)
        if #(_charpos - vector3(1197.0, -3253.72, 7.09)) < 2 then
            _sleep = 0
            if job == true or job2 == true then
                Create3D(vector3(1197.0, -3253.72, 8.2), '~r~ya estas en una mision primero termina una')
            else
                Create3D(vector3(1197.0, -3253.72, 8.2), 'Pulse ~r~E~w~ para iniciar la mision')
                if IsControlJustReleased(0, 38) then
                    ESX.Game.SpawnVehicle('zentorno', vector3(1190.41, -3246.31, 6.03), 91.26, function(veh)
                     exports['Legacyfuel']:SetFuel(veh, 100)
                      TaskWarpPedIntoVehicle(_char, veh, -1)                   
                    end)
                   Blip = AddBlipForCoord(vector3(1181.2, -3262.67, 4.53))
                   SetBlipRoute(Blip, true)   
                   job = true
                end     
            end        
        end 
        if job == true then
            if #(_charpos - vector3(1181.2, -3262.67, 4.53)) < 2 then
                _sleep = 0
                Create3D(vector3(1181.2, -3262.67, 4.53), 'Pulse ~r~E~w~ para entregar la mercancia')
                if IsControlJustReleased(0, 38) then
                    RemoveBlip(Blip)
                    SetBlipRoute(Blip, false)
                    Blip2 = AddBlipForCoord(vector3(1177.36, -3305.34, 6.02))
                     SetBlipRoute(Blip2, true)
                    job = false
                    job2 = true
                end    
            end  
        end
        if job2 == true then
            if #(_charpos - vector3(1179.08, -3305.78, 5.03)) < 2 then
                _sleep = 0
                Create3D(vector3(1179.08, -3305.78, 5.03), 'Pulse ~r~E~w~ para entregar el vehiculo')
                if IsControlJustReleased(0, 38) then
                    DeleteVehicle(GetVehiclePedIsIn(_char))
                    RemoveBlip(Blip)
                    SetBlipRoute(Blip, false)
                    TriggerServerEvent('transportista:addThings')
                    job = false
                    job2 = false
                end    
            end  
        end        
        Citizen.Wait(_sleep)
    end
end)

--
--funtions
--
Create3D = function(coords, text)
    local x, y, z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(5)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

