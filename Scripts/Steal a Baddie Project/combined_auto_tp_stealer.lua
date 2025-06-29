local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Gui Setup
local gui = Instance.new("ScreenGui")
gui.Name = "SectorTPStealerGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local returnPosition

local function getRootPart()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart")
end

local rootPart = getRootPart()

local function holdingTool()
    local character = player.Character
    if character then
        if character:FindFirstChildOfClass("Tool") then
            return true
        end
    end
    return false
end

local function waitForToolRelease(timeout)
    local start = tick()
    while holdingTool() and tick() - start < (timeout or 5) do
        RunService.Stepped:Wait()
    end
end

-- Coordinates split into 8 sectors
local allCoords = {
    Sector1 = {
        Vector3.new(-113.03, 110.82, -535.76), Vector3.new(-112.21, 110.92, -548.22),
        Vector3.new(-112.79, 110.92, -559.05), Vector3.new(-113.32, 110.72, -568.84),
        Vector3.new(-112.56, 110.72, -580.13), Vector3.new(-154.30, 110.72, -580.43),
        Vector3.new(-153.69, 110.92, -569.27), Vector3.new(-153.09, 110.72, -558.24),
        Vector3.new(-153.39, 110.82, -546.70), Vector3.new(-152.86, 110.72, -536.93)
    },
    Sector2 = {
        Vector3.new(-48.17, 110.37, -534.54), Vector3.new(-49.19, 110.72, -546.98),
        Vector3.new(-49.02, 110.72, -559.06), Vector3.new(-48.87, 110.72, -569.77),
        Vector3.new(-48.73, 110.72, -580.27), Vector3.new(-9.88, 110.72, -579.72),
        Vector3.new(-8.17, 110.72, -568.54), Vector3.new(-8.29, 110.92, -559.67),
        Vector3.new(-8.49, 110.27, -545.56), Vector3.new(-8.62, 110.92, -536.16)
    },
    Sector3 = {
        Vector3.new(66.72, 110.55, -535.10), Vector3.new(66.88, 110.82, -546.76),
        Vector3.new(67.02, 110.45, -556.68), Vector3.new(67.19, 110.92, -569.27),
        Vector3.new(67.34, 110.65, -579.54), Vector3.new(107.35, 110.72, -578.97),
        Vector3.new(107.22, 110.72, -569.33), Vector3.new(108.81, 110.72, -558.90),
        Vector3.new(108.64, 110.92, -547.15), Vector3.new(108.50, 110.92, -536.77)
    },
    Sector4 = {
        Vector3.new(172.74, 110.72, -536.47), Vector3.new(172.90, 111.02, -547.86),
        Vector3.new(173.06, 111.02, -558.80), Vector3.new(173.20, 110.92, -569.18),
        Vector3.new(173.36, 111.02, -580.38), Vector3.new(213.95, 110.72, -579.81),
        Vector3.new(213.76, 109.75, -565.82), Vector3.new(213.60, 109.64, -554.51),
        Vector3.new(213.45, 109.95, -543.89), Vector3.new(213.30, 110.00, -533.05)
    },
    Sector5 = {
        Vector3.new(214.62, 111.02, -391.53), Vector3.new(215.09, 110.82, -381.17),
        Vector3.new(214.56, 110.65, -370.45), Vector3.new(215.66, 110.72, -358.63),
        Vector3.new(214.52, 111.02, -347.48), Vector3.new(175.05, 110.22, -349.45),
        Vector3.new(175.51, 110.72, -358.77), Vector3.new(172.87, 110.45, -371.25),
        Vector3.new(173.29, 110.72, -379.63), Vector3.new(173.92, 110.82, -392.18)
    },
    Sector6 = {
        Vector3.new(109.79, 110.72, -390.35), Vector3.new(109.24, 110.82, -379.20),
        Vector3.new(108.70, 110.92, -368.50), Vector3.new(108.21, 110.72, -358.71),
        Vector3.new(109.96, 110.72, -347.45), Vector3.new(67.59, 110.22, -349.57),
        Vector3.new(68.08, 110.82, -359.32), Vector3.new(68.63, 110.65, -370.46),
        Vector3.new(67.42, 110.52, -382.08), Vector3.new(67.93, 110.75, -392.40)
    },
    Sector7 = {
        Vector3.new(-8.25, 111.02, -391.08), Vector3.new(-8.76, 110.72, -380.82),
        Vector3.new(-8.40, 110.82, -368.17), Vector3.new(-7.28, 110.82, -357.29),
        Vector3.new(-7.82, 110.92, -346.59), Vector3.new(-49.26, 110.72, -348.66),
        Vector3.new(-48.76, 111.02, -358.56), Vector3.new(-48.23, 110.72, -369.27),
        Vector3.new(-49.28, 110.65, -381.55), Vector3.new(-48.79, 110.92, -391.34)
    },
    Sector8 = {
        Vector3.new(-112.75, 110.72, -392.01), Vector3.new(-111.52, 110.55, -381.80),
        Vector3.new(-112.15, 110.92, -369.34), Vector3.new(-112.63, 110.65, -359.55),
        Vector3.new(-111.50, 110.72, -347.59), Vector3.new(-153.10, 110.92, -347.55),
        Vector3.new(-152.52, 110.82, -359.16), Vector3.new(-151.92, 110.45, -371.24),
        Vector3.new(-151.48, 110.72, -380.08), Vector3.new(-152.99, 110.92, -391.96)
    }
}

local function createButton(text, offset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 160, 0, 40)
    btn.Position = UDim2.new(1, -170, 0.05 + offset, 0)
    btn.BackgroundColor3 = Color3.fromRGB(200, 255, 200)
    btn.Text = text
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = gui
    return btn
end

local returnBtn = createButton("Set Return Point", 0)
returnBtn.MouseButton1Click:Connect(function()
    rootPart = getRootPart()
    returnPosition = rootPart.Position
    print("[Return Point Set]:", returnPosition)
end)

-- === Autostealer functions (from autostealer.lua) ===
local function findAllStealPrompts()
    local prompts = {}
    local bases = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Bases")
    if not bases then return prompts end

    for _, base in ipairs(bases:GetChildren()) do
        if base:IsA("Model") and base:FindFirstChild("Floors") then
            local floor1 = base.Floors:FindFirstChild("Floor1")
            if floor1 then
                local stands = floor1:FindFirstChild("Interactables")
                stands = stands and stands:FindFirstChild("Stands")
                if stands then
                    for _, stand in ipairs(stands:GetChildren()) do
                        local npcFolder = stand:FindFirstChild("NPC")
                        if npcFolder then
                            for _, npc in ipairs(npcFolder:GetChildren()) do
                                local hrp = npc:FindFirstChild("HumanoidRootPart")
                                if hrp and hrp:FindFirstChild("ProximityAttachment") then
                                    local prompt = hrp.ProximityAttachment:FindFirstChild("StealProximity")
                                    if prompt and prompt:IsA("ProximityPrompt") then
                                        table.insert(prompts, prompt)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return prompts
end

local function stealNearby(radius)
    local root = getRootPart()
    for _, prompt in ipairs(findAllStealPrompts()) do
        if prompt.Enabled and prompt:IsDescendantOf(workspace) then
            local hrp = prompt.Parent and prompt.Parent.Parent
            if hrp and hrp:IsA("BasePart") then
                if (hrp.Position - root.Position).Magnitude <= (radius or 15) then
                    prompt.HoldDuration = 0
                    prompt:InputHoldBegin()
                    task.wait()
                    prompt:InputHoldEnd()
                end
            end
        end
    end
end

-- === Sector logic ===
local isRunning = false
local activeSector

local index = 0
for sectorName, coordList in pairs(allCoords) do
    local btn = createButton(sectorName, index * 0.06 + 0.05)

    btn.MouseButton1Click:Connect(function()
        if isRunning and activeSector == sectorName then
            isRunning = false
            warn("Loop canceled for", sectorName)
            return
        elseif isRunning then
            warn("Another sector is still running.")
            return
        end

        if not returnPosition then
            warn("Return position not set.")
            return
        end

        isRunning = true
        activeSector = sectorName

        coroutine.wrap(function()
            for _, pos in ipairs(coordList) do
                if not isRunning then break end
                rootPart = getRootPart()
                rootPart.CFrame = CFrame.new(pos + Vector3.new(0, 4, 0))
                task.wait(0.5)
                stealNearby(20)
                waitForToolRelease(5)
                if returnPosition then
                    rootPart.CFrame = CFrame.new(returnPosition + Vector3.new(0, 4, 0))
                end
                task.wait(0.3)
            end
            isRunning = false
            activeSector = nil
        end)()
    end)

    index += 1
end

-- Add markers for sectors
local markerFolder = Instance.new("Folder")
markerFolder.Name = "SectorMarkers"
markerFolder.Parent = workspace

for sectorName, coords in pairs(allCoords) do
    local position = coords[1]
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Position = position + Vector3.new(0, 3, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(255, 255, 0)
    part.Name = sectorName
    part.Parent = markerFolder

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 255, 100)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = part
    highlight.Adornee = part

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "Label"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = part
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 1000
    billboard.Parent = part

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = sectorName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
end

