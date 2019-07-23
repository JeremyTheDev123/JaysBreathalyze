RegisterCommand("setbac", function(source,args,rawCommand)
    TriggerServerEvent("setBAC", KeyboardInput("Enter BAC", "", 100))
end, false)

RegisterCommand("searchbac", function(source,args,rawCommand)
    searchbac()
end, false)

function searchbac()
	local ped = PlayerPedId()
	local nearestPlayer = GetNearestPlayerToEntity(ped)
	local entityType = GetEntityType(ped)
	shortestDistance = 2
	closestId = 0
	for id = 0, 32 do
        if NetworkIsPlayerActive( id ) and GetPlayerPed(id) ~= PlayerPedId() then
			ped1 = GetPlayerPed( id )
			local x,y,z = table.unpack(GetEntityCoords(ped))
                if (GetDistanceBetweenCoords(GetEntityCoords(ped1), x,y,z) <  shortestDistance) then
					shortestDistance = GetDistanceBetweenCoords(GetEntityCoords(ped), x,y,z)
					closestId = GetPlayerServerId(id)
				end
        end
	end
	TriggerServerEvent("return", closestId)
end)




---Events
RegisterNetEvent("BAC")
RegisterNetEvent("Breath")
AddEventHandler("BAC", function()
	SetNotificationTextEntry("STRING")
	AddTextComponentString("Blood Alcohol Level has been set!")
	DrawNotification(false, false)
end)

AddEventHandler("Breath", function(results)
	local dots = ". . . ."
	local timer = 0
	for timer=0,5,1 do
		SetNotificationTextEntry("STRING")
		AddTextComponentString("~b~~h~Breathalyzing~h~~n~~c~"..dots)
		local notify = DrawNotification(false, false)
		Citizen.Wait(1000)
		RemoveNotification(notify)
		dots = dots.." . . . ."
	end
	if (results < "0.08") then
		SetNotificationTextEntry("STRING")
		AddTextComponentString("~b~~h~BAC Results:~h~~n~~g~ "..results.."%")
		local notify = DrawNotification(false, false)
	elseif (results >= "0.08") then
		SetNotificationTextEntry("STRING")
		AddTextComponentString("~b~~h~BAC Results:~h~~n~~r~"..results.."%")
		local notify = DrawNotification(false, false)
	elseif (results == nil) then
		SetNotificationTextEntry("STRING")
		AddTextComponentString("~b~~h~BAC Results:~h~~n~~g~ 0.000%")
		local notify = DrawNotification(false, false)
	end
end)