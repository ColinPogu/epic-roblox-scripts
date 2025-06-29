local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- === GUI SETUP ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoStealGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "AutoStealButton"
button.Size = UDim2.new(0, 160, 0, 40)
button.Position = UDim2.new(1, -180, 0.5, 80) -- below Auto-Sell and Clip buttons
button.AnchorPoint = Vector2.new(0, 0)
button.Text = "Auto-Steal (OFF)"
button.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
button.TextColor3 = Color3.new(0, 0, 0)
button.TextScaled = true
button.Font = Enum.Font.SourceSansBold
button.Parent = screenGui

-- === TOGGLE LOGIC ===
local autoSteal = false
button.MouseButton1Click:Connect(function()
	autoSteal = not autoSteal
	button.Text = autoSteal and "Auto-Steal (ON)" or "Auto-Steal (OFF)"
	button.BackgroundColor3 = autoSteal and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

-- === UTILITY: Find all StealProximity prompts across all bases ===
local function findAllStealPrompts()
	local prompts = {}
	local bases = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Bases")
	if not bases then return prompts end

	for _, base in ipairs(bases:GetChildren()) do
		if base:IsA("Model") and base:FindFirstChild("Floors") then
			local floor1 = base.Floors:FindFirstChild("Floor1")
			if floor1 then
				local stands = floor1:FindFirstChild("Interactables")
				stands = stands and stands:FindFirstChild("Stands")
				if stands then
					for _, stand in ipairs(stands:GetChildren()) do
						local npcFolder = stand:FindFirstChild("NPC")
						if npcFolder then
							for _, npc in ipairs(npcFolder:GetChildren()) do
								local hrp = npc:FindFirstChild("HumanoidRootPart")
								if hrp and hrp:FindFirstChild("ProximityAttachment") then
									local prompt = hrp.ProximityAttachment:FindFirstChild("StealProximity")
									if prompt and prompt:IsA("ProximityPrompt") then
										table.insert(prompts, prompt)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return prompts
end

-- === STEAL LOOP ===
RunService.RenderStepped:Connect(function()
	if not autoSteal then return end

	local prompts = findAllStealPrompts()
	for _, prompt in ipairs(prompts) do
		if prompt.Enabled and prompt:IsDescendantOf(workspace) then
			prompt.HoldDuration = 0
			prompt:InputHoldBegin()
			task.wait()
			prompt:InputHoldEnd()
		end
	end
end)
