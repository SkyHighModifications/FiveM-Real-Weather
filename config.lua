--Config.lua created by Smurfy @ SkyHigh Modifications 05/09/23
--Updated 12-09-23
Config = {

    CityID = "", -- https://bulk.openweathermap.org/sample/
    ApiKey = "", -- https://home.openweathermap.org/api_keys
    Country = "GB", -- Great Britian
    UpdateData = "hourly", -- Weather updates in discord and game! its recommened to keep hourly but if you want to change then use either (current, minutely, hourly, daily)
    Lang = "en", -- Language listed below
    Units = "metric", -- either standard , metric or imperial 

    DiscordLog = true, -- to enable discord logs!
    DiscordWebHook = "https://discord.com/api/webhooks/1149492541171966064/KN89TTJLY8klXlgARxMP_WWOumGeDBADG4eGk3oZ243uAR6Ap9lnenzlfO2gRYnROSCx", -- discord webhook
    AvatarUrl = "https://upload.wikimedia.org/wikipedia/en/thumb/f/f4/Met_Office.svg/1024px-Met_Office.svg.png", -- bot profile picture
    BotUserName = "Met Office", -- bot username
    FooterImage = "https://upload.wikimedia.org/wikipedia/en/thumb/f/f4/Met_Office.svg/1024px-Met_Office.svg.png", -- footer image
    DiscordEmbedColour = 52548, -- Decimal Only Embed colour 

    RealTime = true, -- Use IRL PC time in server

    WeatherScripts = {
        "vSync"
    }, -- Add more? {"vSync, So on, So on"} (This will stop this / or those resource's to stop any conflict 
    -- "IF YOUR USING vSync and you do not put it here it will override this script and it wont work!" ) /CASE SENSITIVE\
}

--[[
Lang = {
af = Afrikaans
al = Albanian
ar = Arabic
az = Azerbaijani
bg = Bulgarian
ca = Catalan
cz = Czech
da = Danish
de = German
el = Greek
en = English
eu = Basque
fa = Persian (Farsi)
fi = Finnish
fr = French
gl = Galician
he = Hebrew
hi = Hindi
hr = Croatian
hu = Hungarian
id = Indonesian
it = Italian
ja = Japanese
kr = Korean
la = Latvian
lt = Lithuanian
mk = Macedonian
no = Norwegian
nl = Dutch
pl = Polish
pt = Portuguese
pt_br = Português Brasil
ro = Romanian
ru = Russian
sv, se = Swedish
sk = Slovak
sl = Slovenian
sp, es = Spanish
sr = Serbian
th = Thai
tr = Turkish
ua, uk = Ukrainian
vi = Vietnamese
zh_cn = Chinese Simplified
zh_tw = Chinese Traditional
zu = Zulu
}
--]]