--SCRIPT BY SKIBITGTT

local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local safeDistance = 100 
local Players = game:GetService("Players")
local player = Players.LocalPlayer


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WatermarkGui"
screenGui.Parent = player:WaitForChild("PlayerGui")


local watermark = Instance.new("TextLabel")
watermark.Name = "Watermark"
watermark.Parent = screenGui
watermark.Text = "W script by SKIBITGTT" 
watermark.TextColor3 = Color3.new(6, 3, 0) 
watermark.BackgroundTransparency = 0 
watermark.Font = Enum.Font.SourceSans
watermark.TextSize = 24 -- Font size
watermark.Position = UDim2.new(1, -10, 1, -30) 
watermark.AnchorPoint = Vector2.new(1, 1)
watermark.Size = UDim2.new(0, 200, 0, 50) 

local function isTooCloseToPlayers(part)
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character.PrimaryPart then
            local distance = (part.Position - otherPlayer.Character.PrimaryPart.Position).Magnitude
            if distance < safeDistance then
                return true 
            end
        end
    end
    return false 
end


local function runTeleportScript()
    local toggle = false
    local teleporting = false
    local function teleportToParts(character)
        teleporting = true
        while toggle do
            local parts = workspace:GetDescendants()
            for _, part in ipairs(parts) do
                if not toggle then break end 
                if part:IsA("BasePart") and (part.Name == "10" or part.Name == "34") and not isTooCloseToPlayers(part) then
                    character:SetPrimaryPartCFrame(part.CFrame)
                    wait(0.1) 
                end
            end
            wait()
        end
        teleporting = false
    end

    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F then
            toggle = not toggle
            if toggle and not teleporting then
                local character = player.Character or player.CharacterAdded:Wait()
                teleportToParts(character)
            end
        end
    end)
end


player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    character:WaitForChild("HumanoidRootPart")
    runTeleportScript()
end)


if player.Character then
    player.Character:WaitForChild("Humanoid")
    player.Character:WaitForChild("HumanoidRootPart")
    runTeleportScript()
end
