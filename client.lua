--Made by Jijamik, feel free to modify
--Modified by Smurfy @ SkyHigh Modifications 05/09/23
local src = source

RegisterNetEvent('forecast:actu')
AddEventHandler('forecast:actu', function(Data)
	ClearWeatherTypePersist()
	SetWeatherTypeOverTime(Data["forecast"], 0.01)
	SetWind(Data["VitesseVent"]);
	SetWindSpeed(Data["VitesseVent"])
	SetWindDirection(Data["DirVent"])
    if Data["forecast"] == "XMAS" then
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
    if Data["forecast"] == "THUNDER" or "RAIN" then
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
AddEventHandler("SHM:RealTime", function(src, h, m, s)
	NetworkOverrideClockTime(h, m, s)
end)
TriggerServerEvent("SHM:RealTime")

for k, v in pairs(Config.WeatherScripts) do
	if GetResourceState(v) == 'started' or GetResourceState(v) == 'starting' then
        print("[^1ERROR^7] YOU ARE USING A RESOURCE THAT WILL OVERRIDE ^1"..v.."^7, PLEASE REMOVE ^5" .. v .. "^7")
	end
end
