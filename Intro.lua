local module = {}

function create_intro()
	local frame = Instance.new("Frame")
	frame.BackgroundTransparency = 1
	frame.AnchorPoint = Vector2.new(.5,.5)
	frame.Position = UDim2.new(.5,0,.5,0)
	
	return frame
end

function create_line()
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0,0,.1,0)
	frame.ZIndex = 999
	frame.BorderSizePixel = 0
	
	return frame
end

function module.new(themeColor)
	local self = setmetatable({}, {__index = module})
	local Root = script.Parent
	
	self._frame = create_intro()
	self._template = create_line()
	
	self.LOAD_SPEED = .5
	self.THEME_COLOR = themeColor
	
	self._services = {
		TweenService = game:GetService("TweenService"),
	}
	
	self.tween = function(object, info, goal)
		local tween = self._services.TweenService:Create(object, info, goal)
		tween:Play()
		return tween
	end
	
	return self
end

function module:load(frame)
	frame.Visible = false
	
	local intro = self._frame:Clone()
	intro.Parent = frame.Parent
	intro.Size = frame.Size
	intro.Position = frame.Position
	intro.AnchorPoint = frame.AnchorPoint
	
	for index = 1, 10 do
		local temp = self._template:Clone()
		temp.Parent = intro
		temp.BackgroundColor3 = self.THEME_COLOR
		if index > 1 then
			temp.Position = UDim2.new(0,0,0,temp.AbsoluteSize.Y * (index-1))
		end
		if (index % 2) == 0 then
			temp.AnchorPoint = Vector2.new(1,0)
			temp.Position = temp.Position
				+ UDim2.new(1,0,0,0)
		end
		self.tween(temp, TweenInfo.new(self.LOAD_SPEED, Enum.EasingStyle.Quad), {Size = UDim2.new(1,0,.1,0)})
		task.wait(.1)
	end
	task.wait(self.LOAD_SPEED)
	frame.Visible = true
	for index, line in ipairs(intro:GetChildren()) do
		if line:IsA("Frame") then
			self.tween(line, TweenInfo.new(self.LOAD_SPEED, Enum.EasingStyle.Quad), {Size = UDim2.new(0,0,.1,0)})
		end
	end
	task.wait(self.LOAD_SPEED)
	intro:Destroy()
end

return module
