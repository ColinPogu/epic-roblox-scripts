local MainUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/MainUI.lua"))()
local AddMenuButton = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddMenuButton.lua"))()
local Players = game:GetService("Players")

-- MenuButton toggles full UI visibility
MainUI.MenuButton.MouseButton1Click:Connect(function()
	MainUI.Background.Visible = not MainUI.Background.Visible
end)

-- Dynamically add "Research Menu"
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Research Menu", function()
	MainUI.GridScrolling.Visible = true
	MainUI.ListScrolling.Visible = false
end)

-- Dynamically add "General"
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "General", function()
	MainUI.ListScrolling.Visible = true
	MainUI.GridScrolling.Visible = false
end)

-- Set player name and version
local player = Players.LocalPlayer
MainUI.PlayerName.Text = player.Name
MainUI.Version.Text = "Developer"

-- Populate ViewportFrame
local character = player.Character or player.CharacterAdded:Wait()
local clone = character:Clone()
for _, obj in clone:GetDescendants() do
	if obj:IsA("Script") or obj:IsA("LocalScript") then
		obj:Destroy()
	end
end
clone.Parent = MainUI.Player
MainUI.Player.CurrentCamera = workspace.CurrentCamera
MainUI.Player:ClearAllChildren()
clone.Parent = MainUI.Player

-- X button closes UI
MainUI.X.MouseButton1Click:Connect(function()
	MainUI.ScreenGui:Destroy()
end)
