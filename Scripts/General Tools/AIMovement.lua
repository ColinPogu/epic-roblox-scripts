local module = {}
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local moving = false
local moveThread

local function getRoot()
    local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end


function module.Start(destination, speed)
    if moving then return end
    moving = true
    local stepDuration = 0.3
    local dashSpeed = speed or 60
    local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.AutoRotate = false
    end
    moveThread = task.spawn(function()
        while moving do
            local root = getRoot()
            local offset = destination - root.Position
            local distance = offset.Magnitude
            if distance <= 2 then
                break
            end

            local bv = Instance.new("BodyVelocity")
            bv.Velocity = offset.Unit * dashSpeed
            bv.MaxForce = Vector3.new(1e5, 0, 1e5)
            bv.Parent = root
            Debris:AddItem(bv, stepDuration)

            task.wait(stepDuration)
        end
        moving = false
        if humanoid then
            humanoid.AutoRotate = true
        end
    end)
end

function module.Stop()
    moving = false
    if moveThread then task.cancel(moveThread) end
end

return module
