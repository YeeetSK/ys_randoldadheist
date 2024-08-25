local qbx_core = exports.qbx_core

function client.getPlayerFrameworkId(playerId)
    local player = qbx_core:GetPlayer(id)
    local frameworkId = player.PlayerData.citizenid
    return frameworkId
end