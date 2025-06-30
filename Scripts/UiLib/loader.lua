local Players = game:GetService("Players")

-- wait for assets to load
task.wait(5)

local MainUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/MainUI.lua"))()
local AddMenuButton = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddMenuButton.lua"))()
local ToggleGridFactory = loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/UiLib/AddToggleGridButton.lua"))()

-- utility to create an isolated grid layout with its own toggle controller
local function createGridPage()
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
    Research = createGridPage(),
    General = createGridPage(),
    StealGames = createGridPage()
}

local function hideAll()
    for _, info in pairs(pages) do
        info.controller.Reset()
        info.frame.Visible = false
    end
end

local function showPage(name)
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
end)

-- Add sidebar buttons
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Research", function()
    showPage("Research")
end)
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "General", function()
    showPage("General")
end)
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Steal Games", function()
    showPage("StealGames")
end)

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

pages.General.controller.AddButton(
    pages.General.frame,
    pages.General.template,
    "Toggle ESP",
    function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/General%20Tools/SimpleESP.lua"))()
    end
)

pages.StealGames.controller.AddButton(
    pages.StealGames.frame,
    pages.StealGames.template,
    "Steal a Baddie",
    function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/Scripts/Steal%20a%20Baddie%20Project/combined_auto_tp_stealer.lua"))()
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
        hideAll()
        MainUI.Background.Visible = false
end)
