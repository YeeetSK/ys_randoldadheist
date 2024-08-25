F = {}
F.Core = false
F.useExports = false
local qbLib = {
    ["text"] = "input",
    ["number"] = "number",
    ["checkbox"] = "checkbox",
    ["radio"] = "select",
    ["select"] = "multi-select",
    ["date"] = "date",
    ["slider"] = "slider",
    ["color"] = "color",
    ["date"] = "date",
    ["date-range"] = "date-range",
    ["time"] = "time",
    ["textarea"] = "textarea"

}

local EsxColors = {
    ["success"] = "g",
    ["error"] = "r",
    ["info"] = "b",
    ["primary"] = "c"
}

-- Framework check
if Config.Framework == "esx" then
    F.Core = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qb" then
    F.Core = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "qbox" then
    F.useExports = true
else
    print("FRAMEWORK NOT FOUND OR IS NOT ONE OF THE FRAMEWORKS WE SUPPORT, PLEASE RESTART THE SCRIPT! IT WILL NOT WORK")
    return
end

-- Functions
F.Notify = function(text, type, title, source)
    if source then
        if Config.NotificationLibrary == "qb" then
            F.Core.Functions.Notify(source, text, type, 5000)
        elseif Config.NotificationLibrary == "esx" then
            F.Core.ShowNotification(text, false, false, EsxColors[type])
        elseif Config.NotificationLibrary == "ox_lib" then
            if type == "info" then type = "inform" end
            data = {
                title = title,
                description = text,
                type = type,
                duration = 5000,
                showDuration = true,
                position = "center-right",
            }
            lib.notify(data)
        end
    else
        F.Core.Functions.Notify(text, type, 5000)
    end
end

F.Input = function(data, event, type)
    if Config.InputLibrary == "qb-input" then
        exports['qb-input']:ShowInput(data)
        if type == "server" then
            TriggerServerEvent(event, input)
        else
            TriggerClientEvent(event, input)
        end
    elseif Config.InputLibrary == "ox_lib" then
        local header, data = QBInputToOxLib(data)
        local input = lib.inputDialog(header, data)

        if type == "server" then
            TriggerServerEvent(event, input)
        else
            TriggerClientEvent(event, input)
        end
    end

end

F.Menu = function(inputTable)
    if Config.MenuLibrary == "qb-menu" then
        exports['qb-menu']:openMenu(inputTable)
    elseif Config.MenuLibrary == "ox_lib" then
        data = QBMenuToOxLib(inputTable)
        lib.registerContext(data)
        lib.showContext(data.id)
    end

end
F.TextUI = function(text)
        if Config.TextUILibrary == "qb" then
            if not text then 
                exports['qb-core']:HideText()
            else
                exports['qb-core']:DrawText(text, "right")
            end
        elseif Config.TextUILibrary == "ox_lib" then
            if not text then
                lib.hideTextUI()
            else
                lib.showTextUI(text, { position = 'right-center' })
            end
        end
end