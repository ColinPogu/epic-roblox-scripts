local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local stored = {}

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "CoordCollectorGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function createButton(name, yOffset, text, color)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(0, 180, 0, 40)
	button.Position = UDim2.new(1, -200, 0.3 + yOffset, 0)
	button.BackgroundColor3 = color
	button.Text = text
	button.TextScaled = true
	button.Font = Enum.Font.GothamBold
	button.Parent = gui
	return button
end

-- Visual Log Frame
local outputFrame = Instance.new("TextLabel")
outputFrame.Name = "StoredOutput"
outputFrame.Size = UDim2.new(0, 300, 0.4, 0)
outputFrame.Position = UDim2.new(0, 20, 0.5, 0)
outputFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
outputFrame.TextColor3 = Color3.new(1, 1, 1)
outputFrame.TextXAlignment = Enum.TextXAlignment.Left
outputFrame.TextYAlignment = Enum.TextYAlignment.Top
outputFrame.TextWrapped = false
outputFrame.TextScaled = false
outputFrame.TextSize = 14
outputFrame.Font = Enum.Font.Code
outputFrame.Text = ""
outputFrame.ClipsDescendants = true
outputFrame.TextStrokeTransparency = 0.7
outputFrame.TextWrapped = true
outputFrame.Parent = gui

-- Buttons
local noclipButton = createButton("Noclip", 0, "Noclip XZ (OFF)", Color3.fromRGB(255, 150, 150))
local copyCurrent = createButton("CopyOne", 0.1, "Copy One", Color3.fromRGB(200, 255, 200))
local exportAll = createButton("ExportAll", 0.2, "Copy All", Color3.fromRGB(200, 200, 255))
local clearAll = createButton("ClearAll", 0.3, "Clear", Color3.fromRGB(255, 200, 200))

-- Noclip Logic
local noclipXZ = false
noclipButton.MouseButton1Click:Connect(function()
	noclipXZ = not noclipXZ
	noclipButton.Text = noclipXZ and "Noclip XZ (ON)" or "Noclip XZ (OFF)"
end)

RunService.Stepped:Connect(function()
	if noclipXZ then
		local char = player.Character
		if char then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end
end)

-- Copy one and store
copyCurrent.MouseButton1Click:Connect(function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local pos = hrp.Position
		local text = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
		if not table.find(stored, text) then
			table.insert(stored, text)
			outputFrame.Text = table.concat(stored, "\n")
		end
		pcall(function() setclipboard(text) end)
		print("[Copied One]:", text)
	end
end)

-- Export all
exportAll.MouseButton1Click:Connect(function()
	local joined = table.concat(stored, "\n")
	pcall(function() setclipboard(joined) end)
	print("[Copied All]:\n" .. joined)
end)

-- Clear all
clearAll.MouseButton1Click:Connect(function()
	table.clear(stored)
	outputFrame.Text = ""
	print("[Cleared Stored Coordinates]")
end)
