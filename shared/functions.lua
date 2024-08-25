F = {}
F.Core = false
F.useExports = false
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
-- Data
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

EsxColors = {
    ["success"] = "g",
    ["error"] = "r",
    ["info"] = "b",
    ["primary"] = "c"
}

-- Functions, don't recommend touching these.

F.QBInputToOxLib = function(inputData)
    local dataGenerated = {}
    local menuHeader = inputData.header
    local additionalInfo
    for item in inputData.inputs do
        local intData = {}
        local log = ""
        if item.type then intData.type = qbLib[item.input] log += "Added Type " end
        if item.text then intData.label = item.text log += "Added Label " end
        if item.description then intData.description = item.description log += "Added Description " end
        if item.isRequired then intData.required = item.isRequired log += "Added Requirement " end
        if item.default then intData.placeholder = item.default log += "Added Placeholder " end
        if item.icon then intData.icon = item.icon:match("-(.*)") log += "Added Icon " end
        if item.min then intData.min = item.min log += "Added Min " end
        if item.max then intData.max = item.max log += "Added Max " end
        if item.step then intData.step = item.step log += "Added Step " else intData.step = 1 log += "Step was 0 but required, set to 1 " end
        if qbLib[item.type] == "color" then intData.format = "rgb" log += "Added Color Format as RGB " end
        print('Table data generated. Log: '.. log)
        dataGenerated[#dataGenerated + 1] = intData
    end
    return menuHeader, dataGenerated

end

F.QBMenuToOxLib = function(menuData)
    local dataGenerated = {}
    local data = {
        id = "generated-".. math.random(11111, 99999),
        title = menuData[1].header,
        options = dataGenerated
    }
    for item in menuData do
        if not item.isMenuHeader then
            if item.hidden then break end
            local intTable = {}
            local log = ""
            intTable.title = item.header log += "Added Title "
            if item.txt then intTable.description = item.txt log += "Added Description " end
            if item.disabled then intTable.disabled = item.disabled log += "Disabled Button " end
            if item.icon then intTable.icon = item.icon:match("-(.*)") log += "Added Icon " end
            if item.params then
                if item.params.args then
                    intTable.args = item.params.args
                    log += "Added Args "
                end
                if item.params.event then
                    if isServer then
                        intTable.serverEvent = item.params.event
                        log += "Added Server Event "
                    else
                        intTable.event = item.params.event
                        log += "Added Client Event " 
                    end
                end
            end
            if item.arrow then intTable.arrow = item.arrow log += "Added Arrow " end
            dataGenerated[#dataGenerated + 1] = intTable
            print('Table data generated. Log: '.. log)
            break
        end
    end
    return data
end

