local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true);
ESP.Players = true;
ESP.Tracers = false;
ESP.Boxes = false;
ESP.Names = false;
ESP.Thickness = 2;
ESP.Color = Color3.fromRGB(255, 255, 255)

local SpritzSploit = lib:Window("SpritzSploit [KAT]",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)
local CombatTab = SpritzSploit:Tab("Combat")
local VisualTab = SpritzSploit:Tab("Visuals")
local LocalTab = SpritzSploit:Tab("LocalPlayer")
local MiscTab = SpritzSploit:Tab("Misc")
local DescTab = SpritzSploit:Tab("Description")
local SettingsTab = SpritzSploit:Tab("Settings")


local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local camera = workspace.CurrentCamera
local tweeninfo = TweenInfo.new(0.04)
local Mouse = game.Players.LocalPlayer:GetMouse()
local CircleInline = Drawing.new("Circle")
local CircleOutline = Drawing.new("Circle")
local Player = Players.LocalPlayer

getgenv().silentaim_settings = {
    fov = 300,
    hitbox = "Head",
    fovcircle = false,
}

local function GetClosest(Fov) 
    if silentaimtoggle then
        local Target, Closest = nil, Fov or math.huge
        for i,v in pairs(Players:GetPlayers()) do 
            if (v.Character and v ~= Player and v.Character:FindFirstChild(getgenv().silentaim_settings.hitbox)) then
                local Position, OnScreen = camera:WorldToScreenPoint(v.Character[getgenv().silentaim_settings.hitbox].Position)
                local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if (Distance < Closest and OnScreen) then
                    Closest = Distance
                    Target = v
                end
            end
        end
        return Target
    end
end

function getClosest()
    local closestPlayer = nil
    local closesDist = math.huge
    for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if Dist < closesDist then
                closesDist = Dist
                closestPlayer = v
            end
        end
    end
    return closestPlayer
end


getgenv().aimlocktoggle = false
CombatTab:Toggle("Aim Lock",false, function(t)
    aimlocktoggle = t
    if aimlocktoggle == false then 
        aiming = false
    end
end)

VisualTab:Toggle("ESP Boxes",false, function(t)
    ESP.Boxes = t 
end)

VisualTab:Toggle("ESP Tracers",false, function(t)
    ESP.Tracers = t 
end)

VisualTab:Toggle("ESP Nametags",false, function(t)
    ESP.Names = t 
end)

getgenv().infjumptoggle = false
LocalTab:Toggle("Infinite Jump",false, function(t)
    infjumptoggle = t
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if infjumptoggle then
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
    end)
end)

getgenv().clicktptoggle = false
LocalTab:Toggle("Click TP",false, function(t)
    clicktptoggle = t
    local player = game:GetService("Players").LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local mouse = player:GetMouse()
    
    repeat wait() until mouse
    

        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and clicktptoggle then
                player.Character:MoveTo(Vector3.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z))
            end
        end)
end)

getgenv().nocliptoggle = false
LocalTab:Toggle("Noclip",false, function(t)
    nocliptoggle = t
    char = game.Players.LocalPlayer.Character 
    while nocliptoggle do 
        for _,v in pairs(char:children()) do 
            pcall(function() if v.className == "Part" then v.CanCollide = false elseif v.ClassName == "Model" then
            v.Head.CanCollide = false end end) 
        end 
        game:service("RunService").Stepped:wait() 
    end
end)

LocalTab:Slider("Walk Speed",16,100,30, function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)

LocalTab:Slider("Jump Power",50,200,30, function(t)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = t
end)

getgenv().silentaimtoggle = true
CombatTab:Toggle("Silent Aim",false, function(t)   
    silentaimtoggle = t      
        local Player = Players.LocalPlayer

        local Target
        local CircleInline = Drawing.new("Circle")
        local CircleOutline = Drawing.new("Circle")
        RunService.Stepped:Connect(function()
            if silentaimtoggle then
                CircleInline.Radius = getgenv().silentaim_settings.fov
                CircleInline.Thickness = 2
                CircleInline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
                CircleInline.Transparency = 1
                CircleInline.Color = Color3.fromRGB(255, 255, 255)
                CircleInline.Visible = getgenv().silentaim_settings.fovcircle
                CircleInline.ZIndex = 2
                CircleOutline.Radius = getgenv().silentaim_settings.fov
                CircleOutline.Thickness = 4
                CircleOutline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
                CircleOutline.Transparency = 1
                CircleOutline.Color = Color3.new()
                CircleOutline.Visible = getgenv().silentaim_settings.fovcircle
                CircleOutline.ZIndex = 1
                Target = GetClosest(getgenv().silentaim_settings.fov)
            else
                
            end
        end)
        local Old; Old = hookmetamethod(game, "__namecall", function(Self, ...)
        local Args = {...}
        if (not checkcaller() and getnamecallmethod() == "FindPartOnRayWithIgnoreList") then
            if (table.find(Args[2], workspace.WorldIgnore.Ignore) and Target and Target.Character) then
                local Origin = Args[1].Origin
                Args[1] = Ray.new(Origin, Target.Character[getgenv().silentaim_settings.hitbox].Position - Origin)
                end
            end
        return Old(Self, unpack(Args))
        end)
end)

DescTab:Label("Description")

DescTab:Label("This is SpritzSploit an advanced KAT script!")
DescTab:Label("Enjoy your time here and make the most of it!")
DescTab:Label("Credits: SpritzSploit Development Team")
DescTab:Label("https://discord.gg/M5DvuNzGAz")

UIS.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 and aimlocktoggle == true then
        aiming = true
        local tween
        while aiming do
            tween = TS:Create(camera, tweeninfo, {CFrame = CFrame.new(camera.CFrame.Position,getClosest().Character.Head.Position)})
            tween:Play()
            task.wait()
        end
        tween:Cancel()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = false
    end
end)

