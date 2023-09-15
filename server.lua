-- Made by Jijamik, feel free to modify
-- Modified by Smurfy @ SkyHigh Modifications 05/09/23

local GetWeather = "http://api.openweathermap.org/data/2.5/weather?id=" .. Config.CityID .. "&lang=" .. Config.Language .. "&units=" .. Config.Units .. "&exclude=hourly&APPID=" .. Config.ApiKey .. ""

Citizen.CreateThread(function()
    Debug()
    for _, v in pairs(Config.WeatherScripts) do
        StopResource(v)
        StopResource(GetCurrentResourceName())
        print("FiveM WeatherSync Pro")
        InfoHandle("Synced across all players", "green")
        InfoHandle("Created By Jijamik & SkyHigh Modifications", "purple")
        StartResource(GetCurrentResourceName())
    end
end)

RegisterNetEvent("SHM:RealTime")
AddEventHandler("SHM:RealTime", function()
    while true do
        Wait(0)
        if Config.RealTime == true then
            local time = GetTime()
            TriggerClientEvent("SHM:RealTime", -1, time.d, string.format("%02d", time.h), string.format("%02d", time.m), time.s)
        elseif not Config.RealTime or not Config.Debug then
            CancelEvent()
        end
    end
end)

RegisterServerEvent("forecast:sync")
AddEventHandler("forecast:sync", function()
    TriggerClientEvent("forecast:actu", -1, Data)
end)

function GetTime()
    local timestamp = os.time()
    local d = os.date("*t", timestamp).wday
    local h = tonumber(os.date("%H", timestamp) + tonumber(Config.TimeZoneHrs)) % 24
    local m = tonumber(os.date("%M", timestamp)) % 60
    local s = tonumber(os.date("%S", timestamp)) % 60

    local hStr = string.format("%02d", h)
    local mStr = string.format("%02d", m)
    return {d = d, h = h, m = m, s = s, hStr = hStr, mStr = mStr}
end

function checkForecast(err, response)
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
    local time = GetTime()
    local emoji = "⛅"
    local milesPerHour = ms_to_mph(wind)
    local WindSpeed = Config.WindSpeed
    local formattedMPH = string.format("%.1f", ms_to_mph(wind))

    if type == "Fog" or id == 741 then
        forecast = "FOGGY"
        emoji = "🌫️"
        format = "Foggy"
    elseif type == "Thunderstorm" then
        forecast = "THUNDER"
        emoji = "⛈️"
        format = "Thunder & Lighting"
    elseif type == "Rain" then
        forecast = "RAIN"
        emoji = "🌧️"
        format = "Raining"
    elseif type == "Drizzle" then
        forecast = "CLEARING"
        emoji = "🌧️"
        format = "Drizzle"
        if id == 608 then
            forecast = "OVERCAST"
        end
    elseif type == "Clear" or id == 800 then
        forecast = "CLEAR"
        emoji = "🌞"
        format = "Clear Sunny"
    elseif type == "Clouds" then
        forecast = "CLOUDS"
        emoji = "☁️"
        format = "Cloudy"
        if id == 804 then
            forecast = "OVERCAST"
        end
    elseif type == "Snow" then
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

    if temp > -15 and temp < 0 then
        col = RGBToDecimal(0, 84, 166) -- Dark Blue
    elseif temp > 0 and temp < 8 then
        col = RGBToDecimal(1, 168, 156) -- Light Blue
    elseif temp > 8 and temp < 15 then
        col = RGBToDecimal(255, 197, 1) -- Yellow
    elseif temp > 15 and temp < 25 then
        col = RGBToDecimal(255, 148, 0) -- Orange
    elseif temp > 25 and temp < 27 then
        col = RGBToDecimal(242, 102, 35) -- Dark Orange
    elseif temp > 27 and temp < 50 then
        col = RGBToDecimal(255, 0, 0) -- Red
    else
        col = RGBToDecimal(0, 0, 0)
        ErrorHandle("Color for Discord embed could not be set due to temp error")
    end

    if time.h < 12 then
        AMPM = "AM"
    else
        AMPM = "PM"
    end

    if time.h < 10 then
        time.h = "0" .. time.h
    end

    if time.m < 10 then
        time.m = "0" .. time.m
    end

    print("The weather in " .. location .. " , " .. Config.Country .. " (is currently " .. emoji .. " | " .. format .. "). \n🌡️ Currently: " .. temp .. "°C • Min: " .. tempmini .. "°C • Max: " .. tempmaxi .. "°C. \n✋🏼 Feels like: " .. feelslike .. "°C. \n🥵 Humidity: " .. humid .. " %. \n🌬️ Winds of: " .. formattedMPH .. " " .. WindSpeed .. " are to be expected. \nTime: " .. math.floor(time.h) .. " : " .. math.floor(time.m) .. " - " .. AMPM .. "")
    sendToDiscordForecast(col, type, ('Weather'), " The weather in ***" .. location .. " , " .. Config.Country .. "*** (is currently " .. emoji .. " | " .. format .. "). \n🌡️ Currently: **" .. temp .. "°C** • Min: **" .. tempmini .. "°C** • Max: **" .. tempmaxi .. "°C**. \n✋🏼 Feels like: **" .. feelslike .. "°C**. \n🥵 Humidity: **" .. humid .. " %**. \n🌬️ Winds of: **" .. formattedMPH .. " " .. WindSpeed .. "** are to be expected..")
    TriggerClientEvent("forecast:actu", -1, Data)
    SetTimeout(timerNotify(), checkForecastHTTPRequest)
end

function checkForecastHTTPRequest()
    PerformHttpRequest(GetWeather, checkForecast, "GET")
end

checkForecastHTTPRequest()

function RGBToDecimal(r, g, b)
    local decimalColor = bor(lshift(r, 16), bor(lshift(g, 8), b))
    return decimalColor
end

function lshift(num, bits)
    return num * 2^bits
end

function bor(a, b)
    local result = 0
    local bitPosition = 1
    while a > 0 or b > 0 do
        local bitA = a % 2
        local bitB = b % 2
        result = result + bitPosition * (bitA + bitB)
        a = math.floor(a / 2)
        b = math.floor(b / 2)
        bitPosition = bitPosition * 2
    end
    return result
end

function sendToDiscordForecast(color, type, name, message)
    local time = GetTime()
    if time.h < 12 then
        AMPM = "AM"
    else
        AMPM = "PM"
    end

    if time.h < 10 then
        time.h = "0" .. time.h
    end

    if time.m < 10 then
        time.m = "0" .. time.m
    end

    local color = Config.DiscordEmbedColour
    local botreply = {
        {
            ["color"] = col,
            ["title"] = "***" .. Config.BotUserName .. " | Your Local Weather Updates***",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "FiveM WeatherSync Pro • " .. math.floor(time.h) .. " : " .. math.floor(time.m) .. " - " .. AMPM .. " •",
                ["icon_url"] = Config.FooterImage,
            },
        }
    }

    if message == nil or message == '' then
        return false
    end
    PerformHttpRequest(Config.DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotUserName, embeds = botreply, avatar_url = Config.AvatarUrl}), { ['Content-Type'] = 'application/json' })
end

function ms_to_mph(ms)
    if Config.WindSpeed == "MPH" then
        local mph = ms * 2.23694
        return mph
    elseif Config.WindSpeed == "KM/H" then
        local kph = ms * 3.6
        return kph
    elseif Config.WindSpeed == "M/S" then
        local mps = ms
        return mps
    elseif Config.WindSpeed == "KNOTS" then
        local knots = ms * 1.94384
        return knots
    elseif Config.WindSpeed == "Speed Of Sound" then
        local knots = ms * 343
        return knots
    else
        ErrorHandle("Config.WindSpeed Not Configured")
        return nil
    end
end

function timerNotify()
    while true do
        Citizen.Wait(0)
        local waitTime
        if Config.DiscordBOTUpdates == "24hr" then
            waitTime = 24 * 60 * 60 * 1000 -- 24 hours in milliseconds
        elseif Config.DiscordBOTUpdates == "12hr" then
            waitTime = 12 * 60 * 60 * 1000 -- 12 hours in milliseconds
        elseif Config.DiscordBOTUpdates == "6hr" then
            waitTime = 6 * 60 * 60 * 1000 -- 6 hours in milliseconds
        elseif Config.DiscordBOTUpdates == "1hr" then
            waitTime = 60 * 60 * 1000 -- 1 hour in milliseconds
        elseif Config.DiscordBOTUpdates == "30min" then
            waitTime = 30 * 60 * 1000 -- 30 minutes in milliseconds
        elseif Config.DiscordBOTUpdates == "15min" then
            waitTime = 15 * 60 * 1000 -- 15 minutes in milliseconds
        elseif Config.DiscordBOTUpdates == "none" then
            return -- Exit the function if updates are disabled
        else
            ErrorHandle("Invalid Config.DiscordBOTUpdates value")
            return
        end
        Citizen.Wait(waitTime)
    end
end

function Debug()
    local time = GetTime()
    if Config.Debug == true then
        Command()
        sendToDiscordForecast(0, type, 'Weather', "ERR 200 DEBUG MODE")
        DebugHandle("MODE ONLY USE WHEN NEED TO ")
        DebugHandle("If time shows then I'm working ")
        DebugHandle(time.h .. ":" .. time.m)
        DebugHandle("If weather is showing then I'm working")
        DebugHandle(checkForecast())
    else
        CancelEvent()
    end
end

function Command()
    RegisterCommand("debug", function(source, args)
        -- if IsPlayerAceAllowed(Config.DebugAcePerms) then
        if args[1] == "restart" then
            StopResource(GetCurrentResourceName())
            Wait(5000)
            DebugHandle("InGame command used to restart resource " .. GetCurrentResourceName() .. "")
            InfoHandle("Resource successfully restarted " .. GetCurrentResourceName() .. "", "green")
            StartResource(GetCurrentResourceName())
        elseif args[1] == "weatherdebug" then
            TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^3Weather Debug: ^0Weather is ' .. emoji .. '')
        elseif args[1] == "timedebug" then
            if time.h < 12 then
                TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^3Time Debug: ^0Time is ' .. time.h .. " : " .. time.m .. " |AM|")
            elseif time.h > 12 then
                TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^3Time Debug: ^0Time is ' .. time.h .. " : " .. time.m .. " |PM|")
            else
                ErrorHandle("You do not have perms to use this command!")
                TriggerClientEvent('chatMessage', source, '', {255, 0, 0}, "^1ERROR: ^0You do not have perms to use this command!")
                -- end
            end
        end
    end, false)
end

function ErrorHandle(msg)
    print(("[^1ERROR^7] ^3" .. GetCurrentResourceName() .. "^7: %s"):format(msg))
end

function DebugHandle(msg, col)
    print(("[^1DEBUG MODE^7] ^3" .. GetCurrentResourceName() .. "^7: %s"):format(msg))
end

RegisterNetEvent("" .. GetCurrentResourceName() .. ":ErrorHandle", function(msg)
    ErrorHandle(msg)
end)

RegisterNetEvent("" .. GetCurrentResourceName() .. ":DebugHandle", function(msg)
    DebugHandle(msg, col)
end)

function InfoHandle(msg, col)
    if col == "green" then
        col = 2
    elseif col == "red" then
        col = 1
    elseif col == "blue" then
        col = 4
    elseif col == "purple" then
        col = 6
    elseif col == "amber" then
        col = 3
    else
        col = 7
    end
    print(("[^9INFO^7] ^3" .. GetCurrentResourceName() .. "^7: ^" .. col .. "%s^7"):format(msg))
end
