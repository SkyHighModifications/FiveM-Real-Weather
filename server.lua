VersionCheckURL = "https://api.github.com/repos/SkyHighModifications/FiveM-Real-Weather-Real-Time/releases/latest"


--Made by Jijamik, feel free to modify
--Modified by Smurfy @ SkyHigh Modifications 05/09/23
local GetWeather = "http://api.openweathermap.org/data/2.5/weather?id="..Config.CityID.."&lang="..Config.Lang.."&units="..Config.Units.."&exclude="..Config.UpdateData.."&APPID="..Config.ApiKey..""

RegisterNetEvent("SHM:RealTime")
AddEventHandler("SHM:RealTime", function()
    if Config.RealTime == true then
    time = GetTime()
	TriggerClientEvent("SHM:RealTime", -1, time.d, time.h, time.m, time.s)
    elseif Config.RealTime == false then
        CancelEvent()
    end
end)

function GetTime()
        local timestamp = os.time()
        local d = os.date("*t", timestamp).wday
        local h = tonumber(os.date("%H", timestamp))
        local m = tonumber(os.date("%M", timestamp))
        local s = tonumber(os.date("%S", timestamp))
	return {d = d, h = h, m = m, s = s}
end

function sendToDiscordForecast(color, type, name, message)
      
    local botreply = {
          {
              ["color"] = Config.DiscordEmbedColour,
              ["title"] = "***".. Config.BotUserName .. "***",
              ["description"] = message,
              ["footer"] = {
                ["text"] = "Created By Jijamik & SkyHigh Modifications | Hourly Updated",
                ["icon_url"] = Config.FooterImage,
            },
          }
      }
      if message == nil or message == '' then return false end
      if Config.DiscordLog then
    PerformHttpRequest(Config.DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotUserName, embeds = botreply, avatar_url = Config.AvatarUrl}), { ['Content-Type'] = 'application/json' })
      else
        print("^1ERROR: ^3DISCORD BOT NOT LOGGING!!!^7, ^4Set ^2(true) ^4for logging^7") 
    end
end

function checkForecast(err,response)
    -- while true do
       --  Citizen.Wait(3600000)
    local data = json.decode(response)
    local type = data.weather[1].main
    local id = data.weather[1].id
    local wind = math.floor(data.wind.speed)
    local windrot = data.wind.deg
    local forecast = "EXTRASUNNY"
    local location = data.name
    local humid = math.floor(data.main.humidity)
    local feelslike = math.floor(data.main.feels_like)
    local temp = math.floor(data.main.temp)
    local tempmini = math.floor(data.main.temp_min)
    local tempmaxi = math.floor(data.main.temp_max)
    local vis = math.floor(data.visibility)
    local emoji = "⛅"
    if type == "Fog" or id == 741 then
        forecast = "FOGGY"
        emoji = "🌫️"
        format = "Foggy"
    end
    if type == "Thunderstorm" then
        forecast = "THUNDER"
        emoji = "⛈️"
        format = "Thunder & Lighting"
    end
    if type == "Rain" then
        forecast = "RAIN"
        emoji = "🌧️"
        format = "Raining"
    end
    if type == "Drizzle" then
        forecast = "CLEARING"
        emoji = "🌧️"
        forcast = "Drizzle"
        if id == 608 then
            forecast = "OVERCAST"
        end
    end
    if type == "Clear" or id == 800 then
        forecast = "CLEAR"
        emoji = "🌞"
        format = "Clear Sunny"
    end
    if type == "Clouds" then
        forecast = "CLOUDS"
        emoji = "☁️"
        format = "Cloudy"
        if id == 804 then
            forecast = "OVERCAST"
        end
    end
    if type == "Snow" then
        forecast = "SNOW"
        emoji = "☃️"
        format = "Snowing"
        if id == 600 or id == 602 or id == 620 or id == 621 or id == 622 then
            forecast = "XMAS" and "FOGGY"
            format = "Snowing"
        end
    end
    Data = {
        ["forecast"] = forecast,
        ["VitesseVent"] = wind,
        ["DirVent"] = windrot
    }
    if vis == 10000 then
        visToWord = "Excellent"
    elseif vis < 10000 then
        visToWord = "Good"
    elseif vis < 500 then
        visToWord = "Poor"
    end
    TriggerClientEvent("forecast:actu", -1, Data)
    sendToDiscordForecast(0, type,('Weather')," The weather in ***"..location.." , "..Config.Country.."*** (is currently "..emoji.." | "..format.."). \n:thermometer: Currently **"..temp.."°C** / min temperature of **"..tempmini.."°C** / max temperature of **"..tempmaxi.."°C**. \n:raised_hand: Feels like **"..feelslike.."°C**. \n:hot_face: Humidity **"..humid.." %.**  \n:eyes: Visibility **"..visToWord.." **. \n:wind_blowing_face: Winds of **"..wind.." m/s** are to be expected.")
    SetTimeout(60*60*1000, checkForecastHTTPRequest)
  -- end
end

function checkForecastHTTPRequest()
    PerformHttpRequest(GetWeather, checkForecast, "GET")
end

checkForecastHTTPRequest()

RegisterServerEvent("forecast:sync")
AddEventHandler("forecast:sync",function()
    TriggerClientEvent("forecast:actu", -1, Data)
end)

--[[
"EXTRASUNNY"
"SMOG"
"CLEAR"
"CLOUDS"
"FOGGY"
"OVERCAST"
"RAIN"
"THUNDER"
"CLEARING"
"NEUTRAL"
"SNOW"
"BLIZZARD"
"SNOWLIGHT"
"XMAS"
--]]

Citizen.CreateThread(function()
    for k, v in pairs(Config.WeatherScripts) do
        StopResource(v)
    Wait(300)
    StopResource(GetCurrentResourceName())
    Wait(300)
    print("^2Restarted ^4" ..GetCurrentResourceName().."")
    print("^6Created By Jijamik & SkyHigh Modifications^2 Enjoy^7")
    StartResource(GetCurrentResourceName())
   end
end)


VERSION = {
    Check = function(err, response, headers)
        --Credit: OX_lib version checker by Linden
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
        local latestVersion
        if not currentVersion then
            return
        end

        if err ~= 200 then
            ErrorHandle("An error occurred while trying to get the current version!")
            return
        end
        if response then
            response = json.decode(response)
            if not response.tag_name then
                return
            end

            latestVersion = response.tag_name:match("%d%.%d+%.%d+")
            currentVersion = currentVersion:match("%d%.%d+%.%d+")

            if not latestVersion then
                return
            end

            if currentVersion == latestVersion then
                InfoHandle("You are using the latest version!", "green")
                return
            end

            local currentVersionSplitted = { string.strsplit(".", currentVersion) }
            local latestVersionSplitted = { string.strsplit(".", latestVersion) }

            InfoHandle("Latest version: " .. latestVersion, "green")
            InfoHandle("Your version: " .. currentVersion, "blue")

            for i = 1, #currentVersionSplitted do
                local current, latest = tonumber(currentVersionSplitted[i]), tonumber(latestVersionSplitted[i])
                if current ~= latest then
                    if not current or not latest then
                        return
                    end
                    if current < latest then
                        InfoHandle("You need download latest version! You are using an old version at the moment!", "red")
                    else
                        break
                    end
                end
            end
        end
    end,

    RunVersionChecker = function()
        CreateThread(function()
            PerformHttpRequest(VersionCheckURL, VERSION.Check, "GET")
        end)
    end,
}

AddEventHandler("onResourceStart", function(resourceName)
    local currentName = GetCurrentResourceName()
    if resourceName ~= currentName then
        return
    end
    --Run version checker
    VERSION:RunVersionChecker()
end)

function ErrorHandle(msg)
    print(("[^1ERROR^7] ^3"..GetCurrentResourceName().."^7: %s"):format(msg))
end

RegisterNetEvent(""..GetCurrentResourceName()..":ErrorHandle", function(msg)
    ErrorHandle(msg)
end)

function InfoHandle(msg, col)
    if col == "green" then
        col = 2
    elseif col == "red" then
        col = 1
    elseif col == "blue" then
        col = 4
    else
        col = 3
    end
    print(("[^9INFO^7] ^3"..GetCurrentResourceName().."^7: ^" .. col .. "%s^7"):format(msg))
end
