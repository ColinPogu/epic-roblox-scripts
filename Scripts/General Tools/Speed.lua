local module = {}

local Players = game:GetService("Players")

local enabled = false
local originalSpeed
local speed = 50

local function getHumanoid()
    local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
    return char:FindFirstChildOfClass("Humanoid")
end

function module.Enable()
    if enabled then return end
    enabled = true
    local hum = getHumanoid()
    if hum then
        originalSpeed = hum.WalkSpeed
        hum.WalkSpeed = speed
    end
end

function module.Disable()
    if not enabled then return end
    enabled = false
    local hum = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = originalSpeed or 16
    end
end

return module
