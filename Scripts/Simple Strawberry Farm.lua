local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

local strawberryPos = Vector3.new(44.3, 4.0, -87.7)
local shopPos = Vector3.new(86.6, 3.0, 0.4)

local loopRunning = false

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 40)
button.Position = UDim2.new(1, -210, 0.5, 0)
button.Text = "Game (OFF)"
button.BackgroundColor3 = Color3.fromRGB(200, 255, 200)
button.TextScaled = true
button.Parent = screenGui

-- Teleport to a position
local function teleportTo(pos)
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		char:MoveTo(pos)
	end
end

-- Fire all nearby ProximityPrompts quickly
local function fireNearbyPrompts(radius)
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local hrp = char.HumanoidRootPart

	for _, prompt in ipairs(workspace:GetDescendants()) do
		if prompt:IsA("ProximityPrompt") and prompt.Enabled then
			local part = prompt.Parent:IsA("Model") and prompt.Parent:FindFirstChildWhichIsA("BasePart") or prompt.Parent
			if part and (part.Position - hrp.Position).Magnitude <= radius then
				fireproximityprompt(prompt)
			end
		end
	end
end

-- Simulate clicking the real GUI sell button
local function clickSellButton()
	local gui = player:WaitForChild("PlayerGui")
	local billboard = gui:FindFirstChild("Billboard_UI")
	if not billboard then
		warn("❌ Billboard_UI not found")
		return
	end

	local optionUI = billboard:FindFirstChild("Option_UI")
	if not optionUI then
		warn("❌ Option_UI not found")
		return
	end

	local frame = optionUI:FindFirstChild("Frame")
	if not frame then
		warn("❌ Frame not found inside Option_UI")
		return
	end

	local imageButton = frame:FindFirstChild("ImageButton")
	if not imageButton then
		warn("❌ ImageButton not found")
		return
	end

	local connections = getconnections(imageButton.MouseButton1Click)
	if #connections == 0 then
		warn("❌ No MouseButton1Click connections on ImageButton")
		return
	end

	print("✅ Clicking sell button")
	for _, conn in ipairs(connections) do
		conn.Function()
	end
end

-- Main farming loop
local function runLoop()
	while loopRunning do
		-- Step 1: Go to strawberries
		teleportTo(strawberryPos)
		wait(2)
		fireNearbyPrompts(20)

		-- Step 2: Go to shop
		teleportTo(shopPos)
		wait(1)
		fireNearbyPrompts(15)

		-- Step 3: Sell inventory
		wait(3)
		clickSellButton()
		wait(3)
	end
end

-- Button toggles farming on/off
button.MouseButton1Click:Connect(function()
	loopRunning = not loopRunning
	button.Text = loopRunning and "Game (ON)" or "Game (OFF)"
	button.BackgroundColor3 = loopRunning and Color3.fromRGB(255, 200, 200) or Color3.fromRGB(200, 255, 200)

	if loopRunning then
		coroutine.wrap(runLoop)()
	end
end)
