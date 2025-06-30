return function()
    print("Loader started")

    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- create main screen gui
    local gui = Instance.new("ScreenGui")
    gui.Name = "EpicLoaderGui"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    -- main frame container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui
    print("MainFrame created")

    -- sidebar for navigation
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 120, 1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sidebar.Parent = mainFrame
    print("Sidebar ready")

    local pagesContainer = Instance.new("Frame")
    pagesContainer.Name = "Pages"
    pagesContainer.Size = UDim2.new(1, -120, 1, 0)
    pagesContainer.Position = UDim2.new(0, 120, 0, 0)
    pagesContainer.BackgroundTransparency = 1
    pagesContainer.Parent = mainFrame

    local function createPage(name)
        local page = Instance.new("Frame")
        page.Name = name
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = pagesContainer

        local layout = Instance.new("UIGridLayout")
        layout.CellSize = UDim2.new(0, 120, 0, 30)
        layout.CellPadding = UDim2.new(0, 5, 0, 5)
        layout.Parent = page

        -- placeholder buttons
        for i = 1, 3 do
            local btn = Instance.new("TextButton")
            btn.Text = name .. " Btn " .. i
            btn.Size = UDim2.fromScale(0, 0)
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Parent = page
        end

        return page
    end

    local pages = {
        Research = createPage("Research"),
        General = createPage("General"),
        StealGames = createPage("StealGames")
    }

    local function hideAll()
        for _, p in pairs(pages) do
            p.Visible = false
        end
    end

    local function showPage(name)
        hideAll()
        local page = pages[name]
        if page then
            page.Visible = true
            print("Showing page", name)
        end
    end

    local buttonTemplate = Instance.new("TextButton")
    buttonTemplate.Size = UDim2.new(1, 0, 0, 30)
    buttonTemplate.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    buttonTemplate.TextColor3 = Color3.new(1, 1, 1)

    local layout = Instance.new("UIListLayout")
    layout.Parent = sidebar

    local function addSidebarButton(label, key)
        local btn = buttonTemplate:Clone()
        btn.Text = label
        btn.Parent = sidebar
        btn.MouseButton1Click:Connect(function()
            showPage(key)
        end)
    end

    addSidebarButton("Research", "Research")
    addSidebarButton("General", "General")
    addSidebarButton("Steal Games", "StealGames")
    buttonTemplate:Destroy()

    showPage("Research")

    print("Loader finished")
end
