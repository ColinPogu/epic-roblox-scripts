print("[pages.lua] executing")

--[[
    Page manager that clones scrolling frame templates from MainUI.
    Each created page gets its own cloned container with a button
    template inside for dynamic population. Only one page is visible
    at a time.
]]

return function(ui)
    print("[pages.lua] setting up pages")

    -- template frames and button references
    local gridTemplateFrame = ui.GridScrolling
    local listTemplateFrame = ui.ListScrolling
    local gridButtonTemplate = ui.GridTemplate
    local listButtonTemplate = ui.ListTemplate
    local container = ui.Background

    -- table storing page name -> {Frame = ScrollingFrame, Template = TextButton}
    local pages = {}

    local function createPage(name, useList)
        -- choose which scrolling container to clone
        local sourceFrame = useList and listTemplateFrame or gridTemplateFrame
        local pageFrame = sourceFrame:Clone()
        pageFrame.Name = name .. "Page"
        pageFrame.Visible = false
        pageFrame.Parent = container

        -- locate the button template inside the cloned frame
        local templateName = useList and listButtonTemplate.Name or gridButtonTemplate.Name
        local templateBtn = pageFrame:FindFirstChild(templateName)

        pages[name] = {Frame = pageFrame, Template = templateBtn}
        return pages[name]
    end

    local function hideAll()
        for _, page in pairs(pages) do
            page.Frame.Visible = false
        end
    end

    local function showPage(name)
        hideAll()
        local page = pages[name]
        if page then
            page.Frame.Visible = true
            print("[pages.lua] showing page", name)
        else
            warn("[pages.lua] no page named " .. tostring(name))
        end
    end

    -- default pages
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

