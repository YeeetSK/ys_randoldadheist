shared = {
    resource = GetCurrentResourceName()
    framework = GetConvar('ys:framework', 'qbx')
}



if IsDuplicityVersion() then
    server = {}
    require 'modules.bridge.'shared.framework'.server'
    require 'server/db'
    require 'server/main'

    CreateMissionInfoTable()
else
    client = {}

    require 'modules.bridge.'shared.framework'.client'
    require 'client/main'
end