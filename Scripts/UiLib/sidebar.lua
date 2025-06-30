print("[sidebar.lua] executing")

return function(sideFrame, templateButton, addMenuButton, pagesTable, showPage)
    print("[sidebar.lua] building sidebar")
    local layout = Instance.new("UIListLayout")
    layout.Parent = sideFrame

    for name, _ in pairs(pagesTable) do
        addMenuButton(sideFrame, templateButton, name, function()
            if showPage then
                showPage(name)
            end
        end)
    end

    print("[sidebar.lua] ready")
    return sideFrame
end

