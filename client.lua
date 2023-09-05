--Made by Jijamik, feel free to modify
--Modified by Smurfy @ SkyHigh Modifications 05/09/23

RegisterNetEvent('forecast:actu')
AddEventHandler('forecast:actu', function(Data)
	ClearWeatherTypePersist()
	SetWeatherTypeOverTime(Data["forecast"], 80.00)
	SetWind(1.0)
	SetWindSpeed(Data["VitesseVent"]);
	SetWindDirection(Data["DirVent"])
    if Data["forecast"] == "XMAS" then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
end)

AddEventHandler('onClientMapStart', function()
	TriggerServerEvent('forecast:sync')
    TriggerServerEvent("SHM:RealTime")
end)

TriggerServerEvent('forecast:sync')

SetMillisecondsPerGameMinute(60000)

RegisterNetEvent("SHM:RealTime")
AddEventHandler("SHM:RealTime", function(source, h, m, s)
	NetworkOverrideClockTime(h, m, s)
end)
TriggerServerEvent("SHM:RealTime")
