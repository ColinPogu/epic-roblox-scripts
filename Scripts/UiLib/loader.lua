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

    print("[loader] finished")
end

