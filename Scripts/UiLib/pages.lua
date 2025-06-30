print("[pages.lua] executing")

return function(parent, templateButton)
    print("[pages.lua] setting up pages")
    local container = Instance.new("Frame")
    container.Name = "Pages"
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local pages = {}

    local function createPage(name)
        local page = Instance.new("Frame")
        page.Name = name
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = container

        local layout = Instance.new("UIGridLayout")
        layout.CellSize = templateButton.Size
        layout.CellPadding = UDim2.new(0, 5, 0, 5)
        layout.Parent = page

        for i = 1, 3 do
            local btn = templateButton:Clone()
            btn.Text = name .. " Btn " .. i
            btn.Visible = true
            btn.Parent = page
        end

        pages[name] = page
        return page
    end

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
            print("[pages.lua] showing page", name)
        else
            warn("[pages.lua] no page named " .. tostring(name))
        end
    end

    createPage("Research")
    createPage("General")
    createPage("StealGames")
    showPage("Research")

    print("[pages.lua] ready")
    return {
        container = container,
        pages = pages,
        createPage = createPage,
        showPage = showPage
    }
end

