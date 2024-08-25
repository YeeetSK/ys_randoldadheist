local currentMission

local function doDebuffLoop()
    local playerMaxHealth
            
    CreateThread(function()
        while currentMission > 0 do
            Wait(5000)
            local NewPlayerMaxHealth = GetEntityMaxHealth(cache.ped)
            if NewPlayerMaxHealth == playerMaxHealth then return end
            playerMaxHealth = NewPlayerMaxHealth/2
            SetEntityMaxHealth(cache.ped, playerMaxHealth)
        end
    end)
end

local function checkMission()
    currentMission = lib.callback.await('ys_randoldadheist:server:getCurrentMission')

    if currentMission > 0 then
        doDebuffLoop()
    end
    
end

checkMission()