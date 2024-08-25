function CreateMissionInfoTable()
    MySQL.rawExecute.await(
        [[
            CREATE TABLE IF NOT EXISTS ys_missioninfo (
                playerid VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                currentmission INT DEFAULT 0,
                PRIMARY KEY (playerid)
            );

        ]]
    )
end

function GetPlayerMission(playerId)
    local currentMission =  MySQL.single.await('SELECT `currentmission` FROM `ys_missioninfo` WHERE `playerid` = ? LIMIT 1', {
        playerId
    })
    return currentMission
end