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

local function getVariant(name)
	return Theme.Buttons[name or "Primary"] or Theme.Buttons.Primary
end

return function(props)
	props = props or {}

	local hovered = source(false)
	local pressed = source(false)

	local variant = derive(function()
		return getVariant(read(props.Variant, "Primary"))
	end)

	local disabled = derive(function()
		return read(props.Disabled, false) == true
	end)

	local background = derive(function()
		local state = variant()

		if disabled() then
			return Theme.Colors.SurfaceMuted
		end

		if pressed() then
			return state.Pressed
		end

		if hovered() then
			return state.Hover
		end

		return state.Background
	end)

	local textColor = derive(function()
		if disabled() then
			return Theme.Colors.TextMuted
		end

		return variant().Text
	end)

	local animatedBackground = Motion.tween(background, Motion.Duration.Fast)
	local animatedScale = Motion.hoverPressScale(hovered, pressed, disabled, 1.02, 0.97)
	local animatedStrokeTransparency = Motion.tween(derive(function()
		if disabled() then
			return 0.35
		end

		return if hovered() or pressed() then 0 else 0.12
	end), Motion.Duration.Fast)

	return create "TextButton" {
		Name = props.Name or "Button",
		AnchorPoint = props.AnchorPoint,
		AutoButtonColor = false,
		BackgroundColor3 = animatedBackground,
		BorderSizePixel = 0,
		FontFace = Theme.Fonts.Semibold,
		LayoutOrder = props.LayoutOrder,
		Position = props.Position,
		Size = props.Size or UDim2.fromOffset(160, 44),
		Text = props.Text or "Button",
		TextColor3 = textColor,
		TextSize = props.TextSize or 16,
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
			Color = derive(function()
				return if disabled() then Theme.Colors.Border else variant().Stroke
			end),
			Thickness = props.StrokeThickness or 1,
			Transparency = animatedStrokeTransparency,
		},
	}
end
