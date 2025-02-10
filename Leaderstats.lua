local DataStoreService = game:GetService("DataStoreService")
local moneyStore = DataStoreService:GetDataStore("PlayerMoney")

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local money = Instance.new("NumberValue", leaderstats)
	money.Name = "Bux"


	local success, err = pcall(function()
		local moneyValue = moneyStore:GetAsync(player.UserId)
		if moneyValue then
			money.Value = moneyValue
		else
			money.Value = 0
		end
	end)

	if not success then
		warn("Failed to load money for player " .. player.Name .. ": " .. err)
	end

	money.Changed:Connect(function(newValue)
		local success, err = pcall(function()
			moneyStore:SetAsync(player.UserId, newValue)
		end)

		if not success then
			warn("Failed to save money for player " .. player.Name .. ": " .. err)
		end
	end)
end)



game.Players.PlayerRemoving:Connect(function(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local money = leaderstats:FindFirstChild("Money")
		if money then
			local success, err = pcall(function()
				moneyStore:SetAsync(player.UserId, money.Value)
			end)

			if not success then
				warn("Failed to save money for player " .. player.Name .. ": " .. err)
			end
		end
	end
end)
