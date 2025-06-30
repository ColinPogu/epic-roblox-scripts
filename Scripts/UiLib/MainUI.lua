-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local ListScrolling = Instance.new("ScrollingFrame")
local TextButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local TextLabel = Instance.new("TextLabel")
local Side = Instance.new("ScrollingFrame")
local Menus = Instance.new("TextButton")
local UIListLayout_2 = Instance.new("UIListLayout")
local UIPadding_2 = Instance.new("UIPadding")
local Personal = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Player = Instance.new("ViewportFrame")
local PlayerName = Instance.new("TextLabel")
local Version = Instance.new("TextLabel")
local X = Instance.new("TextButton")
local Name = Instance.new("TextLabel")
local GridScrolling = Instance.new("ScrollingFrame")
local TextButton_2 = Instance.new("TextButton")
local UIPadding_3 = Instance.new("UIPadding")
local UIGridLayout = Instance.new("UIGridLayout")
local MenuButton = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Background.Name = "Background"
Background.Parent = ScreenGui
Background.BackgroundColor3 = Color3.fromRGB(46, 48, 56)
Background.BorderColor3 = Color3.fromRGB(0, 0, 0)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.206206962, 0, 0.2371995, 0)
Background.Size = UDim2.new(0.5926705, 0, 0.521748304, 0)

UICorner.Parent = Background

UIAspectRatioConstraint.Parent = Background
UIAspectRatioConstraint.AspectRatio = 2.000

ListScrolling.Name = "ListScrolling"
ListScrolling.Parent = Background
ListScrolling.Active = true
ListScrolling.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
ListScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
ListScrolling.BorderSizePixel = 0
ListScrolling.Position = UDim2.new(0.291039824, 0, 0.142204762, 0)
ListScrolling.Size = UDim2.new(0.708431184, 0, 0.857794821, 0)

TextButton.Parent = ListScrolling
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(8.05728106e-08, 0, -2.68482182e-07, 0)
TextButton.Size = UDim2.new(0.939999938, 0, 0.0323784128, 0)
TextButton.Visible = false
TextButton.Font = Enum.Font.SourceSans
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true

UIListLayout.Parent = ListScrolling
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

UIPadding.Parent = ListScrolling
UIPadding.PaddingLeft = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 5)

TextLabel.Parent = ListScrolling
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0, 0, 0.417887151, 0)
TextLabel.Size = UDim2.new(0.940351069, 0, 0.155344576, 0)
TextLabel.Visible = false
TextLabel.Font = Enum.Font.SourceSans
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

Side.Name = "Side"
Side.Parent = Background
Side.Active = true
Side.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
Side.BorderColor3 = Color3.fromRGB(0, 0, 0)
Side.BorderSizePixel = 0
Side.Position = UDim2.new(0, 0, 0.142204881, 0)
Side.Size = UDim2.new(0.297944486, 0, 0.657358646, 0)

Menus.Name = "Menus"
Menus.Parent = Side
Menus.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
Menus.BorderColor3 = Color3.fromRGB(28, 29, 34)
Menus.BorderSizePixel = 0
Menus.Position = UDim2.new(-1.07773559e-07, 0, -1.76605184e-07, 0)
Menus.Size = UDim2.new(0.940437198, 0, 0.127204657, 0)
Menus.Visible = false
Menus.Font = Enum.Font.SourceSans
Menus.TextColor3 = Color3.fromRGB(255, 255, 255)
Menus.TextSize = 48.000
Menus.TextWrapped = true

UIListLayout_2.Parent = Side
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 2)

UIPadding_2.Parent = Side
UIPadding_2.PaddingLeft = UDim.new(0, 5)
UIPadding_2.PaddingTop = UDim.new(0, 5)

Personal.Name = "Personal"
Personal.Parent = Background
Personal.BackgroundColor3 = Color3.fromRGB(46, 48, 56)
Personal.BorderColor3 = Color3.fromRGB(46, 48, 56)
Personal.BorderSizePixel = 0
Personal.Position = UDim2.new(0.00657167751, 0, 0.819278598, 0)
Personal.Size = UDim2.new(0.277401507, 0, 0.161006093, 0)

UICorner_2.Parent = Personal

Player.BackgroundTransparency = 1.000
Player.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Player.BorderSizePixel = 0
Player.BorderColor3 = Color3.fromRGB(0, 0, 0)
Player.Name = "Player"
Player.Parent = Personal

PlayerName.Name = "PlayerName"
PlayerName.Parent = Personal
PlayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.BackgroundTransparency = 1.000
PlayerName.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayerName.BorderSizePixel = 0
PlayerName.Position = UDim2.new(0.315971106, 0, -0.0120164519, 0)
PlayerName.Size = UDim2.new(0.66833812, 0, 0.571428597, 0)
PlayerName.Font = Enum.Font.Cartoon
PlayerName.LineHeight = 1.170
PlayerName.Text = "Test"
PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.TextScaled = true
PlayerName.TextSize = 14.000
PlayerName.TextWrapped = true

Version.Name = "Version"
Version.Parent = Personal
Version.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Version.BackgroundTransparency = 1.000
Version.BorderColor3 = Color3.fromRGB(0, 0, 0)
Version.BorderSizePixel = 0
Version.Position = UDim2.new(0.315971106, 0, 0.539003968, 0)
Version.Size = UDim2.new(0.66833812, 0, 0.571428597, 0)
Version.Font = Enum.Font.Cartoon
Version.LineHeight = 1.170
Version.Text = "Test"
Version.TextColor3 = Color3.fromRGB(255, 255, 255)
Version.TextScaled = true
Version.TextSize = 14.000
Version.TextWrapped = true

X.Name = "X"
X.Parent = Background
X.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
X.BackgroundTransparency = 1.000
X.BorderColor3 = Color3.fromRGB(0, 0, 0)
X.BorderSizePixel = 0
X.Position = UDim2.new(0.957764208, 0, 0, 0)
X.Size = UDim2.new(0.0401750132, 0, 0.127204478, 0)
X.Font = Enum.Font.SourceSans
X.Text = "X"
X.TextColor3 = Color3.fromRGB(255, 0, 0)
X.TextScaled = true
X.TextSize = 14.000
X.TextWrapped = true

Name.Name = "Name"
Name.Parent = Background
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Name.BorderSizePixel = 0
Name.Position = UDim2.new(0.00710223662, 0, 0.00669812504, 0)
Name.Size = UDim2.new(0.30525291, 0, 0.111411221, 0)
Name.Font = Enum.Font.Cartoon
Name.LineHeight = 1.170
Name.Text = "DababyScripts"
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.TextScaled = true
Name.TextSize = 14.000
Name.TextWrapped = true

GridScrolling.Name = "GridScrolling"
GridScrolling.Parent = Background
GridScrolling.Active = true
GridScrolling.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
GridScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
GridScrolling.BorderSizePixel = 0
GridScrolling.Position = UDim2.new(0.291039824, 0, 0.142204762, 0)
GridScrolling.Size = UDim2.new(0.708431184, 0, 0.857794821, 0)
GridScrolling.Visible = false

TextButton_2.Parent = GridScrolling
TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.BorderSizePixel = 0
TextButton_2.Size = UDim2.new(0.264020979, 0, 0.461636871, 0)
TextButton_2.Visible = false
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextScaled = true
TextButton_2.TextSize = 14.000
TextButton_2.TextWrapped = true

UIPadding_3.Parent = GridScrolling
UIPadding_3.PaddingLeft = UDim.new(0, 5)
UIPadding_3.PaddingTop = UDim.new(0, 5)

UIGridLayout.Parent = GridScrolling
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, 100, 0, 50)

MenuButton.Name = "MenuButton"
MenuButton.Parent = ScreenGui
MenuButton.BackgroundColor3 = Color3.fromRGB(46, 48, 56)
MenuButton.BackgroundTransparency = 0.350
MenuButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
MenuButton.BorderSizePixel = 5
MenuButton.Position = UDim2.new(0.00753602898, 0, 0.369668245, 0)
MenuButton.Size = UDim2.new(0.126722604, 0, 0.108247131, 0)
MenuButton.Font = Enum.Font.SourceSans
MenuButton.Text = "Menu"
MenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuButton.TextScaled = true
MenuButton.TextSize = 14.000
MenuButton.TextWrapped = true

return {
	ScreenGui = ScreenGui,
	Background = Background,
	Side = Side,
	GridScrolling = GridScrolling,
	MenusTemplate = Menus, -- button template for cloning
}
