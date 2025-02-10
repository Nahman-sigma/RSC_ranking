local RS = game:GetService("ReplicatedStorage")
local Amaterasu = RS.Remotes:WaitForChild("Amaterasu")
local Activation = RS.Remotes:WaitForChild("Activation")
local ActivateSound = game:GetService("ReplicatedStorage").Sounds.SharinganSFX
local DeactivateSound = game:GetService("ReplicatedStorage").Sounds.SharinganDeactivate
local ActivateAnimation = RS.Animations:WaitForChild("Activation") -- Gets animation from Replicated Storage
local AmaterasuAnimation = RS.Animations:WaitForChild("Amaterasu")   -- Gets animation from replicated storage


Activation.OnServerEvent:Connect(function(player)
	local Hum = player.Character:WaitForChild("Humanoid")
	local ActivationAnim = Hum:LoadAnimation(ActivateAnimation)
	local Mode = player:FindFirstChild("Mode")
	local OriginalFaceId = player.Character.Head:FindFirstChild("face").Texture
	player.Character.Head:WaitForChild("face").Texture = 'http://www.roblox.com/asset/?id=7914788337'
	-- Anims and sound Plays
	ActivateSound:Play()
	ActivationAnim:Play()
	wait(14)
	player.Character.Head:WaitForChild("face").Texture = OriginalFaceId
end)

Amaterasu.OnServerEvent:Connect(function(player)
	local Hum = player.Character:WaitForChild("Humanoid")
	local hrp = player.Character:WaitForChild("HumanoidRootPart")
	local AmaterasuAnim = Hum:LoadAnimation(AmaterasuAnimation)
	local part = Instance.new("Part")
	part.Parent = player.Character
	part.Name = "Part"
	part.CFrame = hrp.CFrame * CFrame.new(0,0,-10)
	part.Transparency = .5
	part.Anchored = true
	part.Massless = true
	part.CanCollide = false
	local hitbox = Instance.new("Part")
	hitbox.Name = "Hitbox"
	hitbox.Parent = workspace
	hitbox.CFrame = part.CFrame
	hitbox.Size = Vector3.new(10, 10 ,10)
	hitbox.Color = Color3.new(0.603922, 0.0235294, 0.0509804)
	hitbox.Transparency = .5
	hitbox.Anchored = true
	hitbox.Massless = true
	hitbox.CanCollide = false
	local fire = Instance.new("Fire")
	fire.Color = Color3.new(0, 0, 0)
	fire.Heat = 20	
	fire.SecondaryColor = Color3.new(0, 0, 0)
	fire.Parent = part
	fire.Size = 30
	
	
	hitbox.Touched:Connect(function(hit)
		local char = hit.Parent
		local hum = char:WaitForChild("Humanoid")
		
		while hum.Health ~= 10 do
			hum:TakeDamage(10)
		end
	end)
	
	-- Anim and sound plays
	AmaterasuAnim:Play()
	wait(5)
	fire:Destroy()
	part:Destroy()
	hitbox:Destroy()
end)
