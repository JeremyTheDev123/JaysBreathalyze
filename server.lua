RegisterServerEvent("setBAC")
AddEventHandler("setBAC", function(amount)
	TriggerClientEvent("BAC", source)
	bacData[source] = amount
end)

bacData = {} 
RegisterServerEvent("return")
AddEventHandler('return', function(id)
	RconPrint("Breathalyzing: "..id)
	if bacData[id] ~= nil then
		TriggerClientEvent("Breath", source, bacData[id])
	elseif bacData[id] == nil then
		TriggerClientEvent("Breath", source, "0.00")
	end
end)