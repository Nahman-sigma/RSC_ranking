local Sell = workspace.Sell
local Prompt = workspace.Boxes.Prompt
local playerService = game:GetService("Players")


Prompt.ProximityPrompt.TriggerEnded:Connect(function(player)
	local BoxTool = game:GetService("ServerStorage").Box:Clone()

	if not player.Character:FindFirstChild("Box") and not player.Backpack:FindFirstChild("Box") then
		BoxTool.Parent = player.Character
		Prompt.Sound:Play()
		player.PlayerGui.SellTag.Enabled = true
	end
end)


Sell.Touched:Connect(function(hit)
	local payment = math.random(30, 50)
	local char = hit.Parent
	local player = playerService:GetPlayerFromCharacter(char)
	
	if char:FindFirstChild("Box") then
		Sell.Sound1:Play()
		player.PlayerGui.SellTag.Enabled = false
		char:FindFirstChild("Box"):Destroy()
		Sell.Sound2:Play()
		player.leaderstats.Bux.Value += payment
	end
end)
