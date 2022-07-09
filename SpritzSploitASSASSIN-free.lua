local __index; __index = hookmetamethod(game, "__index", function(self, index)
    return __index(self, index)
end)

local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local SpritzSploit = lib:Window("SpritzSploit [ASSASSIN] Free Access",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)
local CombatTab = SpritzSploit:Tab("Combat")
local VisualTab = SpritzSploit:Tab("Visuals")
local LocalTab = SpritzSploit:Tab("LocalPlayer")
local DescTab = SpritzSploit:Tab("Description")

local lp = game.Players.LocalPlayer
local Player = game:GetService("Players").LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

local ttable = {"BALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLSBALLS", "COCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCKCOCK"}
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true);
ESP.Players = true;
ESP.Tracers = false;
ESP.Boxes = false;
ESP.Names = false;
ESP.Thickness = 2;
ESP.Color = Color3.fromRGB(255, 255, 255)


FOV_Circle = Drawing.new("Circle")
FOV_Circle.Color = Color3.fromRGB(255,255,255)
FOV_Circle.Thickness = 2.5
FOV_Circle.NumSides = 20
FOV_Circle.Radius = 200
FOV_Circle.Visible = false
FOV_Circle.Filled = false

_G.Toggle = false
CombatTab:Toggle("Silent Aim",false, function(t)
    _G.Toggle = t
end)

CombatTab:Toggle("Show FOV",false, function(t)
    FOV_Circle.Visible = t
end)

getgenv().ifuckinghatelife = false
VisualTab:Toggle("ESP Toggle",false, function(t)
    ESP:Toggle(t)
    ifuckinghatelife = t
    while ifuckinghatelife do 
        wait(1)
        local playertable = {}
        for _,v in pairs(game.Players:GetPlayers()) do 
            table.insert(playertable, v.Name)
        end
        local ttable = {}
        for _,v in pairs(game.Players.LocalPlayer.PlayerGui.ScreenGui:GetDescendants()) do 
            if string.find(v.Name, "TargetText") then 
                table.insert(ttable, v.Text)
            end
        end
        for i = 1, #playertable do 
            if playertable[i] == ttable[1] or playertable[i] == game.Players.LocalPlayer.Name then 
            else 
            ESP:Add(game.Workspace[playertable[i]]:FindFirstChild("HumanoidRootPart"), {
                Name = playertable[i],
                IsEnabled = "cpespbruh",
                Color = Color3.fromRGB(255,255,255)
            })
            end
        end
        if ttable[1] == game.Players.LocalPlayer.Name then
        else
            ESP:Add(game.Workspace[ttable[1]]:FindFirstChild("HumanoidRootPart"), {
                Name = "Target: "..ttable[1],
                IsEnabled = "targetESP",
                Color = Color3.fromRGB(255,0,0)
            })
        end
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

DescTab:Label("Description")

DescTab:Label("This is SpritzSploit a premium Assassin script!")
DescTab:Label("Enjoy your time here and make the most of it!")
DescTab:Label("Credits: SpritzSploit Development Team")
DescTab:Label("https://discord.gg/M5DvuNzGAz")

game:GetService('RunService').RenderStepped:connect(function()
    pcall(function()
        if _G.Toggle then
            for i, v in pairs(game:GetService("Workspace").KnifeHost.PowerUps:GetDescendants()) do
                if v:IsA("Part") then
                    v.Archivable = true
                end
            end
        end
    end)
end)

spawn(function()
    game:GetService('RunService').RenderStepped:connect(function()
        pcall(function()
            if _G.Toggle then
                for i, v in pairs(game:GetService("Workspace").KnifeHost:GetDescendants()) do
                    if v:IsA("Part") then
                        if v.Archivable == true then
                            local PlayerPosition = ClosestPlayerToCursor().baseHitbox.CFrame
                            v.CFrame = PlayerPosition
                        end
                    end
                end
            end
        end)
    end)
end)

game:GetService('RunService').Stepped:connect(function()
    FOV_Circle.Position = Vector2.new(Mouse.X, Mouse.Y + 37)
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and _G.Toggle == true then
        
        task.wait(.35);
    
        local function ClosestPlayerToCursor()
            local Closest = nil;
            local Distance = 9e9;
            for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= Player then
                    if Workspace[v.Name]:FindFirstChild("Humanoid") and Workspace[v.Name].Humanoid.Health ~= 0 then
                        local Position = Camera:WorldToViewportPoint(Workspace[v.Name].HumanoidRootPart.Position);
                        local Magnitude = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude;
                        if Magnitude < Distance and Magnitude < FOV_Circle.Radius then
                            Closest = workspace[v.Name];
                            Distance = Magnitude;
                        end
                    end
                end
            end
            return Closest
        end

        local ThrowAtTarget = function(args1, args2, args3)
            return game:GetService("ReplicatedStorage").Remotes.ThrowKnife:FireServer(args1,args2,args3);
        end
        
        ThrowAtTarget(workspace[ClosestPlayerToCursor().Name].Head.Position, 0, CFrame.new());
        
    end
end)

spawn(function()
    pcall(function()
        Mouse.KeyDown:Connect(function(key)
            if _G.Toggle == true then
                _G.Toggle = true
                FOV_Circle.Visible = true
            elseif _G.Toggle == false then
                _G.Toggle = false
                FOV_Circle.Visible = false
            end
        end)
    end)
end)

game:GetService('RunService').Stepped:connect(function()
    FOV_Circle.Position = Vector2.new(Mouse.X, Mouse.Y + 37)
end)

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name ~= lp.Name then 
        a = child.Name
        child:WaitForChild("HumanoidRootPart")
        ESP:Add(child.HumanoidRootPart, {
            Name = a,
            IsEnabled = "cpespbruh",
            Color = Color3.fromRGB(255,255,255)
        })
    end
end)