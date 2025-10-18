local Fit = {}

function Fit:Set(Frame)
	local RunService = game:GetService("RunService")
	
	local Camera = workspace.CurrentCamera
	local ViewPortSize = Camera.ViewportSize
	local Scale = Instance.new("UIScale", Frame)
	
	local function UpdateScale()
		ViewPortSize = Camera.ViewportSize
		Scale.Scale = (ViewPortSize.X + ViewPortSize.Y)/1600
		if Scale.Scale >= 1 then
			Scale.Scale = 1
		end
	end
	
	local Thread = coroutine.create(function()
		while true do
			UpdateScale()
			task.wait()
		end
	end)
	coroutine.resume(Thread)
end

return Fit
