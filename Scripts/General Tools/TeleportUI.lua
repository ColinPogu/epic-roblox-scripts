local module = {}

local Players = game:GetService("Players")

local gui
local storedPos

local function parseVector(text)
    if not text then return nil end
    local x, y, z = text:match("%-?%d+%.?%d*"), nil, nil
    if x then
        y = text:match("%-?%d+%.?%d*", #x + 2)
    end
    if y then
        z = text:match("%-?%d+%.?%d*", #x + #y + 3)
    end
    if x and y and z then
        return Vector3.new(tonumber(x), tonumber(y), tonumber(z))
    end
    return nil
end

local function teleport(pos)
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and pos then
        hrp.CFrame = CFrame.new(pos)
    end
end

local function createGui()
    local player = Players.LocalPlayer
    gui = Instance.new("ScreenGui")
    gui.Name = "TeleportUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Name = "Container"
    frame.Size = UDim2.new(0, 200, 0, 180)
    frame.Position = UDim2.new(1, -210, 0.35, 0)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Parent = gui

    local storeBtn = Instance.new("TextButton")
    storeBtn.Name = "StoreButton"
    storeBtn.Size = UDim2.new(1, -20, 0, 30)
    storeBtn.Position = UDim2.new(0, 10, 0, 10)
    storeBtn.Text = "Store Current Pos"
    storeBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    storeBtn.TextScaled = true
    storeBtn.Parent = frame

    local tpBtn = Instance.new("TextButton")
    tpBtn.Name = "TeleportButton"
    tpBtn.Size = UDim2.new(1, -20, 0, 30)
    tpBtn.Position = UDim2.new(0, 10, 0, 50)
    tpBtn.Text = "Teleport"
    tpBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 100)
    tpBtn.TextScaled = true
    tpBtn.Parent = frame

    local inputBox = Instance.new("TextBox")
    inputBox.Name = "CoordBox"
    inputBox.Size = UDim2.new(1, -20, 0, 30)
    inputBox.Position = UDim2.new(0, 10, 0, 90)
    inputBox.PlaceholderText = "X, Y, Z"
    inputBox.ClearTextOnFocus = false
    inputBox.TextScaled = true
    inputBox.Parent = frame

    local saveBtn = Instance.new("TextButton")
    saveBtn.Name = "SaveButton"
    saveBtn.Size = UDim2.new(1, -20, 0, 30)
    saveBtn.Position = UDim2.new(0, 10, 0, 130)
    saveBtn.Text = "Save Typed Pos"
    saveBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    saveBtn.TextScaled = true
    saveBtn.Parent = frame

    storeBtn.MouseButton1Click:Connect(function()
        local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            storedPos = hrp.Position
            storeBtn.Text = string.format("Stored: %.1f, %.1f, %.1f", storedPos.X, storedPos.Y, storedPos.Z)
        end
    end)

    tpBtn.MouseButton1Click:Connect(function()
        if storedPos then
            teleport(storedPos)
        end
    end)

    saveBtn.MouseButton1Click:Connect(function()
        local pos = parseVector(inputBox.Text)
        if pos then
            storedPos = pos
            storeBtn.Text = string.format("Stored: %.1f, %.1f, %.1f", storedPos.X, storedPos.Y, storedPos.Z)
        end
    end)
end

function module.Enable()
    if gui then return end
    createGui()
end

function module.Disable()
    if gui then
        gui:Destroy()
        gui = nil
    end
end

return module

