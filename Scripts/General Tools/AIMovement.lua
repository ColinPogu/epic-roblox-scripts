local module = {}
local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")

local moving = false
local connections = {}

local function getCharacter()
    local player = Players.LocalPlayer
    return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoidRootPart()
    local char = getCharacter()
    return char:WaitForChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = getCharacter()
    return char:WaitForChild("Humanoid")
end

local function clearConnections()
    for i, con in ipairs(connections) do
        con:Disconnect()
    end
    connections = {}
end

local function computePath(target)
    local root = getHumanoidRootPart()
    local path = PathfindingService:CreatePath()
    path:ComputeAsync(root.Position, target)
    if path.Status ~= Enum.PathStatus.Success then
        return nil
    end
    return path
end

local function followPath(path)
    local humanoid = getHumanoid()
    local waypoints = path:GetWaypoints()
    local index = 1

    local function moveToWaypoint()
        if not moving then return end
        local wp = waypoints[index]
        if not wp then
            moving = false
            return
        end
        if wp.Action == Enum.PathWaypointAction.Jump then
            humanoid.Jump = true
        end
        humanoid:MoveTo(wp.Position)
    end

    moveToWaypoint()

    connections[#connections+1] = humanoid.MoveToFinished:Connect(function(reached)
        if not moving then return end
        if reached then
            index += 1
            if index <= #waypoints then
                moveToWaypoint()
            else
                moving = false
                clearConnections()
            end
        else
            local newPath = computePath(waypoints[#waypoints].Position)
            if newPath then
                waypoints = newPath:GetWaypoints()
                index = 1
                moveToWaypoint()
            else
                moving = false
                clearConnections()
            end
        end
    end)

    connections[#connections+1] = RunService.Stepped:Connect(function()
        if not moving then return end
        local root = getHumanoidRootPart()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Players.LocalPlayer then
                local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - root.Position).Magnitude < 5 then
                    humanoid:Move(Vector3.new((root.Position - hrp.Position).Unit.X, 0, (root.Position - hrp.Position).Unit.Z), true)
                end
            end
        end
    end)
end

function module.Start(target)
    if moving then return end
    local path = computePath(target)
    if path then
        moving = true
        followPath(path)
    end
end

function module.Stop()
    moving = false
    clearConnections()
    local humanoid = getHumanoid()
    humanoid:Move(Vector3.zero, true)
end

return module
