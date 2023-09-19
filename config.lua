-- Config.lua created by Smurfy @ SkyHigh Modifications 05/09/23
-- Updated 15-09-23
Config = {
    -- Weather API Configuration
    CityID = "",  -- City ID, e.g., London | https://bulk.openweathermap.org/sample/
    ApiKey = "",  -- OpenWeather API Key | https://home.openweathermap.org/api_keys
    Country = "GB",  -- Country Code, e.g., Great Britain
    Language = "en",  -- Language code

    -- Weather Unit Settings
    Units = "metric",  -- Units for temperature (standard, metric, imperial)
    WindSpeed = "MPH",  -- Wind speed units (MPH, KM/H, M/S, KNOTS, Speed Of Sound)

    -- Discord Integration
    DiscordBOTUpdates = "1hr",  -- Bot's update frequency (24hr, 12hr, 6hr, 1hr, 30min, 15min, none)
    DiscordLog = true,  -- Enable Discord logs
    DiscordWebHook = "", -- Discord Webhook
    AvatarUrl = "https://play-lh.googleusercontent.com/-8wkZVkXugyyke6sDPUP5xHKQMzK7Ub3ms2EK9Jr00uhf1fiMhLbqX7K9SdoxbAuhQ",
    BotUserName = "Open Weather", -- Bot Username
    FooterImage = "https://play-lh.googleusercontent.com/-8wkZVkXugyyke6sDPUP5xHKQMzK7Ub3ms2EK9Jr00uhf1fiMhLbqX7K9SdoxbAuhQ", -- Footer Image

    -- Real-Time Settings
    RealTime = true,  -- Use IRL PC time in server
    TimeZoneHrs = 1,  -- Timezone offset in hours

    -- Weather Scripts Configuration
    WeatherScripts = {
        "vSync"
    },
    
    -- Debug Settings
    Debug = false,  -- Debug mode
    -- DebugAcePerms = "group.admin",  -- ACE permissions for debugging < WIP

        -- Update Settings
    CheckForUpdates = true -- Check for GitHub updates! 

--[[
    Lang = {
        "af", -- Afrikaans
        "al", -- Albanian
        "ar", -- Arabic
        "az", -- Azerbaijani
        "bg", -- Bulgarian
        "ca", -- Catalan
        "cz", -- Czech
        "da", -- Danish
        "de", -- German
        "el", -- Greek
        "en", -- English
        "eu", -- Basque
        "fa", -- Persian (Farsi)
        "fi", -- Finnish
        "fr", -- French
        "gl", -- Galician
        "he", -- Hebrew
        "hi", -- Hindi
        "hr", -- Croatian
        "hu", -- Hungarian
        "id", -- Indonesian
        "it", -- Italian
        "ja", -- Japanese
        "kr", -- Korean
        "la", -- Latvian
        "lt", -- Lithuanian
        "mk", -- Macedonian
        "no", -- Norwegian
        "nl", -- Dutch
        "pl", -- Polish
        "pt", -- Portuguese
        "pt_br", -- Português Brasil
        "ro", -- Romanian
        "ru", -- Russian
        "sv", -- Swedish
        "se", -- Swedish
        "sk", -- Slovak
        "sl", -- Slovenian
        "sp", -- Spanish
        "es", -- Spanish
        "sr", -- Serbian
        "th", -- Thai
        "tr", -- Turkish
        "ua", -- Ukrainian
        "uk", -- Ukrainian
        "vi", -- Vietnamese
        "zh_cn", -- Chinese Simplified
        "zh_tw", -- Chinese Traditional
        "zu" -- Zulu
    }
    --]]
}

