local Players = game:GetService("Players")

-- wait for assets to load
task.wait(5)

local MainUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/MainUI.lua"))()
local AddMenuButton = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddMenuButton.lua"))()
local AddToggleGridButton = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddToggleGridButton.lua"))()

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

-- Add "Steal Games" button to Side
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Steal Games", function()
        AddToggleGridButton.Reset()
        for _, child in ipairs(MainUI.GridScrolling:GetChildren()) do
                if child ~= MainUI.GridTemplate and child:IsA("GuiObject") then
                        child:Destroy()
                end
        end
        MainUI.GridScrolling.Visible = true
        MainUI.ListScrolling.Visible = false
        AddToggleGridButton.AddButton(
                MainUI.GridScrolling,
                MainUI.GridTemplate,
                "TP Stealer",
                function()
                        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/Steal%20a%20Baddie%20Project/combined_auto_tp_stealer.lua"))()
                end
        )
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

-- Show local player's avatar in ViewportFrame using their UserId
task.spawn(function()
        local avatar = Players:CreateHumanoidModelFromUserId(player.UserId)
        MainUI.Player:ClearAllChildren()
        avatar.Parent = MainUI.Player

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
