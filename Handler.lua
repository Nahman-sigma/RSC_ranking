--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false) -- Disables Leaderstats


local player = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")


local frame = script.Parent.Frame
local update = frame.Update
local textLabel = frame.TextLabel
local tweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
local originalPosition = update.Position
local newPost = UDim2.new(0, 0, -1.175, 0)
local previousMoneyValue = player.leaderstats.Bux.Value


local transparencyTween = tweenService:Create(update, tweenInfo, {TextTransparency = 0})
local positionTween = tweenService:Create(update, tweenInfo, {Position = newPost})


local function updateText()
	local currentMoneyValue = player.leaderstats.Bux.Value
	local moneyChange = currentMoneyValue - previousMoneyValue

	if moneyChange ~= 0 then
		update.Text = "+ " .. moneyChange

		update.TextTransparency = 1
		update.Position = originalPosition

	
		transparencyTween:Play()
		positionTween:Play()


		transparencyTween.Completed:Connect(function()
			local reverseTransparencyTween = tweenService:Create(update, tweenInfo, {TextTransparency = 1})
			reverseTransparencyTween:Play()
		end)

		previousMoneyValue = currentMoneyValue
	end
	textLabel.Text = "$ " .. currentMoneyValue
end

player.leaderstats.Bux.Changed:Connect(updateText)

textLabel.Text = "$ " .. player.leaderstats.Bux.Value

