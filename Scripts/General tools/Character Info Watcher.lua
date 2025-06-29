local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
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

local lastDump = ""

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
        local char = player.Character or player.CharacterAdded:Wait()
        local lines = scan(char, 0, {})
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
                table.insert(lines, string.format("Health: %.1f/%.1f", humanoid.Health, humanoid.MaxHealth))
                table.insert(lines, string.format("WalkSpeed: %.1f", humanoid.WalkSpeed))
                table.insert(lines, string.format("JumpPower: %.1f", humanoid.JumpPower))
        end
        return table.concat(lines, "\n")
end

button.MouseButton1Click:Connect(function()
        local info = getInfo()
        if info ~= lastDump then
                lastDump = info
                print(info)
        end
end)
