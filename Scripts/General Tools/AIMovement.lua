local module = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local moving = false
local currentTween
local moveThread

local function getRoot()
    local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function stepTowards(destination, stepDistance)
    local root = getRoot()
    local offset = destination - root.Position
    local distance = offset.Magnitude
    if distance <= 0 then return distance end
    local travel = math.min(stepDistance, distance)
    local nextPos = root.Position + offset.Unit * travel
    if currentTween then
        currentTween:Cancel()
    end
    currentTween = TweenService:Create(root, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = CFrame.new(nextPos)})
    currentTween:Play()
    currentTween.Completed:Wait()
    return distance - travel
end

function module.Start(destination, stepDistance)
    if moving then return end
    moving = true
    local step = stepDistance or 10
    moveThread = task.spawn(function()
        while moving do
            local remaining = stepTowards(destination, math.clamp(step, 2, 10))
            if remaining <= 2 then
                break
            end
        end
        moving = false
    end)
end

function module.Stop()
    moving = false
    if currentTween then currentTween:Cancel() end
    if moveThread then task.cancel(moveThread) end
end

return module
