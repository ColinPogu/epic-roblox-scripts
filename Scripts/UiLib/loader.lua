local MainUI = loadfile("MainUI.lua")()
local AddMenuButton = loadfile("AddMenuButton.lua")()

-- Add "Research Menu" button to the Side panel
AddMenuButton(MainUI.Side, MainUI.MenusTemplate, "Research Menu", function()
	MainUI.GridScrolling.Visible = not MainUI.GridScrolling.Visible
end)
