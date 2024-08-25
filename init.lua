shared = {
    resource = GetCurrentResourceName()
}

if IsDuplicityVersion() then
    require 'server/db'
    require 'server/main'

    CreateMissionInfoTable()
else
    require 'client/main'
end