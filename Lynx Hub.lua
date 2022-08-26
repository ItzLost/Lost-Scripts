repeat
    wait()
until(game:IsLoaded())
repeat
    wait()
until(game.Players.LocalPlayer.Character)
repeat
    wait()
until(game.Players.LocalPlayer.Character:FindFirstChild("Block"))

--variables
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local run = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer
local keeplynxhub = "KeepLynx.txt"
local mouse = plr:GetMouse()
local mobs = {}
local json
local Duration
local Style
local part

-- functions
local function tp(id)
    game:GetService("TeleportService"):Teleport(id)
end

local function GetPlayer(string)
    local lower = string:lower()
    for _, otherplr in next, game.Players:GetPlayers() do
        if otherplr.Name:sub(1,#string):lower() == lower or otherplr.DisplayName:sub(1,#string):lower() == lower then
            return otherplr
        end
    end
end

local function Distance(v1, v2)
    return(v1-v2).Magnitude
end

local function notif(Title, Text, ...)
    if ... == nil then
        Duration = 7
    else
        Duration = ...
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Duration}
    )
end

local function kill(path, object)
    for i, v in ipairs(path:GetChildren()) do
        if path:FindFirstChild(object) then
            path[object]:Destroy()
            return true
        end
    end
end

local function twn(char, time, coords, ...)
    if ... == nil then
        Style = Enum.EasingStyle.Linear
    else
        Style = Enum.EasingStyle[...]
    end
    game:GetService("TweenService"):Create(char, TweenInfo.new(time, Style), {CFrame = coords}):Play()
end

local function respawn(oldpos)
    local race = plr.Character.Race.Value
	if game.PlaceId == 536102540 and (race == "Android" or race == "Human" or race == "Saiyan") then
		if plr.Character:FindFirstChild("Block") then
			local args = {[1] = workspace.FriendlyNPCs:FindFirstChild("Hair Stylist")}
			plr.Backpack.ServerTraits.ChatStart:FireServer(unpack(args))
			wait(.3)
    		local args = {[1] = {[1] = "Yes"}}
			plr.Backpack.ServerTraits.plr.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))
			wait(.3)
			local args = {[1] = "woah"}
			plr.Backpack.HairScript.RemoteEvent:FireServer(unpack(args))
		end
	elseif plr.Character:FindFirstChild("Block") then
		plr.Character:BreakJoints()
	end
    run.Stepped:Connect(function()
        if not plr.Character:FindFirstChild("Block") then
            plr.Character.HumanoidRootPart.CFrame = oldpos
        end
    end)
end

-- all credits to infinite yield hub for this function
function toClipboard(String)
	local clipBoard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
	if clipBoard then
		clipBoard(String)
		notif("Copied the invite to clipboard", "Nice, go use it now.")
	else
		notif("Your exploit doesn't have the ability to use the clipboard", "Sad but you're bad.")
	end
end
--

local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzLost/Lost-Scripts/main/Solaris%20UI%20modified%20a%20lil%20bit"))()
local Lib = SolarisLib:New(
    {Name = "Lynx",
    FolderToSave = "Lynx Hub"}
)
SolarisLib:Notification("Lynx Hub loading..", "It'll be fast.")
run.Stepped:connect(function()
    if game:GetService("CoreGui"):FindFirstChild("dosage's solaris gui") then
        game:GetService("CoreGui")["dosage's solaris gui"].Name = "Lynx Hub"
    end
end)
-- Main tab
local Main = Lib:Tab("Main")
local Useful = Main:Section("Useful")
local Respawns = Main:Section("Respawns")
local Godmodes = Main:Section("Godmodes")

Useful:Slider("Dodge Speed", 0, 6000, 0, 10, "Dodge Speed", function(sliderspeed) -- Not made by me.
    if sliderspeed >= 100 then
        local down = false
        local velocity = Instance.new("BodyVelocity")
        velocity.maxForce = Vector3.new(10000000, 0, 10000000)
        local speed = sliderspeed
        local gyro = Instance.new("BodyGyro")
        gyro.maxTorque = Vector3.new(10000000, 0, 10000000)

        function onButton1Down(mouse)
            down = true
            velocity.Parent = plr.Character.UpperTorso
            velocity.velocity = (plr.Character.Humanoid.MoveDirection) * speed
            gyro.Parent = plr.Character.UpperTorso
            while down do
                if not down then
                    break
                end
                velocity.velocity = (plr.Character.Humanoid.MoveDirection) * speed
                local refpos = gyro.Parent.Position + (gyro.Parent.Position - workspace.CurrentCamera.CoordinateFrame.p).unit * 5
                gyro.cframe = CFrame.new(gyro.Parent.Position, Vector3.new(refpos.x, gyro.Parent.Position.y, refpos.z))
                wait(.1)
            end
        end

        function onButton1Up(mouse)
            velocity.Parent = nil
            gyro.Parent = nil
            down = false
        end

        function onSelected(mouse)
            mouse.KeyDown:connect(function(k)
                if k:lower()== "q" then
                    onButton1Down(mouse)
                end
            end)
            mouse.KeyUp:connect(function(k)
                if k:lower()== "q"then
                    onButton1Up(mouse)
                end
            end)
        end
        onSelected(plr:GetMouse())
    end
end)

Useful:Toggle("NoSlow", nil, "NoSlow", function(Noslow)
    if Noslow == false then
        ns:Disconnect()
    elseif Noslow then
        ns = run.Stepped:connect(function()
            for i, v in pairs(plr.Character:GetDescendants()) do
                if v.Name == "Block" then
                    v.Value = false
                end
                if v.Name == "Action" or v.Name == "Activity" or v.Name == "Attacking" or v.Name == "Using" or v.Name == "hyper" or v.Name == "Hyper" or v.Name == "KiBlasted" or v.Name == "heavy" or v.Name == "NotHardBack" or v.Name == "Tele" or v.Name == "Blocked" or v.Name == "tele" or v.Name == "Killed" or v.Name == "Slow" or v.Name == "BodyVelocity" then
                    v:Destroy()
                end
            end
        end)
    end
end)

Useful:Toggle("Invisible", nil, "Invis", function(Invis)
    if Invis == false then
        respawn(plr.Character.HumanoidRootPart.CFrame)
    elseif Invis then
        if game.PlaceId == 3565304751 then
            kill(plr.Character, "RightLowerLeg")
            kill(plr.Character, "LeftLowerLeg")
            kill(plr.Character, "RightFoot")
            kill(plr.Character, "LeftFoot")
            kill(plr.Character, "LowerTorso")
            kill(plr.Character, "RightUpperLeg")
            kill(plr.Character, "LeftUpperLeg")
        else
            if plr.Backpack:FindFirstChild("Flash Strike") then
                plr.Backpack["Flash Strike"].Parent = plr.Character
                wait(.1)
                kill(plr.Character["Flash Strike"].Activator, "Animation")
                plr.Character["Flash Strike"]:Activate()
            else
                kill(plr.Character, "RightLowerLeg")
                kill(plr.Character, "LeftLowerLeg")
                kill(plr.Character, "RightFoot")
                kill(plr.Character, "LeftFoot")
                kill(plr.Character, "LowerTorso")
                kill(plr.Character, "RightUpperLeg")
                kill(plr.Character, "LeftUpperLeg")
            end
        end
    end
end)

Useful:Button("Spy chat", function()
    plr.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = true
    plr.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = UDim2.new(0, 0, 0, 290)
end)

Useful:Button("HideLevel", function()
    while wait() do
        if plr.Character:FindFirstChildOfClass("Model") then
            plr.Character:FindFirstChildOfClass("Model"):Destroy()
        end
    end
end)

Useful:Button("Remove Wings/ Halo", function()
    while wait() do
        if plr.Character:FindFirstChild("RebirthWings") then
            kill(plr.Character.RebirthWings, "Handle")
        elseif plr.Character:FindFirstChild("RealHalo") then
            kill(plr.Character.RealHalo, "Handle")
        end
    end
end)

Useful:Toggle("Bean Spam", nil, "Bean Spam", function(BeanSpam)
    _G.Spam = BeanSpam
    coroutine.wrap(function()
        while wait() do
            if _G.Spam then
                plr.Backpack.ServerTraits.EatSenzu:FireServer("")
            else
                _G.Spam = false
            end
        end
    end){}
end)

if game.PlaceId == 536102540 then
    Useful:Dropdown("Slot Changer", {"Slot1", "Slot2", "Slot3"}, "", "Slot Changer" ,function(Slot)
        if Slot ~= "" then
            local args = {[1] = workspace.FriendlyNPCs:FindFirstChild("Character Slot Changer")}
            plr.Backpack.ServerTraits.ChatStart:FireServer(unpack(args))
            wait(.4)
            local args = {[1] = {[1] = "Yes"}}
            plr.Backpack.ServerTraits.plr.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))
            wait(.4)
            local args = {[1] = {[1] = "k"}}
            plr.Backpack.ServerTraits.plr.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))
            wait(.4)
            local args = {[1] = {[1] = Slot}}
            plr.Backpack.ServerTraits.plr.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))
        end
    end)
end

Respawns:Button("Respawn", function()
    respawn(plr.Character.HumanoidRootPart.CFrame)
end)

Respawns:Button("Hard Reset", function()
    plr.Character:BreakJoints()
end)

if game.PlaceId == 535527772 or game.PlaceId == 3552158750 then
    Respawns:Button("T.O.P. Respawn", function()
        for i, v in ipairs(game.Players:GetPlayers()) do
            if v.Name ~= plr.Name then
                while wait() do
                    if plr.Character.Humanoid.Health <= 1 then
                        kill(plr.Character, "SuperAction")
                        wait(.1)
                        twn(plr.Character.HumanoidRootPart, .3, CFrame.new(100, 100, 100)):Play()
                    end
                end
            end
        end
        notif("T.O.P. respawn", "You need to NOT be alone, at least 2 players are required", 15)
    end)
end

if game.PlaceId == 536102540 then
    Godmodes:Toggle("Earth Godmode", nil, "Earth Godmode", function(godmode)
        if godmode == false then
            gm:Disconnect()
        elseif godmode then
            gm = run.Stepped:connect(function()
                firetouchinterest(plr.Character.HumanoidRootPart, game.Workspace.Touchy.Part, 0)
                firetouchinterest(plr.Character.HumanoidRootPart, game.Workspace.Touchy.Part, 1)
                if plr.PlayerGui:FindFirstChild("Popup") then
                    plr.PlayerGui.Popup:Destroy()
                end
            end)
        end
    end)

    Godmodes:Toggle("Earth Hair Godmode", nil, "Earth Hair Godmodes", function(hairgm)
        if hairgm == false then
            plr.Character:BreakJoints()
        elseif hairgm then
            plr.Character.Parent = game.Workspace.Effects
            wait()
            local args1 = game:GetService("Workspace").FriendlyNPCs["Hair Stylist"]
            plr.Backpack.ServerTraits.ChatStart:FireServer(args1)
            wait(.3)
            local args = {[1] = {[1] = "Yes"}}
            plr.Backpack.ServerTraits.plr.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))
            run.Stepped:connect(function()
                plr.PlayerGui.Setup.Enabled = false
            end)
        end
    end)
end
if game.PlaceId ~= 3565304751 then
    Godmodes:Toggle("Universal Godmode", nil, "Universal Godmode", function(unigod)
        if unigod == false then
            plr.Character:BreakJoints()
        elseif unigod == true then
            -- al credits to jacob and aloof for uni god and uni god fix
            function start(char)
                char:WaitForChild("Block")
                char:WaitForChild("Humanoid"):UnequipTools()
                local Move = "Afterimage Strike"
                wait(1)
                if game.FindFirstChild(plr.Backpack, Move) then
                    char.HumanoidRootPart:WaitForChild("Vanish"):Destroy()
                    plr.Backpack["Afterimage Strike"].Parent = char
                    repeat
                        wait()
                        char[Move].Targeter:FireServer(char)
                        char[Move]:Activate()
                    until (game.FindFirstChild(char, "i"))
                    char.Humanoid:UnequipTools()
                end
            end
            start(game.Workspace.Live:WaitForChild(plr.Name))
            old = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                local args = { ... }
                if method == "FireServer" and tostring(self) == "Input" then
                    if args[1][1] == "blockoff" or args[1][1] == "blockon" then
                        return
                    end
                end
                return old(self, ...)
            end)
        end
    end)
else
    Godmodes:Label("No Godmode in queue :p")
end

local glitches = Lib:Tab("Glitches")
local Glitch = glitches:Section("Glitch Players")
local antiglitch = glitches:Section("Anti Glitches")

if game.PlaceId ~= 3565304751 then
    Glitch:Button("Dragon Crush glitch (grab)", function()
        mouse.KeyDown:connect(function(key)
                if plr.Backpack:FindFirstChild("Dragon Crush") then
                    notif("Press N near a player to grab him", "Respawn or hard reset to stop")
                    if key == "n" then
                    plr.Character.Humanoid:EquipTool(plr.Backpack["Dragon Crush"])
                    wait(.1)
                    if plr.Character["Dragon Crush"].Activator:FindFirstChild("Flip") then
                        plr.Character["Dragon Crush"].Activator.Flip:Destroy()
                    end
                    plr.Character["Dragon Crush"]:Activate()
                end
            else
                notif("You need Dragon Crush", "You can buy that attack in the shop in the section melee", 15)
            end
        end)
    end)
    Glitch:Button("Dragon Throw glitch (grab)", function()
        mouse.KeyDown:connect(function(key)
            if plr.Backpack:FindFirstChild("Dragon Throw") then
                if key == "j" then
                    notif("Press J near a player to grab him", "Respawn or hard reset to stop")
                    plr.Character.Humanoid:EquipTool(plr.Backpack["Dragon Throw"])
                    wait(.1)
                    if plr.Character["Dragon Throw"].Activator:FindFirstChild("Flip") then
                        plr.Character["Dragon Throw"].Activator.Flip:Destroy()
                    end
                    plr.Character["Dragon Throw"]:Activate()
                end
            else
                notif("You need Dragon Throw", "You can buy that attack in the shop in the section melee", 15)
            end
        end)
    end)
    Glitch:Button("Bone Crush glitch", function()
        mouse.KeyDown:connect(function(key)
            if plr.Backpack:FindFirstChild("Bone Crush") then
                notif("Press K near a player to send him to heaven", "Respawn or hard reset to re use")
                if key == "k" then
                    plr.Character.Humanoid:EquipTool(plr.Backpack["Bone Crush"])
                    wait(.1)
                    if plr.Character["Bone Crush"].Activator:FindFirstChild("Crash") then
                        plr.Character["Bone Crush"].Activator.Crash:Destroy()
                    end
                    plr.Character["Bone Crush"]:Activate()
                end
            else
                notif("You need Bone Crush", "You can buy that attack in the shop in the section melee", 15)
            end
        end)
    end)
    Glitch:Button("Trash Glitch", function()
        if plr.Character.HumanoidRootPart:FindFirstChild("VanishParticle") then
            plr.Character.HumanoidRootPart.VanishParticle:Destroy()
            notif("use the attack Trash? or Trash???", "ez")
        end
    end)
    Glitch:Button("Freeze player glitch", function()
        mouse.KeyDown:connect(function(key)
            if plr.Backpack:FindFirstChild("Dragon Crush") then
                notif("Press O near a player to freeze him", "")
                if key == "o" then
                    plr.Character.Humanoid:EquipTool(plr.Backpack["Dragon Crush"])
                    wait(.1)
                    if plr.Character["Dragon Crush"].Activator:FindFirstChild("Flip") then
                        plr.Character["Dragon Crush"].Activator.Flip:Destroy()
                    end
                    plr.Character["Dragon Crush"]:Activate()
                    wait(.1)
                    tp(game.PlaceId)
                end
            else
                notif("You need Dragon Crush", "You can buy that attack in the shop in the section melee", 15)
            end
        end)
    end)
    if game.PlaceId == 536102540 then
        Glitch:Button("Throw a player in queue ( won't work if they have antiqueue )", function()
            if plr.Backpack:FindFirstChild("Dragon Crush") then
                notif("Press L near a player to throw him to queue", "Respawn or hard reset to re use")
                mouse.KeyDown:connect(function(key)
                    if key == "l" then
                        plr.Character.Humanoid:EquipTool(plr.Backpack["Dragon Crush"])
                        wait(.1)
                        if plr.Character["Dragon Crush"].Activator:FindFirstChild("Flip") then
                            plr.Character["Dragon Crush"].Activator.Flip:Destroy()
                        end
                        plr.Character["Dragon Crush"]:Activate()
                        wait(.5)
                        twn(plr.Character.HumanoidRootPart, 0, CFrame.new(2656.27, 3943.92, -2516))
                        if game.Workspace.Wormhole:FindFirstChild("TouchInterest")  then
                            game.Workspace.Wormhole.TouchInterest:Destroy()
                        end
                    end
                end)
            end
        end)
        Glitch:Button("Force Someone into queue ( will work if they have antiqueue BUT will throw you in queue too )", function()
            if plr.Backpack:FindFirstChild("Dragon Crush") then
                notif("Press i near a player to force him to queue", "")
                mouse.KeyDown:connect(function(key)
                    if key == "i" then
                        plr.Character.Humanoid:EquipTool(plr.Backpack["Dragon Crush"])
                        wait(.1)
                        if plr.Character["Dragon Crush"].Activator:FindFirstChild("Flip") then
                            plr.Character["Dragon Crush"].Activator.Flip:Destroy()
                        end
                        plr.Character["Dragon Crush"]:Activate()
                        wait(.5)
                        if plr.Character:FindFirstChild("PowerOutput") then
                            plr.Character.PowerOutput:Destroy()
                        end
                        twn(plr.Character.HumanoidRootPart, 0, CFrame.new(2656.27, 3943.92, -2516))
                        if game.Workspace.Wormhole:FindFirstChild("TouchInterest") then
                            game.Workspace.Wormhole.TouchInterest:Destroy()
                        end
                        wait(2)
                        plr.Character:BreakJoints()
                        tp(game.PlaceId)
                    end
                end)
            end
        end)
    end
else
    Glitch:Label("No Glitches in queue :p")
end
antiglitch:Button("Anti queue throw", function()
    if game.Workspace.Wormhole:FindFirstChild("TouchInterest")  then
        game.Workspace.Wormhole.TouchInterest:Destroy()
    end
end)
if game.PlaceId ~= 3565304751 then
    antiglitch:Toggle("Anti BoneCrush/Trash glitch", nil, "Anti BoneCrush/Trash glitch", function(antiglitches)
        _G.antiglitch = antiglitches
        while wait() do
            if not _G.antiglitch then
                break
            end
            if _G.antiglitch then
                if plr.Character.LowerTorso:FindFirstChild("BodyVelocity") then
                    plr.Character.LowerTorso.BodyVelocity:Destroy()
                end
            else
                _G.antiglitch = false
            end
        end
    end)
    antiglitch:Button("AntiGrab", function()
        run.Stepped:connect(function()
            if plr.Character:FindFirstChild("MoveStart") then
                respawn(plr.Character.HumanoidRootPart.CFrame)
            end
        end)
    end)
end

local Teleports = Lib:Tab("Teleports")
local tps = Teleports:Section("Tps")
local Queue = Teleports:Section("Queue")
local earth = Teleports:Section("Earth")
local namek = Teleports:Section("Namek")
local space = Teleports:Section("Space")
local future = Teleports:Section("Future")
local sworld = Teleports:Section("Secret World")
local zaros = Teleports:Section("Zaros")
local heaven = Teleports:Section("Heaven")

tps:Textbox("Tween to player", false, function(tweenplr)
    local mhm = GetPlayer(tweenplr)
    for i, target in pairs(game.Players:GetChildren()) do
        if target == mhm then
            if game.Workspace.Live:FindFirstChild(target.Name) and target.Character:FindFirstChild("HumanoidRootPart") then
                local vardistance = Distance(plr.Character.HumanoidRootPart.Position, target.Character.HumanoidRootPart.Position)
                game:GetService("TweenService"):Create(plr.Character.HumanoidRootPart, TweenInfo.new(vardistance/5000, Enum.EasingStyle.Quad), {CFrame = target.Character.HumanoidRootPart.CFrame}):Play()
            end
        end
    end
end)

tps:Button("Rejoin", function()
    tp(game.PlaceId)
end)

Queue:Button("Queue", function()
    if game.PlaceId ~= 3565304751 then tp(3565304751) end
end)
earth:Dropdown("Earth", {"Earth", "South City", "West City", "Central City", "Spawn", "Broly Pad", "Top", "Hard Top"}, "", "Earth", function(earthTP)
    if earthTP == "Top" then
        if game.PlaceId ~= 536102540 then tp(536102540) else
twn(plr.Character.HumanoidRootPart, 2, CFrame.new(2499.61, 3944.9, -2028.61)):Play() end
    elseif earthTP == "Hard Top" then
        if game.PlaceId ~= 536102540 then tp(536102540) else
        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(2518.82, 3944.92, -2523.64)):Play() end
        elseif earthTP == "Broly Pad" then
            if game.PlaceId ~= 536102540 then tp(536102540) else
            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(2732.16, 3944.93, -2272.36)):Play() end
            elseif earthTP == "South City" then
                if game.PlaceId ~= 536102540 then tp(536102540) else
                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-457.984, 25.0702, -6392.42)):Play() end
                elseif earthTP == "West City" then
                    if game.PlaceId ~= 536102540 then tp(536102540) else
                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-571.317, 22.0967, -2895.73)):Play() end
                    elseif earthTP == "Central City" then
                        if game.PlaceId ~= 536102540 then tp(536102540) else
                        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-3843.82, 22.1032, -1428.37)):Play() end
                        elseif earthTP == "Spawn" then
                            if game.PlaceId ~= 536102540 then tp(536102540) else
                            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-5946.07, 21.1173, -4216.57)):Play() end
                            elseif earthTP == "Earth" then
                                if game.PlaceId ~= 536102540 then tp(536102540) end
    end
end)
namek:Dropdown("Namek", {"Namek", "South Namek", "Western Namek", "Central Namek", "Ginyu Force", "Guru's House", "Secret Place", "Frieza's Spaceship"}, "", "Namek", function(namekTP)
    if namekTP == "Namek" then
        if game.PlaceId ~= 882399924 then tp(882399924) end
        elseif namekTP == "South Namek" then
            if game.PlaceId ~= 882399924 then tp(882399924) else
        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-1166.57, 20.8272, -2979.9)):Play() end
            elseif namekTP == "Western Namek" then
                if game.PlaceId ~= 882399924 then tp(882399924) else
                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(4060.94, 20.8176, -2545.91)):Play() end
                elseif namekTP == "Central Namek" then
                    if game.PlaceId ~= 882399924 then tp(882399924) else
                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-728.481, 29.8514, 371.669)):Play() end
                    elseif namekTP == "Ginyu Force" then
                        if game.PlaceId ~= 882399924 then tp(882399924) else
                        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(4686.57, 20.8204, 965.467)):Play() end
                        elseif namekTP == "Guru's House" then
                            if game.PlaceId ~= 882399924 then tp(882399924) else
                            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(2444.49, 529.14, -2287.25)):Play() end
                            elseif namekTP == "Secret Place" then
                                if game.PlaceId ~= 882399924 then tp(882399924) else
                                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-1974.04, 78.4368, -2963.62)):Play() end
                                elseif namekTP == "Frieza's Spaceship" then
                                    if game.PlaceId ~= 882399924 then tp(882399924) else
                                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(2741.47, 46.5799, 701.319)):Play() end
    end
end)
space:Dropdown("Space", {"Space", "Fieza's Planet #981", "Nemee", "Potafeu", "New Planet Vegeta", "Eros", "Tabza", "Beerus's Planet", "Alpha", "Yardrat", "Popol", "Wartin", "Asteroids"}, "", "Space", function(spaceTP)
    if spaceTP == "Space" then
        if game.PlaceId ~= 478132461 then tp(478132461) end
        elseif spaceTP == "Fieza's Planet #981" then
            if game.PlaceId ~= 478132461 then tp(478132461) else
            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-74.4402, 76.3373, -3.12689)):Play() end
            elseif spaceTP == "Nemee" then
                if game.PlaceId ~= 478132461 then tp(478132461) else
                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-6762.59, -150.849, 2093.79)):Play() end
                elseif spaceTP == "Potafeu" then
                    if game.PlaceId ~= 478132461 then tp(478132461) else
                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-4191.4, -1135.53, -2553.78)):Play() end
                    elseif spaceTP == "New Planet Vegeta" then
                        if game.PlaceId ~= 478132461 then tp(478132461) else
                        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-6689.38, 777.12, -3790.19)):Play() end
                        elseif spaceTP == "Eros" then
                            if game.PlaceId ~= 478132461 then tp(478132461) else
                            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(77.7641, 162.212, -5829.74)):Play() end
                            elseif spaceTP == "Tabza" then
                                if game.PlaceId ~= 478132461 then tp(478132461) else
                                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(5112.3, 69.5484, -5682.29)):Play() end
                                elseif spaceTP == "Beerus's Planet" then
                                    if game.PlaceId ~= 478132461 then tp(478132461) else
                                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(6425, 2799.3, -9684.44)):Play() end
                                    elseif spaceTP == "Alpha" then
                                        if game.PlaceId ~= 478132461 then tp(478132461) else
                                        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(5397.73, 777.114, 21.7836)):Play() end
                                        elseif spaceTP == "Yardrat" then
                                            if game.PlaceId ~= 478132461 then tp(478132461) else
                                            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(12656.7, 1197.39, 1570.18)):Play() end
                                            elseif spaceTP == "Popol" then
                                                if game.PlaceId ~= 478132461 then tp(478132461) else
                                                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(10628.7, 1259.29, 9352.7)):Play() end
                                                elseif spaceTP == "Wartin" then
                                                    if game.PlaceId ~= 478132461 then tp(478132461) else
                                                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-6931.55, 2163.28, 5888.39)):Play() end
                                                    elseif spaceTP == "Asteroids" then
                                                        if game.PlaceId ~= 478132461 then tp(478132461) else
                                                        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(2912.41, 706.121, 4837.85)):Play() end
    end
end)
future:Dropdown("Future", {"Spawn", "Central City", "South City", "West City", "Satan City", "Cell Games Arena", "Mountains"}, "", "Future", function(futureTP)
    if futureTP == "Future" then
        if game.PlaceId ~= 569994010 then tp(569994010) end
        elseif futureTP == "Spawn" then
            if game.PlaceId ~= 569994010 then tp(569994010) else
            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(3371.73, -92.2734, 1652.57)):Play() end
            elseif futureTP == "Central City" then
                if game.PlaceId ~= 569994010 then tp(569994010) else
                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-520.103, -94.5956, 1042.38)):Play() end
                elseif futureTP == "South City" then
                    if game.PlaceId ~= 569994010 then tp(569994010) else
                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(2180.2, -88.4255, -2707.64)):Play() end
                    elseif futureTP == "West City" then
                        if game.PlaceId ~= 569994010 then tp(569994010) else
                        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(1801.2, -93.3969, 520.312)):Play() end
                        elseif futureTP == "Satan City" then
                            if game.PlaceId ~= 569994010 then tp(569994010) else
                            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-2868.46, 24.5855, 360.547)):Play() end
                            elseif futureTP == "Cell Games Arena" then
                                if game.PlaceId ~= 569994010 then tp(569994010) else
                                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(1580.55, -92.4884, 2476.67)):Play() end
                                elseif futureTP == "Mountains" then
                                    if game.PlaceId ~= 569994010 then tp(569994010) else
                                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-463.835, 283.766, -846.05)):Play() end
    end
end)
sworld:Dropdown("Secret Wolrd", {"Secret World", "Gods", "Universal GOD 1%", "Further Beyond", "Gogeta and Janemba"}, "", "Secret World", function(swTP)
    if swTP == "Secret World" then
        if game.PlaceId ~= 2046990924 then tp(2046990924) end
        elseif swTP == "Gods" then
            if game.PlaceId ~= 2046990924 then tp(2046990924) else
            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(3109.19, 731.151, 2539.74)):Play() end
            elseif swTP == "Universal GOD 1%" then
                if game.PlaceId ~= 2046990924 then tp(2046990924) else
                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(488.087, -5.95599, 3954.13)):Play() end
                elseif swTP == "Further Beyond" then
                    if game.PlaceId ~= 2046990924 then tp(2046990924) else
                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-868.206, 407.821, 5016.27)):Play() end
                    elseif swTP == "Gogeta and Janemba" then
                        if game.PlaceId ~= 2046990924 then tp(2046990924) else
                        twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-1854.98, 157.867, -1034.26)):Play() end
    end
end)
zaros:Dropdown("Zaros", {"King Zaros", "Dark Mountains", "Crystal Mines"}, "", "Zaros", function(zarosTP)
    if zarosTP == "Zaros" then
        if game.PlaceId ~= 2651456105 then tp(2651456105) end
        elseif zarosTP == "King Zaros" then
            if game.PlaceId ~= 2651456105 then tp(2651456105) else
            twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-178.858, 4077.97, 5961.85)):Play() end
            elseif zarosTP == "Dark Mountains" then
                if game.PlaceId ~= 2651456105 then tp(2651456105) else
                twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-993.31, 434.338, 3973.5)):Play() end
                elseif zarosTP == "Crystal Mines" then
                    if game.PlaceId ~= 2651456105 then tp(2651456105) else
                    twn(plr.Character.HumanoidRootPart, 2, CFrame.new(-4891.42, 35.4522, 1665.59)):Play() end
    end
end)

heaven:Button("Heaven", function()
    if game.PlaceId ~= 3552157537 then tp(3552157537) end
end)

local Autofarm = Lib:Tab("AutoFarm")
if game.PlaceId ~= 3565304751 then
    local Farm = Autofarm:Section("Npcs")
    local Moves = Autofarm:Section("Auto Moves")
    local Autoearth = Autofarm:Section("AutoEarth")

    Farm:Textbox("NPC1", false, function(npc1)
        _G.NPC1 = npc1
        return(_G.NPC1)
    end)
    Farm:Textbox("NPC2", false, function(npc2)
        _G.NPC2 = npc2
        return(_G.NPC2)
    end)
    Farm:Textbox("NPC3", false, function(npc3)
        _G.NPC3 = npc3
        return(_G.NPC3)
    end)
    Farm:Textbox("NPC4", false, function(npc4)
        _G.NPC4 = npc4
        return(_G.NPC4)
    end)
    Farm:Textbox("NPC5", false, function(npc5)
        _G.NPC5 = npc5
        return(_G.NPC5)
    end)

    local autofarm = Farm:Toggle("Farm npcs", nil, "Farm npcs", function(NPCFarm)
        _G.Farm = NPCFarm
        if _G.Farm then
            -- this is here so the character doesn't loop fall when he isn't flying, makes the autotop better, faster, smoother and nicer to look att
            part = Instance.new("Part", game.workspace)
            run.Stepped:connect(function()
                part.Position = plr.Character.HumanoidRootPart.CFrame * Vector3.new(0, -3, 0)
            end)
            part.Anchored = true
            part.Transparency = 1
        else
            if part then
                part:Destroy()
            end
        end
        coroutine.wrap(function()
            while wait() do
                coroutine.wrap(function()
                    while wait() do
                        if _G.Farm == false then
                            plr.Character:BreakJoints()
                            _G.ShouldISetNil = true
                            break
                        end
                    end
                end){}
                if _G.Farm then
                    print(_G.NPC1)
                    print(_G.NPC2)
                    print(_G.NPC3)
                    print(_G.NPC4)
                    print(_G.NPC5)
                    if _G.NPC1 ~= nil and string.len(_G.NPC1) >= 4 then
                        table.insert(mobs, _G.NPC1)
                    end
                    if _G.NPC2 ~= nil and  string.len(_G.NPC2) >= 4 then
                        table.insert(mobs, _G.NPC2)
                    end
                    if _G.NPC3 ~= nil and  string.len(_G.NPC3) >= 4 then
                        table.insert(mobs, _G.NPC3)
                    end
                    if _G.NPC4 ~= nil and  string.len(_G.NPC4) >= 4 then
                        table.insert(mobs, _G.NPC4)
                    end
                    if _G.NPC5 ~= nil and  string.len(_G.NPC5) >= 4 then
                        table.insert(mobs, _G.NPC5)
                    end

                    for i, v in pairs(game.workspace.Live:GetChildren()) do
                        for idk, mob in pairs(mobs) do
                            if v.Name:sub(1, #mob) == mobs[1] or v.Name:sub(1, #mob) == mobs[2] or v.Name:sub(1, #mob) == mobs[3] or v.Name:sub(1, #mob) == mobs[4] or v.Name:sub(1, #mob) == mobs[5] then
                                for i, plrs in ipairs(game.Players:GetPlayers()) do
                                    if v.Name ~= plrs.Name then
                                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                            if v.Humanoid.Health > 0 then
                                                coroutine.wrap(function()
                                                    while wait(.2) do
                                                        if (plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude < 20 and v.Humanoid.Health > 0 then
                                                            plr.Backpack.ServerTraits.Input:FireServer({[1] = "md"},CFrame.new(0,0,0),nil,false)
                                                        end
                                                        if plr.Character.Humanoid.Health <= 0 then
                                                            break
                                                        end
                                                    end
                                                end){}
                                                coroutine.wrap(function()
                                                    repeat wait()
                                                        if plr.Character.Humanoid.Health <= 0 then
                                                            break
                                                        end
                                                        game.Workspace.CurrentCamera.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position,Vector3.new(v.HumanoidRootPart.Position.X,plr.Character.HumanoidRootPart.Position.Y,v.HumanoidRootPart.Position.Z)) * CFrame.new(0,2,10)
                                                    until(v.Humanoid.Health <= 0 or plr.Character.Humanoid.Health <= 0)
                                                end){}
                                                repeat
                                                    if (plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude <= 300 then
                                                        break
                                                    end
                                                    game:GetService("TweenService"):Create(plr.Character.HumanoidRootPart, TweenInfo.new((plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude/2500 , Enum.EasingStyle.Linear), {CFrame = CFrame.new(v.HumanoidRootPart.CFrame * Vector3.new(0, 0, 5))}):Play()
                                                    wait(1.2)
                                                until((plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude <= 200 or v.Humanoid.Health <= 0 or plr.Character.Humanoid.Health <= 0)
                                                repeat wait()
                                                    plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                                                until(v.Humanoid.Health <= 0 or plr.Character.Humanoid.Health <= 0)
                                            end
                                        else
                                            print("no more mobs")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end){}
    end)
    coroutine.wrap(function()
        while wait() do
            if _G.ShouldISetNil then
                autofarm:Set(nil)
            end
        end
    end){}

    Moves:Textbox("Move1", false, function(Move1)
        _G.Move1 = Move1
        return(_G.Move1)
    end)
    Moves:Textbox("Move2", false, function(Move2)
        _G.Move2 = Move2
        return(_G.Move2)
    end)
    Moves:Textbox("Move3", false, function(Move3)
        _G.Move3 = Move3
        return(_G.Move3)
    end)
    Moves:Textbox("Move4", false, function(Move4)
        _G.Move4 = Move4
        return(_G.Move4)
    end)
    Moves:Textbox("Move5", false, function(Move5)
        _G.Move5 = Move5
        return(_G.Move5)
    end)
    Moves:Textbox("Move6", false, function(Move6)
        _G.Move6 = Move6
        return(_G.Move6)
    end)
    Moves:Textbox("Move7", false, function(Move7)
        _G.Move7 = Move7
        return(_G.Move7)
    end)
    Moves:Textbox("Move8", false, function(Move8)
        _G.Move8 = Move8
        return(_G.Move8)
    end)
    Moves:Textbox("Move9", false, function(Move9)
        _G.Move9 = Move9
        return(_G.Move9)
    end)

    Moves:Toggle("Spam Moves", nil, "Spam Moves", function(MoveSpam)
        _G.MoveSpam = MoveSpam
        run.Stepped:connect(function()
            if _G.MoveSpam then
                for i, v in ipairs(plr.Backpack:GetChildren()) do
                    if v.Name == _G.Move1 or v.Name == _G.Move2 or v.Name == _G.Move3 or v.Name == _G.Move4 or v.Name == _G.Move5 or v.Name == _G.Move6 or v.Name == _G.Move7 or v.Name == _G.Move8 or v.Name == _G.Move9 then
                        v.Parent = plr.Character
                        wait(.1)
                        v:Activate()
                        v:Deactivate()
                        wait(.1)
                        v.Parent = plr.Backpack
                        plr.Backpack.ServerTraits.EatSenzu:FireServer("")
                    end
                end
            else
                _G.MoveSpam = false
            end
        end)
    end)
    Moves:Toggle("Melee Spam", nil, "Melee Spam", function(MeleeSpam)
        _G.MeleeSpam = MeleeSpam
        run.Stepped:connect(function()
            if _G.MeleeSpam then
                for i, v in ipairs(plr.Backpack:GetChildren()) do
                    if v.Name == "Meteor Crash" or v.Name == "Anger Rush" or v.Name == "Kick Barrage" or v.Name == "Deadly Dance" or v.Name == "Flash Strike" or v.Name == "God Slicer" or v.Name == "TS Molotov" or v.Name == "Wolf Fang Fist" or v.Name == "Neo Wolf Fand Fist" then
                        v.Parent = plr.Character
                        wait(.1)
                        v:Activate()
                        v:Deactivate()
                        wait(.1)
                        v.Parent = plr.Backpack
                        plr.Backpack.ServerTraits.EatSenzu:FireServer("")
                    end
                end
            else
                _G.MeleeSpam = false
            end
        end)
    end)
    Moves:Toggle("KiTracker Spam", nil, "KiTracker Spam", function(kitrackspam)
        _G.kitrackspam = kitrackspam
        run.Stepped:connect(function()
            if _G.kitrackspam then
                for i, v in ipairs(plr.Backpack:GetChildren()) do
                    if v.Name == "Chain Destructo Disk" or v.Name == "Super Volley" or v.Name == "Sudden Storm" or v.Name == "Justice Flash" or v.Name == "Finish Breaker" or v.Name == "Pressure Gauge" or v.Name == "Explosive Grip" or v.Name == "Unrelenting Volley" or v.Name == "Hellzone Grenade" or v.Name == "Death Saucer" or v.Name == "Blaster Meteor" or v.Name == "Divine Lasso" or v.Name == "Genocide Shell" or v.Name == "Crusher Ball" then
                        v.Parent = plr.Character
                        wait(.1)
                        v:Activate()
                        v:Deactivate()
                        wait(.1)
                        v.Parent = plr.Backpack
                        plr.Backpack.ServerTraits.EatSenzu:FireServer("")
                    end
                end
            else
                _G.kitrackspam = false
            end
        end)
    end)

    if game.PlaceId == 536102540 then
        Autoearth:Button("Bulma To Spaceship Quest", function()
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Bulma"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "Yes"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.7)
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Spaceship"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "No"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
        end)
        Autoearth:Button("Namek Spaceship Quest", function()
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Quest Giver"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "Yes"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.7)
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["NamekianShip"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "No"})
        end)
        Autoearth:Button("Trunks Future Time Machine Quest", function()
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Trunks [Future]"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "Yes"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.7)
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["TimeMachine"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "No"})
        end)
        Autoearth:Button("Korin", function()
            plr.Backpack.ServerTraits.ChatStart:FireServer(game:GetService("Workspace").FriendlyNPCs["Korin"].Chat.Chat)
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "DRINK"})
        end)
        Autoearth:Button("Elder Kai", function()
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Elder Kai"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "Yes"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
        end)
        Autoearth:Button("Suit Case Man", function()
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Young Man"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "Yes"})
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
            wait(.7)
            plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Suitcase"])
            wait(.5)
            plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
        end)
        Autoearth:Button("Do All", function()
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/Katsu-Toshiro/Katsu-Toshiro_Scripts/main/AutoEarth.lua'),true))()
        end)
    end
else
    local noauto = Autofarm:Section("No Autofarm in queue ;D")
    noauto:Label("No Autofarm in queue :p")
end
local Buy = Lib:Tab("Buy")
local BeanJar = Buy:Section("Beans/jars")
local Elderkai = Buy:Section("Elder Kai")
local PresForms = Buy:Section("Pres Forms")

if game.PlaceId == 536102540 then
    BeanJar:Dropdown("Beans or Jras", {"Beans", "Jars"}, "", "Beans/Jars", function(Jarbean)
        _G.JarBean = Jarbean
        return(_G.JarBean)
    end)
    BeanJar:Dropdown("Number", {"8", "80"}, "", "Number", function(Numberbean)
        _G.NumberBean = Numberbean
        return(_G.NumberBean)
    end)
    BeanJar:Dropdown("Color", {"Red", "Yellow", "Green", "Blue"}, "", "Color", function(Colorbean)
        _G.ColorBean = Colorbean
        return(_G.ColorBean)
    end)
    BeanJar:Toggle("Buy", nil, "Buy", function(Buybean)
        _G.Buying = Buybean
        coroutine.wrap(function()
            if _G.Buying then
                while wait() do
                    if not _G.Buying then
                        break
                    end
                    if _G.JarBean == "Jars" then
                        if _G.NumberBean == "8" then
                            notif("You cannot buy 8 Jars, you need to buy 80", "SnakeWorl is retarted it's not my fault", 15)
                            break
                        end
                    end
                    plr.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs:FindFirstChild("Korin BEANS"))
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = _G.JarBean})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = _G.NumberBean})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = _G.ColorBean})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "Yes"})
                    wait(.3)
                    plr.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                end
            end
        end){}
    end)

    Elderkai:Toggle("Elder Kai", nil, "ElderKai", function(Eld)
        _G.Elder = Eld
        coroutine.wrap(function()
            while wait() do
                if not _G.Elder then
                    break
                end
                if _G.Elder then
                    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs:FindFirstChild("Elder Kai"))
                    wait(.3)
                    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "Yes"})
                    wait(.3)
                    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({[1] = "k"})
                    wait(.3)
                elseif not _G.Elder then
                    _G.Elder = false
                end
            end
        end){}
    end)
else
    BeanJar:Label("No buying jars outside of earth :p")
    Elderkai:Label("No Elder Kai outside of earth :p")
end

PresForms:Button("MSSJB, CSSJB, SSJBE (500K)", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Complete Super Saiyan Blue")
end)

PresForms:Button("SSJ4 (800K)", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("SSJ4")
end)

PresForms:Button("Coolor Form", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Cooler Form")
end)

PresForms:Button("Golden Cooler", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Golden Cooler")
end)

PresForms:Button("KKX100, Kaioken x 100", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("KaioKenx100")
end)

PresForms:Button("DH, Dark Human", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Dark Human")
end)

PresForms:Button("Despair", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Despair")
end)

PresForms:Button("Demon Namekian", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Demon Namekian")
end)

PresForms:Button("White Namekian", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("White Namek")
end)

PresForms:Button("Dark Majin", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Dark Majin")
end)

PresForms:Button("Unstable", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Unstable")
end)

PresForms:Button("MUI", function()
    game:GetService("ReplicatedStorage").AttemptBuy:InvokeServer("Mastered Ultra Instinct")
end)

local statcheck = Lib:Tab("Stat Checker")
local entername = statcheck:Section("Stats Checker")

local Health = entername:Slider("Health", 0, 10000000, 0, 1, "Health", function(Health)
    _G.Health = Health
    return(_G.Health)
end)
local Kimax = entername:Slider("Ki Max", 0, 10000000, 0, 1, "Ki Max", function(Kimax)
    _G.Kimax = Kimax
    return(_G.Kimax)
end)
local Melee = entername:Slider("Melee Damage", 0, 10000000, 0, 1, "Melee Damage", function(Melee)
    _G.Melee = Melee
    return(_G.Melee)
end)
local KiDamage = entername:Slider("Ki Damage", 0, 10000000, 0, 1, "Ki Damage", function(KiDamage)
    _G.KiDamage = KiDamage
    return(_G.KiDamage)
end)
local MeleeRes = entername:Slider("Melee Resistance", 0, 10000000, 0, 1, "Melee Resistance", function(MeleeRes)
    _G.MeleeRes = MeleeRes
    return(_G.MeleeRes)
end)
local KiRes = entername:Slider("Ki Resistance", 0, 10000000, 0, 1, "Ki Resistance", function(KiRes)
    _G.KiRes = KiRes
    return(_G.KiRes)
end)
local Speedstat = entername:Slider("Speed", 0, 10000000, 0, 1, "Speed", function()
    _G.Speed = Speed
    return(_G.Speed)
end)

entername:Textbox("Player Name", false, function(name)
    if string.len(name) > 1 then
        local plrname = GetPlayer(name)
        for idk, target in pairs(game.Players:GetChildren()) do
            if target == plrname then
                if game.Workspace.Live:FindFirstChild(target.Name) then
                    if target.Character:FindFirstChild("Stats") then
                        Health:Set(tonumber(target.Character.Stats["Health-Max"].Value))
                        Kimax:Set(tonumber(target.Character.Stats["Ki-Max"].Value))
                        Melee:Set(tonumber(target.Character.Stats["Phys-Damage"].Value))
                        KiDamage:Set(tonumber(target.Character.Stats["Ki-Damage"].Value))
                        MeleeRes:Set(tonumber(target.Character.Stats["Phys-Resist"].Value))
                        KiRes:Set(tonumber(target.Character.Stats["Ki-Resist"].Value))
                        Speedstat:Set(tonumber(target.Character.Stats.Speed.Value))
                    end
                end
            end
        end
    end
end)

local autostats = Lib:Tab("Auto Stats")
local autostat = autostats:Section("Auto Stats")

autostat:Toggle("Health Max", nil, "Health Max", function(hmax)
    _G.hmax = hmax
    coroutine.wrap(function()
        while wait() do
            if _G.hmax then
                plr.Backpack.ServerTraits.AttemptUpgrade:FireServer(plr.PlayerGui.HUD.Bottom.Stats["Health-Max"])
            else
                _G.hmax = false
            end
        end
    end){}
end)
autostat:Toggle("KiMax", nil, "KiMax", function(KiMax)
    _G.KiMax = KiMax
    coroutine.wrap(function()
        while wait() do
            if _G.KiMax then
                plr.Backpack.ServerTraits.AttemptUpgrade:FireServer(plr.PlayerGui.HUD.Bottom.Stats["Ki-Max"])
            else
                _G.KiMax = false
            end
        end
    end){}
end)
autostat:Toggle("Melee Damage", nil, "Melee Damage", function(meleedmg)
    _G.meleedmg = meleedmg
    coroutine.wrap(function()
        while wait() do
            if _G.meleedmg then
                plr.Backpack.ServerTraits.AttemptUpgrade:FireServer(plr.PlayerGui.HUD.Bottom.Stats["Phys-Damage"])
            else
                _G.meleedmg = false
            end
        end
    end){}
end)
autostat:Toggle("Ki Damage", nil, "Ki Damage", function(kidmg)
    _G.kidmg = kidmg
    coroutine.wrap(function()
        while wait() do
            if _G.kidmg then
                plr.Backpack.ServerTraits.AttemptUpgrade:FireServer(plr.PlayerGui.HUD.Bottom.Stats["Ki-Damage"])
            else
                _G.kidmg = false
            end
        end
    end){}
end)
autostat:Toggle("Melee Resistance", nil, "MeleeRes", function(meleeres)
    _G.meleeres = meleeres
    coroutine.wrap(function()
        while wait() do
            if _G.meleeres then
                plr.Backpack.ServerTraits.AttemptUpgrade:FireServer(plr.PlayerGui.HUD.Bottom.Stats["Phys-Resist"])
            else
                _G.meleeres = false
            end
        end
    end){}
end)
autostat:Toggle("Ki Resistance", nil, "Ki Resistance", function(kires)
    _G.kires = kires
    coroutine.wrap(function()
        while wait() do
            if _G.kires then
                plr.Backpack.ServerTraits.AttemptUpgrade:FireServer(plr.PlayerGui.HUD.Bottom.Stats["Ki-Resist"])
            else
                _G.kires = false
            end
        end
    end){}
end)
autostat:Toggle("Speed", nil, "Speed", function(statspeed)
    _G.statspeed = statspeed
    coroutine.wrap(function()
        while wait() do
            if _G.statspeed then
                plr.Backpack.ServerTraits.AttemptUpgrade:FireServer(plr.PlayerGui.HUD.Bottom.Stats["Speed"])
            else
                _G.statspeed = false
            end
        end
    end){}
end)

local Credits = Lib:Tab("Credits + Settings")
local CreditSection = Credits:Section("Credits")
local Settings = Credits:Section("Settings")

CreditSection:Label("This hub was made by Lost#4000.")
CreditSection:Label("Promoted by Newcyga#4000.")
CreditSection:Label("Insomnia did some annoying sections.")
CreditSection:Button("Join Lost's discord server by cliking on this", function()
    -- all the credit to infinite yield hub again
    if toClipboard then
		toClipboard('https://discord.com/invite/dYHag43eeU')
    end
    local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    if httprequest then
		httprequest({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = HttpService:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = HttpService:GenerateGUID(false),
				args = {code = 'uC9rA8UXV5'}
			})
		})
	end
    --
end)
Settings:Button("Destroy UI", function()
    if game.CoreGui:FindFirstChild("Lynx Hub") then
        kill(game.CoreGui, "Lynx Hub")
    end
end)
Settings:Button("Kill Roblox", function()
    game:Shutdown()
end)
Settings:Button("Crash Roblox", function()
    while true do end
end)
local keeplh = Settings:Toggle("Keep Lynx", true, "Keep Lynx", function(keeplynx)
    _G.keeplynx = keeplynx
end)
coroutine.wrap(function()
    if (writefile) then
        if isfile(keeplynxhub) then
            json = HttpService:JSONDecode(readfile(keeplynxhub))
            if _G.keeplynx ~= json then
                keeplh:Set(json)
            end
            while wait() do
                if json ~= _G.keeplynx then
                    json = HttpService:JSONEncode(_G.keeplynx)
                    writefile(keeplynxhub, json)
                end
            end
        else
            json = HttpService:JSONEncode(_G.keeplynx)
            writefile(keeplynxhub, json)
        end
    else
        plr:kick("Your executor cannot support this hub sorry.")
    end
end){}
-- credits to iy for this variable
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
plr.OnTeleport:connect(function(tpstate)
    if tpstate == Enum.TeleportState.Started then
        if _G.keeplynx and queueteleport then
            queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ItzLost/Lost-Scripts/main/Lost-Commands.lua'))()") -- I'll change that when the hub is finished
        end
    end
end)

SolarisLib:Notification("Lynx Hub loaded!", "Enjoy this little hub")
