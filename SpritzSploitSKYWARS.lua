local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true);
ESP.Players = true;
ESP.Tracers = false;
ESP.Boxes = false;
ESP.Names = false;
ESP.Thickness = 2;
ESP.Color = Color3.fromRGB(255, 255, 255)

getgenv().executed = executed
if executed == false then 
    game.workspace.Lobby.KillPlates:remove()
    game:GetService("Players").LocalPlayer.PlayerGui.Extra.Local:Destroy() 
end
executed = true

for _,v in pairs(game.Workspace:GetChildren()) do 
    if v.Name == "antivoid" then 
        v:Destroy()
    end
end

local antivoidpart = Instance.new("Part")
antivoidpart.Parent = game.Workspace
antivoidpart.Name = "antivoid"
antivoidpart.Anchored = true
antivoidpart.CFrame = CFrame.new(1, 160, 1)
antivoidpart.Size = Vector3.new(666,1,666)
antivoidpart.Color = Color3.fromRGB(255,0,0)
antivoidpart.Transparency = 1
antivoidpart.CanCollide = false

local SpritzSploit = lib:Window("SpritzSploit",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)
local CombatTab = SpritzSploit:Tab("Combat")
local VisualTab = SpritzSploit:Tab("Visuals")
local TeleportsTab = SpritzSploit:Tab("Teleports")
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

TeleportsTab:Button("Mega VIP", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2, 264, 68)
end)
TeleportsTab:Button("VIP", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0, 264, -70)
end)
TeleportsTab:Button("Group Room", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(129, 264, 4)
end)
TeleportsTab:Button("Center Island", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1, 165, -10)
end)
TeleportsTab:Button("Island 1", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8, 165, -96)
end)
TeleportsTab:Button("Island 2", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(102, 165, -108)
end)
TeleportsTab:Button("Island 3", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 165, 2)
end)
TeleportsTab:Button("Island 4", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(115, 165, 109)
end)
TeleportsTab:Button("Island 5", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9, 165, 120)
end)
TeleportsTab:Button("Island 6", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-103, 165, 122)
end)
TeleportsTab:Button("Island 7", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-111, 165, 18)
end)
TeleportsTab:Button("Island 8", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-115, 165, -95)
end)

getgenv().aimlocktoggle = false
CombatTab:Toggle("Aim Lock",false, function(t)
    aimlocktoggle = t
    if aimlocktoggle == false then 
        aiming = false
    end
end)

getgenv().triggerbottoggle = false
CombatTab:Toggle("Trigger Bot",false, function(t)
    triggerbottoggle = t
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
            
    RunService.RenderStepped:Connect(function()
        if Mouse.Target and triggerbottoggle == true then
            if Mouse.Target.Parent:FindFirstChild('Humanoid') then
                mouse1click()
                mouse1release()
            end
        end
    end)
end)

getgenv().Reach = 30
CombatTab:Slider("Reach",5,5000,Reach, function(t)
    game:GetService"RunService".Stepped:Connect(function()
        pcall(function()
          Sword = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle
            for i,v in pairs(game.Players:GetPlayers()) do 
                if v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Left Arm") then
                 if (game.Players.LocalPlayer.Character.Torso.Position - v.Character.Torso.Position).Magnitude <= getgenv()().Reach then
                       v.Character['Left Arm']:BreakJoints()
                       v.Character['Left Arm'].Transparency = 1
                       v.Character['Left Arm'].CanCollide = false
                       v.Character['Left Arm'].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(1,0,-3.5)
                   end
               end
           end
        end)
    end)
end)

local hitboxsize = 1
local showhitbox = false

getgenv().hitboxexpand = false
CombatTab:Toggle("Hitbox Expander",false, function(t)
    hitboxexpand  = t
end)

CombatTab:Toggle("Show Hitboxes",false, function(t)
    showhitbox  = t
    for _,v in pairs(game.Players:GetPlayers()) do 
        if v ~= game.Players.LocalPlayer then 
            if showhitbox then 
                v.Character.HumanoidRootPart.Transparency = 0.5
            else 
                v.Character.HumanoidRootPart.Transparency = 1 
            end
        end
    end
end)

CombatTab:Slider("Hitbox Size",0,50,30, function(t)
    local hitboxsize = t
    if hitboxexpand then
        for _,v in pairs(game.Players:GetPlayers()) do 
            if v ~= game.Players.LocalPlayer then
                if showhitbox then
                    v.Character.HumanoidRootPart.Transparency = 0.5
                    v.Character.HumanoidRootPart.Color = Color3.fromRGB(255,0,0)
                else 
                    v.Character.HumanoidRootPart.Transparency = 1
                    v.Character.HumanoidRootPart.Color = Color3.fromRGB(255,255,255)
                end
                v.Character.HumanoidRootPart.Size = Vector3.new(hitboxsize ,hitboxsize ,hitboxsize)
            end
        end
    end
end)

getgenv().infshield = false
MiscTab:Toggle("Infinite Shield",false, function(t)
    infshield = t
    while infshield do
        local playerName = game.Players.LocalPlayer.Name
        game.Players.LocalPlayer.Character:FindFirstChild("Shield"):Activate()
        wait (1)
        game.Workspace:FindFirstChild(playerName).Shield.ShieldPotion:Destroy()
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

MiscTab:Toggle("Anti Void",false, function(t)
    if t == true then 
        antivoidpart.Transparency = 0.7 
        antivoidpart.CanCollide = true 
    else 
        antivoidpart.Transparency = 1
        antivoidpart.CanCollide = false
    end
end)

getgenv().autocollectcoinstoggle = false
MiscTab:Toggle("Auto Collect Coins",false, function(t)
    autocollectcoinstoggle = t
	while autocollectcoinstoggle do 
		wait()
		for _,v in pairs(game.Workspace.GameStorage.Coins:GetChildren()) do 
			if string.find(v.Name, "Coin") then 
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
			end
		end
	end
end)

getgenv().autofarmtoggle = false
MiscTab:Toggle("Auto Farm",false, function(t)
    autofarmtoggle = t
    
    local cpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    
    local stuff = workspace:getDescendants()
    while autofarmtoggle do
        for i=1,#stuff do
		    if stuff[i].Name == "Block" and stuff[i].Parent.Name == "Ores" then
			    repeat
				    wait()
				    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = stuff[i].CFrame
				    game.Players.LocalPlayer.Character.Axe.RemoteEvent:FireServer(stuff[i])
			    until stuff[i].Name ~= "Block" or not game.Players.LocalPlayer.Character:findFirstChild("Axe")
		    end
	    end
    end
end)

SettingsTab:Colorpicker("Change UI Color",Color3.fromRGB(44, 120, 224), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

DescTab:Label("Description")

DescTab:Label("This is SpritzSploit an advanced skywars script!")
DescTab:Label("Enjoy your time here and make the most of it!")
DescTab:Label("Credits: spritzy#9656 and BruhSoundEffect#2081")



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

spawn(function() 
wait(1)
    while true do
        wait()
        while hitboxexpand do 
            for _,v in pairs(game.Players:GetPlayers()) do 
                if v ~= game.Players.LocalPlayer then
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.Size = Vector3.new(hitboxsize ,hitboxsize ,hitboxsize)
                    v.Character.HumanoidRootPart.Color = Color3.fromRGB(255,0,0)
                end
            end
        end
    end
end)

