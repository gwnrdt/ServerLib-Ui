local SnapdragonController = loadstring(game:HttpGet("https://raw.githubusercontent.com/gwnrdt/ServerLib-Ui/refs/heads/main/SnapdragonController.lua"))()
local SnapdragonRef = loadstring(game:HttpGet("https://raw.githubusercontent.com/gwnrdt/ServerLib-Ui/refs/heads/main/SnapdragonRef.lua"))()

local function createDragController(...)
	return SnapdragonController.new(...)
end

local function setDragState(state)
	return SnapdragonController:SetDragEnabled(state)
end

local function createRef(gui)
	return SnapdragonRef.new(gui)
end

local export
export = {
	createDragController = createDragController, 
	SnapdragonController = SnapdragonController,
	setDragState = setDragState,
	createRef = createRef
}
-- roblox-ts `default` support
export.default = export
return export
