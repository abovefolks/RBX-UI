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

local function write(target, value)
	if type(target) == "function" then
		target(value)
	end
end

local function snap(value, minValue, maxValue, step)
	local clamped = math.clamp(value, minValue, maxValue)

	if step and step > 0 then
		clamped = math.round(clamped / step) * step
	end

	return math.clamp(clamped, minValue, maxValue)
end

return function(props)
	props = props or {}

	local dragging = source(false)
	local trackRef

	local minValue = derive(function()
		return read(props.Min, 0)
	end)

	local maxValue = derive(function()
		return read(props.Max, 100)
	end)

	local currentValue = derive(function()
		return snap(read(props.Value, minValue()), minValue(), maxValue(), read(props.Step, 1))
	end)

	local percent = derive(function()
		local range = maxValue() - minValue()

		if range <= 0 then
			return 0
		end

		return math.clamp((currentValue() - minValue()) / range, 0, 1)
	end)
	local animatedPercent = Motion.tween(percent, Motion.Duration.Fast)
	local animatedThumbSize = Motion.scale(derive(function()
		return if dragging() then UDim2.fromOffset(22, 22) else UDim2.fromOffset(18, 18)
	end), Motion.Duration.Fast, Motion.Damping.Soft)

	local function updateFromInput(input)
		if not trackRef then
			return
		end

		local alpha = (input.Position.X - trackRef.AbsolutePosition.X) / trackRef.AbsoluteSize.X
		local nextValue = minValue() + math.clamp(alpha, 0, 1) * (maxValue() - minValue())
		nextValue = snap(nextValue, minValue(), maxValue(), read(props.Step, 1))

		write(props.Value, nextValue)

		if props.OnChanged then
			props.OnChanged(nextValue)
		end
	end

	return create "Frame" {
		Name = props.Name or "Slider",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.LayoutOrder,
		Size = props.Size or UDim2.new(1, 0, 0, 54),

		create "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		create "Frame" {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.fromScale(1, 0),

			create "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Semibold,
				Size = UDim2.fromScale(0.7, 0),
				Text = props.Label or "Slider",
				TextColor3 = Theme.Colors.Text,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			create "TextLabel" {
				AnchorPoint = Vector2.new(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = Theme.Fonts.Medium,
				Position = UDim2.fromScale(1, 0),
				Size = UDim2.fromScale(0.3, 0),
				Text = derive(function()
					return tostring(currentValue())
				end),
				TextColor3 = Theme.Colors.TextMuted,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Right,
			},
		},

		create "Frame" {
			Name = "Track",
			BackgroundColor3 = Theme.Colors.SurfaceMuted,
			BorderSizePixel = 0,
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, 14),

			InputBegan = function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				dragging(true)
				updateFromInput(input)
			end,

			InputChanged = function(input)
				if dragging() and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					updateFromInput(input)
				end
			end,

			InputEnded = function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging(false)
				end
			end,

			Vide.action(function(instance)
				trackRef = instance
			end),

			create "UICorner" {
				CornerRadius = UDim.new(1, 0),
			},

			create "Frame" {
				Name = "Fill",
				BackgroundColor3 = Theme.Colors.Accent,
				BorderSizePixel = 0,
				Size = derive(function()
					return UDim2.fromScale(animatedPercent(), 1)
				end),

				create "UICorner" {
					CornerRadius = UDim.new(1, 0),
				},
			},

			create "Frame" {
				Name = "Thumb",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Theme.Colors.Text,
				BorderSizePixel = 0,
				Position = derive(function()
					return UDim2.fromScale(animatedPercent(), 0.5)
				end),
				Size = animatedThumbSize,

				create "UICorner" {
					CornerRadius = UDim.new(1, 0),
				},

				create "UIStroke" {
					Color = Theme.Colors.Accent,
					Thickness = 3,
				},
			},
		},
	}
end
