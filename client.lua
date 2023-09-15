-- Original script by Jijamik, modified by Smurfy @ SkyHigh Modifications on 05/09/23

RegisterNetEvent('forecast:actu')
AddEventHandler('forecast:actu', function(data)
    ClearWeatherTypePersist()
    SetWeatherTypeOverTime(data["forecast"], 0.01)
    SetWind(data["VitesseVent"])
    SetWindSpeed(data["VitesseVent"])
    SetWindDirection(data["DirVent"])

    if data["forecast"] == "XMAS" then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
        SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), 0), true)
        SetVehicleReduceTraction(GetVehiclePedIsIn(PlayerPedId(), 0), 0.5)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
        SetVehicleReduceTraction(GetVehiclePedIsIn(PlayerPedId(), 0), 0.0)
        SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), 0), false)
    end

    if data["forecast"] == "THUNDER" or data["forecast"] == "RAIN" then
        SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), 0), true)
        SetVehicleReduceTraction(GetVehiclePedIsIn(PlayerPedId(), 0), 0.2)
    else
        SetVehicleReduceTraction(GetVehiclePedIsIn(PlayerPedId(), 0), 0.0)
        SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), 0), false)
    end
end)

AddEventHandler('onClientMapStart', function()
    TriggerServerEvent('forecast:sync')
    TriggerServerEvent("SHM:RealTime")
end)

TriggerServerEvent('forecast:sync')

SetMillisecondsPerGameMinute(60000)

RegisterNetEvent("SHM:RealTime")
AddEventHandler("SHM:RealTime", function(_, h, m, s)
    NetworkOverrideClockTime(h, m, s)
end)

TriggerServerEvent("SHM:RealTime")

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/debug', GetCurrentResourceName(), {
        { name = "Weather / Time Script", help = "Available types: restart | weatherdebug | timedebug" }
    })
end)