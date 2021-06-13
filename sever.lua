ESX                                = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
        
RegisterServerEvent('transportista:addThings')
AddEventHandler('transportista:addThings', function()
    local user = ESX.GetPlayerFromId(source)
    user.addMoney(800)   
    user.addInventoryItem('bread', 1)     
    user.showNotification('Has recibido tu recompensa buen trabajo')
    --TriggerClientEvent('esx:shownotification', source, 'Has recibido tu recompensa buen trabajo')
end)
