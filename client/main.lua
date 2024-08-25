local playerPed = cache.ped
local playerHealth


-- setting player healt to half if the things are not done
CreateThread(function()
    while true do
        Wait(5000)
        if GetEntityMaxHealth(playerPed) == playerHealth then return end
        playerHealth = GetEntityMaxHealth(playerPed)/2
        SetEntityMaxHealth(playerPed, playerHealth)
    end
end)