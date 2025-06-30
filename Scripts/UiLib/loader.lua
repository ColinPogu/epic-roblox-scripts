return function()
    print("[loader] Starting UI initialization")

    local Players = game:GetService("Players")

    -- wait for assets to load
    task.wait(5)

    print("[loader] Loading MainUI")
    local MainUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/MainUI.lua"))()
    print("[loader] MainUI created")

    print("[loader] Loading helper modules")
    local AddMenuButton = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddMenuButton.lua"))()
    local ToggleGridFactory = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddToggleGridButton.lua"))()

-- utility to create an isolated grid layout with its own toggle controller
local function createGridPage(name)
    print("[loader] Creating grid page", name)
    local frame = MainUI.GridScrolling:Clone()
    frame.Visible = false
    frame.Parent = MainUI.Background
    local template = frame:FindFirstChild(MainUI.GridTemplate.Name)
    local controller = ToggleGridFactory.CreateController()
    return {
        frame = frame,
        template = template,
        controller = controller
    }
end

-- pages table holds all sidebar page data
local pages = {
    Research = createGridPage("Research"),
    General = createGridPage("General"),
    StealGames = createGridPage("StealGames")
}

local function hideAll()
    for _, info in pairs(pages) do
        info.controller.Reset()
        info.frame.Visible = false
    end
end

local function showPage(name)
    print("[loader] Showing page", name)
    hideAll()
    local page = pages[name]
    if page then
        page.frame.Visible = true
    end
end

-- Make GUI draggable
MainUI.Background.Active = true
MainUI.Background.Draggable = true

-- Toggle full UI visibility via MenuButton
MainUI.MenuButton.MouseButton1Click:Connect(function()
        MainUI.Background.Visible = not MainUI.Background.Visible
        print("[loader] Toggled UI", MainUI.Background.Visible)
end)

-- Add sidebar buttons
print("[loader] Creating sidebar buttons")
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Research", function()
    showPage("Research")
end)
print("[loader] Added sidebar button: Research")
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "General", function()
    showPage("General")
end)
print("[loader] Added sidebar button: General")
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Steal Games", function()
    showPage("StealGames")
end)
print("[loader] Added sidebar button: Steal Games")

-- Set PlayerName and Version labels
local player = Players.LocalPlayer
MainUI.PlayerName.Text = player.Name
MainUI.Version.Text = "Developer"

-- Example button in Research Menu
pages.Research.controller.AddButton(
    pages.Research.frame,
    pages.Research.template,
    "Character Info",
    function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/Research%20Tools/Character%20Info%20Watcher.lua"))()
    end
)

print("[loader] Added Research button: Character Info")

pages.General.controller.AddButton(
    pages.General.frame,
    pages.General.template,
    "Toggle ESP",
    function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/General%20Tools/SimpleESP.lua"))()
    end
)

print("[loader] Added General button: Toggle ESP")

pages.StealGames.controller.AddButton(
    pages.StealGames.frame,
    pages.StealGames.template,
    "Steal a Baddie",
    function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/Steal%20a%20Baddie%20Project/combined_auto_tp_stealer.lua"))()
    end
)

print("[loader] Added StealGames button: Steal a Baddie")

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

print("[loader] Avatar viewport setup complete")

-- X button hides UI but not MenuButton
MainUI.X.MouseButton1Click:Connect(function()
        hideAll()
        MainUI.Background.Visible = false
        print("[loader] Closed UI window")
end)

print("[loader] UI initialization complete")

end
