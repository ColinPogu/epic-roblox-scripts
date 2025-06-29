local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SectorTPGui"

local returnPosition = nil

-- === All 80 coordinates split into 8 groups of 10 ===
local allCoords = {
	Sector1 = {
		Vector3.new(-226.43, 25.82, -270.36), Vector3.new(-232.10, 25.76, -270.34), Vector3.new(-241.36, 25.82, -270.31),
		Vector3.new(-248.21, 25.76, -270.29), Vector3.new(-257.37, 25.82, -270.26), Vector3.new(-258.52, 25.82, -236.02),
		Vector3.new(-250.22, 25.82, -236.59), Vector3.new(-243.46, 25.82, -237.05), Vector3.new(-234.71, 25.82, -237.66),
		Vector3.new(-225.51, 25.82, -235.90),
	},
	Sector2 = {
		Vector3.new(-225.82, 25.82, -163.91), Vector3.new(-234.14, 25.82, -164.69), Vector3.new(-242.46, 25.82, -165.47),
		Vector3.new(-248.99, 25.82, -164.30), Vector3.new(-256.91, 25.82, -165.04), Vector3.new(-258.55, 25.82, -129.42),
		Vector3.new(-251.04, 25.82, -128.71), Vector3.new(-241.92, 25.82, -127.85), Vector3.new(-234.64, 25.82, -128.59),
		Vector3.new(-226.35, 25.82, -128.18),
	},
	Sector3 = {
		Vector3.new(-226.22, 25.82, -57.64), Vector3.new(-234.14, 25.82, -57.92), Vector3.new(-242.89, 25.82, -58.27),
		Vector3.new(-249.64, 25.82, -58.54), Vector3.new(-257.59, 25.82, -58.85), Vector3.new(-259.00, 25.82, -23.32),
		Vector3.new(-249.47, 25.82, -22.94), Vector3.new(-241.12, 25.82, -22.62), Vector3.new(-234.37, 25.82, -22.35),
		Vector3.new(-226.71, 25.82, -22.05),
	},
	Sector4 = {
		Vector3.new(-224.45, 25.82, 50.03), Vector3.new(-231.61, 25.64, 50.68), Vector3.new(-240.85, 25.82, 49.87),
		Vector3.new(-249.48, 25.82, 50.59), Vector3.new(-256.34, 25.82, 49.99), Vector3.new(-257.74, 25.82, 84.72),
		Vector3.new(-249.84, 25.82, 85.35), Vector3.new(-242.70, 25.82, 85.92), Vector3.new(-233.97, 25.82, 86.62),
		Vector3.new(-225.24, 25.82, 85.09),
	},
	Sector5 = {
		Vector3.new(-86.60, 25.82, 85.74), Vector3.new(-78.15, 25.82, 85.71), Vector3.new(-71.36, 25.82, 85.69),
		Vector3.new(-61.30, 25.82, 85.66), Vector3.new(-51.74, 25.62, 85.62), Vector3.new(-53.83, 25.82, 51.73),
		Vector3.new(-62.26, 25.82, 51.75), Vector3.new(-69.52, 25.82, 51.77), Vector3.new(-78.67, 25.82, 51.80),
		Vector3.new(-85.43, 25.82, 51.83),
	},
	Sector6 = {
		Vector3.new(-85.80, 25.82, -21.52), Vector3.new(-78.58, 25.82, -22.22), Vector3.new(-69.44, 25.82, -22.03),
		Vector3.new(-62.42, 25.82, -22.71), Vector3.new(-54.01, 25.82, -21.20), Vector3.new(-54.04, 25.82, -56.28),
		Vector3.new(-60.65, 25.82, -55.63), Vector3.new(-69.98, 25.82, -56.88), Vector3.new(-77.79, 25.82, -56.12),
		Vector3.new(-85.32, 25.82, -55.38),
	},
	Sector7 = {
		Vector3.new(-86.19, 25.82, -127.00), Vector3.new(-79.00, 25.82, -128.77), Vector3.new(-69.45, 25.82, -128.40),
		Vector3.new(-62.30, 25.82, -128.12), Vector3.new(-54.35, 25.82, -127.82), Vector3.new(-54.36, 25.82, -164.09),
		Vector3.new(-60.82, 25.82, -164.34), Vector3.new(-69.97, 25.82, -164.69), Vector3.new(-78.38, 25.82, -163.98),
		Vector3.new(-85.27, 25.82, -164.24),
	},
	Sector8 = {
		Vector3.new(-87.31, 25.82, -235.89), Vector3.new(-77.39, 25.82, -235.51), Vector3.new(-69.44, 25.82, -235.20),
		Vector3.new(-61.39, 25.82, -234.89), Vector3.new(-54.54, 25.82, -234.62), Vector3.new(-53.16, 25.82, -270.16),
		Vector3.new(-61.78, 25.82, -270.49), Vector3.new(-68.93, 25.82, -270.77), Vector3.new(-77.68, 25.82, -271.11),
		Vector3.new(-85.71, 25.82, -271.42),
	}
}

-- 🟩 Button creator
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

-- 🟡 Return point button
local returnBtn = createButton("Set Return Point", 0)
returnBtn.MouseButton1Click:Connect(function()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root then
		returnPosition = root.Position
		print("[Return Point Set]:", returnPosition)
	end
end)

-- 🔴 Proximity prompt trigger helper
local function firePromptNear(pos)
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("ProximityPrompt") and obj.Parent:IsA("BasePart") then
			if (obj.Parent.Position - pos).Magnitude < 10 then
				pcall(function()
					fireproximityprompt(obj)
				end)
			end
		end
	end
end

-- 🔷 Sector Buttons
local index = 0
for sectorName, coordList in pairs(allCoords) do
	local btn = createButton(sectorName, index * 0.06 + 0.05)
	btn.MouseButton1Click:Connect(function()
		if not returnPosition then
			warn("Return position not set.")
			return
		end

		coroutine.wrap(function()
			for _, pos in ipairs(coordList) do
				rootPart.CFrame = CFrame.new(pos + Vector3.new(0, 4, 0))
				wait(0.6)
				firePromptNear(pos)
				wait(0.6)
				rootPart.CFrame = CFrame.new(returnPosition + Vector3.new(0, 4, 0))
				wait(1.1)
			end
		end)()
	end)
	index += 1
end
