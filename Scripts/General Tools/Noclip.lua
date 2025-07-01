local module = {}

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local connection

local function getParts()
    local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
    return char:GetDescendants()
end

local function onStep()
    for _, obj in ipairs(getParts()) do
        if obj:IsA("BasePart") then
            obj.CanCollide = false
        end
    end
end

function module.Enable()
    if connection then return end
    connection = RunService.Stepped:Connect(onStep)
end

function module.Disable()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    for _, obj in ipairs(getParts()) do
        if obj:IsA("BasePart") then
            obj.CanCollide = true
        end
    end
end

return module
