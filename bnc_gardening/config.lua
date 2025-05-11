Config = {}

Config.DrawDistance = 15.0 -- The distance where the script draw markers

Config.NumberOfJobs = 10 -- Number of claimable jobs (reset on script, also on server restart), set it to nil means infinte jobs

Config.Dispatcher = {
    Name = 'Boss', -- For text UI
    Ped = 'csb_ortega', -- Ped model
    Heading = 88.31, -- Only if ped is not nil
    Position = vector3(-956.2419, 327.7668, 71.4643), -- Position of marker or ped
    Marker = 2 -- Marker type
}

-- CAR
Config.UseCar = true
Config.CarModel = 'BISON3'
Config.CarSpawns = {
    {coords = vector3(-947.2892, 308.8965, 71.21664), heading = 179.32},
    {coords = vector3(-943.472, 309.2144, 71.23109), heading = 179.32},
    {coords = vector3(-939.7031, 309.0909, 71.20101), heading = 179.32},
    {coords = vector3(-935.7231, 309.0164, 71.23377), heading = 179.32}
}
Config.CheckIfBlocked = true
Config.ZoneToCheck = 2.0
Config.SetPlayerToCar = true
Config.DisplayWrong = true
Config.Cardeleter = vector3(-939.1661, 298.0536, 70.81053)
Config.CardeleterSize = 5.0

-- BLIPS
Config.DispatcherBlip = true
Config.DispatcherBlipName = 'Garden Twins Co.'
Config.DispatcherBlipId = 541
Config.DispatcherBlipColor = 2

Config.ClientBlip = true
Config.ClientBlipId = 280
Config.ClientBlipColor = 2
Config.ClientBlipName = 'Customer'

-- JOB MENU
Config.JobMenu = true -- If true players can access their job infos and they can leave or end the job in the menu
Config.MenuKey = 166 -- Basic is 166 (F5), you can pick key code here: https://docs.fivem.net/docs/game-references/controls/
Config.DisplayJobs = true

-- PROGRESS BAR
Config.ProgressBars = true -- If true you need to have the rprogress script started
Config.WeedProcess = 10 -- How much time does it take to dig out the weed
Config.TrashProcess = 3 -- How much time does it take to put the trash in the car

-- TEXT UI
Config.TextUI = '3d' -- no, 3DText, ESX.ShowHelpNotification (the strings are: no, 3d, esx)
Config.OverHead = true -- If true, the 3DText will be shown over the npc head
Config.OverObject = true -- If true, the 3DText will be shown over the placed objects

-- NOTIFY
Config.NotifyType = 'esx' -- esx or esx-advanced (more coming soon...)
Config.NotfiyTasks = true
Config.AdvancedTitle = 'Garden Twins Co.'

-- DISCORD LOG
Config.Webhook = 'https://discord.com/api/webhooks/1084165093606043688/8MliOlnTxLFmG1zEtcJ7ZkxX5I_DE9eX_ITXnveFsSmCMyQKgSVL6AfssTDJJ0mvj8gP'
Config.LogColor = '65352'
Config.IconURL = 'https://cdn.discordapp.com/attachments/823189849682477077/1209832856759566378/bnc_logo.png?ex=66040b26&is=65f19626&hm=3c4641397b01065d760a806466470f3a9dfd4083f05c3f0019fae0bdd7a7cc81&'
Config.ServerName = 'Server Name'
Config.Title = 'Player get payed from Gardening job (bnc_gardening)'
Config.PlayerName = 'Player Name: '
Config.PlayerID = 'Player ID: '
Config.Money = 'Money amount: '
Config.Check = 'Money type: '

-- OTHERS
Config.PayCheckType = 'cash' -- cash or bank

Config.Talk = true -- If player need to talk with the customer, before he start the work

Config.SetWaypoint = true -- If true the script will set a waypoint to the job's location

Config.Locales = {
    -- TEXTUI
    ['speak'] = 'Press [~g~E~w~] to talk with: ',
    ['speak_client'] = 'Press [~g~E~w~] to talk with: ',
    ['trash_in'] = 'Press [~g~H~w~] to take trash out',
    ['trash_wrong'] = '~r~You cant do the job with this vehicle!',
    ['plant_pick'] = 'Press [~g~E~w~] to weeding',
    ['trash_up'] = 'Press [~g~E~w~] to pick up trash',
    -- NOTIFICATIONS
    ['job_already'] = 'You are already on a job!',
    ['weeding_done'] = 'Weeding done!',
    ['trash_done'] = 'Trash tooken out!',
    ['job_done'] = 'All tasks done!',
    ['payed'] = 'You get you paycheck!', -- not good if youre not using advanced notification, so I recommend to change it (if using normal esx notification)
    ['carcant'] = 'You already have a job vehicle!',
    -- PROGRESSBARS
    ['weeding'] = 'Weeding...',
    ['trash'] = 'Taking trash out...'
}

Config.Dialogs = {
    -- ANSWERS
    ['yes'] = 'Yes',
    ['no'] = 'No',
    ['yes_job'] = 'Yes (end job)',
    ['no_job'] = 'No (end job)',
    ['leave_job'] = 'End job',
    ['end_job'] = 'End job (Done)',
    -- INFOS
    ['mission'] = 'Current job: ',
    ['client_name'] = 'Customer name: ',
    ['tasks'] = 'Tasks: ',
    ['paycheck'] = 'Paycheck: ',
    ['currency'] = '$',
    -- QUESTIONS
    ['start'] = 'Can you start the job?',
    ['leave_end'] = 'Did you finish the job, because I cant see it.',
    ['job'] = 'Do you need a job?',
    -- DESCRIPTIONS
    ['take_job'] = 'Currently available jobs: ' -- Change text if Config.DisplayJobs = false
}

-- CLIENTS
Config.Customers = { -- Grass are the plants and trash are the bags like in the video!
    {Name = 'Reed John', Position = vector3(-1755.398, 366.947, 89.57526), Ped = 'a_m_o_beach_01', Heading = 186.07, Todos = {
            {typ = 'grass', pos = vector3(-1756.901, 337.7521, 88.07566)},
            {typ = 'trash', pos = vector3(-1760.297, 370.6013, 88.84641)},
            {typ = 'trash', pos = vector3(-1761.394, 372.8191, 88.70425)},
            {typ = 'grass', pos = vector3(-1768.159, 357.199, 88.97801)},
            {typ = 'grass', pos = vector3(-1742.631, 345.6198, 87.97063)},
            {typ = 'grass', pos = vector3(-1731.784, 330.1357, 87.13667)},
            {typ = 'grass', pos = vector3(-1731.577, 343.8775, 88.07915)}
        },
    Payment = math.random(75, 250) -- 75 - 250 (is real), you can also set a fix price, then just Payment = 75
    },

    {Name = 'Penzes Mark', Position = vector3(-1755.398, 366.947, 89.57526), Ped = 'g_m_y_azteca_01', Heading = 186.07, Todos = {
            {typ = 'grass', pos = vector3(-1756.901, 337.7521, 88.07566)},
            {typ = 'trash', pos = vector3(-1760.297, 370.6013, 88.84641)},
            {typ = 'trash', pos = vector3(-1761.394, 372.8191, 88.70425)},
            {typ = 'grass', pos = vector3(-1768.159, 357.199, 88.97801)},
            {typ = 'grass', pos = vector3(-1742.631, 345.6198, 87.97063)},
            {typ = 'grass', pos = vector3(-1731.784, 330.1357, 87.13667)}, 
            {typ = 'grass', pos = vector3(-1731.577, 343.8775, 88.07915)}
        },
    Payment = math.random(75, 250) -- 75 - 250 (is real), you can also set a fix price, then just Payment = 75
    },

    {Name = 'Will Smith', Position = vector3(-820.6252, 177.2142, 71.606), Ped = 'u_m_y_baygor', Heading = 186.07, Todos = {
        {typ = 'grass', pos = vector3(-829.0579, 183.6001, 71.78156)},
        {typ = 'trash', pos = vector3(-846.5162, 179.0975, 70.03461)},
        {typ = 'trash', pos = vector3(-807.7663, 192.4564, 72.91647)},
        {typ = 'grass', pos = vector3(-792.03, 192.1044, 72.97131)},
        {typ = 'grass', pos = vector3(-769.1545, 184.6548, 73.15475)},
        {typ = 'grass', pos = vector3(-775.7469, 177.4944, 72.77947)},
        {typ = 'trash', pos = vector3(-797.9863, 173.4622, 72.64791)},
        {typ = 'trash', pos = vector3(-792.0524, 156.168, 70.67477)},
        {typ = 'trash', pos = vector3(-806.2907, 162.3752, 71.53727)}

    },
Payment = 250 -- 75 - 250 (is real), you can also set a fix price, then just Payment = 75
},

{Name = 'Dominic Toretto', Position = vector3(-932.0549, 798.4067, 183.3078), Ped = 'u_m_m_bankman', Heading = 186.07, Todos = {
    {typ = 'trash', pos = vector3(-946.2101, 806.2072, 181.9914)},
    {typ = 'trash', pos = vector3(-941.5741, 809.8366, 184.7808)},
    {typ = 'trash', pos = vector3(-941.8629, 831.3918, 184.3322)},
    {typ = 'trash', pos = vector3(-932.3724, 827.1451, 184.3368)},
    {typ = 'grass', pos = vector3(-911.1558, 848.7571, 185.7893)},
    {typ = 'trash', pos = vector3(-908.3917, 833.3119, 184.9265)},
    {typ = 'trash', pos = vector3(-912.3243, 817.5217, 184.3379)},

},
Payment = math.random(75,250) -- 75 - 250 (is real), you can also set a fix price, then just Payment = 75
},

{Name = 'Dwayne Jhonson', Position = vector3(1010.834, 63.50891, 80.99056), Ped = 's_m_y_baywatch_01', Heading = 186.07, Todos = {
    {typ = 'grass', pos = vector3(1029.506, 62.14999, 81.9773)},
    {typ = 'grass', pos = vector3(1054.021, 82.14793, 82.01909)},
    {typ = 'grass', pos = vector3(1063.457, 111.4505, 81.89149)},
    {typ = 'grass', pos = vector3(1082.714, 100.9173, 81.89102)},
    {typ = 'grass', pos = vector3(1046.72, 40.27552, 81.88695)},
    {typ = 'grass', pos = vector3(1025.737, 22.3586, 81.92522)},
    {typ = 'grass', pos = vector3(1011.948, 14.35204, 82.03128)},
    {typ = 'grass', pos = vector3(1006.68, 28.64966, 82.0758)},
    {typ = 'grass', pos = vector3(985.0691, -5.627067, 82.19028)}

},
Payment = 250 -- 75 - 250 (is real), you can also set a fix price, then just Payment = 75
},

{Name = 'Gottem Sterling', Position = vector3(814.5184, -274.336, 66.311), Ped = 'a_m_y_bevhills_01', Heading = 186.07, Todos = {
    {typ = 'grass', pos = vector3(825.4858, -277.0648, 66.53271)},
    {typ = 'grass', pos = vector3(826.9252, -283.8511, 66.74677)},
    {typ = 'grass', pos = vector3(825.3803, -295.364, 66.60819)},
    {typ = 'grass', pos = vector3(818.3166, -298.6576, 66.62186)},
    {typ = 'grass', pos = vector3(844.5981, -301.6114, 66.18236)},
    {typ = 'grass', pos = vector3(853.2657, -278.1761, 66.15055)},
    {typ = 'grass', pos = vector3(867.4058, -292.644, 65.64156)},
    {typ = 'grass', pos = vector3(871.2393, -302.7771, 65.11152)},
    {typ = 'grass', pos = vector3(883.5457, -307.9949, 64.81438)}

},
Payment = 250 -- 75 - 250 (is real), you can also set a fix price, then just Payment = 75
},
}
