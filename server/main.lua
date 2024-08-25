lib.callback.register('ys_randoldadheist:server:getCurrentMission', function(source)
    local playerId = client.getPlayerFrameworkId(source)
    local currentMission = GetPlayerMission(playerId)
    return currentMission
end)