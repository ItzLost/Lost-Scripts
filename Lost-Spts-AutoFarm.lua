if AutoFarmLost1687Loaded then
    wait(9e9)
end
getgenv().AutoFarmLost1687Loaded = true
math.randomseed(os.time())

-- file shit
coroutine.wrap(function()
    if not writefile then
        repeat wait() until(game:IsLoaded())
        repeat wait() until(game.Players.LocalPlayer)
        game.Players.LocalPlayer:Kick("Executor cannot support this script.")
    else
        repeat wait() until(game:IsLoaded())
        local HttpService = game:GetService("HttpService")
        if isfile(filename) then
            json = HttpService:JSONDecode(readfile(filename))
            if json ~= _G.LostAutofarmSettings then
                _G.LostAutofarmSettings = json
            end
        else
            json = HttpService:JSONEncode(_G.LostAutofarmSettings)
            writefile(filename, json)
	    end
    end
end){}

local PsyPlaces = {
    [1] = CFrame.new(-2558, 5416, -507), -- Flying Island 1M
    [2] = CFrame.new(-2582, 5516, -505), -- Flying Island 1B
    [3] = CFrame.new(-2563, 5501, -434), -- Flying Island Bridge 1T
    [4] = CFrame.new(-2532, 5486, -528), -- Flying Island Waterfall 1Qa
}
local PsyAmountNeeded = {
    [1] = 1e15, -- 1Qa
    [2] = 1e12, -- 1T
    [3] = 1e9, -- 1B
    [4] = 1e6, -- 1M
}
local BTPlaces = {
    [1] = CFrame.new(-279, 279, 1007), -- Red Pool 500B
    [2] = CFrame.new(-271, 280, 991), -- Green Pool 5B
    [3] = CFrame.new(-254, 287, 980), -- HellFire 50M
    [4] = CFrame.new(-2015, 714, -1934), -- Volcano 500k
    [5] = CFrame.new(-2301, 977, 1070),-- Tornado 50k
    [6] = CFrame.new(1638, 259, 2248), -- Iceberg 5k
    [7] = CFrame.new(357, 264, -495), -- Fire Pit 500
    [8] = CFrame.new(368, 250, -445), -- Ice Pool 5
}
local BTAmountNeeded = {
    [1] = 500e9, -- 500B
    [2] = 5e9, -- 5B
    [3] = 50e6, -- 50M
    [4] = 500e3, -- 500k
    [5] = 50e3, -- 50k
    [6] = 5e3, -- 5k
    [7] = 500,
    [8] = 5,
}
local FSPlaces = {
    [1] = CFrame.new(433, 249, 991),
    [2] = CFrame.new(-2276, 1943, 1050),
    [3] = CFrame.new(1177, 4789, -2294),
    [4] = CFrame.new(1380, 9274, 1647),
    [5] = CFrame.new(-352, 15725, 16),
}
local FSAmountNeeded = {
    [1] = 10e12, -- 10T
    [2] = 100e6, -- 100B
    [3] = 1e6, -- 1B
    [4] = 1e6, -- 1M
    [5] = 100,
}

if _G.LostAutofarmSettings.Farming == "Body Toughness" then
    _G.stathelloidk = "BodyToughness"
elseif _G.LostAutofarmSettings.Farming == "Psychic Power" then
    _G.stathelloidk = "PsychicPower"
elseif _G.LostAutofarmSettings.Farming == "Fist Strength" then
    _G.stathelloidk = "FistStrength"
end

local function kill(path, object)
    for i, v in ipairs(path:GetChildren()) do
        if v.Name == object then
            v:Destroy()
            return true
        end
    end
end

local function round(num)
	return(math.floor(num * 10^3 + .5)/10^3)
end

local function ConvertToLetter(number)
    local newnum
	if number/1e18 >= 1 then
		newnum = number/1e18
		return(round(newnum).."Qi")
    end
	if number/1e15 >= 1 then
		newnum = number/1e15
		return(round(newnum).."Qa")
    end
	if number/1e12 >= 1 then
		newnum = number/1e12
		return(round(newnum).."T")
    end
	if number/1e9 >= 1 then
		newnum = number/1e09
		return(round(newnum).."B")
    end
	if number/1e6 >= 1 then
		newnum = number/1e06
		return(round(newnum).."M")
    end
	if number/1e3 >= 1 then
		newnum = number/1e03
		return(round(newnum).."K")
    end
	return(round(number))
end

local function RandomName()
	local res = ""
	for i = 1, 15 do
		local case = math.random(1,3)
		if case == 1 then
			res = res..string.char(math.random(97, 122))
		else
			res = res..string.upper(string.char(math.random(97, 122)))
		end
	end
	return res
end

coroutine.wrap(function()
    local function DisplayTime(time)
        local days = math.floor(time / 86400)
        local remaining = time % 86400
        local hours = math.floor(remaining / 3600)
        remaining = remaining % 3600
        local minutes = math.floor(remaining / 60)
        remaining = remaining % 60
        local seconds = remaining
        local answer = tostring(days).." Days "..hours.." Hours "..minutes.." Minutes "..seconds.." Seconds"
        return answer
    end
    rconsoleclear()
    if identifyexecutor() == "ScriptWare" then
        rconsolename("Lost AutoFarm")
        rconsoleprint([[
                                    __               __    __ __  __ __  ____  ____  ____ 
                                   / /   ____  _____/ /___/ // /_/ // / / __ \/ __ \/ __ \
                                  / /   / __ \/ ___/ __/_  _  __/ // /_/ / / / / / / / / /
                                 / /___/ /_/ (__  ) /_/_  _  __/__  __/ /_/ / /_/ / /_/ / 
                                /_____/\____/____/\__/ /_//_/    /_/  \____/\____/\____/  
    
        ]], "blue")
    else
        rconsolename("Lost AutoFarm")
        rconsoleprint("@@BLUE@@")
        rconsoleprint[[
                                    __               __    __ __  __ __  ____  ____  ____ 
                                   / /   ____  _____/ /___/ // /_/ // / / __ \/ __ \/ __ \
                                  / /   / __ \/ ___/ __/_  _  __/ // /_/ / / / / / / / / /
                                 / /___/ /_/ (__  ) /_/_  _  __/__  __/ /_/ / /_/ / /_/ / 
                                /_____/\____/____/\__/ /_//_/    /_/  \____/\____/\____/  
    
        ]]
        rconsoleprint("@@YELLOW@@")
    end
    rconsoleprint("\n".."\n".."\n".."\n")
    if not game:IsLoaded() then
        rconsoleprint("\n".."Game is loading...", "yellow")
        repeat wait() until(game:IsLoaded())
        rconsoleprint("\n".."Game loaded.", "yellow")
    else
        rconsoleprint("\n".."Game loaded.", "yellow")
    end
    rconsoleprint("\n".."Disabling 3D Render ( Reduces cpu usage ).", "yellow")
    game.RunService:Set3dRenderingEnabled(false)
    rconsoleprint("\n".."3D Render Disabled.", "yellow")
    if not game.Players.LocalPlayer.Character then
        rconsoleprint("\n".."Loading character...", "yellow")
        repeat wait() until(game.Players.LocalPlayer.Character)
        rconsoleprint("\n".."Character loaded.", "yellow")
    else
        rconsoleprint("\n".."Character loaded.", "yellow")
    end
    local oldidkyeah = game.Players.LocalPlayer.PrivateStats[_G.stathelloidk].Value
    local idktime = 0
    while wait(1) do
        idktime = idktime + 1
        rconsoleclear()
        if identifyexecutor() == "ScriptWare" then
            rconsolename("Lost AutoFarm")
            rconsoleprint([[
                                        __               __    __ __  __ __  ____  ____  ____ 
                                       / /   ____  _____/ /___/ // /_/ // / / __ \/ __ \/ __ \
                                      / /   / __ \/ ___/ __/_  _  __/ // /_/ / / / / / / / / /
                                     / /___/ /_/ (__  ) /_/_  _  __/__  __/ /_/ / /_/ / /_/ / 
                                    /_____/\____/____/\__/ /_//_/    /_/  \____/\____/\____/  
        
            ]], "blue")
        else
            rconsolename("Lost AutoFarm")
            rconsoleprint("@@BLUE@@")
            rconsoleprint[[
                                        __               __    __ __  __ __  ____  ____  ____ 
                                       / /   ____  _____/ /___/ // /_/ // / / __ \/ __ \/ __ \
                                      / /   / __ \/ ___/ __/_  _  __/ // /_/ / / / / / / / / /
                                     / /___/ /_/ (__  ) /_/_  _  __/__  __/ /_/ / /_/ / /_/ / 
                                    /_____/\____/____/\__/ /_//_/    /_/  \____/\____/\____/  
        
            ]]
        end
        if identifyexecutor() ~= "ScriptWare" then
            rconsoleprint("@@RED@@")
        end
        rconsoleprint("\n".."Working on ".._G.LostAutofarmSettings.Farming..".", "red")
        if _G.LostAutofarmSettings.Invis then
            rconsoleprint("\n".."You are invisible.", "red")
        else
            rconsoleprint("\n".."You are not invisible.", "red")
        end
        rconsoleprint("\n".."Old ".._G.LostAutofarmSettings.Farming.." Stat = "..ConvertToLetter(oldidkyeah), "red")
        rconsoleprint("\n".."Time Elapsed : "..DisplayTime(idktime), "red")
    end
end){}
repeat wait() until(game:IsLoaded())
coroutine.wrap(function()
    repeat wait() until(game:FindFirstChild("CoreGui"))
    for i = 1, math.random(2, 30) do
        local ScreenGui_2 = Instance.new("ScreenGui")
        local Frame_3 = Instance.new("Frame")
        ScreenGui_2.Name = RandomName()
        ScreenGui_2.Parent = game.CoreGui
        ScreenGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        Frame_3.Name = RandomName()
        Frame_3.Parent = ScreenGui_2
        Frame_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Frame_3.BorderSizePixel = 0
        Frame_3.Position = UDim2.new(-0.00325203245, 0, 0, 0)
        Frame_3.Size = UDim2.new(0, math.random(1000000, 9000000), 0, math.random(1000000, 9000000))
    end
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("ImageLabel")
    local TextLabel_Roundify_10px = Instance.new("ImageLabel")
    local Frame_2 = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    local TextLabel_2 = Instance.new("TextLabel")
    local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
    ScreenGui.Name = RandomName()
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Frame.Name = RandomName()
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1.000
    Frame.Position = UDim2.new(0.300271004, 0, 0.167012453, 0)
    Frame.Size = UDim2.new(0.439024389, 0, 0.563278019, 0)
    Frame.Image = "rbxassetid://3570695787"
    Frame.ImageColor3 = Color3.fromRGB(55, 105, 255)
    Frame.ScaleType = Enum.ScaleType.Slice
    Frame.SliceCenter = Rect.new(100, 100, 100, 100)
    Frame.SliceScale = 0.100
    TextLabel_Roundify_10px.Name = RandomName()
    TextLabel_Roundify_10px.Parent = Frame
    TextLabel_Roundify_10px.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel_Roundify_10px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_Roundify_10px.BackgroundTransparency = 1.000
    TextLabel_Roundify_10px.Position = UDim2.new(0.5, 0, 0.116022103, 0)
    TextLabel_Roundify_10px.Size = UDim2.new(1, 0, 0.232044205, 0)
    TextLabel_Roundify_10px.Image = "rbxassetid://3570695787"
    TextLabel_Roundify_10px.ImageColor3 = Color3.fromRGB(109, 0, 255)
    TextLabel_Roundify_10px.ScaleType = Enum.ScaleType.Slice
    TextLabel_Roundify_10px.SliceCenter = Rect.new(100, 100, 100, 100)
    TextLabel_Roundify_10px.SliceScale = 0.100
    Frame_2.Name = RandomName()
    Frame_2.Parent = TextLabel_Roundify_10px
    Frame_2.BackgroundColor3 = Color3.fromRGB(109, 0, 255)
    Frame_2.BorderSizePixel = 0
    Frame_2.Size = UDim2.new(1, 0, 0.857142866, 0)
    TextLabel.Name = RandomName()
    TextLabel.Parent = Frame_2
    TextLabel.BackgroundColor3 = Color3.fromRGB(109, 0, 255)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0, 0, 0, 15)
    TextLabel.Size = UDim2.new(1, 0, 0.861111104, 0)
    TextLabel.Font = Enum.Font.RobotoMono
    TextLabel.Text = "Lost AutoFarm"
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 100.000
    TextLabel.TextWrapped = true
    UITextSizeConstraint.Name = RandomName()
    UITextSizeConstraint.Parent = TextLabel
    TextLabel_2.Name = RandomName()
    TextLabel_2.Parent = Frame
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.BackgroundTransparency = 1.000
    TextLabel_2.Position = UDim2.new(0, 32, 0, 200)
    TextLabel_2.Size = UDim2.new(0.904938281, 0, 0.44383058, 0)
    TextLabel_2.Font = Enum.Font.RobotoMono
    TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_2.TextScaled = true
    TextLabel_2.TextSize = 100.000
    TextLabel_2.TextWrapped = true
    UITextSizeConstraint_2.Name = RandomName()
    UITextSizeConstraint_2.Parent = TextLabel_2
    game.RunService.Stepped:connect(function()
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        print("♠ Made By Lost#4000 ♠")
        warn("♠ ez AutoFarm ♠")
        game.workspace.CurrentCamera.CameraType = "Scriptable"
        game:GetService("TweenService"):Create(game.workspace.CurrentCamera, TweenInfo.new(0, Enum.EasingStyle.Linear), {CFrame = CFrame.new(math.random(1000000, 9000000), math.random(1000000, 9000000), math.random(1000000, 9000000))}):Play()
        TextLabel_2.Text = _G.LostAutofarmSettings.Farming.." : "..ConvertToLetter(game.Players.LocalPlayer.PrivateStats[_G.stathelloidk].Value)
    end)
    error("♠ There is no error in my script ;| ♠")
end){}
repeat wait() until(game.Players.LocalPlayer)
local plr = game.Players.LocalPlayer
repeat wait() until(plr.PlayerGui:FindFirstChild("IntroGui"))
if plr.PlayerGui.IntroGui.Enabled then
    repeat
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "Respawn"})
        plr.PlayerGui.IntroGui.Enabled = false
        wait(1)
    until(game.Players.LocalPlayer.Character)
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "ConcealRevealAura"})
else
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "ConcealRevealAura"})
end
repeat wait() until(plr.Character)
function Invisible()
    if _G.LostAutofarmSettings.Invis then
        if plr.Character:FindFirstChild("LeftLowerLeg") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(1000000, 9000000), math.random(1000000, 9000000), math.random(1000000, 9000000))
            wait(.1)
            if plr.Character:FindFirstChild("Head") then
                plr.Character.Head.Anchored = true
            end
            kill(plr.Character.HumanoidRootPart, "SPTS_PN_BG")
            kill(plr.Character.HumanoidRootPart, "SPTS_RK_BG")
            kill(plr.Character, "RightLowerLeg")
            kill(plr.Character, "LeftLowerLeg")
            kill(plr.Character, "RightFoot")
            kill(plr.Character, "LeftFoot")
            kill(plr.Character, "LowerTorso")
            kill(plr.Character, "RightUpperLeg")
            kill(plr.Character, "LeftUpperLeg")
            return(true)
        end
    end
    return(false)
end
Invisible()

game.RunService.Stepped:connect(function()
    plr.PlayerGui.IntroGui.Enabled = false
    local BTStat = tonumber(plr.PrivateStats.BodyToughness.Value)
    local PSYStat = tonumber(plr.PrivateStats.PsychicPower.Value)
    local FSStat = tonumber(plr.PrivateStats.FistStrength.Value)
    if plr.Character then
        if plr.Character:FindFirstChild("HumanoidRootPart") then
            if _G.LostAutofarmSettings.Farming == "Psychic Power" then
                for i, v in ipairs(PsyAmountNeeded) do
                    if plr.Character:FindFirstChild("Humanoid") then
                        if plr.Character.Humanoid.Health <= 0 then
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "Respawn"})
                            if not Invisible() then
                                wait(1)
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "ConcealRevealAura"})
                            end
                        end
                    end
                    if PSYStat >= v then
                        if plr.Backpack:FindFirstChild("Meditate") then
                            plr.Character.Humanoid:EquipTool(plr.Backpack.Meditate)
                        end
                        plr.Character.HumanoidRootPart.CFrame = PsyPlaces[i]
                        break
                    end
                end
            elseif _G.LostAutofarmSettings.Farming == "Body Toughness" then
                for i, v in ipairs(BTAmountNeeded) do
                    if plr.Character:FindFirstChild("Humanoid") then
                        if plr.Character.Humanoid.Health < 50 then
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "Respawn"})
                        end
                    end
                    if BTStat >= v then
                        Invisible()
                        plr.Character.HumanoidRootPart.CFrame = BTPlaces[i]
                        break
                    end
                end
            elseif _G.LostAutofarmSettings.Farming == "Fist Strength" then
                for i, v in ipairs(FSAmountNeeded) do
                    if plr.Character:FindFirstChild("Humanoid") then
                        if plr.Character.Humanoid.Health <= 0 then
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "Respawn"})
                            if not Invisible() then
                                wait(1)
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "ConcealRevealAura"})
                            end
                        end
                    end
                    if FSStat >= v then
                        Invisible()
                        plr.Character.HumanoidRootPart.CFrame = FSPlaces[i]
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "Add_FS_Request",[2] = (i + 1)})
                        break
                    end
                end
            end
        end
    end
end)

local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ItzLost/Lost-Scripts/main/Lost-Spts-AutoFarm.lua'))()")
