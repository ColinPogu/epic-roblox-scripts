local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- GUI setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RevealGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local function createButton(text, offsetY)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 150, 0, 40)
	button.Position = UDim2.new(1, -160, 0.4, offsetY)
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(255, 200, 200)
	button.TextScaled = true
	button.Parent = screenGui
	return button
end

local revealButton = createButton("Reveal Players", 0)
local noclipButton = createButton("NoClip (OFF)", 50)
local specButton = createButton("Spectator (OFF)", 100)
local flightButton = createButton("Flight (OFF)", 150)
local speedButton = createButton("Speed Boost (OFF)", 200)
local storeButton = createButton("📍 Store Location", 250)
local tpButton = createButton("🚀 Teleport Location", 300)

-- States
local revealEnabled = false
local noclipEnabled = false
local specEnabled = false
local flightEnabled = false
local speedEnabled = false
local originalSpeed = nil
local savedPosition = nil
local highlights = {}

-- Reveal logic
local function revealPlayers()
	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player and otherPlayer.Character then
			if not otherPlayer.Character:FindFirstChildOfClass("Highlight") then
				local h = Instance.new("Highlight")
				h.FillColor = Color3.fromRGB(255, 255, 0)
				h.OutlineColor = Color3.fromRGB(255, 255, 255)
				h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				h.Parent = otherPlayer.Character
				table.insert(highlights, h)
			end
		end
	end
end

revealButton.MouseButton1Click:Connect(function()
	revealEnabled = not revealEnabled
	revealButton.Text = revealEnabled and "✔ Players Outlined" or "Reveal Players"
	revealButton.BackgroundColor3 = revealEnabled and Color3.fromRGB(200, 255, 200) or Color3.fromRGB(255, 200, 200)

	if not revealEnabled then
		for _, h in ipairs(highlights) do
			if h and h.Parent then h:Destroy() end
		end
		table.clear(highlights)
	else
		revealPlayers()
	end
end)

-- Noclip logic
local noclipConn = nil
noclipButton.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	noclipButton.Text = noclipEnabled and "NoClip (ON)" or "NoClip (OFF)"
	noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(200, 255, 200) or Color3.fromRGB(255, 200, 200)

	local char = player.Character
	if not char then return end

	local function setNoClip(state)
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = not state
			end
		end
	end

	if noclipEnabled then
		setNoClip(true)
		if noclipConn then noclipConn:Disconnect() end
		noclipConn = RunService.Stepped:Connect(function()
			if player.Character then
				setNoClip(true)
			end
		end)
	else
		if noclipConn then noclipConn:Disconnect() end
		setNoClip(false)
	end
end)

-- Flight logic
local flightConn = nil
local moveInput = {W = 0, A = 0, S = 0, D = 0, Q = 0, E = 0}
local flightSpeed = 80

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	local key = input.KeyCode.Name
	if moveInput[key] ~= nil then
		moveInput[key] = 1
	end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
	if gpe then return end
	local key = input.KeyCode.Name
	if moveInput[key] ~= nil then
		moveInput[key] = 0
	end
end)

flightButton.MouseButton1Click:Connect(function()
	flightEnabled = not flightEnabled
	flightButton.Text = flightEnabled and "Flight (ON)" or "Flight (OFF)"
	flightButton.BackgroundColor3 = flightEnabled and Color3.fromRGB(200, 255, 200) or Color3.fromRGB(255, 200, 200)

	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	if flightEnabled then
		hum.PlatformStand = true
		if flightConn then flightConn:Disconnect() end
		flightConn = RunService.RenderStepped:Connect(function(dt)
			local camCF = Camera.CFrame
			local moveDir = Vector3.new(
				moveInput.D - moveInput.A,
				moveInput.E - moveInput.Q,
				moveInput.S - moveInput.W
			)
			if moveDir.Magnitude > 0 then
				local worldDir = camCF:VectorToWorldSpace(moveDir.Unit)
				hrp.CFrame = hrp.CFrame + (worldDir * flightSpeed * dt)
			end
		end)
	else
		if flightConn then flightConn:Disconnect() end
		if hum then hum.PlatformStand = false end
	end
end)

-- Speed Boost
speedButton.MouseButton1Click:Connect(function()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if not speedEnabled then
		originalSpeed = humanoid.WalkSpeed
		humanoid.WalkSpeed = originalSpeed * 1.3
		speedButton.Text = "Speed Boost (ON)"
		speedButton.BackgroundColor3 = Color3.fromRGB(200, 255, 200)
	else
		if originalSpeed then
			humanoid.WalkSpeed = originalSpeed
		end
		speedButton.Text = "Speed Boost (OFF)"
		speedButton.BackgroundColor3 = Color3.fromRGB(255, 200, 200)
	end

	speedEnabled = not speedEnabled
end)

-- 📍 Store Location
storeButton.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		savedPosition = hrp.Position
		storeButton.Text = "📍 Stored!"
		wait(1)
		storeButton.Text = "📍 Store Location"
	end
end)

-- 🚀 Teleport Location
tpButton.MouseButton1Click:Connect(function()
	if not savedPosition then return end
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(savedPosition)
	end
end)
