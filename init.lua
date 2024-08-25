shared = {
    resource = GetCurrentResourceName()
}

if IsDuplicityVersion() then
    require 'server/main'
else
    require 'client/main'
end