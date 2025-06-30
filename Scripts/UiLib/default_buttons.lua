return function(pagesModule, toggleLib, loadRemote)
    print("[default_buttons] adding default page buttons")
    local controllers = {}

    local function add(pageName, label, path)
        local page = pagesModule.pages[pageName]
        if not page then
            warn("[default_buttons] missing page: " .. pageName)
            return
        end
        local ctrl = controllers[pageName]
        if not ctrl then
            ctrl = toggleLib.CreateController()
            controllers[pageName] = ctrl
        end
        ctrl.AddButton(page.Frame, page.Template, label, function()
            return loadRemote(path)
        end)
    end

    add("StealGames", "Steal a Baddie", "Scripts/Steal a Baddie Project/combined_auto_tp_stealer.lua")

    return controllers
end
