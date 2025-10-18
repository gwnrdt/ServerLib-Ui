local module = {}
module.__index = module

function module.new(frame)
	local self = setmetatable({}, module)
	self._states = {
		Minimized = false,
		Maximized = false,
		None = true,
		
		WasMinimized = false,
	}
	self._services = {
		TweenService = game:GetService("TweenService"),
	}
	
	self._actualSize = UDim2.new()
	self._lastPos = UDim2.new()
	
	self._frame = frame
	
	self.tween = function(object, info, goal)
		local tween = self._services.TweenService:Create(object, info, goal)
		tween:Play()
		return tween
	end
	
	self._actualSize = self._frame.Size
	return self
end

function module:setState(state, onEvent)
	if self._states.Minimized then
		self._states.WasMinimized = true
	end
	if state == "Minimize" then
		self._states.Minimized = true
		self._states.Maximized = false
		self._states.None = false
	elseif state == "Maximize" then
		self._states.Minimized = false
		self._states.Maximized = true
		self._states.None = false
	elseif state == "None" then
		self._states.Minimized = false
		self._states.Maximized = false
		self._states.None = true
	end
	
	if type(onEvent) == "function" then
		onEvent()
	end
	self:setAnimation()
end

function module:updateSize()
	self._actualSize = self._frame.Size
end

function module:setAnimation()
	local content = self._frame.Pages
	local top = self._frame.Top
	local title = top.Title
	local background = self._frame.Background
	local dropShadow = background.DropShadow.Shadow1
	
	local fullscreen = self._frame._fullscreen
	
	if self._states.Minimized then
		--self._frame:TweenSize(UDim2.new(0,0,0,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, .15, true, nil)
		content.Visible = false
		self.tween(dropShadow, TweenInfo.new(.3), {ImageTransparency = 1})
		self.tween(self._frame, TweenInfo.new(.3), {Size = UDim2.new(0,top.AbsoluteSize.X,0,top.AbsoluteSize.Y)})
		self.tween(self._frame, TweenInfo.new(.3), {AnchorPoint = Vector2.new(0,0)})
		task.wait(.3)
		self.tween(self._frame, TweenInfo.new(.3), {Size = UDim2.new(0, top.Title.AbsoluteSize.X+160, 0, 45)})
		self.tween(title, TweenInfo.new(.3), {Position = UDim2.new(.4,0,.5,0)})
	end
	if self._states.Maximized then
		self._lastPos = self._frame.Position
		self.tween(dropShadow, TweenInfo.new(.3), {ImageTransparency = .2})
		self.tween(self._frame, TweenInfo.new(.3), {Size = UDim2.new(1,0,1,0)})
		self.tween(self._frame, TweenInfo.new(.3), {Position = UDim2.new(.5,0,.5,0)})
		self.tween(self._frame, TweenInfo.new(.3), {AnchorPoint = Vector2.new(.5,.5)})
		content.Visible = true
		task.spawn(function()
			task.wait(.3)
			fullscreen.Enabled = true
		end)
	end
	if self._states.None then
		self.tween(dropShadow, TweenInfo.new(.3), {ImageTransparency = .2})
		self.tween(self._frame, TweenInfo.new(.3), {Size = self._actualSize})
		self.tween(self._frame, TweenInfo.new(.3), {AnchorPoint = Vector2.new(0,0)})
		self.tween(title, TweenInfo.new(.3), {Position = UDim2.new(.5,0,.5,0)})
		if not self._states.WasMinimized then
			self.tween(self._frame, TweenInfo.new(.3), {Position = self._lastPos})
		end
		fullscreen.Enabled = false
		
		self._states.WasMinimized = false
		task.spawn(function()
			task.wait(.3)
			content.Visible = true
		end)
	end
end

return module
