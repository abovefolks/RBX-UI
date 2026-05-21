local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local Motion = require(script.Parent.Motion)
local Theme = require(script.Parent.Theme)

local create = Vide.create
local derive = Vide.derive
local source = Vide.source

local function read(value, fallback)
	if value == nil then
		return fallback
	end

	if type(value) == "function" then
		return value()
	end

	return value
end

return function(props)
	props = props or {}

	local hovered = source(false)
	local pressed = source(false)

	local disabled = derive(function()
		return read(props.Disabled, false) == true
	end)

	local background = derive(function()
		if disabled() then
			return Theme.Colors.SurfaceMuted
		end

		if pressed() then
			return Theme.Colors.AccentPressed
		end

		if hovered() then
			return Theme.Colors.SurfaceMuted
		end

		return props.BackgroundColor3 or Theme.Colors.SurfaceRaised
	end)

	local animatedBackground = Motion.tween(background, Motion.Duration.Fast)
	local animatedScale = Motion.hoverPressScale(hovered, pressed, disabled, 1.06, 0.92)

	return create "TextButton" {
		Name = props.Name or "IconButton",
		AnchorPoint = props.AnchorPoint,
		AutoButtonColor = false,
		BackgroundColor3 = animatedBackground,
		BorderSizePixel = 0,
		FontFace = Theme.Fonts.Bold,
		LayoutOrder = props.LayoutOrder,
		Position = props.Position,
		Size = props.Size or UDim2.fromOffset(36, 36),
		Text = props.Icon or "X",
		TextColor3 = derive(function()
			return if disabled() then Theme.Colors.TextMuted else (props.TextColor3 or Theme.Colors.Text)
		end),
		TextSize = props.TextSize or 18,
		TextTransparency = derive(function()
			return if disabled() then 0.25 else 0
		end),
		ZIndex = props.ZIndex,

		Activated = function(...)
			if disabled() or props.OnActivated == nil then
				return
			end

			props.OnActivated(...)
		end,

		MouseEnter = function()
			hovered(true)
		end,

		MouseLeave = function()
			hovered(false)
			pressed(false)
		end,

		MouseButton1Down = function()
			if not disabled() then
				pressed(true)
			end
		end,

		MouseButton1Up = function()
			pressed(false)
		end,

		create "UICorner" {
			CornerRadius = props.CornerRadius or Theme.Radii.Control,
		},

		create "UIScale" {
			Scale = animatedScale,
		},

		create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = props.StrokeColor or Theme.Colors.Border,
			Thickness = 1,
			Transparency = 0.1,
		},
	}
end
