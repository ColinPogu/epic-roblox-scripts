
local function createController()
    local activeButtons = {}

    local function cleanupEntry(entry)
        if entry.enabled then
            local obj = entry.handle
            if obj then
                if typeof(obj) == "Instance" and obj.Destroy then
                    obj:Destroy()
            elseif type(obj) == "table" then
                if obj.Disable then
                    obj:Disable()
                elseif obj.Toggle then
                    obj:Toggle(false)
                elseif obj.Destroy then
                    obj:Destroy()
                end
            elseif type(obj) == "function" then
                -- if function used as cleanup callback
                pcall(obj)
            end
        end
    end
        end
        entry.enabled = false
        entry.handle = nil
    end

    local ToggleLib = {}

    function ToggleLib.AddButton(gridFrame, templateButton, labelText, moduleLoader)
        local btn = templateButton:Clone()
        btn.Name = labelText:gsub("%s+", "")
        btn.Text = labelText
        btn.Visible = true
        btn.Parent = gridFrame

    local entry = {enabled=false, handle=nil, loader=moduleLoader}
        activeButtons[btn] = entry

    local function enable()
        local result
        if typeof(moduleLoader) == "Instance" then
            result = require(moduleLoader)
        elseif type(moduleLoader) == "function" then
            result = moduleLoader()
        end
        if type(result) == "table" then
            if result.Enable then
                result.Enable()
            elseif result.Toggle then
                result.Toggle(true)
            end
        elseif type(result) == "function" then
            result()
        end
        entry.handle = result
    end

    local function disable()
        cleanupEntry(entry)
    end

        btn.MouseButton1Click:Connect(function()
            entry.enabled = not entry.enabled
            if entry.enabled then
                enable()
            else
                disable()
            end
        end)

        return btn
    end

    function ToggleLib.Reset()
        for _, entry in pairs(activeButtons) do
            cleanupEntry(entry)
        end
        activeButtons = {}
    end

    return ToggleLib
end

return {CreateController = createController}
