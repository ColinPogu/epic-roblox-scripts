return function()
    print("[loader] started")

    local baseUrl = "https://raw.githubusercontent.com/ColinPogu/epic-roblox-scripts/main/"
    local function loadRemote(path, ...)
        print("[loader] loading " .. path)
        local args = { ... }
        local source = game:HttpGet(baseUrl .. path)
        local result = loadstring(source)(table.unpack(args))

        if type(result) == "function" and #args > 0 then
            result = result(table.unpack(args))
        end

        return result
    end

    -- Load main UI which creates the ScreenGui and base layout
    local ui = loadRemote("Scripts/UiLib/MainUI.lua")
    print("[loader] MainUI loaded")

    -- Personal info setup
    local Players = game:GetService("Players")
    ui.Version.Text = "Developer"
    ui.PlayerName.Text = Players.LocalPlayer.Name

    -- Render the player's avatar in the viewport
    local viewport = ui.Player
    viewport:ClearAllChildren()
    local cam = Instance.new("Camera")
    cam.Parent = viewport
    viewport.CurrentCamera = cam
    local desc = Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId)
    local model = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15)
    local world = Instance.new("WorldModel")
    world.Parent = viewport
    model.Parent = world
    cam.CFrame = CFrame.new(model.Head.Position + Vector3.new(0, 0, 5), model.Head.Position)

    -- Utility for cloning sidebar buttons
    local addMenuButton = loadRemote("Scripts/UiLib/AddMenuButton.lua")

    -- Set up pages container and default pages using the GridScrolling frame
    -- Create page manager using the scrolling frame templates
    local pagesModule = loadRemote("Scripts/UiLib/pages.lua", ui)
    print("[loader] pages module loaded")

    -- Build the sidebar and connect buttons to page switching
    loadRemote(
        "Scripts/UiLib/sidebar.lua",
        ui.Side,
        ui.MenusTemplate,
        addMenuButton,
        pagesModule.pages,
        pagesModule.showPage
    )
    print("[loader] sidebar module loaded")

    -- Populate pages with default toggle buttons
    local toggleLib = loadRemote("Scripts/UiLib/AddToggleGridButton.lua")
    loadRemote(
        "Scripts/UiLib/default_buttons.lua",
        pagesModule,
        toggleLib,
        loadRemote
    )

    --=== AI Movement Extension ===--
    local stealBtn = ui.Side:FindFirstChild("StealGames")
    if stealBtn then
        local aiButton
        local targetPos
        local aiModule = loadRemote("Scripts/General Tools/AIMovement.lua")

        local setTarget = ui.MenusTemplate:Clone()
        setTarget.Name = "SetTargetLocation"
        setTarget.Text = "Set Target Location"
        setTarget.Size = UDim2.new(0, 160, 0, 40)
        setTarget.Position = UDim2.new(1, -170, 0.3, 0)
        setTarget.Visible = false
        setTarget.Parent = ui.ScreenGui or ui.Background.Parent

        local startPath = ui.MenusTemplate:Clone()
        startPath.Name = "StartAIPath"
        startPath.Text = "Start AI Path"
        startPath.Size = UDim2.new(0, 160, 0, 40)
        startPath.Position = UDim2.new(1, -170, 0.4, 0)
        startPath.Visible = false
        startPath.Parent = ui.ScreenGui or ui.Background.Parent

        setTarget.MouseButton1Click:Connect(function()
            local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                targetPos = hrp.Position
            end
        end)

        startPath.MouseButton1Click:Connect(function()
            if startPath.Text:find("Stop") then
                aiModule.Stop()
                startPath.Text = "Start AI Path"
            else
                if targetPos then
                    aiModule.Start(targetPos)
                    startPath.Text = "Stop AI Path"
                end
            end
        end)

        local function toggleFloat()
            local vis = not setTarget.Visible
            setTarget.Visible = vis
            startPath.Visible = vis
        end

        stealBtn.MouseButton1Click:Connect(function()
            if not aiButton then
                aiButton = ui.MenusTemplate:Clone()
                aiButton.Name = "AIMovement"
                aiButton.Text = "AI Movement"
                aiButton.Visible = true
                aiButton.Parent = ui.Side
                aiButton.MouseButton1Click:Connect(toggleFloat)
            end
        end)
    end

    -- Menu controls
    ui.MenuButton.MouseButton1Click:Connect(function()
        ui.Background.Visible = not ui.Background.Visible
    end)

    ui.X.MouseButton1Click:Connect(function()
        ui.Background.Visible = false
    end)

    print("[loader] finished")
end

