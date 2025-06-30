local MainUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/MainUI.lua"))()
local AddMenuButton = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddMenuButton.lua"))()
local AddToggleGridButton = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddToggleGridButton.lua"))()
local Players = game:GetService("Players")

-- Make GUI draggable
MainUI.Background.Active = true
MainUI.Background.Draggable = true

-- Toggle full UI visibility via MenuButton
MainUI.MenuButton.MouseButton1Click:Connect(function()
	MainUI.Background.Visible = not MainUI.Background.Visible
end)

-- Add "Research Menu" button to Side
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Research Menu", function()
        AddToggleGridButton.Reset()
        MainUI.GridScrolling.Visible = true
        MainUI.ListScrolling.Visible = false
end)

-- Add "General" button to Side
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "General", function()
        AddToggleGridButton.Reset()
        MainUI.ListScrolling.Visible = true
        MainUI.GridScrolling.Visible = false
end)

-- Set PlayerName and Version labels
local player = Players.LocalPlayer
MainUI.PlayerName.Text = player.Name
MainUI.Version.Text = "Developer"

-- Example button in Research Menu
AddToggleGridButton.AddButton(
        MainUI.GridScrolling,
        MainUI.GridTemplate,
        "Character Info",
        function()
                return loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/Research%20Tools/Character%20Info%20Watcher.lua"))()
        end
)

-- Show local player's character in ViewportFrame
task.spawn(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local clone = character:Clone()

	-- Remove scripts from clone
	for _, obj in clone:GetDescendants() do
		if obj:IsA("Script") or obj:IsA("LocalScript") then
			obj:Destroy()
		end
	end

	-- Clean and show clone in viewport
	MainUI.Player:ClearAllChildren()
	clone.Parent = MainUI.Player

	local camera = Instance.new("Camera")
	camera.CFrame = CFrame.new(Vector3.new(0, 2, 8), Vector3.new(0, 2, 0))
	camera.Parent = MainUI.Player
	MainUI.Player.CurrentCamera = camera
end)

-- X button hides UI but not MenuButton
MainUI.X.MouseButton1Click:Connect(function()
        AddToggleGridButton.Reset()
        MainUI.Background.Visible = false
end)
