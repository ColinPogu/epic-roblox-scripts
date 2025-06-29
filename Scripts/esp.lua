local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Make GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RevealGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local revealButton = Instance.new("TextButton")
revealButton.Size = UDim2.new(0, 150, 0, 40)
revealButton.Position = UDim2.new(1, -160, 0.4, 0) -- Right side of screen
revealButton.Text = "Reveal Players"
revealButton.BackgroundColor3 = Color3.fromRGB(255, 200, 200)
revealButton.TextScaled = true
revealButton.Parent = screenGui

-- Reveal function
local function revealPlayers()
	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player and otherPlayer.Character then
			local highlight = otherPlayer.Character:FindFirstChildOfClass("Highlight")
			if not highlight then
				highlight = Instance.new("Highlight")
				highlight.FillColor = Color3.fromRGB(255, 255, 0)
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.Parent = otherPlayer.Character
			end
		end
	end
end

-- Hook to button
revealButton.MouseButton1Click:Connect(function()
	revealPlayers()
	revealButton.Text = "✔ Players Outlined"
	revealButton.BackgroundColor3 = Color3.fromRGB(200, 255, 200)
end)
