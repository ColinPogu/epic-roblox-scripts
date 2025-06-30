print("[pages.lua] executing")

return function(gridFrame, templateButton)
    print("[pages.lua] setting up pages")

    gridFrame.Visible = true

    local pages = {}

    local function createPage(name)
        local buttons = {}
        for i = 1, 3 do
            local btn = templateButton:Clone()
            btn.Text = name .. " Btn " .. i
            btn.Visible = false
            btn.Parent = gridFrame
            table.insert(buttons, btn)
        end

        pages[name] = buttons
        return buttons
    end

    local function hideAll()
        for _, btns in pairs(pages) do
            for _, b in ipairs(btns) do
                b.Visible = false
            end
        end
    end

    local function showPage(name)
        hideAll()
        local btns = pages[name]
        if btns then
            for _, b in ipairs(btns) do
                b.Visible = true
            end
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
        pages = pages,
        createPage = createPage,
        showPage = showPage
    }
end

