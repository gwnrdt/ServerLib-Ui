local TweenService = game:GetService("TweenService")

local Fade = {}
local ExcludedNames = {"Pages"}

local EasingStyle = Enum.EasingStyle.Quint
local EasingDirection = Enum.EasingDirection.InOut

function Fade:Tween(Object, Info, Goal)
	local Tween = TweenService:Create(Object, Info, Goal)
	Tween:Play()
	return Tween
end

function Fade:CheckIfValid(Object)
	if Object:IsA("TextButton") or Object:IsA("TextLabel") or Object:IsA("TextBox") or Object:IsA("ScrollingFrame") or Object:IsA("ImageLabel") or Object:IsA("ImageButton") or Object:IsA("UIStroke") or Object:IsA("BasePart") or Object:IsA("MeshPart") or Object:IsA("Frame") and not table.find(ExcludedNames, Object.Name) then
		return true
	else
		return false
	end
end

function Fade:CheckForAttributes(Object)
	if Object:IsA("TextButton") or Object:IsA("TextLabel") or Object:IsA("TextBox") then
		if not Object:GetAttribute("InitialBackgroundTransparency") and not Object:GetAttribute("InitialTextTransparency") then
			Object:SetAttribute("InitialBackgroundTransparency", Object.BackgroundTransparency)
			Object:SetAttribute("InitialTextTransparency", Object.TextTransparency)
		end
	elseif Object:IsA("ScrollingFrame") then
		if not Object:GetAttribute("InitialBackgroundTransparency") and not Object:GetAttribute("InitialTextTransparency") and not Object:GetAttribute("InitialScrollBarTransparency") then
			Object:SetAttribute("InitialBackgroundTransparency", Object.BackgroundTransparency)
			Object:SetAttribute("InitialScrollBarTransparency", Object.ScrollBarImageTransparency)
		end
	elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
		if not Object:GetAttribute("InitialBackgroundTransparency") and not Object:GetAttribute("InitialImageTransparency") then
			Object:SetAttribute("InitialBackgroundTransparency", Object.BackgroundTransparency)
			Object:SetAttribute("InitialImageTransparency", Object.ImageTransparency)
		end
	elseif Object:IsA("UIStroke") then
		if not Object:GetAttribute("InitialTransparency") then
			Object:SetAttribute("InitialTransparency", Object.Transparency)
		end
	elseif Object:IsA("Frame") then
		if not Object:GetAttribute("InitialBackgroundTransparency") then
			Object:SetAttribute("InitialBackgroundTransparency", Object.BackgroundTransparency)
		end
	elseif Object:IsA("BasePart") or Object:IsA("MeshPart") then
		if not Object:GetAttribute("InitialTransparency") then
			Object:SetAttribute("InitialTransparency", Object.Transparency)
		end
	elseif Object:IsA("Texture") or Object:IsA("Decal") then
		if not Object:GetAttribute("InitialTransparency") then
			Object:SetAttribute("InitialTransparency", Object.Transparency)
		end
	end
end

function Fade:SetTransparency(Object, Transparency, Speed)
	local function Scan(Object)
		if Transparency == 0 then
			self:CheckForAttributes(Object)
			if Object:GetAttribute("InitialTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {Transparency = Object:GetAttribute("InitialTransparency")})
			end
			if Object:GetAttribute("InitialBackgroundTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {BackgroundTransparency = Object:GetAttribute("InitialBackgroundTransparency")})
			end
			if Object:GetAttribute("InitialImageTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ImageTransparency = Object:GetAttribute("InitialImageTransparency")})
			end
			if Object:GetAttribute("InitialTextTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {TextTransparency = Object:GetAttribute("InitialTextTransparency")})
			end
			if Object:GetAttribute("InitialScrollBarTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ScrollBarImageTransparency = Object:GetAttribute("InitialScrollBarTransparency")})
			end
		else
			self:CheckForAttributes(Object)
			if Object:GetAttribute("InitialTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {Transparency = Transparency})
			end
			if Object:GetAttribute("InitialBackgroundTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {BackgroundTransparency = Transparency})
			end
			if Object:GetAttribute("InitialImageTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ImageTransparency = Transparency})
			end
			if Object:GetAttribute("InitialTextTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {TextTransparency = Transparency})
			end
			if Object:GetAttribute("InitialScrollBarTransparency") then
				self:Tween(Object, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ScrollBarImageTransparency = Transparency})
			end
		end
		
		for _, Part in ipairs(Object:GetChildren()) do
			local Valid = self:CheckIfValid(Part)
			if Valid then
				if Transparency == 0 then
					self:CheckForAttributes(Part)
					if Part:GetAttribute("InitialTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {Transparency = Part:GetAttribute("InitialTransparency")})
					end
					if Part:GetAttribute("InitialBackgroundTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {BackgroundTransparency = Part:GetAttribute("InitialBackgroundTransparency")})
					end
					if Part:GetAttribute("InitialImageTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ImageTransparency = Part:GetAttribute("InitialImageTransparency")})
					end
					if Part:GetAttribute("InitialTextTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {TextTransparency = Part:GetAttribute("InitialTextTransparency")})
					end
					if Part:GetAttribute("InitialScrollBarTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ScrollBarImageTransparency = Part:GetAttribute("InitialScrollBarTransparency")})
					end
				else
					self:CheckForAttributes(Part)
					if Part:GetAttribute("InitialTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {Transparency = Transparency})
					end
					if Part:GetAttribute("InitialBackgroundTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {BackgroundTransparency = Transparency})
					end
					if Part:GetAttribute("InitialImageTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ImageTransparency = Transparency})
					end
					if Part:GetAttribute("InitialTextTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {TextTransparency = Transparency})
					end
					if Part:GetAttribute("InitialScrollBarTransparency") then
						self:Tween(Part, TweenInfo.new(Speed, EasingStyle, EasingDirection), {ScrollBarImageTransparency = Transparency})
					end
				end
				Scan(Part)
			end
		end
	end
	Scan(Object)
end

function Fade:FadeClose(Object, Speed)
	self:SetTransparency(Object, 1, Speed)
end

function Fade:FadeOpen(Object, Speed)
	self:SetTransparency(Object, 0, Speed)
end

return Fade
