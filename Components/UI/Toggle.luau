local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local Motion = require(script.Parent.Motion)
local Theme = require(script.Parent.Theme)

local create = Vide.create
local derive = Vide.derive

local function read(value, fallback)
	if value == nil then
		return fallback
	end

	if type(value) == "function" then
		return value()
	end

	return value
end

local function write(target, value)
	if type(target) == "function" then
		target(value)
	end
end

return function(props)
	props = props or {}

	local enabled = derive(function()
		return read(props.Value, false) == true
	end)

	local disabled = derive(function()
		return read(props.Disabled, false) == true
	end)

	local trackColor = derive(function()
		if disabled() then
			return Theme.Colors.SurfaceMuted
		end

		return if enabled() then Theme.Colors.Accent else Theme.Colors.SurfaceRaised
	end)
	local knobPosition = derive(function()
		return if enabled() then UDim2.fromScale(0.73, 0.5) else UDim2.fromScale(0.27, 0.5)
	end)
	local knobColor = derive(function()
		return if enabled() then Theme.Colors.Background else Theme.Colors.Text
	end)

	local animatedTrackColor = Motion.tween(trackColor, Motion.Duration.Fast)
	local animatedKnobPosition = Motion.tween(knobPosition, Motion.Duration.Slow, Motion.Damping.Snappy)
	local animatedKnobColor = Motion.tween(knobColor, Motion.Duration.Fast)

	local function setEnabled(nextValue)
		if disabled() then
			return
		end

		write(props.Value, nextValue)

		if props.OnChanged then
			props.OnChanged(nextValue)
		end
	end

	return create "TextButton" {
		Name = props.Name or "Toggle",
		AutoButtonColor = false,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.LayoutOrder,
		Size = props.Size or UDim2.new(1, 0, 0, 34),
		Text = "",

		Activated = function()
			setEnabled(not enabled())
		end,

		create "Frame" {
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = animatedTrackColor,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0, 0.5),
			Size = UDim2.fromOffset(52, 28),

			create "UICorner" {
				CornerRadius = UDim.new(1, 0),
			},

			create "Frame" {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = animatedKnobColor,
				BorderSizePixel = 0,
				Position = animatedKnobPosition,
				Size = UDim2.fromOffset(20, 20),

				create "UICorner" {
					CornerRadius = UDim.new(1, 0),
				},
			},
		},

		create "TextLabel" {
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			FontFace = Theme.Fonts.Semibold,
			Position = UDim2.new(0, 66, 0.5, 0),
			Size = UDim2.new(1, -66, 0, 24),
			Text = props.Label or "Toggle",
			TextColor3 = derive(function()
				return if disabled() then Theme.Colors.TextMuted else Theme.Colors.Text
			end),
			TextSize = 15,
			TextXAlignment = Enum.TextXAlignment.Left,
		},
	}
end
