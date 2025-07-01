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

    add("Research", "Character Info Watcher", "Scripts/Research Tools/Character Info Watcher.lua")
    add("General", "Simple ESP", "Scripts/General Tools/SimpleESP.lua")
    add("General", "Noclip", "Scripts/General Tools/Noclip.lua")
    add("General", "Flight", "Scripts/General Tools/Flight.lua")
    add("StealGames", "Steal a Baddie", "Scripts/Steal a Baddie Project/combined_auto_tp_stealer.lua")

    do
        local page = pagesModule.pages["StealGames"]
        if page then
            local ctrl = controllers["StealGames"]
            if not ctrl then
                ctrl = toggleLib.CreateController()
                controllers["StealGames"] = ctrl
            end
            ctrl.AddButton(page.Frame, page.Template, "AI Movement", function()
                return loadRemote("Scripts/General Tools/AIMovementUI.lua", loadRemote)
            end)
        end
    end

    return controllers
end
