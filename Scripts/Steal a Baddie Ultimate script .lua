local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SectorTPGui"

local returnPosition = nil

-- === NEW 80 coordinates split into 8 groups of 10 (FASTER VERSION) ===
local allCoords = {
	Sector1 = {
		Vector3.new(-113.03, 110.82, -535.76), Vector3.new(-112.21, 110.92, -548.22), Vector3.new(-112.79, 110.92, -559.05),
		Vector3.new(-113.32, 110.72, -568.84), Vector3.new(-112.56, 110.72, -580.13), Vector3.new(-154.30, 110.72, -580.43),
		Vector3.new(-153.69, 110.92, -569.27), Vector3.new(-153.09, 110.72, -558.24), Vector3.new(-153.39, 110.82, -546.70),
		Vector3.new(-152.86, 110.72, -536.93),
	},
	Sector2 = {
		Vector3.new(-48.17, 110.37, -534.54), Vector3.new(-49.19, 110.72, -546.98), Vector3.new(-49.02, 110.72, -559.06),
		Vector3.new(-48.87, 110.72, -569.77), Vector3.new(-48.73, 110.72, -580.27), Vector3.new(-9.88, 110.72, -579.72),
		Vector3.new(-8.17, 110.72, -568.54), Vector3.new(-8.29, 110.92, -559.67), Vector3.new(-8.49, 110.27, -545.56),
		Vector3.new(-8.62, 110.92, -536.16),
	},
	Sector3 = {
		Vector3.new(66.72, 110.55, -535.10), Vector3.new(66.88, 110.82, -546.76), Vector3.new(67.02, 110.45, -556.68),
		Vector3.new(67.19, 110.92, -569.27), Vector3.new(67.34, 110.65, -579.54), Vector3.new(107.35, 110.72, -578.97),
		Vector3.new(107.22, 110.72, -569.33), Vector3.new(108.81, 110.72, -558.90), Vector3.new(108.64, 110.92, -547.15),
		Vector3.new(108.50, 110.92, -536.77),
	},
	Sector4 = {
		Vector3.new(172.74, 110.72, -536.47), Vector3.new(172.90, 111.02, -547.86), Vector3.new(173.06, 111.02, -558.80),
		Vector3.new(173.20, 110.92, -569.18), Vector3.new(173.36, 111.02, -580.38), Vector3.new(213.95, 110.72, -579.81),
		Vector3.new(213.76, 109.75, -565.82), Vector3.new(213.60, 109.64, -554.51), Vector3.new(213.45, 109.95, -543.89),
		Vector3.new(213.30, 110.00, -533.05),
	},
	Sector5 = {
		Vector3.new(214.62, 111.02, -391.53), Vector3.new(215.09, 110.82, -381.17), Vector3.new(214.56, 110.65, -370.45),
		Vector3.new(215.66, 110.72, -358.63), Vector3.new(214.52, 111.02, -347.48), Vector3.new(175.05, 110.22, -349.45),
		Vector3.new(175.51, 110.72, -358.77), Vector3.new(172.87, 110.45, -371.25), Vector3.new(173.29, 110.72, -379.63),
		Vector3.new(173.92, 110.82, -392.18),
	},
	Sector6 = {
		Vector3.new(109.79, 110.72, -390.35), Vector3.new(109.24, 110.82, -379.20), Vector3.new(108.70, 110.92, -368.50),
		Vector3.new(108.21, 110.72, -358.71), Vector3.new(109.96, 110.72, -347.45), Vector3.new(67.59, 110.22, -349.57),
		Vector3.new(68.08, 110.82, -359.32), Vector3.new(68.63, 110.65, -370.46), Vector3.new(67.42, 110.52, -382.08),
		Vector3.new(67.93, 110.75, -392.40),
	},
	Sector7 = {
		Vector3.new(-8.25, 111.02, -391.08), Vector3.new(-8.76, 110.72, -380.82), Vector3.new(-8.40, 110.82, -368.17),
		Vector3.new(-7.28, 110.82, -357.29), Vector3.new(-7.82, 110.92, -346.59), Vector3.new(-49.26, 110.72, -348.66),
		Vector3.new(-48.76, 111.02, -358.56), Vector3.new(-48.23, 110.72, -369.27), Vector3.new(-49.28, 110.65, -381.55),
		Vector3.new(-48.79, 110.92, -391.34),
	},
	Sector8 = {
		Vector3.new(-112.75, 110.72, -392.01), Vector3.new(-111.52, 110.55, -381.80), Vector3.new(-112.15, 110.92, -369.34),
		Vector3.new(-112.63, 110.65, -359.55), Vector3.new(-111.50, 110.72, -347.59), Vector3.new(-153.10, 110.92, -347.55),
		Vector3.new(-152.52, 110.82, -359.16), Vector3.new(-151.92, 110.45, -371.24), Vector3.new(-151.48, 110.72, -380.08),
		Vector3.new(-152.99, 110.92, -391.96),
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
