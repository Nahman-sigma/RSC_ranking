local eyeFrame = script.Parent.Frame
local eye = script.Parent.Sharingan
local Gui = script.Parent
local UIS = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local Backpack = Player.Backpack
local BackpackChildren = Player.Backpack:GetChildren()
local ActivateSound = game:GetService("ReplicatedStorage").Sounds.SharinganSFX
local DeactivateSound = game:GetService("ReplicatedStorage").Sounds.SharinganDeactivate
local descendant = Player.Character:GetDescendants()
local mouse = game:GetService("MouseService")
local RS = game:GetService("ReplicatedStorage")
local Amaterasu = RS.Remotes:WaitForChild("Amaterasu")
local OriginalFaceId = Player.Character:WaitForChild("Head"):FindFirstChild("face").Texture
local Activation = RS.Remotes:WaitForChild("Activation")

local SharinganDuration = 10 -- Amount of time mode lasts
local ModeCoolDown = 1 -- Mode cooldown
-- Creating values
local ActivationTime = Instance.new("IntValue")
ActivationTime.Parent = game.Players.LocalPlayer
ActivationTime.Name = 'Activation_Time'
ActivationTime.Value = 0

local Mode = Instance.new("StringValue")
Mode.Parent = game.Players.LocalPlayer
Mode.Name = 'Mode' 
Mode.Value = 'Off'

local TrueModeCoolDown = Instance.new("StringValue")
TrueModeCoolDown.Parent = Mode
TrueModeCoolDown.Name = "TrueModeCooldown" -- Stops moves from being used after sharingan ended
TrueModeCoolDown.Value = "Off"


UIS.InputBegan:Connect(function(input)
	
	if input.UserInputType == Enum.UserInputType.Keyboard then
		
		if input.KeyCode == Enum.KeyCode.J and Mode.Value == "Off" then
			
			print("Sharingan Anim Activated")
			eye.Visible = true
			eyeFrame.Visible = true
			TrueModeCoolDown.Value = "On"
			Mode.Value = 'On'
			Activation:FireServer()
			ActivateSound:Play()
			Player.Character.Humanoid.WalkSpeed = 8
			
			while true do
				task.wait()
				eye.Rotation = eye.Rotation + 1
				ActivationTime.Value = ActivationTime.Value + 1	
				
				if ActivationTime.Value == 180 then
					eye.Visible = false
					Player.Character.Humanoid.WalkSpeed = 16
					eyeFrame.Visible = false
					ActivationTime.Value = 0
					print("Sharingan Anim Ended")
					break
				end
			end
			
			wait(SharinganDuration)
			TrueModeCoolDown.Value = "Off"
			Backpack:ClearAllChildren()
			DeactivateSound:Play()
			
			wait(ModeCoolDown)
			Mode.Value = 'Off'
			
			
		end
		
	end
	
	if input.UserInputType == Enum.UserInputType.Keyboard then
		
		
		if input.KeyCode == Enum.KeyCode.E and TrueModeCoolDown.Value == "On" then
			
			print("Amaterasu Fired")
			Amaterasu:FireServer()
			
			
			
		end
		
		
	end
	
	
	
end)
