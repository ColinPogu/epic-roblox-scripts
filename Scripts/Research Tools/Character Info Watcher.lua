local module = {}
local gui
local connections = {}

local function createGui()
    local player = game:GetService("Players").LocalPlayer
    gui = Instance.new("ScreenGui")
    gui.Name = "CharacterInfoWatcher"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local button = Instance.new("TextButton")
    button.Name = "DumpInfoButton"
    button.Size = UDim2.new(0, 160, 0, 40)
    button.Position = UDim2.new(1, -180, 0.7, 0)
    button.Text = "Dump Character Info"
    button.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
    button.TextScaled = true
    button.Font = Enum.Font.SourceSansBold
    button.Parent = gui

    local outputBox = Instance.new("TextBox")
    outputBox.Name = "InfoOutput"
    outputBox.Size = UDim2.new(0, 400, 0.4, 0)
    outputBox.Position = UDim2.new(0, 20, 0.2, 0)
    outputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    outputBox.TextColor3 = Color3.new(1, 1, 1)
    outputBox.Font = Enum.Font.Code
    outputBox.TextSize = 14
    outputBox.TextXAlignment = Enum.TextXAlignment.Left
    outputBox.TextYAlignment = Enum.TextYAlignment.Top
    outputBox.ClearTextOnFocus = false
    outputBox.MultiLine = true
    outputBox.Text = ""
    outputBox.Parent = gui

    local function scan(obj, indent, out)
        indent = indent or 0
        out = out or {}
        table.insert(out, string.rep("  ", indent) .. obj.Name .. " [" .. obj.ClassName .. "]")
        for _, child in ipairs(obj:GetChildren()) do
            scan(child, indent + 1, out)
        end
        return out
    end

    local function getInfo()
        local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
        local lines = scan(char, 0, {})
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            table.insert(lines, string.format("Health: %.1f/%.1f", humanoid.Health, humanoid.MaxHealth))
            table.insert(lines, string.format("WalkSpeed: %.1f", humanoid.WalkSpeed))
            table.insert(lines, string.format("JumpPower: %.1f", humanoid.JumpPower))
        end
        return table.concat(lines, "\n")
    end

    connections[#connections+1] = button.MouseButton1Click:Connect(function()
        outputBox.Text = getInfo()
        print(outputBox.Text)
    end)
end

function module.Enable()
    if gui then return end
    createGui()
end

function module.Disable()
    for _, con in ipairs(connections) do
        con:Disconnect()
    end
    connections = {}
    if gui then
        gui:Destroy()
        gui = nil
    end
end

return module
