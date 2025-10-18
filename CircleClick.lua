function CreateCircle()
	local Circle = Instance.new("ImageLabel")
	Circle.ImageTransparency = .9
	Circle.Image = "rbxassetid://266543268"
	Circle.BackgroundTransparency = 1
	Circle.ZIndex = 10
	
	return Circle
end

function CircleClick(Button, X, Y, Color)
	coroutine.resume(coroutine.create(function()
		
		Button.ClipsDescendants = true
		
		local Circle = CreateCircle()
			Circle.Parent = Button
			Circle.ZIndex = Button.ZIndex + 1
			Circle.ImageColor3 = Color
			local NewX = X - Circle.AbsolutePosition.X
			local NewY = Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
		
		local Size = 0
		if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.X*1.5
		elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.Y*1.5
		elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then		
			Size = Button.AbsoluteSize.X*1.5
		end
		
		local Time = 0.5
			Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
			for i=1,10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time/10)
			end
			Circle:Destroy()
			
	end))
end

return CircleClick
