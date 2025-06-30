return function(sideFrame, templateButton, labelText, onClick)
	local newButton = templateButton:Clone()
	newButton.Name = labelText:gsub("%s+", "")
	newButton.Text = labelText
	newButton.Visible = true
	newButton.Parent = sideFrame

	if onClick then
		newButton.MouseButton1Click:Connect(onClick)
	end

	return newButton
end
