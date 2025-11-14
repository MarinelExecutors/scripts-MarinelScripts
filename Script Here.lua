-- NoNameOwner FE Script
local bannedPlayers = {} -- Store permabanned players

-- Function to check if player is permabanned
local function isPermabanned(player)
    return bannedPlayers[player.UserId] ~= nil
end

-- Ban logic for new players
game.Players.PlayerAdded:Connect(function(player)
    if isPermabanned(player) then
        player:Kick("You are permabanned by a hacker")
        print("Permabanned player attempted to join: " .. player.Name)
    else
        -- Detect alt accounts (simple heuristic)
        local isAlt = false
        -- Implement your detection logic here (e.g., same IP, device, etc.)
        -- For example purposes, assume players with same UserId are banned
        -- or add your own logic.

        -- Example: If the player is suspected to be an alt, permaban
        -- This is a placeholder; actual detection needs more info
        -- if someCondition then
        --     bannedPlayers[player.UserId] = true
        --     player:Kick("You are permabanned by a hacker")
        -- end
    end
end)

-- Load external script
local success, err = pcall(function()
    print("NoNameOwner is now executed.")
end)

if not success then
    print("ERROR: NoNameOwner is already running")
end

-- Support features: fly, shiftlock, speed, flyfling, goto, loopgoto
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flyEnabled = false
local flySpeed = 50
local currentFlyVelocity = Vector3.new(0, 0, 0)

-- Fly toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        flyEnabled = not flyEnabled
        print("Fly mode: " .. (flyEnabled and "Enabled" or "Disabled"))
    end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        -- Shiftlock toggle
        localPlayer.Character.HumanoidRootPart.Running = not localPlayer.Character.HumanoidRootPart.Running
    end
end)

-- Fly movement
RunService.Heartbeat:Connect(function()
    if flyEnabled then
        local moveDirection = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0,1,0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDirection = moveDirection - Vector3.new(0,1,0)
        end
        currentFlyVelocity = moveDirection * flySpeed
        rootPart.Velocity = currentFlyVelocity
    end
end)

-- Speed control
local speed = 16
humanoid.WalkSpeed = speed

-- goto and loopgoto (simple example)
local gotoPosition = Vector3.new(0, 10, 0)
local gotoActive = false

function goto(pos)
    rootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
end

function loopgoto(pos, delay)
    gotoActive = true
    while gotoActive do
        goto(pos)
        wait(delay)
    end
end

-- Example usage
-- Uncomment below to use
-- loopgoto(gotoPosition, 5)

-- Additional features can be added following this pattern
