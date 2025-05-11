ESX = exports['es_extended']:getSharedObject()
local noj = Config.NumberOfJobs

RegisterNetEvent("bnc_gardening:GetNOJ")
AddEventHandler("bnc_gardening:GetNOJ", function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local data = noj
    --print(data..' - Data')
	TriggerClientEvent("bnc_gardening:ReceiveData", _source, data)
end)

RegisterNetEvent("bnc_gardening:MinusJob")
AddEventHandler("bnc_gardening:MinusJob", function()
    noj = noj - 1
end)

RegisterNetEvent("bnc_gardening:PlusJob")
AddEventHandler("bnc_gardening:PlusJob", function()
    noj = noj + 1
end)

RegisterNetEvent("bnc_gardening:Pay")
AddEventHandler("bnc_gardening:Pay", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local data2 = {
        id = _source,
        name = xPlayer.getName(),
        get = Config.PayCheckType,
        money = money
    }
    if Config.PayCheckType == 'cash' then
        SendLog(data2)
        xPlayer.addAccountMoney('money', money)
    elseif Config.PayCheckType == 'bank' then
        SendLog(data2)
        xPlayer.addAccountMoney('bank', money)
    else
        print('Invalid Config.PayCheckType value in the gardening job!')
    end
    if Config.NotifyType == 'esx' then
        xPlayer.showNotification(Config.Locales['payed']..' '..money..Config.Dialogs['currency'])
    elseif Config.NotifyType == 'esx-advanced' then
        xPlayer.showAdvancedNotification(Config.AdvancedTitle, money..Config.Dialogs['currency'], Config.Locales['payed'], 'CHAR_ORTEGA', 9)
    end
end)

function SendLog(data)
	local information = {
		{
			["color"] = Config.LogColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Log',
			},
			["title"] = Config.Title,
			["description"] = Config.PlayerName..data.name..'\n '..Config.PlayerID..data.id..'\n '..Config.Money..data.money..'\n '..Config.Check..data.get,

			["footer"] = {
				["text"] = os.date('%Y/%m/%d [%X]'),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = '', embeds = information}), {['Content-Type'] = 'application/json'})
end