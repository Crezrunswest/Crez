

local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
local Notify = AkaliNotif.Notify;

if getgenv().CrezWareloaded == true then
    if getgenv().CrezWare.Options.Notifications == true then

Notify({
Description = "Settings From Script Updated.";
Title = "CrezWare";
Duration = 1.5;
});
        return
    end
    end
    getgenv().CrezWareloaded = true
    
    if getgenv().CrezWare.Options.Notifications == true then

Notify({
Description = "Script Loading...";
Title = "CrezWare";
Duration = 1.5;
});
wait(2)
Notify({
Description = "Script Loaded Enjoy!";
Title = "CrezWare";
Duration = 1.5;
});
end
wait(1)
local targ = nil
local Plr  = nil

local Players, Client, Mouse, RS, Camera =
    game:GetService("Players"),
    game:GetService("Players").LocalPlayer,
    game:GetService("Players").LocalPlayer:GetMouse(),
    game:GetService("RunService"),
    game:GetService("Workspace").CurrentCamera

local silentcircle = Drawing.new("Circle")

local tracercircle = Drawing.new("Circle")

silentcircle.Transparency = getgenv().CrezWare.Fov.Silent.Transparency
silentcircle.Thickness = getgenv().CrezWare.Fov.Silent.Thickness
silentcircle.Color = getgenv().CrezWare.Fov.Silent.Color
silentcircle.Filled = getgenv().CrezWare.Fov.Silent.Filled

tracercircle.Transparency = getgenv().CrezWare.Fov.Camlock.Transparency
tracercircle.Thickness = getgenv().CrezWare.Fov.Camlock.Thickness
tracercircle.Color = getgenv().CrezWare.Fov.Camlock.Color
tracercircle.Filled = getgenv().CrezWare.Fov.Camlock.Filled

local UpdateFOV = function ()
    if (not silentcircle and not tracercircle) then
        return silentcircle and tracercircle
    end
    tracercircle.Visible  = getgenv().CrezWare.Fov.Camlock.Visible
    tracercircle.Radius   = getgenv().CrezWare.Fov.Camlock.Size * 2
    tracercircle.Filled = getgenv().CrezWare.Fov.Camlock.Filled
    tracercircle.Thickness = getgenv().CrezWare.Fov.Camlock.Thickness
    tracercircle.Transparency = getgenv().CrezWare.Fov.Camlock.Transparency
    tracercircle.Position = Vector2.new(Mouse.X, Mouse.Y + (game:GetService("GuiService"):GetGuiInset().Y))
    tracercircle.Color = getgenv().CrezWare.Fov.Camlock.Color
    tracercircle.NumSides = getgenv().CrezWare.Fov.Camlock.Sides
    
    silentcircle.Visible  = getgenv().CrezWare.Fov.Silent.Visible
    silentcircle.Radius   = getgenv().CrezWare.Fov.Silent.Size * 2
    silentcircle.Filled = getgenv().CrezWare.Fov.Silent.Filled
    silentcircle.Thickness = getgenv().CrezWare.Fov.Silent.Thickness
    silentcircle.Transparency = getgenv().CrezWare.Fov.Silent.Transparency
    silentcircle.Position = Vector2.new(Mouse.X, Mouse.Y + (game:GetService("GuiService"):GetGuiInset().Y))
    silentcircle.Color = getgenv().CrezWare.Fov.Silent.Color
    silentcircle.NumSides = getgenv().CrezWare.Fov.Silent.Sides
    return silentcircle and tracercircle
end

RS.Heartbeat:Connect(UpdateFOV)

local WallCheck = function(destination, ignore)
    local Origin    = Camera.CFrame.p
    local CheckRay  = Ray.new(Origin, destination - Origin)
    local Hit       = game.workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
    return Hit      == nil
end


local WTS = function (Object)
    local ObjectVector = Camera:WorldToScreenPoint(Object.Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
end

local IsOnScreen = function (Object)
    local IsOnScreen = Camera:WorldToScreenPoint(Object.Position)
    return IsOnScreen
end

local FilterObjs = function (Object)
    if string.find(Object.Name, "Gun") then
        return
    end
    if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
        return true
    end
end

local ClosestPlrFromMouse = function()
    local Target, Closest = nil, 1/0
    
    for _ ,v in pairs(Players:GetPlayers()) do
    	if getgenv().CrezWare.Checks.Wall then
    		if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
    			local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
    			local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
    
    			if (silentcircle.Radius * 1.27 > Distance and Distance < Closest and OnScreen) and WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}) then
    				Closest = Distance
    				Target = v
    	

    			end
    		end
    	else
    		if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
    			local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
    			local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
    
    			if (silentcircle.Radius * 1.27 > Distance and Distance < Closest and OnScreen) then
    				Closest = Distance
    				Target = v
    			end
    		end
    	end
    end
    return Target
end

local ClosestPlrFromMouse2 = function()
    local Target, Closest = nil, tracercircle.Radius * 1.27
    
    for _ ,v in pairs(Players:GetPlayers()) do
    	if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
        	if getgenv().CrezWare.Checks.Wall then
        		local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
        		local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
        
        		if (Distance < Closest and OnScreen) and WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}) then
        			Closest = Distance
        			Target = v
        		end
        	    else
        			local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
        			local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
        
        			if (Distance < Closest and OnScreen) then
        				Closest = Distance
        				Target = v
        			end
        		end
            end
        end
    return Target
end

local GetClosestBodyPart = function (character)
    local ClosestDistance = 1/0
    local BodyPart = nil
    
    if (character and character:GetChildren()) then
        for _,  x in next, character:GetChildren() do
            if FilterObjs(x) and IsOnScreen(x) then
                local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if (silentcircle.Radius * 1.27 > Distance and Distance < ClosestDistance) then
                    ClosestDistance = Distance
                    BodyPart = x
                end
            end
        end
    end
    return BodyPart
end

local GetClosestBodyPartV2 = function (character)
    local ClosestDistance = 1/0
    local BodyPart = nil
    
    if (character and character:GetChildren()) then
        for _,  x in next, character:GetChildren() do
            if FilterObjs(x) and IsOnScreen(x) then
                local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if (Distance < ClosestDistance) then
                    ClosestDistance = Distance
                    BodyPart = x
                end
            end
        end
    end
    return BodyPart
end

Mouse.KeyDown:Connect(function(Key)
    local Keybind = getgenv().CrezWare.Camlock.Keybind:lower()
    if (Key == Keybind) then
        if getgenv().CrezWare.Camlock.Enabled == true then
            IsTargetting = not IsTargetting
            if IsTargetting then
                Plr = ClosestPlrFromMouse2()
            else
                if Plr ~= nil then
                    Plr = nil
                    IsTargetting = false
                end
            end
        end
    end
end)

Mouse.KeyDown:Connect(function(Key)
    local Keybind = getgenv().CrezWare.Silent.Keybind:lower()
    if (Key == Keybind) and getgenv().CrezWare.Silent.UseKeybind == true then
            if getgenv().CrezWare.Silent.Enabled == true then
				getgenv().CrezWare.Silent.Enabled = false
				if getgenv().CrezWare.Options.Notifications == true then
				    
local Notify = AkaliNotif.Notify;
				Notify({
Description = "Silent Disabled";
Title = "CrezWare";
Duration = 1.5;
});
end 
                
            else
				getgenv().CrezWare.Silent.Enabled = true
				if getgenv().CrezWare.Options.Notifications == true then
				    
local Notify = AkaliNotif.Notify;
				Notify({
Description = "Silent Enabled";
Title = "CrezWare";
Duration = 1.5;
});
end
                
            end
        end
    end
)






                            



local grmt = getrawmetatable(game)
local backupindex = grmt.__index
setreadonly(grmt, false)

grmt.__index = newcclosure(function(self, v)
    if (getgenv().CrezWare.Silent.Enabled and Mouse and tostring(v) == "Hit") then
        if targ and targ.Character then
    		if getgenv().CrezWare.Silent.Predict then
    			local endpoint = game.Players[tostring(targ)].Character[getgenv().CrezWare.Silent.Aimpart].CFrame + (
    				game.Players[tostring(targ)].Character[getgenv().CrezWare.Silent.Aimpart].Velocity * getgenv().CrezWare.Silent.Prediction
    			)
    			return (tostring(v) == "Hit" and endpoint)
    		else
    			local endpoint = game.Players[tostring(targ)].Character[getgenv().CrezWare.Silent.Aimpart].CFrame
    			return (tostring(v) == "Hit" and endpoint)
    		end
        end
    end
    return backupindex(self, v)
end)



RS.Heartbeat:Connect(function()
	if getgenv().CrezWare.Silent.Enabled then
	    if targ and targ.Character and targ.Character:WaitForChild(getgenv().CrezWare.Silent.Aimpart) then
            if getgenv().CrezWare.Resolver.Enabled == true and targ.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude > 70 then            
                pcall(function()
                    local TargetVel = targ.Character[getgenv().CrezWare.Silent.Aimpart]
                    TargetVel.Velocity = Vector3.new(0, 0, 0)
                    TargetVel.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            
                end)
            end
            if getgenv().CrezWare.Checks.AntiGroundShots == true and targ.Character:FindFirstChild("Humanoid") == Enum.HumanoidStateType.Freefall then
                pcall(function()
                    local TargetVelv5 = targ.Character[getgenv().CrezWare.Silent.Aimpart]
                    TargetVelv5.Velocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 5), TargetVelv5.Velocity.Z)
                    TargetVelv5.AssemblyLinearVelocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 5), TargetVelv5.Velocity.Z)
                end)
            end
            
            if getgenv().CrezWare.Resolver.Enabled == true then            
                pcall(function()
                    local TargetVelv2 = targ.Character[getgenv().CrezWare.Silent.Aimpart]
                    TargetVelv2.Velocity = Vector3.new(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                    TargetVelv2.AssemblyLinearVelocity = Vector3.new(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                end)
            end
	    end
	end
	



if getgenv().CrezWare.Custom.Shake == true then
       if Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
       
           getgenv().CrezWare.Camlock.ShakeValue = getgenv().CrezWare.Custom.AirShakeValue
       else
        getgenv().CrezWare.Camlock.ShakeValue  = getgenv().CrezWare.Custom.GroundShakeValue

  end
end

if getgenv().CrezWare.Custom.Smoothness == true then
       if Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
       
           getgenv().CrezWare.Camlock.SmoothnessValue = getgenv().CrezWare.Custom.AirSmoothnessValue
       else
        getgenv().CrezWare.Camlock.SmoothnessValue = getgenv().CrezWare.Custom.GroundSmoothnessValue
  end
end




    if getgenv().CrezWare.Camlock.Enabled == true then
        if getgenv().CrezWare.Resolver.Enabled == true and Plr and Plr.Character and Plr.Character:WaitForChild(getgenv().CrezWare.Camlock.Aimpart) and Plr.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude > 70 then
            pcall(function()
                local TargetVelv3 = Plr.Character[getgenv().CrezWare.Camlock.Aimpart]
                TargetVelv3.Velocity = Vector3.new(0, 0, 0)
                TargetVelv3.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
        end
        if getgenv().CrezWare.Checks.AntiGroundShots == true and Plr.Character:FindFirstChild("Humanoid") == Enum.HumanoidStateType.Freefall then
                pcall(function()
                    local TargetVelv5 = Plr.Character[getgenv().CrezWare.Camlock.Aimpart]
                    TargetVelv5.Velocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 5), TargetVelv5.Velocity.Z)
                    TargetVelv5.AssemblyLinearVelocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 5), TargetVelv5.Velocity.Z)
                end)
        end
    
        if getgenv().CrezWare.Resolver.Enabled == true and Plr and Plr.Character and Plr.Character:WaitForChild(getgenv().CrezWare.Camlock.Aimpart) then
            pcall(function()
                local TargetVelv4 = Plr.Character[getgenv().CrezWare.Camlock.Aimpart]
                TargetVelv4.Velocity = Vector3.new(TargetVelv4.Velocity.X, 0, TargetVelv4.Velocity.Z)
                TargetVelv4.AssemblyLinearVelocity = Vector3.new(TargetVelv4.Velocity.X, 0, TargetVelv4.Velocity.Z)
            end)
        end
    end
end)

RS.RenderStepped:Connect(function()
	if getgenv().CrezWare.Silent.Enabled then
        if getgenv().CrezWare.Checks.Knocked == true and targ and targ.Character then 
            local KOd = targ.Character:WaitForChild("BodyEffects")["K.O"].Value
            local Grabbed = targ.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
            if KOd or Grabbed then
                targ = nil
            end
        end
	end
    if getgenv().CrezWare.Camlock.Enabled == true then
        if getgenv().CrezWare.Checks.Knocked == true and Plr and Plr.Character then 
            local KOd = Plr.Character:WaitForChild("BodyEffects")["K.O"].Value
            local Grabbed = Plr.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
            if KOd or Grabbed then
                Plr = nil
                IsTargetting = false
            end
        end
        
		if getgenv().CrezWare.Checks.DisableOnDeath == true and Plr and Plr.Character:FindFirstChild("Humanoid") then
			if Plr.Character.Humanoid.health < 2 then
				Plr = nil
				IsTargetting = false
			end
		end
		if getgenv().CrezWare.Checks.DisableOnDeath == true and Plr and Plr.Character:FindFirstChild("Humanoid") then
			if Client.Character.Humanoid.health < 2 then
				Plr = nil
				IsTargetting = false
			end
		end
        if getgenv().CrezWare.Checks.DisableOutsideFov == true and Plr and Plr.Character and Plr.Character:WaitForChild("HumanoidRootPart") then
            if
            Camlock.Radius <
                (Vector2.new(
                    Camera:WorldToScreenPoint(Plr.Character.HumanoidRootPart.Position).X,
                    Camera:WorldToScreenPoint(Plr.Character.HumanoidRootPart.Position).Y
                ) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
             then
                Plr = nil
                IsTargetting = false
            end
        end
		if getgenv().CrezWare.Camlock.Predict and Plr and Plr.Character and Plr.Character:FindFirstChild(getgenv().CrezWare.Camlock.Aimpart) then
			if getgenv().CrezWare.Camlock.Shake then
				local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().CrezWare.Camlock.Aimpart].Position + Plr.Character[getgenv().CrezWare.Camlock.Aimpart].Velocity * getgenv().CrezWare.Camlock.Prediction +
				Vector3.new(
					math.random(-getgenv().CrezWare.Camlock.ShakeValue, getgenv().CrezWare.Camlock.ShakeValue),
					math.random(-getgenv().CrezWare.Camlock.ShakeValue, getgenv().CrezWare.Camlock.ShakeValue),
					math.random(-getgenv().CrezWare.Camlock.ShakeValue, getgenv().CrezWare.Camlock.ShakeValue)
				) * 0.1)
				Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().CrezWare.Camlock.SmoothnessValue / 2, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			else
    			local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().CrezWare.Camlock.Aimpart].Position + Plr.Character[getgenv().CrezWare.Camlock.Aimpart].Velocity * getgenv().CrezWare.Camlock.Prediction)
    			Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().CrezWare.Camlock.SmoothnessValue / 2, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			end
		elseif getgenv().CrezWare.Camlock.Predict == false and Plr and Plr.Character and Plr.Character:FindFirstChild(getgenv().CrezWare.Camlock.Aimpart) then
			if getgenv().CrezWare.Camlock.Shake then
				local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().CrezWare.Camlock.Aimpart].Position +
				Vector3.new(
					math.random(-getgenv().CrezWare.Camlock.ShakeValue, getgenv().CrezWare.Camlock.ShakeValue),
					math.random(-getgenv().CrezWare.Camlock.ShakeValue, getgenv().CrezWare.Camlock.ShakeValue),
					math.random(-getgenv().CrezWare.Camlock.ShakeValue, getgenv().CrezWare.Camlock.ShakeValue)
				) * 0.1)
				Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().CrezWare.Camlock.SmoothnessValue / 2, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		    else
    			local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().CrezWare.Camlock.Aimpart].Position)
    			Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().CrezWare.Camlock.SmoothnessValue / 2, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		    end
		end
	end
end)

task.spawn(function ()
    while task.wait() do
    	if getgenv().CrezWare.Silent.Enabled then
            targ = ClosestPlrFromMouse()
    	end
        if Plr then
            if getgenv().CrezWare.Camlock.Enabled and (Plr.Character) and getgenv().CrezWare.Camlock.NearestCursorAimpart then
                getgenv().CrezWare.Camlock.Aimpart = tostring(GetClosestBodyPartV2(Plr.Character))
            end
        end
        if targ then
            if getgenv().CrezWare.Silent.Enabled and (targ.Character) and getgenv().CrezWare.Silent.NearestCursorAimpart then
                getgenv().CrezWare.Silent.Aimpart = tostring(GetClosestBodyPart(targ.Character))
            end
        end
    end
end)

getgenv().uhpoop = {
    ["Enabled"] = (getgenv().CrezWare.GunFov.Enabled),
    ["Double-Barrel SG"] = {["FOV"] = (getgenv().CrezWare.GunFov.DoubleBarrel)}, --// Db
    ["DoubleBarrel"] = {["FOV"] = (getgenv().CrezWare.GunFov.DoubleBarrel)}, --// Db
    ["Revolver"] = {["FOV"] = (getgenv().CrezWare.GunFov.Revolver)}, --// Rev
    ["SMG"] = {["FOV"] = (getgenv().CrezWare.GunFov.Smg)}, --// Uzi/Smg
    ["Shotgun"] = {["FOV"] = (getgenv().CrezWare.GunFov.Shotgun)}, --// Sg
    ["TacticalShotgun"] = {["FOV"] = (getgenv().CrezWare.GunFov.TacticalShotgun)}, --// Tac
    ["Silencer"] = {["FOV"] = (getgenv().CrezWare.GunFov.Silencer)}, -- smg
    
}                 

local Script = {Functions = {}}
    Script.Functions.getToolName = function(name)
        local split = string.split(string.split(name, "[")[2], "]")[1]
        return split
    end
    Script.Functions.getEquippedWeaponName = function()
        if (Client.Character) and Client.Character:FindFirstChildWhichIsA("Tool") then
           local Tool =  Client.Character:FindFirstChildWhichIsA("Tool")
           if string.find(Tool.Name, "%[") and string.find(Tool.Name, "%]") and not string.find(Tool.Name, "Wallet") and not string.find(Tool.Name, "Phone") then
              return Script.Functions.getToolName(Tool.Name)
           end
        end
        return nil
    end
    RS.RenderStepped:Connect(function()
    if Script.Functions.getEquippedWeaponName() ~= nil then
        local WeaponSettings = getgenv().uhpoop[Script.Functions.getEquippedWeaponName()]
        if WeaponSettings ~= nil and getgenv().CrezWare.GunFov.Enabled == true then
            getgenv().CrezWare.Fov.Silent.Size = WeaponSettings.FOV
        else
            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Fov.Silent.Size
        end
    end
end)

local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/GravesFr/opensourceskidded/main/s"))()
Aiming.TeamCheck(false)



local Workspace = game:GetService("Workspace")

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")



local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

local CurrentCamera = Workspace.CurrentCamera


Aiming.FOV = 50
--------------------------------------------------
--------------------------------------------------- -fov 5.5-6.6 is legit

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end
end


game:GetService("RunService").Heartbeat:Connect(
                                function()
                                    if
                                        getgenv().CrezWare.Range.Enabled == true and getgenv().CrezWare.Range.Type == "Fov" and Aiming.Selected ~= nil and (Aiming.Selected.Character) and targ and targ.Character then
                                        if
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.CloseDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.CloseFov
                                            
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.MidDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.MidFov
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.FarDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.FarFov
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.VeryFarDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.VeryFarFov
                                        end
                                    end
                                end
                            )
                            
                            game:GetService("RunService").Heartbeat:Connect(
                                function()
                                    if
                                        getgenv().CrezWare.Range.Enabled == true and getgenv().CrezWare.Range.Type == "Prediction" and Aiming.Selected ~= nil and (Aiming.Selected.Character) and targ and Plr.Character then
                                        if
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.CloseDetection
                                         then
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.ClosePrediction
                                            
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.MidDetection
                                         then
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.MidPrediction
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.FarDetection
                                         then
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.FarPrediction
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.VeryFarDetection
                                         then
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.VeryFarPrediction
                                        end
                                    end
                                end
                            )
                            
                            game:GetService("RunService").Heartbeat:Connect(
                                function()
                                    if
                                        getgenv().CrezWare.Range.Enabled == true and getgenv().CrezWare.Range.Type == "Both" and Aiming.Selected ~= nil and (Aiming.Selected.Character) and targ and Plr.Character then
                                        if
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.CloseDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.CloseFov
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.ClosePrediction
                                            
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.MidDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.MidFov
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.MidPrediction
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.FarDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.FarFov
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.FarPrediction
                                        elseif
                                            (game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Position -
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                                                getgenv().CrezWare.Range.VeryFarDetection
                                         then
                                            getgenv().CrezWare.Fov.Silent.Size = getgenv().CrezWare.Range.VeryFarFov
                                            getgenv().CrezWare.Silent.Prediction = getgenv().CrezWare.Range.VeryFarPrediction
                                        end
                                    end
                                end
                            )



local Player = game:GetService("Players").LocalPlayer
            local Mouse = Player:GetMouse()
            local SpeedGlitch = false
            Mouse.KeyDown:Connect(function(Key)
                if getgenv().CrezWare.Macro.Type == "Normal" and getgenv().CrezWare.Macro.Enabled == true and Key == getgenv().CrezWare.Macro.Keybind then
                    SpeedGlitch = not SpeedGlitch
                    if SpeedGlitch == true then
                        repeat game:GetService("RunService").Heartbeat:wait()
                            keypress(0x49)
                            game:GetService("RunService").Heartbeat:wait()

                            keypress(0x4F)
                            game:GetService("RunService").Heartbeat:wait()

                            keyrelease(0x49)
                            game:GetService("RunService").Heartbeat:wait()

                            keyrelease(0x4F)
                            game:GetService("RunService").Heartbeat:wait()

                        until SpeedGlitch == false
                    end
                end
            end)
            
            
            
            local Player = game:GetService("Players").LocalPlayer
            local Mouse = Player:GetMouse()
            local SpeedGlitch = false
            Mouse.KeyDown:Connect(function(Key)
                if getgenv().CrezWare.Macro.Type == "Shift" and getgenv().CrezWare.Macro.Enabled == true and Key == getgenv().CrezWare.Macro.Keybind then
                    SpeedGlitch = not SpeedGlitch
                    if SpeedGlitch == true then
                        repeat game:GetService("RunService").Heartbeat:wait()

                            keypress(0xA0)
                            game:GetService("RunService").Heartbeat:wait()

                            keypress(0xA0)
                            game:GetService("RunService").Heartbeat:wait()

                            keyrelease(0xA0)
                            game:GetService("RunService").Heartbeat:wait()

                            keyrelease(0xA0)
                            game:GetService("RunService").Heartbeat:wait()

                        until SpeedGlitch == false
                    end
                end
            end)
            
      if getgenv().CrezWare.Resolver.Enabled == true then 
          local hrp
local resolver = game:GetService("RunService")

demiseuwu.Heartbeat:Connect(function()
    pcall(function()
        for i,v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer  then
                hrp = v.Character.HumanoidRootPart
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
            end
        end
    end)
end)
end
            
            

    while getgenv().CrezWare.AutoPrediction.Enabled == false do
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local pingValue = string.split(ping, " ")[1]
    local pingNumber = tonumber(pingValue)
   
    if pingNumber < 30 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P20)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P20)
    elseif pingNumber < 40 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P30)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P30)
    elseif pingNumber < 50 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P40)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P40)
    elseif pingNumber < 60 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P50)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P50)
    elseif pingNumber < 70 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P60)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P60)
    elseif pingNumber < 80 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P70)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P70)
    elseif pingNumber < 90 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P80)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P80)
    elseif pingNumber < 100 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P90)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P90)
    elseif pingNumber < 110 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P100)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P100)
         elseif pingNumber < 120 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P110)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P110)
         elseif pingNumber < 130 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P120)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P120)
         elseif pingNumber < 140 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P130)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P130)
         elseif pingNumber < 150 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P140)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P140)
         elseif pingNumber < 160 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P150)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P150)
        elseif pingNumber < 170 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P160)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P160)
        elseif pingNumber < 180 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P170)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P170)
        elseif pingNumber < 190 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P180)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P180)
        elseif pingNumber < 200 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P190)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P190)
        elseif pingNumber < 210 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P200)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P200)
        elseif pingNumber < 260 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P250)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P250)
        elseif pingNumber < 310 then
        CrezWare.Camlock.Prediction = (getgenv().CrezWare.AutoPrediction.P300)
        CrezWare.Silent.Prediction = (getgenv().CrezWare.AutoPrediction.P300)
	end
 
    wait(0.5)
end