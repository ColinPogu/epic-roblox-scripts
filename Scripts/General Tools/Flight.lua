local module = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character
local hrp
local humanoid

local flying = false
local velocity
local gyro
local speed = 100
local control = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}

local inputBeganCon
local inputEndedCon

local function ensureCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    hrp = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
end

local function flyLoop()
    RunService:BindToRenderStep("Flying", Enum.RenderPriority.Character.Value + 1, function()
        local cam = workspace.CurrentCamera
        local moveDir = (cam.CFrame.LookVector * (control.F - control.B) + cam.CFrame.RightVector * (control.R - control.L)) + Vector3.new(0, control.U - control.D, 0)
        if moveDir.Magnitude > 0 then
            velocity.Velocity = moveDir.Unit * speed
        else
            velocity.Velocity = Vector3.zero
        end
    end)
end

local function stopFlying()
    flying = false
    RunService:UnbindFromRenderStep("Flying")
    if inputBeganCon then inputBeganCon:Disconnect() inputBeganCon = nil end
    if inputEndedCon then inputEndedCon:Disconnect() inputEndedCon = nil end
    if velocity then velocity:Destroy() velocity = nil end
    if gyro then gyro:Destroy() gyro = nil end
    if humanoid then humanoid.PlatformStand = false end
end

local function startFlying()
    if flying then return end
    ensureCharacter()
    flying = true
    humanoid.PlatformStand = true

    velocity = Instance.new("BodyVelocity")
    velocity.Velocity = Vector3.zero
    velocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    velocity.P = 1250
    velocity.Parent = hrp

    gyro = Instance.new("BodyGyro")
    gyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    gyro.P = 3000
    gyro.CFrame = hrp.CFrame
    gyro.Parent = hrp

    flyLoop()

    inputBeganCon = UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.W then control.F = 1 end
        if input.KeyCode == Enum.KeyCode.S then control.B = 1 end
        if input.KeyCode == Enum.KeyCode.A then control.L = 1 end
        if input.KeyCode == Enum.KeyCode.D then control.R = 1 end
        if input.KeyCode == Enum.KeyCode.Space then control.U = 1 end
        if input.KeyCode == Enum.KeyCode.LeftShift then control.D = 1 end
    end)

    inputEndedCon = UIS.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then control.F = 0 end
        if input.KeyCode == Enum.KeyCode.S then control.B = 0 end
        if input.KeyCode == Enum.KeyCode.A then control.L = 0 end
        if input.KeyCode == Enum.KeyCode.D then control.R = 0 end
        if input.KeyCode == Enum.KeyCode.Space then control.U = 0 end
        if input.KeyCode == Enum.KeyCode.LeftShift then control.D = 0 end
    end)
end

function module.Enable()
    startFlying()
end

function module.Disable()
    stopFlying()
end

return module
