local module = {}
local Players = game:GetService("Players")
local connections = {}
local highlights = {}
local enabled = false

local function addHighlight(char)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = char
    highlight.FillColor = Color3.fromRGB(255,0,0)
    highlight.OutlineColor = Color3.fromRGB(255,255,255)
    highlight.Parent = char
    table.insert(highlights, highlight)
end

function module.Enable()
    if enabled then return end
    enabled = true
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            local char = plr.Character or plr.CharacterAdded:Wait()
            addHighlight(char)
            connections[#connections+1] = plr.CharacterAdded:Connect(addHighlight)
        end
    end
end

function module.Disable()
    if not enabled then return end
    enabled = false
    for _, conn in ipairs(connections) do
        conn:Disconnect()
    end
    connections = {}
    for _, h in ipairs(highlights) do
        h:Destroy()
    end
    highlights = {}
end

return module
