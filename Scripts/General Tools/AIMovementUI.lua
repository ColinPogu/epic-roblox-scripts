local module = {}
local Players = game:GetService("Players")

local gui
local aiModule
local targetPos
local debugLabel
local moving = false

local function showMessage(text)
    if debugLabel then
        debugLabel.Text = text
        debugLabel.Visible = true
        task.delay(1.5, function()
            if debugLabel then
                debugLabel.Visible = false
            end
        end)
    end
end

local function ensureAIModule(loader)
    if aiModule then return end
    if type(loader) == "function" then
        aiModule = loader("Scripts/General Tools/AIMovement.lua")
    else
        aiModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/General%20Tools/AIMovement.lua"))()
    end
end

local function createGui(loader)
    local player = Players.LocalPlayer
    gui = Instance.new("ScreenGui")
    gui.Name = "AIMovementUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local setTarget = Instance.new("TextButton")
    setTarget.Name = "SetTargetLocation"
    setTarget.Size = UDim2.new(0, 160, 0, 40)
    setTarget.Position = UDim2.new(1, -170, 0.3, 0)
    setTarget.Text = "Set Target Location"
    setTarget.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
    setTarget.TextScaled = true
    setTarget.Parent = gui

    local startPath = Instance.new("TextButton")
    startPath.Name = "StartAIPath"
    startPath.Size = UDim2.new(0, 160, 0, 40)
    startPath.Position = UDim2.new(1, -170, 0.4, 0)
    startPath.Text = "Start AI Path"
    startPath.BackgroundColor3 = Color3.fromRGB(200, 255, 200)
    startPath.TextScaled = true
    startPath.Parent = gui

    debugLabel = Instance.new("TextLabel")
    debugLabel.Name = "DebugMessage"
    debugLabel.Size = UDim2.new(0, 200, 0, 30)
    debugLabel.Position = UDim2.new(0.5, -100, 0.2, 0)
    debugLabel.BackgroundTransparency = 0.3
    debugLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    debugLabel.TextColor3 = Color3.new(1, 1, 1)
    debugLabel.TextScaled = true
    debugLabel.Visible = false
    debugLabel.Parent = gui

    setTarget.MouseButton1Click:Connect(function()
        local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            targetPos = hrp.Position
            showMessage("Target Location Set")
        end
    end)

    startPath.MouseButton1Click:Connect(function()
        ensureAIModule(loader)
        if moving then
            moving = false
            aiModule.Stop()
            startPath.Text = "Start AI Path"
            showMessage("Movement Interrupted")
        else
            if targetPos then
                moving = true
                aiModule.Start(targetPos)
                startPath.Text = "Stop AI Path"
                showMessage("Dashing to Base...")
            end
        end
    end)
end

function module.Enable(loader)
    if gui then return end
    createGui(loader)
end

function module.Disable()
    if aiModule and moving then
        aiModule.Stop()
        moving = false
    end
    if gui then
        gui:Destroy()
        gui = nil
        debugLabel = nil
    end
end

return module
