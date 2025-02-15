-- Simple mobile fly script with adjustable speed

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local speed = 50  -- Default fly speed

local bodyVelocity

-- Function to start flying
local function startFlying()
    if flying then return end
    flying = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.new(0, speed, 0)  -- Controls the vertical speed
    bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")

    humanoid.PlatformStand = true
end

-- Function to stop flying
local function stopFlying()
    if not flying then return end
    flying = false

    if bodyVelocity then
        bodyVelocity:Destroy()
    end
    humanoid.PlatformStand = false
end

-- Toggle fly on mobile input
local UserInputService = game:GetService("UserInputService")

UserInputService.TouchStarted:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- Toggle fly when the player touches the screen (or use a specific area of the screen for custom buttons)
    if not flying then
        startFlying()
    else
        stopFlying()
    end
end)

-- Function to adjust fly speed dynamically
local function changeSpeed(newSpeed)
    speed = newSpeed
    if flying then
        bodyVelocity.Velocity = Vector3.new(0, speed, 0)
    end
end

-- Example: Change speed to 100 (you can change this in the script or connect to a UI)
changeSpeed(100)
